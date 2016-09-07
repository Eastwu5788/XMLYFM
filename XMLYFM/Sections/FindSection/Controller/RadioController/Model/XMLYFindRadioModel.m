//
//  XMLYFindRadioModel.m
//  XMLYFM
//
//  Created by East_wu on 16/9/7.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYFindRadioModel.h"

@implementation XMLYFindRadioCategoryItem

@end

@implementation XMLYPlayModel

@end

@implementation XMLYFindRadioInfoModel

@end

@implementation XMLYFindRadioModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"categories":[XMLYFindRadioCategoryItem class],
             @"localRadios":[XMLYFindRadioInfoModel class],
             @"topRadios":[XMLYFindRadioInfoModel class]};
}

@end
