//
//  XMLYListenDetailAPI.m
//  XMLYFM
//
//  Created by East_wu on 16/9/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYListenDetailAPI.h"

static NSString *const kListenDetailAPI = @"http://mobile.ximalaya.com/m/subject_detail";

@implementation XMLYListenDetailAPI

+ (void)requestListenDetailAPI:(NSInteger)cid completion:(XMLYBaseAPICompletion)completion {
    NSMutableDictionary *params = [self params];
    [params setObject:@(cid) forKey:@"id"];
    [params setObject:@"iPhone" forKey:@"device"];
    [params setObject:[NSString stringWithFormat:@"pageview/subject@%ld",(long)cid] forKey:@"statEvent"];
    [params setObject:@"subjectlist@精品听单" forKey:@"statPage"];
    [params setObject:@(1) forKey:@"statPosition"];
    [params setObject:@"精品听单" forKey:@"statModule"];
    
    XMLYBaseRequest *request = [XMLYBaseRequest requestWithURL:kListenDetailAPI];
    [request startWithMethod:XMLYHTTPTypePOST params:params completion:^(id responseObject, NSString *message, BOOL success) {
        if(completion) {
            completion(responseObject,message,success);
        }
    }];
}

@end
