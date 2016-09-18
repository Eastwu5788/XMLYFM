//
//  XMLYPlayHeaderView.h
//  XMLYFM
//
//  Created by East_wu on 16/9/15.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseSecHeaderView.h"
#import "XMLYPlayPageModel.h"
#import "XMLYAudioHelper.h"


@class XMLYPlayHeaderView;

@protocol XMLYPlayHeaderViewDelegate <NSObject>

// 播放、暂停按钮事件点击回调
- (void)playHeaderView:(XMLYPlayHeaderView *)view didStatuButtonClick:(UIButton *)btn;

// 上一个按钮点击事件回调
- (void)playHeaderView:(XMLYPlayHeaderView *)view didPreButtonClick:(UIButton *)btn;

// 下一个按钮点击事件回调
- (void)playHeaderView:(XMLYPlayHeaderView *)view didNextButtonClick:(UIButton *)btn;

@end

@interface XMLYPlayHeaderView : XMLYBaseSecHeaderView

@property (nonatomic, strong) XMLYPlayPageModel *model;

@property (nonatomic, weak) __weak id<XMLYPlayHeaderViewDelegate> delegate;

//状态变化
- (void)audioStatusChanged:(DOUAudioStreamerStatus)status;
//进度变化
- (void)audioDurationChange:(NSTimeInterval)currentTime duration:(NSTimeInterval)duration;
//下载进度变化
- (void)audioBufferStatusChange:(NSUInteger)receivedLength expectedLength:(NSUInteger)expectedLength downloadSpeed:(NSUInteger)downloadSpeed;

@end
