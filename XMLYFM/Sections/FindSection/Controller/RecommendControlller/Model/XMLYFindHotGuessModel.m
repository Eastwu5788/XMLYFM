//
//  XMLYFindHotGuessModel.m
//  XMLYFM
//
//  Created by East_wu on 16/8/11.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYFindHotGuessModel.h"

@implementation XMLYFindHotGuessModel

@end

@implementation XMLYFindDiscoverColumnsModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list":@"XMLYFindDiscoverDetailModel"};
}

@end


@implementation XMLYFindDiscoverDetailModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"properties":@"XMLYFindDiscoverProperityModel"};
}

@end

@implementation XMLYFindDiscoverProperityModel


@end

@implementation XMLYFindGuessMode


@end


@implementation XMLYCityColumnModel


@end


@implementation XMLYHotRecommend


@end

@implementation XMLYHotRecommendItemModel


@end