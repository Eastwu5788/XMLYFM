//
//  XMLYPlayDBHelper.m
//  XMLYFM
//
//  Created by East_wu on 16/9/16.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYPlayDBHelper.h"
#import "FMDatabase.h"

/*
 | --- id int --- | --- album_id int --- | --- track_id --- | --- album_title varchar(1000) --- | --- track_title varchar(1000) --- | --- coverSmall varchar(1000) --- | --- cache_path --- | --- time_history int --- |  --- isPlaying --- | --- create_time int --- | --- update_time --- |
      主键自增            专辑id                  分集id                专辑标题                            分集标题                                小封面                             上次播放到的时间            是否正在播放             记录创建时间              记录修改时间
 */

static NSString *const kDBSqlCreateTable = @"create table if not exists xmly_play_history_cache(id integer primary key autoincrement,album_id int,track_id int,album_title text,track_title text,coverSmall text,cache_path text,time_history int,isPlaying int,create_time int,update_time int);";

@interface XMLYPlayDBHelper ()

@property (nonatomic, strong) FMDatabase *dataBase;

@end

@implementation XMLYPlayDBHelper

+ (instancetype)dbHelper {
    XMLYPlayDBHelper *helper = [XMLYPlayDBHelper new];
    [helper createDataBaseTable];
    return helper;
}

#pragma mark - 查询是否当前播放的数据
- (XMLYBaseAudioModel *)queryPlayingAudio {
    //查询数据库中正在播放的数据
    NSString *querySql = [NSString stringWithFormat:@"select * from xmly_play_history_cache order by update_time desc;"];
   
    //打开数据库
    [self.dataBase open];
    //执行sql语句
    FMResultSet *set = [self.dataBase executeQuery:querySql];
    //sql结果转换
    XMLYBaseAudioModel *audioModel = [self transQueryResurt2Model:set];
    //关闭数据库
    [self.dataBase close];
    return audioModel;
}

//批量查询历史记录
- (NSMutableArray<XMLYBaseAudioModel *> *)queryPlayHistory {
    //sql语句
    NSString *querySql = [NSString stringWithFormat:@"select * from xmly_play_history_cache order by update_time desc;"];
    //打开数据库
    [self.dataBase open];
    //执行sql语句
    FMResultSet *set = [self.dataBase executeQuery:querySql];
    //结果转换
    NSMutableArray *results = [self transQueryResult2ModelArray:set];
    //关闭数据库
    [self.dataBase close];
    return results;
}

#pragma mark - 保存当前播放的数据
- (void)saveCurrentPlayAudioInfo:(XMLYPlayPageModel *)playModel cachePath:(NSString *)path{
    int timestamp = (int)time(NULL);
    //查询数据库中有没有旧数据
    NSString *querySql = [NSString stringWithFormat:@"select * from xmly_play_history_cache where album_id = %ld;",playModel.albumInfo.albumId];
    //更新当前的信息
    NSString *updateSql = [NSString stringWithFormat:@"update xmly_play_history_cache set isPlaying = 1,update_time = %d where album_id = %ld;",timestamp,playModel.albumInfo.albumId];
    //如果当前数据库表中无数据，则插入新数据
    NSString *insertSql = [NSString stringWithFormat:@"insert into xmly_play_history_cache(album_id,track_id,album_title,track_title,coverSmall,cache_path,time_history,isPlaying,create_time,update_time) values (%ld,%ld,'%@','%@','%@','%@',%d,%d,%d,%d);",playModel.albumInfo.albumId,playModel.trackInfo.trackId,playModel.albumInfo.title,playModel.trackInfo.title,playModel.albumInfo.coverSmall,path,0,1,timestamp,timestamp];
    //打开数据库
    [self.dataBase open];
    //查询是否有旧数据
    FMResultSet *set = [self.dataBase executeQuery:querySql];
    //有旧数据则更新，无旧数据就插入
    if(set.next) {
        [self.dataBase executeUpdate:updateSql];
    } else {
        [self.dataBase executeUpdate:insertSql];
    }
    [self.dataBase close];
}

- (void)deleteRecordByAlbumId:(NSInteger)albumID trackID:(NSInteger)trackID {
    
}

#pragma mark - 更新数据变化
//关闭上一次播放的记录
- (void)updateLastPlayingRecordWithDuration:(NSInteger)time {
    //关闭上一次播放的记录，更新为未正在播放
    NSString *updateSql = [NSString stringWithFormat:@"update xmly_play_history_cache set isPlaying = 0,time_history = %ld where isPlaying = 1;",time];
    [self.dataBase open];
    [self.dataBase executeUpdate:updateSql];
    [self.dataBase close];
}

#pragma mark - private
// 将查询结果转换成模型
- (XMLYBaseAudioModel *)transQueryResurt2Model:(FMResultSet *)result {
    while (result.next) {
        XMLYBaseAudioModel *model = [[XMLYBaseAudioModel alloc] init];
        model.cid = [result intForColumn:@"id"];
        model.album_id = [result intForColumn:@"album_id"];
        model.track_id = [result intForColumn:@"track_id"];
        model.album_title = [result stringForColumn:@"album_title"];
        model.track_title = [result stringForColumn:@"track_title"];
        model.coverSmall = [result stringForColumn:@"coverSmall"];
        model.time_history = [result intForColumn:@"time_history"];
        model.isPlaying = [result intForColumn:@"isPlaying"];
        model.cachePath = [result stringForColumn:@"cache_path"];
        return model;
    }
    return nil;
}

- (NSMutableArray *)transQueryResult2ModelArray:(FMResultSet *)result {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    while (result.next) {
        XMLYBaseAudioModel *model = [[XMLYBaseAudioModel alloc] init];
        model.cid = [result intForColumn:@"id"];
        model.album_id = [result intForColumn:@"album_id"];
        model.track_id = [result intForColumn:@"track_id"];
        model.album_title = [result stringForColumn:@"album_title"];
        model.track_title = [result stringForColumn:@"track_title"];
        model.coverSmall = [result stringForColumn:@"coverSmall"];
        model.time_history = [result intForColumn:@"time_history"];
        model.isPlaying = [result intForColumn:@"isPlaying"];
        model.cachePath = [result stringForColumn:@"cache_path"];
        [arr addObject:model];
    }
    return arr;
}

#pragma mark - 初始化
/*
 *   创建数据库表
 */
- (void)createDataBaseTable {
    //打开数据库
    [self.dataBase open];
    //执行创建数据库操作
    [self.dataBase executeUpdate:kDBSqlCreateTable];
    //关闭数据库
    [self.dataBase close];
}

#pragma mark - getter
- (FMDatabase *)dataBase {
    if(!_dataBase) {
        _dataBase = [FMDatabase databaseWithPath:[self dataBasePath]];
    }
    return _dataBase;
}

- (NSString *)dataBasePath {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [path stringByAppendingPathComponent:@"fmdb_play_history_cache_db.sqlite"];
}

@end
