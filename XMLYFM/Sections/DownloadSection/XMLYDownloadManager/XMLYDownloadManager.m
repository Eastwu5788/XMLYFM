//
//  XMLYDownloadManager.m
//  XMLYFM
//
//  Created by East_wu on 16/9/19.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYDownloadManager.h"
#import "XMLYDownloadDBHelper.h"
#import "XMLYDownloadRequest.h"
#import <pthread.h>
#import "YYCache.h"


@interface XMLYLinkQueueNode : NSObject {
    @package
    __unsafe_unretained XMLYLinkQueueNode *_next; //下一个节点
    XMLYDownTaskModel *_value; //存储在该节点的数据
}
@end

@implementation XMLYLinkQueueNode
@end

@interface XMLYLinkQueue : NSObject {
    @package
    XMLYLinkQueueNode *_front; // 头节点
    XMLYLinkQueueNode *_rear;  //尾节点
}

// 入队
- (void)enterQueue:(XMLYDownTaskModel *)value;

// 出队
- (XMLYDownTaskModel *)outQueue;

// 判断队列是否为空
- (BOOL)emptyQueue;

@end



@implementation XMLYLinkQueue

// 初始化队列
- (instancetype)init {
    self = [super init];
    [self initQueue];
    return self;
}

// 初始化队列
- (void)initQueue {
    XMLYLinkQueueNode *node = [XMLYLinkQueueNode new];
    self->_front = node;
    self->_rear = node;
    self->_front->_next = nil;
}

// 入队
- (void)enterQueue:(XMLYDownTaskModel *)value {
    // 生成一个节点
    XMLYLinkQueueNode *node = [XMLYLinkQueueNode new];
    node->_value = value;
    node->_next = nil;
    
    // 将该节点添加到尾节点上
    self->_rear->_next = node;
    self->_rear = node;
}

// 出队
- (XMLYDownTaskModel *)outQueue {
    // 队列为空
    if(self->_front == self->_rear) {
        return nil;
    }
    
    // 头结点
    XMLYLinkQueueNode *node = self->_front->_next;
    
    self->_front->_next = node->_next;
    if(node->_next == nil) {
        self->_rear = self->_front;
    }
    
    return node->_value;
}

- (BOOL)emptyQueue {
    return self->_rear == self->_front;
}

@end


@interface XMLYDownloadManager () {
    pthread_mutex_t _lock;       //线程锁
    XMLYLinkQueue   *_waitQueue; // 等待下载队列
}

@property (nonatomic, strong) YYCache *cache;
@property (nonatomic, strong) NSMutableDictionary *downloadingCache;

@end

@implementation XMLYDownloadManager

/*
 * 单例创建
 */
+ (instancetype)manager {
    static XMLYDownloadManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[XMLYDownloadManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    pthread_mutex_init(&_lock, NULL);
    _waitQueue = [[XMLYLinkQueue alloc] init];
    _downloadingCache = [[NSMutableDictionary alloc] init];
    _maxDownloadCount = 2;
    return self;
}

/*
 * 新增一个下载任务
 * 如果当前任务已存在，则会返回false
 * 下载任务创建成功 返回yes
 */
- (void)addDownloadTask:(XMLYDownTaskModel *)taskModel completion:(void(^)(BOOL success,XMLYDownloadError error))completion{
    // 1.输入合法性检查
    if(taskModel == nil || taskModel.trackModel == nil || taskModel.albumModel == nil){
        if(completion) {
            completion(NO,XMLYDownloadErrorIllegalInput);
        };
        return;
    }
    
    // 2.如果当前 任务已经在操作队列中、或者已经下载过，则返回NO
    if([self checkDownloadTask:taskModel.trackModel.trackId albumID:taskModel.trackModel.albumId]) {
        if(completion) {
            completion(NO,XMLYDownloadErrorExists);
        };
        return;
    }
    
    // 3.保存下载数据
    [self addDownloadTaskToHistory:taskModel];
    
    // 4.将下载任务添加到待下载队列中
    pthread_mutex_lock(&_lock);
    [_waitQueue enterQueue:taskModel];
    pthread_mutex_unlock(&_lock);
    
    // 5.检查是否需要开启新的下载任务
    [self checkStartDownloadTask];
    
    if(completion) {
        completion(YES,XMLYDownloadErrorNone);
    }
}



/*
 * 查询当前正在进行的所有下载任务
 */
- (NSMutableArray<XMLYDownTaskModel *> *)downloadTasks {
    NSMutableArray *arr = [NSMutableArray new];
    [self.downloadingCache enumerateKeysAndObjectsUsingBlock:^(NSString *key, XMLYDownTaskModel  *obj, BOOL * _Nonnull stop) {
        [arr addObject:obj];
    }];
    return arr;
}

/*
 * 查询album_id 获取albumModel
 */
- (XMLYAlbumModel *)taskModelAlbumFromAlbumID:(NSInteger)album_id {
    //2.获取存储的专辑信息
    XMLYAlbumModel *model = (XMLYAlbumModel *)[self.cache objectForKey:[NSString stringWithFormat:@"download_album_id_%ld",album_id]];
    return model;
}

/*
 * 根据track_id 获取trackModel
 */
- (XMLYAlbumTrackItemModel *)taskModelTrackFromAlbumID:(NSInteger)track_id {
    //1.获取存储的专辑中的某一条声音
    XMLYAlbumTrackItemModel *model = (XMLYAlbumTrackItemModel *)[self.cache objectForKey:[NSString stringWithFormat:@"download_track_id_%ld",track_id]];
    return model;
}


#pragma mark - private

- (void)downloadTaskByAFNetworkding:(XMLYDownTaskModel *)model {
    
    @weakify(self);
    NSURLSessionDownloadTask *task = [XMLYDownloadRequest requestDownloadFromURL:model.trackModel.playPathAacv224 progress:^(NSInteger completedUnitCount, NSInteger totalUnitCount) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate downloadProgress:completedUnitCount expected:totalUnitCount trackID:model.trackModel.trackId albumID:model.trackModel.albumId];
        });
    } destination:[model destinationLocaoPath] completion:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        @strongify(self);
        NSLog(@"filePath:%@ 下载完成error:%@",filePath,error);
        
        [self updateDownloadTaskStatus:error destinationFile:filePath taskModel:model];
        [self.downloadingCache removeObjectForKey:[NSString stringWithFormat:@"%ld",model.trackModel.trackId]];
    }];
    
    model.downloadTask = task;
}

