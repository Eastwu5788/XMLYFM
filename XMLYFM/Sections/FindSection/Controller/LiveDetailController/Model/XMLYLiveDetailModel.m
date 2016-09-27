//
//  XMLYLiveDetailModel.m
//  XMLYFM
//
//  Created by East_wu on 16/9/14.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYLiveDetailModel.h"
#import "NSString+Extension.h"


@implementation XMLYLivePlayUrl

@end

@implementation XMLYLiveDetailActivity

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"playUrl":[XMLYLivePlayUrl class]};
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"desc":@"description"};
}

- (void)calculateFrameForCell {
    CGSize size = CGSizeMake(kScreenWidth - 20, CGFLOAT_MAX);
    size = [self.desc sizeForFont:[UIFont systemFontOfSize:13] size:size mode:NSLineBreakByWordWrapping];
    
    self.cellHeight = size.height + 32;
}

@end

@implementation XMLYAnchorInfo

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"desc":@"description"};
}

- (void)calculateFrameForCell {
    self.nicknamewidth = [self.nickname sizeForFont:[UIFont systemFontOfSize:15] size:CGSizeMake(300, 18) mode:NSLineBreakByWordWrapping].width + 1;
    
}

@end

@implementation XMLYActivitySchedules

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"playUrl":[XMLYLivePlayUrl class]};
}

@end

@implementation XMLYLiveDetailModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"activityDetail":[XMLYLiveDetailActivity class],
             @"anchorInfo":[XMLYAnchorInfo class],
             @"activitySchedules":[XMLYActivitySchedules class]};
}

- (void)calculateFrameForCell {
    [self.activityDetail calculateFrameForCell];
    [self.anchorInfo calculateFrameForCell];
    
}

@end
