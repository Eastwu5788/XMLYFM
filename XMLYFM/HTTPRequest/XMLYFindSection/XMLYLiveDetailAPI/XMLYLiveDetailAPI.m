//
//  XMLYLiveDetailAPI.m
//  XMLYFM
//
//  Created by East_wu on 16/9/14.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYLiveDetailAPI.h"

static NSString *const kLiveDetailAPI = @"http://live.ximalaya.com/live-activity-web/v3/activity/detail";


@implementation XMLYLiveDetailAPI

+ (void)requestLiveDetail:(NSInteger)liveID completion:(XMLYBaseAPICompletion)completion {
    NSMutableDictionary *params = [self params];
    [params setObject:@(liveID) forKey:@"id"];
    
    XMLYBaseRequest *request = [XMLYBaseRequest requestWithURL:kLiveDetailAPI];
    [request startWithMethod:XMLYHTTPTypeGET params:params completion:^(id responseObject, NSString *message, BOOL success) {
        if(completion) {
            completion(responseObject,message,success);
        }
    }];
}

@end
