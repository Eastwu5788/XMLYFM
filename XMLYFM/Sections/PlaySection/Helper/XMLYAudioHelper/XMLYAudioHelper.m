//
//  XMLYAudioHelper.m
//  XMLYFM
//
//  Created by East_wu on 16/9/16.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYAudioHelper.h"

static void *kAudioStatusKVOKey = &kAudioStatusKVOKey;
static void *kAudioDurationKVOKey = &kAudioDurationKVOKey;
static void *kAudioBufferingRatioKVOKey = &kAudioBufferingRatioKVOKey;


@interface XMLYAudioHelper ()

@property (nonatomic, strong) DOUAudioStreamer      *streamer;
@property (nonatomic, strong) DOUAudioVisualizer    *audioVisualizer;
@property (nonatomic, strong) NSTimer               *timer;

@end

@implementation XMLYAudioHelper

+ (instancetype)helper {
    static XMLYAudioHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[XMLYAudioHelper alloc] init];
    });
    return helper;
}

#pragma mark - public
// 播放某一段音频
- (void)startPlayAudioWithItem:(XMLYAudioItem *)item withProgress:(NSInteger)progress{
    [self resetStreamerWithItem:item withProgress:progress];
}

// 暂停、播放
- (void)actionPlayPaush {
    self.oriProgress = 0;
    if([self.streamer status] == DOUAudioStreamerPaused || [self.streamer status] == DOUAudioStreamerIdle) {
        [self.streamer play];
    } else {
        [self.streamer pause];
    }
}

// 停止
- (void)actionStop {
    [self.streamer stop];
}

// 设置进度
- (void)actionProgress:(NSTimeInterval)timeInterval {
    [self.streamer setCurrentTime:timeInterval];
}

// 销毁当前音频流
- (void)destoryAudioStream {
    [_timer invalidate];
    [self.streamer stop];
    [self cancelStreamer];
}

- (CGFloat)audioProgress {
    return [self.streamer currentTime];
}

- (NSString *)cachePath {
    return [self.streamer cachedPath];
}

#pragma mark - getter

- (NSTimer *)timer {
    if(!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

//取消音频流
- (void)cancelStreamer {
    if(_streamer != nil) {
        [self.streamer pause];
        [self.streamer removeObserver:self forKeyPath:@"status"];
        [self.streamer removeObserver:self forKeyPath:@"duration"];
        [self.streamer removeObserver:self forKeyPath:@"bufferingRatio"];
        self.streamer = nil;
    }
}

//重置音频流
- (void)resetStreamerWithItem:(XMLYAudioItem *)item withProgress:(NSInteger)progress{
    
    self.oriProgress = progress;
    
    //取消音频流
    [self cancelStreamer];
    
    //初始化音频流
    self.streamer = [DOUAudioStreamer streamerWithAudioFile:item];
    
    //设置kvo属性监听
    [self.streamer addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:kAudioStatusKVOKey];
    [self.streamer addObserver:self forKeyPath:@"duration" options:NSKeyValueObservingOptionNew context:kAudioDurationKVOKey];
    [self.streamer addObserver:self forKeyPath:@"bufferingRatio" options:NSKeyValueObservingOptionNew context:kAudioBufferingRatioKVOKey];
    
    //播放音频
    [self.streamer play];
    
   
    [self timer];
}

#pragma mark - private
//更新状态
- (void)updateStatus {
    if([self.delegate respondsToSelector:@selector(audioHelperStatuChange:)]) {
        if([self.streamer status] == DOUAudioStreamerError) {
            NSLog(@"error:%@",self.streamer.error);
        }
        [self.delegate audioHelperStatuChange:[self.streamer status]];
    }
    if(self.streamer.status == DOUAudioStreamerPlaying && self.oriProgress > 0) {
        [self.streamer setCurrentTime:self.oriProgress];
    }
}

//时间进度发生变化
- (void)timerAction:(id)timer {
    if([self.delegate respondsToSelector:@selector(audioHelperDurationChange:duration:)]) {
        if(_streamer == nil && [_streamer duration] == 0.0) {
            [self.delegate audioHelperDurationChange:0 duration:0];
        }else{
            [self.delegate audioHelperDurationChange:[self.streamer currentTime] duration:[self.streamer duration]];
        }
    }
}

//下载进度发生变化
- (void)updateBufferingStatus {
    if(!_streamer) return;
    
    if([self.delegate respondsToSelector:@selector(audioHelperBufferStatusChange:expectedLength:downloadSpeed:)]) {
        [self.delegate audioHelperBufferStatusChange:[self.streamer receivedLength] expectedLength:[self.streamer expectedLength] downloadSpeed:[self.streamer downloadSpeed]];
    }
    
    //缓冲全部完成
//    if([self.streamer receivedLength] == [self.streamer expectedLength]) {
//        [self cacheAudio];
//    }
    //NSLog(@"-----%@",self.streamer.cachedPath);
}


- (void)cacheAudio {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"audioCache"];
    if(![manager fileExistsAtPath:path]) {
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSError *err = nil;
    [manager moveItemAtPath:self.streamer.cachedPath toPath:[path stringByAppendingPathComponent:[self.streamer.cachedPath lastPathComponent]] error:&err];
    if(err) {
        NSLog(@"error:%@",err);
    }else{
        NSLog(@"缓存地址:%@",path);
    }
}



#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if(context == kAudioStatusKVOKey) {
        [self performSelector:@selector(updateStatus) onThread:[NSThread mainThread] withObject:nil waitUntilDone:NO];
    }else if(context == kAudioDurationKVOKey) {
        [self performSelector:@selector(timerAction:) onThread:[NSThread mainThread] withObject:nil waitUntilDone:NO];
    }else if(context == kAudioBufferingRatioKVOKey) {
        [self performSelector:@selector(updateBufferingStatus) onThread:[NSThread mainThread] withObject:nil waitUntilDone:NO];
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end










