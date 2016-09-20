//
//  XMLYAlbumListModel.m
//  XMLYFM
//
//  Created by East_wu on 16/9/13.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYAlbumListModel.h"

@implementation XMLYAlbumTrackItemModel


- (int64_t)trackSize {
    NSString *path = self.destinationLocaoPath;
    NSFileManager *manager = [NSFileManager defaultManager];
    NSError *error;
    NSDictionary *dic = [manager attributesOfItemAtPath:path error:&error];
    int64_t size = [[dic objectForKey:NSFileSize] longLongValue];
    return size;
}


- (NSString *)destinationLocaoPath {
    NSString *localPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    localPath = [localPath stringByAppendingPathComponent:@"XMLYAudioPathCache"];
    NSError *erro = nil;
    if(![[NSFileManager defaultManager] fileExistsAtPath:localPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:localPath withIntermediateDirectories:YES attributes:nil error:&erro];
    }
    NSArray *downloadPath = [self.playPathAacv224 componentsSeparatedByString:@"/"];
    NSString *path = nil;
    if(downloadPath.count) {
        path = downloadPath.lastObject;
    }
    localPath = [localPath stringByAppendingPathComponent:path];
    return localPath;
}



@end

@implementation XMLYAlbumTracksModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list":[XMLYAlbumTrackItemModel class]};
}

@end

@implementation XMLYAlbumModel

@end

@implementation XMLYAlbumUserModel

@end

@implementation XMLYAlbumListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"album":[XMLYAlbumModel class],
             @"user":[XMLYAlbumUserModel class],
             @"tracks":[XMLYAlbumTracksModel class]};
}

@end
