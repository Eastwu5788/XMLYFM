//
//  XMLYFindRecommendHelper.m
//  XMLYFM
//
//  Created by East_wu on 16/8/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYFindRecommendHelper.h"
#import "XMLYNotification.h"

@interface XMLYFindRecommendHelper ()

@property (nonatomic, strong) NSTimer *findRecommendLiveTimer;

@property (nonatomic, strong) NSTimer *findRecommendHeaderTimer;

@end

@implementation XMLYFindRecommendHelper

#pragma mark - 公共部分
+ (instancetype)helper {
    static XMLYFindRecommendHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[XMLYFindRecommendHelper alloc] init];
    });
    return helper;
}

/**
 *  销毁所有的定时器
 */
- (void)destoryAllTimer {
    [self destoryLiveTimer];
    [self destoryHeaderTimer];
}


#pragma mark - 直播定时器相关
/**
 *  开启定时器
 */
- (void)startLiveTimer {
    [self destoryLiveTimer];
    _findRecommendLiveTimer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(liveTimerChanged) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_findRecommendLiveTimer forMode:NSRunLoopCommonModes];
}


/**
 *  销毁定时器
 */
- (void)destoryLiveTimer {
    if(self.findRecommendLiveTimer) {
        [self.findRecommendLiveTimer setFireDate:[NSDate distantFuture]];
        [self.findRecommendLiveTimer invalidate];
        self.findRecommendLiveTimer = nil;
    }
}

/**
 *  广播通知状态改变
 */
- (void)liveTimerChanged {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationFindRecommendLiveTimer object:nil];
}

#pragma mark - 头部定时器相关

- (void)startHeadTimer {
    [self destoryHeaderTimer];
    _findRecommendHeaderTimer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(headerTimerChanged) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_findRecommendHeaderTimer forMode:NSRunLoopCommonModes];
}

- (void)destoryHeaderTimer {
    if(self.findRecommendHeaderTimer) {
        [self.findRecommendHeaderTimer setFireDate:[NSDate distantFuture]];
        [self.findRecommendHeaderTimer invalidate];
        self.findRecommendHeaderTimer = nil;
    }
}

- (void)headerTimerChanged {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationFindRecommendHeaderTimer object:nil];
}

@end
