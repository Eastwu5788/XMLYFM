//
//  XMLYScribeRecomAPI.m
//  XMLYFM
//
//  Created by East_wu on 16/9/9.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYScribeRecomAPI.h"

static NSString *const kScribeRecomAPI = @"http://mobile.ximalaya.com/feed/v1/recommend/classic/unlogin";

@implementation XMLYScribeRecomAPI

+ (void)requestScribeRecomData:(NSInteger)page completion:(XMLYBaseAPICompletion)completion{
   
    NSMutableDictionary *params = [self params];
    [params setObject:@(page) forKey:@"pageId"];
    [params setObject:@"iPhone" forKey:@"device"];
    [params setObject:@(20) forKey:@"pageSize"];
    [params setObject:@(1473389098.260717) forKey:@"ts"];
    
    XMLYBaseRequest *request = [XMLYBaseRequest requestWithURL:kScribeRecomAPI];
    [request startWithMethod:XMLYHTTPTypeGET params:params completion:^(id responseObject, NSString *message, BOOL success) {
        if(completion) {
            completion(responseObject,message,success);
        }
    }];
}

@end
