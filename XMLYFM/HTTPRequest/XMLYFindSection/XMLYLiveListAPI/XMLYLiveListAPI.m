//
//  XMLYLiveListAPI.m
//  XMLYFM
//
//  Created by East_wu on 16/9/11.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYLiveListAPI.h"

static NSString *const kLiveListAPI = @"http://live.ximalaya.com/live-activity-web/v3/activity/list";

@implementation XMLYLiveListAPI

+ (void)requestLiveList:(NSInteger)page completion:(XMLYBaseAPICompletion)completion {
    NSMutableDictionary *params = [self params];
    [params setObject:@"iPhone" forKey:@"device"];
    [params setObject:@(page) forKey:@"pageId"];
    [params setObject:@(30) forKey:@"pageSize"];
    [params setObject:@"pageview/livelist@现场直播" forKey:@"statEvent"];
    [params setObject:@"现场直播_更多" forKey:@"statModule"];
    [params setObject:@"tab@发现_推荐" forKey:@"statPage"];
    
    XMLYBaseRequest *request = [XMLYBaseRequest requestWithURL:kLiveListAPI];
    [request startWithMethod:XMLYHTTPTypeGET params:params completion:^(id responseObject, NSString *message, BOOL success) {
        if(completion) {
            completion(responseObject,message,success);
        }
    }];
}

@end
