//
//  XMLYAlbumListModel.m
//  XMLYFM
//
//  Created by East_wu on 16/9/13.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYAlbumListModel.h"

@implementation XMLYAlbumTrackItemModel

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
