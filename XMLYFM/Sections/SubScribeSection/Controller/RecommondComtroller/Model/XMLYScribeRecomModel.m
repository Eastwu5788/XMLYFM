//
//  XMLYScribeRecomModel.m
//  XMLYFM
//
//  Created by East_wu on 16/9/9.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYScribeRecomModel.h"
#import "NSString+Extension.h"


@implementation XMLYScribeRecomItemModel

- (void)calculateFrameForCell {
    CGSize size = CGSizeMake(kScreenWidth - 120.0f, CGFLOAT_MAX);
    size = [self.title sizeForFont:[UIFont systemFontOfSize:16] size:size mode:NSLineBreakByCharWrapping];
    
    self.titleLabelHeight = size.height + 1;
    
    self.cellHeight = self.titleLabelHeight + 62.0f;
}

@end

@implementation XMLYScribeRecomModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list":[XMLYScribeRecomItemModel class]};
}

- (void)calculateFrameForItems {
    [self.list enumerateObjectsUsingBlock:^(XMLYScribeRecomItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj calculateFrameForCell];
    }];
}

@end
