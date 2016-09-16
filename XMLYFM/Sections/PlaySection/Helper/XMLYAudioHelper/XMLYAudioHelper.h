//
//  XMLYAudioHelper.h
//  XMLYFM
//
//  Created by East_wu on 16/9/16.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLYAudioItem.h"
#import "DOUAudioStreamer.h"
#import "DOUAudioVisualizer.h"

@protocol XMLYAudioHelperDelegate <NSObject>

/* 
 * 音频播放进度发生变化
 * currentTime: 当前播放时间
 * duration: 总时长
 */
- (void)audioHelperDurationChange:(NSTimeInterval)currentTime duration:(NSTimeInterval)duration;

/*
 * 状态变化的回调
 * status：新状态
 */
- (void)audioHelperStatuChange:(DOUAudioStreamerStatus)status;

/*
 * 下载进度发生变化
 * receivedLength: 当前以下载的音频大小
 * expectedLength: 当前音频总长度
 * downloadSpeed: 当前下载速度
 */
- (void)audioHelperBufferStatusChange:(NSUInteger)receivedLength expectedLength:(NSUInteger)expectedLength downloadSpeed:(NSUInteger)downloadSpeed;

@end


@interface XMLYAudioHelper : NSObject

//代理
@property (nonatomic, weak) __weak id<XMLYAudioHelperDelegate>delegate;

+ (instancetype)helper;

// 播放某一个音频 播放下一个、上一个音频 传入该audio的item即可
- (void)startPlayAudioWithItem:(XMLYAudioItem *)item;

// 暂停、播放 根据当前状态自动判断
- (void)actionPlayPaush;

// 停止
- (void)actionStop;

// 设置当前进度
- (void)actionProgress:(NSTimeInterval)timeInterval;

// 销毁当前音频流
- (void)destoryAudioStream;

@end
