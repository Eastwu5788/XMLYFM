//
//  XMLYFindRecommendHelper.h
//  XMLYFM
//
//  Created by East_wu on 16/8/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLYFindRecommendHelper : NSObject

#pragma mark - Common
+ (instancetype)helper;

/**
 *  销毁所有的定时器
 */
- (void)destoryAllTimer;

#pragma mark - Live
/**
 *  开启为直播设置的定时器
 */
- (void)startLiveTimer;

/**
 *  销毁定时器
 */
- (void)destoryLiveTimer;

#pragma mark - Header
/**
 *  开启头部的定时器
 */
- (void)startHeadTimer;

/**
 *  销毁头部的定时器
 */
- (void)destoryHeaderTimer;



@end
