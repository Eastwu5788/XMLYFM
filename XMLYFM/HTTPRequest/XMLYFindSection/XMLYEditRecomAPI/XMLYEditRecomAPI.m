//
//  XMLYEditRecomAPI.m
//  XMLYFM
//
//  Created by East_wu on 16/9/11.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYEditRecomAPI.h"

static NSString *kEditRecomAPI = @"http://mobile.ximalaya.com/mobile/discovery/v2/recommend/editor";

@implementation XMLYEditRecomAPI

+ (void)requestEditRecomWithPage:(NSInteger)page completion:(XMLYBaseAPICompletion)completion {
    NSMutableDictionary *params = [self params];
    [params setObject:@"iPhone" forKey:@"device"];
    [params setObject:@(page) forKey:@"pageId"];
    [params setObject:@(20) forKey:@"pageSize"];
    [params setObject:@"pageview/albumlist@小编推荐" forKey:@"statEvent"];
    [params setObject:@"小编推荐_更多" forKey:@"statModule"];
    [params setObject:@"tab@发现_推荐" forKey:@"statPage"];
    [params setObject:@"5.4.27" forKey:@"version"];
    
    XMLYBaseRequest *request = [XMLYBaseRequest requestWithURL:kEditRecomAPI];
    [request startWithMethod:XMLYHTTPTypeGET params:params completion:^(id responseObject, NSString *message, BOOL success) {
        if(completion) {
            completion(responseObject,message,success);
        }
    }];

}

@end
