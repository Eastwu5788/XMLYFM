//
//  XMLYPlayAlbumTrackAPI.m
//  XMLYFM
//
//  Created by East_wu on 16/9/15.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYPlayAlbumTrackAPI.h"

static NSString *kPlayAlbumTrackAPI = @"http://mobile.ximalaya.com/v1/track/ca/playpage/18556415";

@implementation XMLYPlayAlbumTrackAPI

/*
 *  请求相册音频详情
 */
+ (void)requestPlayAlbumTrackDetailWithAblumID:(NSInteger)albumID trackUID:(NSInteger)trackID completion:(XMLYBaseAPICompletion)completion {
    NSMutableDictionary *params = [self params];
    [params setObject:@(albumID) forKey:@"albumId"];
    [params setObject:@(trackID) forKey:@"trackUid"];
    
    XMLYBaseRequest *request = [XMLYBaseRequest requestWithURL:kPlayAlbumTrackAPI];
    [request startWithMethod:XMLYHTTPTypeGET params:params completion:^(id responseObject, NSString *message, BOOL success) {
        if(completion) {
            completion(responseObject,message,success);
        }
    }];
}

@end
