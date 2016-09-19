//
//  XMLYDownTaskModel.m
//  XMLYFM
//
//  Created by East_wu on 16/9/19.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYDownTaskModel.h"
#import "NSString+Extension.h"

@implementation XMLYDownTaskModel

- (NSString *)destinationLocaoPath {
    NSString *str = [NSString stringWithFormat:@"xmly_audio_path_%ld_%ld",self.trackModel.trackId,self.trackModel.albumId];
    NSString *localPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    localPath = [localPath stringByAppendingPathComponent:@"XMLYAudioPathCache"];
    NSError *erro = nil;
    if(![[NSFileManager defaultManager] fileExistsAtPath:localPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:localPath withIntermediateDirectories:YES attributes:nil error:&erro];
    }
    localPath = [localPath stringByAppendingPathComponent:[str md5String]];
    return localPath;
}

@end
