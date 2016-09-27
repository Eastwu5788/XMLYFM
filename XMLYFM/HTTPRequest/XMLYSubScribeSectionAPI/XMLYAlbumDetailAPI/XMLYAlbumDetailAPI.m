//
//  XMLYAlbumDetailAPI.m
//  XMLYFM
//
//  Created by East_wu on 16/9/13.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYAlbumDetailAPI.h"

static NSString *const kAlbumDetailAPI = @"http://mobile.ximalaya.com/mobile/v1/album/detail";
static NSString *const kAlbumListAPI = @"http://mobile.ximalaya.com/mobile/v1/album";

@implementation XMLYAlbumDetailAPI

/**
 *  请求专辑详情
 *  tab@订阅听_推荐
 *  @param albumId    专辑id
 *  @param tab        tab名称
 *  @param stat       子名称
 *  @param completion 完成回调
 */
+ (void)requestAlbumDetail:(NSInteger)albumId tab:(NSString *)tab stat:(NSString *)stat position:(NSInteger)position completion:(XMLYBaseAPICompletion)completion {
    NSMutableDictionary *params = [self params];
    [params setObject:@(albumId) forKey:@"albumId"];
    [params setObject:[NSString stringWithFormat:@"pageview/album@%ld",(long)albumId] forKey:@"statEvent"];
    [params setObject:stat forKey:@"statModule"];
    [params setObject:[NSString stringWithFormat:@"tab@%@_%@",tab,stat] forKey:@"statPage"];
    [params setObject:@(position) forKey:@"statPosition"];
    
    XMLYBaseRequest *request = [XMLYBaseRequest requestWithURL:kAlbumDetailAPI];
    [request startWithMethod:XMLYHTTPTypeGET params:params completion:^(id responseObject, NSString *message, BOOL success) {
        if(completion){
            completion(responseObject,message,success);
        }
    }];
    
}


/**
 *  请求专辑里面的分集列表
 *
 *  @param albumID    专辑id
 */
+ (void)requestAlbumWithID:(NSInteger)albumID trackId:(NSInteger)trackId tab:(NSString *)tab stat:(NSString *)stat position:(NSInteger)position completion:(XMLYBaseAPICompletion)completion {
    NSMutableDictionary *params = [self params];
    [params setObject:@(albumID) forKey:@"albumId"];
    [params setObject:@(20) forKey:@"pageSize"];
    [params setObject:@(0) forKey:@"source"];
    [params setObject:@(trackId) forKey:@"trackId"];
    [params setObject:[NSString stringWithFormat:@"pageview/album@%ld",(long)albumID] forKey:@"statEvent"];
    [params setObject:stat forKey:@"statModule"];
    [params setObject:[NSString stringWithFormat:@"tab@%@_%@",tab,stat] forKey:@"statPage"];
    [params setObject:@(position) forKey:@"statPosition"];
    
    XMLYBaseRequest *request = [XMLYBaseRequest requestWithURL:kAlbumListAPI];
    [request startWithMethod:XMLYHTTPTypeGET params:params completion:^(id responseObject, NSString *message, BOOL success) {
        if(completion){
            completion(responseObject,message,success);
        }
    }];

}

@end
