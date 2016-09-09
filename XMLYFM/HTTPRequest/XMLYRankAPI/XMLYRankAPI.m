//
//  XMLYRankAPI.m
//  XMLYFM
//
//  Created by East_wu on 16/9/8.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYRankAPI.h"

static NSString *const kXMLYRankAPI = @"http://mobile.ximalaya.com/mobile/discovery/v2/rankingList/group?channel=ios-b1&device=iPhone&includeActivity=true&includeSpecial=true&scale=2&version=5.4.27";

@implementation XMLYRankAPI

+ (void)requestRankresponse:(XMLYBaseAPICompletion)completion {
    XMLYBaseRequest *request = [XMLYBaseRequest requestWithURL:kXMLYRankAPI];
    [request startWithMethod:XMLYHTTPTypeGET params:nil completion:^(id responseObject, NSString *message, BOOL success) {
        if(completion) {
            completion(responseObject,message,success);
        }
    }];
}

@end
