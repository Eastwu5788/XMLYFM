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
 | --- id int --- | --- album_id int --- | --- track_id --- | --- album_title varchar(1000) --- | --- track_title varchar(1000) --- | --- coverSmall varchar(1000) --- | --- time_history int --- |  --- isPlaying --- | --- create_time int --- | --- update_time --- |
      主键自增            专辑id                  分集id                专辑标题                            分集标题                                小封面                             上次播放到的时间            是否正在播放             记录创建时间              记录修改时间
 */

static NSString *const kDBSqlCreateTable = @"create table if not exists xmly_play_history_cache(id integer primary key autoincrement,album_id int,track_id int,album_title text,track_title text,coverSmall text,time_history int,isPlaying int,create_time int,update_time int);";

@interface XMLYPlayDBHelper ()

@property (nonatomic, strong) FMDatabase *dataBase;

@end

@implementation XMLYPlayDBHelper

+ (instancetype)dbHelper {
    XMLYPlayDBHelper *helper = [XMLYPlayDBHelper new];
    [helper createDataBaseTable];
    return helper;
}

#pragma mark - 保存当前播放的数据
- (void)saveCurrentPlayAudioInfo:(XMLYPlayPageModel *)playModel {
    int timestamp = (int)time(NULL);
    //查询数据库中有没有旧数据
    NSString *querySql = [NSString stringWithFormat:@"select * from xmly_play_history_cache where album_id = %ld;",playModel.albumInfo.albumId];
    //更新当前的信息
    NSString *updateSql = [NSString stringWithFormat:@"update xmly_play_history_cache set isPlaying = 1,update_time = %d where album_id = %ld;",timestamp,playModel.albumInfo.albumId];
    //如果当前数据库表中无数据，则插入新数据
    NSString *insertSql = [NSString stringWithFormat:@"insert into xmly_play_history_cache(album_id,track_id,album_title,track_title,coverSmall,time_history,isPlaying,create_time,update_time) values (%ld,%ld,'%@','%@','%@',%d,%d,%d,%d);",playModel.albumInfo.albumId,playModel.trackInfo.trackId,playModel.albumInfo.title,playModel.trackInfo.title,playModel.albumInfo.coverSmall,0,1,timestamp,timestamp];
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
- (void)updateLastPlayingRecord {
    //关闭上一次播放的记录，更新为未正在播放
    NSString *updateSql = [NSString stringWithFormat:@"update xmly_play_history_cache set isPlaying = 0 where isPlaying = 1;"];
    [self.dataBase open];
    [self.dataBase executeUpdate:updateSql];
    [self.dataBase close];
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
