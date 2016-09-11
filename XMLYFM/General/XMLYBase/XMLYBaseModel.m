//
//  XMLYBaseModel.m
//  XMLYFM
//
//  Created by East_wu on 16/8/10.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseModel.h"

@implementation XMLYBaseModel

MJCodingImplementation

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"cid":@"id"
             };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"cid":@"id"};
}






@end
