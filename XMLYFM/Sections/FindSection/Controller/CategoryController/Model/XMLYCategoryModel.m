//
//  XMLYCategoryModel.m
//  XMLYFM
//
//  Created by East_wu on 16/9/7.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYCategoryModel.h"

@implementation XMLYListItemModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"cid":@"id"};
}

@end

@implementation XMLYCategoryModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"discoveryColumns": [XMLYFindDiscoverColumnsModel class],
             @"list":[XMLYListItemModel class]};
}




@end
