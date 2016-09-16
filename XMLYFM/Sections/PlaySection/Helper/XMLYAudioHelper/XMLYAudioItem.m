//
//  XMLYAudioItem.m
//  XMLYFM
//
//  Created by East_wu on 16/9/16.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYAudioItem.h"

@implementation XMLYAudioItem

//- (NSString *)audioFileHost {
//    if(!_audioFileHost) {
//        _audioFileHost = [self defaultLocalPath];
//    }
//    return _audioFileHost;
//}

- (NSString *)defaultLocalPath {
    NSString *localPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    localPath = [localPath stringByAppendingPathComponent:@"XMLYAudioCache"];
    NSError *erro = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:localPath withIntermediateDirectories:YES attributes:nil error:&erro];
    return localPath;
}

@end
