//
//  XMLYDownloadManager.h
//  XMLYFM
//
//  Created by East_wu on 16/9/19.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLYDownTaskModel.h"

typedef NS_ENUM(NSInteger, XMLYDownloadError) {
    XMLYDownloadErrorExists       = 0,  //当前下载任务以存在
    XMLYDownloadErrorIllegalInput = 1, //输入非法
    XMLYDownloadErrorDefined      = 1,  //当前不允许下载
    XMLYDownloadErrorMemoryNeed   = 2,  //内存不足
    XMLYDownloadErrorUnknown      = 3,  //未知错误
    XMLYDownloadErrorNone         = 4,  //未出错
};

@protocol XMLYDownloadManagerDelegate <NSObject>

/*
 * 下载进度发生变化的回调
 */
- (void)downloadProgress:(NSInteger)downloaded expected:(NSInteger)expected trackID:(NSInteger)track_id albumID:(NSInteger)album_id;

@end

@interface XMLYDownloadManager : NSObject

+ (instancetype)manager;

/*
 * 设置一次最多有多少条下载任务
 * 默认是2条
 */
@property (nonatomic, assign) NSInteger maxDownloadCount;

/*
 * 代理
 */
@property (nonatomic, weak) __weak id<XMLYDownloadManagerDelegate> delegate;

/* 
 * 新增一个下载任务
 * 如果当前任务已存在，则会返回false
 * 下载任务创建成功 返回yes
 */
- (void)addDownloadTask:(XMLYDownTaskModel *)taskModel completion:(void(^)(BOOL success,XMLYDownloadError error))completion;

/*
 * 查询当前正在进行的所有下载任务
 */
- (NSMutableArray<XMLYDownTaskModel *> *)downloadTasks;

/*
 * 查询album_id 获取albumModel
 */
- (XMLYAlbumModel *)taskModelAlbumFromAlbumID:(NSInteger)album_id;

/*
 * 根据track_id 获取trackModel
 */
- (XMLYAlbumTrackItemModel *)taskModelTrackFromAlbumID:(NSInteger)track_id;

@end
