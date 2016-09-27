//
//  XMLYAlbumDetailAPI.h
//  XMLYFM
//
//  Created by East_wu on 16/9/13.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseAPI.h"

@interface XMLYAlbumDetailAPI : XMLYBaseAPI

/**
 *  请求专辑详情
 *  tab@订阅听_推荐
 *  @param albumId    专辑id
 *  @param tab        tab名称
 *  @param stat       子名称
 *  @param completion 完成回调
 */
+ (void)requestAlbumDetail:(NSInteger)albumId tab:(NSString *)tab stat:(NSString *)stat position:(NSInteger)position completion:(XMLYBaseAPICompletion)completion;

/**
 *  请求专辑里面的分集列表
 *
 *  @param albumID    专辑id
 */
+ (void)requestAlbumWithID:(NSInteger)albumID trackId:(NSInteger)trackId tab:(NSString *)tab stat:(NSString *)stat position:(NSInteger)position completion:(XMLYBaseAPICompletion)completion;

@end
