//
//  XMLYListenListAPI.m
//  XMLYFM
//
//  Created by East_wu on 16/9/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYListenListAPI.h"

static NSString *kListenListAPI = @"http://mobile.ximalaya.com/m/subject_list";

@implementation XMLYListenListAPI

+ (void)requestListenListWithPage:(NSInteger)page completion:(XMLYBaseAPICompletion)completion {
    NSMutableDictionary *params = [self params];
    [params setObject:@"iPhone" forKey:@"device"];
    [params setObject:@(page) forKey:@"page"];
    [params setObject:@(20) forKey:@"per_page"];
    [params setObject:@(2) forKey:@"scale"];
    [params setObject:@"pageview/subjectlist@精品听单" forKey:@"statEvent"];
    [params setObject:@"精品听单_更多" forKey:@"statModule"];
    [params setObject:@"tab@发现_推荐" forKey:@"statPage"];
    
    XMLYBaseRequest *request = [XMLYBaseRequest requestWithURL:kListenListAPI];
    [request startWithMethod:XMLYHTTPTypeGET params:params completion:^(id responseObject, NSString *message, BOOL success) {
        if(completion) {
            completion(responseObject,message,success);
        }
    }];
}

@end
