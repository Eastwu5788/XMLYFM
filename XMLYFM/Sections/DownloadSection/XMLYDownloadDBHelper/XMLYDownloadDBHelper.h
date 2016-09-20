//
//  XMLYDownloadDBHelper.h
//  XMLYFM
//
//  Created by East_wu on 16/9/19.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLYDownloadDBHelper : NSObject

+ (instancetype)helper;

/*
 *  查询某一条记录是否存在
 */
- (BOOL)itemExistsForTrackID:(NSInteger)track_id albumId:(NSInteger)album_id;

/*
 *  向数据库中插入一条新的记录
 */
- (void)insertDownloadTaskHistory:(NSInteger)track_id albumID:(NSInteger)album_id;

/*
 *  更新下载状态
 */
- (void)updateDownloadTask:(NSInteger)track_id albumID:(NSInteger)album_id status:(NSInteger)status;

/*
 * 查询专辑数据
 */
- (NSArray *)queryAlbumsFromDownloadHistory;

/*
 * 查询声音id
 */
- (NSArray *)queryTracksFromDownloadHistory;

/*
 * 更具album_id查询track_id;
 */
- (NSArray *)queryTrackByAlbumFromDownloadHistory:(NSInteger)album_id;

@end