// 更新下载数据
- (void)updateDownloadTaskStatus:(NSError *)error destinationFile:(NSURL *)filePath taskModel:(XMLYDownTaskModel *)model {
    if(error) {
        // 下载失败数据更新
        [[XMLYDownloadDBHelper helper] updateDownloadTask:model.trackModel.trackId albumID:model.trackModel.albumId status:3];
    }else{
        // 下载完成数据更新
        [[XMLYDownloadDBHelper helper] updateDownloadTask:model.trackModel.trackId albumID:model.trackModel.albumId status:2];
    }
}

#pragma mark - Cache

// 检查是否需要开启新的下载任务
- (void)checkStartDownloadTask {
    // 正在下载任务最多有2条
    pthread_mutex_lock(&_lock);
    NSInteger count = self.downloadingCache.allKeys.count;
    pthread_mutex_unlock(&_lock);
    if(count == _maxDownloadCount) {
        return;
    }

    // 取出下载任务
    pthread_mutex_lock(&_lock);
    XMLYDownTaskModel *model = [_waitQueue outQueue];
    pthread_mutex_unlock(&_lock);
    
    // 如果model为空，则表示当前队列中没有任务
    if(!model) {
        return;
    }
    
    // 开启下载任务
    [self startDownloadTask:model];
}

// 开启下载任务
- (void)startDownloadTask:(XMLYDownTaskModel *)model {
    // 将模型存储到下载缓存冲
    pthread_mutex_lock(&_lock);
    [_downloadingCache setObject:model forKey:[NSString stringWithFormat:@"%ld",model.trackModel.trackId]];
    pthread_mutex_unlock(&_lock);
    
    // 更新数据库数据 将该条数据的状态更新为正在下载
    [[XMLYDownloadDBHelper helper] updateDownloadTask:model.trackModel.trackId albumID:model.trackModel.albumId status:1];
    
    // 通过AFNetworking 开始下载
    [self downloadTaskByAFNetworkding:model];
}

/*
 * 增加一个新的下载任务到历史记录中
 */
- (void)addDownloadTaskToHistory:(XMLYDownTaskModel *)taskModel {
    //1.存储专辑中的某一条声音
    [self.cache setObject:taskModel.trackModel forKey:[NSString stringWithFormat:@"download_track_id_%ld",taskModel.trackModel.trackId]];
    //2.存储专辑信息
    [self.cache setObject:taskModel.albumModel forKey:[NSString stringWithFormat:@"download_album_id_%ld",taskModel.trackModel.albumId]];
    //3.生成一条记录插入到数据库中 此时的状态是未下载
    [[XMLYDownloadDBHelper helper] insertDownloadTaskHistory:taskModel.trackModel.trackId albumID:taskModel.trackModel.albumId];
}

/*
 * 检查track_id、album_id所代表的下载任务是否已经下载，或者正在下载
 */
- (BOOL)checkDownloadTask:(NSInteger)track_id albumID:(NSInteger)album_id {
    return [[XMLYDownloadDBHelper helper] itemExistsForTrackID:track_id albumId:album_id];
}



#pragma mark - getter


- (YYCache *)cache {
    if(!_cache) {
        _cache = [YYCache cacheWithName:@"xmly_cache_download_history_model"];
    }
    return _cache;
}

@end
