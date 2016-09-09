//
//  XMLYFindAPI.m
//  XMLYFM
//
//  Created by East_wu on 16/8/9.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYFindAPI.h"

#define kRecommendAPI     @"http://mobile.ximalaya.com/mobile/discovery/v4/recommends?channel=ios-b1&device=iPhone&includeActivity=true&includeSpecial=true&scale=2&version=5.4.21"

#define kHotAndGuessAPI   @"http://mobile.ximalaya.com/mobile/discovery/v2/recommend/hotAndGuess?code=43_110000_1100&device=iPhone&version=5.4.21"

#define kLiveRecommendAPI @"http://live.ximalaya.com/live-activity-web/v3/activity/recommend"

#define kRecomBannerAPI   @"http://adse.ximalaya.com/ting?appid=0&device=iPhone&name=find_banner&network=WIFI&operator=3&scale=2&version=5.4.21"

@implementation XMLYFindAPI

/**
 *  由于都是抓的接口，所以都是写死的东西
 */
+ (void)requestRecommends:(XMLYBaseAPICompletion)completion {
    XMLYBaseRequest *request = [XMLYBaseRequest requestWithURL:kRecommendAPI];
    [request startWithMethod:XMLYHTTPTypeGET params:nil completion:^(id responseObject, NSString *message, BOOL success) {
        if(completion){
            completion(responseObject,message,success);
        }
    }];
}

+ (void)requestHotAndGuess:(XMLYBaseAPICompletion)completion {
    XMLYBaseRequest *request = [XMLYBaseRequest requestWithURL:kHotAndGuessAPI];
    [request startWithMethod:XMLYHTTPTypeGET params:nil completion:^(id responseObject, NSString *message, BOOL success) {
        if(completion){
            completion(responseObject,message,success);
        }
    }];
}

+ (void)requestLiveRecommend:(XMLYBaseAPICompletion)completion {
    XMLYBaseRequest *request = [XMLYBaseRequest requestWithURL:kLiveRecommendAPI];
    [request startWithMethod:XMLYHTTPTypeGET params:nil completion:^(id responseObject, NSString *message, BOOL success) {
        if(completion){
            completion(responseObject,message,success);
        }
    }];
}

+ (void)requestFooterAd:(XMLYBaseAPICompletion)completion {
    XMLYBaseRequest *request = [XMLYBaseRequest requestWithURL:kRecomBannerAPI];
    [request startWithMethod:XMLYHTTPTypeGET params:nil completion:^(id responseObject, NSString *message, BOOL success) {
        if(completion){
            completion(responseObject,message,success);
        }
    }];
}

@end
