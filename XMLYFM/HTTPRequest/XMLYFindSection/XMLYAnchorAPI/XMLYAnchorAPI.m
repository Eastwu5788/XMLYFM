//
//  XMLYAnchorAPI.m
//  XMLYFM
//
//  Created by East_wu on 16/9/8.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYAnchorAPI.h"

static NSString *const kXMLYAnchorAPI = @"http://mobile.ximalaya.com/mobile/discovery/v1/anchor/recommend?device=iPhone&version=5.4.27";

@implementation XMLYAnchorAPI

+ (void)requestAnchorData:(XMLYBaseAPICompletion)completion {
    XMLYBaseRequest *request = [XMLYBaseRequest requestWithURL:kXMLYAnchorAPI];
    [request startWithMethod:XMLYHTTPTypeGET params:nil completion:^(id responseObject, NSString *message, BOOL success) {
        if(completion) {
            completion(responseObject,message,success);
        }
    }];
}

@end
