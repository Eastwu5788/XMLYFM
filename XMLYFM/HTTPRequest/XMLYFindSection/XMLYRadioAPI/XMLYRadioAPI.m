//
//  XMLYRadioAPI.m
//  XMLYFM
//
//  Created by East_wu on 16/9/7.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYRadioAPI.h"

static NSString *const kXMLYRadioAPI = @"http://live.ximalaya.com/live-web/v4/homepage?device=iPhone";

@implementation XMLYRadioAPI

+ (void)requestRadioRecommend:(XMLYBaseAPICompletion)completion {
    XMLYBaseRequest *request = [XMLYBaseRequest requestWithURL:kXMLYRadioAPI];
    [request startWithMethod:XMLYHTTPTypeGET params:nil completion:^(id responseObject, NSString *message, BOOL success) {
        if(completion) {
            completion(responseObject,message,success);
        }
    }];
}

@end
