//
//  XMLYPlayPageModel.m
//  XMLYFM
//
//  Created by East_wu on 16/9/15.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYPlayPageModel.h"
#import "NSString+Extension.h"


@implementation XMLYTrackInfoModel

- (void)calculateHeaderCellHeight {
    
    CGSize size = CGSizeMake(kScreenWidth - 20, CGFLOAT_MAX);
    self.titleHeight = [self.title sizeForFont:[UIFont systemFontOfSize:20] size:size mode:NSLineBreakByCharWrapping].height + 5;
    
    self.contentHeight = [self.shortRichIntro sizeForFont:[UIFont systemFontOfSize:15] size:size mode:NSLineBreakByCharWrapping].height + 5;
    
    self.headerHeight = self.titleHeight + self.contentHeight + 150;
}

@end

@implementation XMLYAlbumInfoModel


@end

@implementation XMLYAssociationAlbumsInfoModel

- (void)calculateHeightFroCell {
    CGSize maxSize = CGSizeMake(kScreenWidth - 120.0f, CGFLOAT_MAX);
    CGSize size = [self.title sizeForFont:[UIFont systemFontOfSize:16] size:maxSize mode:NSLineBreakByCharWrapping];
    
    self.titleHight = size.height + 5;
    
    size = [self.intro sizeForFont:[UIFont systemFontOfSize:13] size:maxSize mode:NSLineBreakByCharWrapping];
    
    self.subTitleHeight = size.height + 5;
    
    self.cellHeight = self.titleHight + self.subTitleHeight + 55.0f;
}


@end


@implementation XMLYAlbumUserInfoModel

- (void)calculateFrameForUser {
    
    CGSize size = CGSizeMake(200, 15);
    self.nicknameWidth = [self.nickname sizeForFont:[UIFont systemFontOfSize:15] size:size mode:NSLineBreakByWordWrapping].width;

}

@end

@implementation XMLYComentInfoItemModel

- (void)calculateFrameForCell {
    CGSize size = CGSizeMake(kScreenWidth - 84, CGFLOAT_MAX);
    size = [self.content sizeForFont:[UIFont systemFontOfSize:12] size:size mode:NSLineBreakByCharWrapping];
    
    self.contentHeight = size.height + 2;
    
    self.cellHeight = self.contentHeight + 50.0f;
}

@end

@implementation XMLYCommentInfoModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list":[XMLYComentInfoItemModel class]};
}

- (void)calculateFrameForCell {
    for(XMLYComentInfoItemModel *model in self.list) {
        [model calculateFrameForCell];
    }
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

- (void)calculateFrameForCell {
    [self.trackInfo calculateHeaderCellHeight];
    [self.userInfo calculateFrameForUser];
    [self.commentInfo calculateFrameForCell];
    for(XMLYAssociationAlbumsInfoModel *model in self.associationAlbumsInfo) {
        [model calculateHeightFroCell];
    }
}

@end
