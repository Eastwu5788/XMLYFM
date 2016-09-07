//
//  XMLYCategoryFooterModel.m
//  XMLYFM
//
//  Created by East_wu on 16/9/7.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYCategoryFooterModel.h"

@implementation XMLYCategoryFooterAdModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"adAuto":@"auto",
             @"desc":@"description"};
}

@end

@implementation XMLYCategoryFooterModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data":[XMLYCategoryFooterAdModel class]};
}

@end
