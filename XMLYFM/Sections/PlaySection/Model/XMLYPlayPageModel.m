//
//  XMLYPlayPageModel.m
//  XMLYFM
//
//  Created by East_wu on 16/9/15.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYPlayPageModel.h"

@implementation XMLYTrackInfoModel


@end

@implementation XMLYAlbumInfoModel


@end

@implementation XMLYAssociationAlbumsInfoModel


@end


@implementation XMLYAlbumUserInfoModel


@end

@implementation XMLYComentInfoItemModel



@end

@implementation XMLYCommentInfoModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list":[XMLYComentInfoItemModel class]};
}

@end

@implementation XMLYTrackRewardInfoItemModel



@end

@implementation XMLYTrackRewardInfoModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"rewords":[XMLYTrackRewardInfoItemModel class]};
}

@end

@implementation XMLYPlayPageModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"trackInfo":[XMLYTrackInfoModel class],
             @"albumInfo":[XMLYAlbumInfoModel class],
             @"associationAlbumsInfo":[XMLYAssociationAlbumsInfoModel class],
             @"userInfo":[XMLYAlbumUserInfoModel class],
             @"commentInfo":[XMLYCommentInfoModel class],
             @"trackRewardInfo":[XMLYTrackRewardInfoModel class]
             };
}


@end
