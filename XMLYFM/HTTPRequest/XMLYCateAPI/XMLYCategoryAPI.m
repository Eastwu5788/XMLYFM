//
//  XMLYCategoryAPI.m
//  XMLYFM
//
//  Created by East_wu on 16/8/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYCategoryAPI.h"

#define kCategoryItemsAPI @"http://mobile.ximalaya.com/mobile/discovery/v2/categories?channel=ios-b1&code=43_110000_1100&device=iPhone&picVersion=13&scale=2&version=5.4.27"
#define kCategoryFooterAPI @"http://adse.ximalaya.com/ting?appid=0&device=iPhone&name=find_banner&network=WIFI&operator=3&scale=2&version=5.4.27"

@implementation XMLYCategoryAPI

/**
 *  类别中的分类和banner下方的按钮
 */
+ (void)requestCategory:(XMLYBaseAPICompletion)completion {
    XMLYBaseRequest *request = [XMLYBaseRequest requestWithURL:kCategoryItemsAPI];
    [request startWithMethod:XMLYHTTPTypeGET params:nil completion:^(id responseObject, NSString *message, BOOL success) {
        if(completion) {
            completion(responseObject,message,success);
        }
    }];
}

/**
 *  发现栏目中得FootView的请求地址
 */
+ (void)requestFootBanner:(XMLYBaseAPICompletion)completion {
    XMLYBaseRequest *request = [XMLYBaseRequest requestWithURL:kCategoryFooterAPI];
    [request startWithMethod:XMLYHTTPTypeGET params:nil completion:^(id responseObject, NSString *message, BOOL success) {
        if(completion) {
            completion(responseObject,message,success);
        }
    }];
}

@end
