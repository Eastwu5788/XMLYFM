//
//  XMLYListenDetailModel.m
//  XMLYFM
//
//  Created by East_wu on 16/9/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYListenDetailModel.h"
#import "NSString+Extension.h"

@implementation XMLYListenDetailOriginModel

@end

@implementation XMLYListenDetailItemModel

- (void)calculateFrameForItemCell {
    CGSize maxSize = CGSizeMake(kScreenWidth - 150, CGFLOAT_MAX);
    maxSize = [self.title sizeForFont:[UIFont systemFontOfSize:15] size:maxSize mode:NSLineBreakByWordWrapping];
    
    self.titleHeight = maxSize.height + 1;
    
    self.cellHeight = maxSize.height + 56.0f;
}

@end

@implementation XMLYListenDetailEditInfo

- (void)calculateFrameForInfoCell {
    CGSize maxSize = CGSizeMake(kScreenWidth - 40, CGFLOAT_MAX);
    CGSize size = [self.intro sizeForFont:[UIFont systemFontOfSize:13] size:maxSize mode:NSLineBreakByWordWrapping];
    self.introHeight = size.height + 1;
    self.cellHeight = size.height + 90.0f;
    
    self.nickNameWidth = [self.nickname sizeForFont:[UIFont systemFontOfSize:12] size:CGSizeMake(100, 14) mode:NSLineBreakByCharWrapping].width;
}

@end

@implementation XMLYListenDetailModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list":[XMLYListenDetailItemModel class]};
}

- (void)calculateIntroCellHeight {
    [self.info calculateFrameForInfoCell];
    
    [self.list enumerateObjectsUsingBlock:^(XMLYListenDetailItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj calculateFrameForItemCell];
    }];
}

@end
