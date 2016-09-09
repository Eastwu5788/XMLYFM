//
//  XMLYFindRankModel.m
//  XMLYFM
//
//  Created by East_wu on 16/9/8.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYFindRankModel.h"

@implementation XMLYFindRankItemModel

@end

@implementation XMLYFindRankDetailModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"firstKResults":[XMLYFindRankItemModel class]};
}

@end

@implementation XMLYFindRankListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list":[XMLYFindRankDetailModel class]};
}

@end

@implementation XMLYFindRankModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"datas":[XMLYFindRankListModel class],
             @"focusImages":[XMLYFindFocusImagesModel class]};
}

@end
