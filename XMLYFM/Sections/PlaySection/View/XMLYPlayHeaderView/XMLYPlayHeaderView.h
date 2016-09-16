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

@interface XMLYPlayHeaderView : XMLYBaseSecHeaderView

@property (nonatomic, strong) XMLYPlayPageModel *model;

//状态变化
- (void)audioStatusChanged:(DOUAudioStreamerStatus)status;
//进度变化
- (void)audioDurationChange:(NSTimeInterval)currentTime duration:(NSTimeInterval)duration;
//下载进度变化
- (void)audioBufferStatusChange:(NSUInteger)receivedLength expectedLength:(NSUInteger)expectedLength downloadSpeed:(NSUInteger)downloadSpeed;

@end
