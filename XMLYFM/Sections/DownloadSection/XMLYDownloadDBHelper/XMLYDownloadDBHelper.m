//
//  XMLYDownloadDBHelper.m
//  XMLYFM
//
//  Created by East_wu on 16/9/19.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYDownloadDBHelper.h"
#import "FMDatabase.h"

/*
 下载记录表
 status : 0、等待下载 1、正在下载 2、已下载 3、下载失败，等待下次重试
 
 |- id 主键自增 -|- track_id -| - album_id - | - status - | - create_ime - | - update_time - |
 */

static NSString *kDBTableCreateSQL = @"create table if not exists xmly_download_history_cache(id integer primary key autoincrement,track_id int,album_id int,status int,create_time int,update_time int);";

@interface XMLYDownloadDBHelper ()

@property (nonatomic, strong) FMDatabase *dataBase;

@end

@implementation XMLYDownloadDBHelper

+ (instancetype)helper {
    XMLYDownloadDBHelper *helper = [[XMLYDownloadDBHelper alloc] init];
    [helper createDataBaseTable];
    return helper;
}

#pragma mark - 更新记录
- (void)updateDownloadTask:(NSInteger)track_id albumID:(NSInteger)album_id status:(NSInteger)status {
    NSString *sql = [NSString stringWithFormat:@"update xmly_download_history_cache set status = %ld where track_id = %ld and album_id = %ld",status,track_id,album_id];
    [self.dataBase open];
    [self.dataBase executeUpdate:sql];
    [self.dataBase close];
}

#pragma mark - 查询记录
/*
 *  查询某一条记录是否存在
 */
- (BOOL)itemExistsForTrackID:(NSInteger)track_id albumId:(NSInteger)album_id {
    NSString *sql = [NSString stringWithFormat:@"select id from xmly_download_history_cache where track_id = %ld and album_id = %ld",track_id,album_id];
    [self.dataBase open];
    FMResultSet *result = [self.dataBase executeQuery:sql];
    [self.dataBase close];
    return result.next;
}

/*
 * 查询专辑数据
 */
- (NSArray *)queryAlbumsFromDownloadHistory {
    NSString *sql = [NSString stringWithFormat:@"select album_id from xmly_download_history_cache"];
    [self.dataBase open];
    FMResultSet *result = [self.dataBase executeQuery:sql];
    NSMutableArray *arr = [NSMutableArray new];
    while (result.next) {
        NSInteger result_id = [result intForColumn:@"album_id"];
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"integerValue == %ld",result_id];
        NSArray *result = [arr filteredArrayUsingPredicate:pre];
        if(result.count == 0) {
            [arr addObject:@(result_id)];
        }
    }
    [self.dataBase close];
    return arr;
}


/*
 * 更具album_id查询track_id;
 */
- (NSArray *)queryTrackByAlbumFromDownloadHistory:(NSInteger)album_id {
    NSString *sql = [NSString stringWithFormat:@"select track_id from xmly_download_history_cache where album_id = %ld",album_id];
    [self.dataBase open];
    FMResultSet *result = [self.dataBase executeQuery:sql];
    NSMutableArray *arr = [NSMutableArray new];
    while (result.next) {
        NSInteger result_id = [result intForColumn:@"track_id"];
        [arr addObject:@(result_id)];
    }
    return arr;
}

/*
 * 查询声音id
 */
- (NSArray *)queryTracksFromDownloadHistory {
    NSString *sql = [NSString stringWithFormat:@"select track_id from xmly_download_history_cache where status = 2"];
    [self.dataBase open];
    FMResultSet *result = [self.dataBase executeQuery:sql];
    NSMutableArray *arr = [NSMutableArray new];
    while (result.next) {
        NSInteger result_id = [result intForColumn:@"track_id"];
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"integerValue == %ld",result_id];
        NSArray *result = [arr filteredArrayUsingPredicate:pre];
        if(result.count == 0) {
            [arr addObject:@(result_id)];
        }
    }
    [self.dataBase close];
    return arr;
}

#pragma mark - 插入记录
/*
 * 插入一条新的下载记录
 */
- (void)insertDownloadTaskHistory:(NSInteger)track_id albumID:(NSInteger)album_id {
    int timestamp = (int)time(NULL);
    NSString *sql = [NSString stringWithFormat:@"insert into xmly_download_history_cache(track_id,album_id,status,create_time,update_time) values (%ld,%ld,0,%d,%d);",track_id,album_id,timestamp,timestamp];
    [self.dataBase open];
    [self.dataBase executeUpdate:sql];
    [self.dataBase close];
}

#pragma mark - 数据库创建
/*
 *   创建数据库表
 */
- (void)createDataBaseTable {
    //打开数据库
    [self.dataBase open];
    //执行创建数据库操作
    [self.dataBase executeUpdate:kDBTableCreateSQL];
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
    return [path stringByAppendingPathComponent:@"fmdb_audio_down_history_cache_db.sqlite"];
}

@end
