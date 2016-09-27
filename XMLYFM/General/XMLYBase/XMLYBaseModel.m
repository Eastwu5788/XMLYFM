//
//  XMLYBaseModel.m
//  XMLYFM
//
//  Created by East_wu on 16/8/10.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseModel.h"

@implementation XMLYBaseModel



+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"cid":@"id"
             };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"cid":@"id"};
}



- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self xr_modelEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    return [self xr_modelInitWithCoder:aDecoder];
}

- (id)copyWithZone:(NSZone *)zone {
    return [self xr_modelCopy];
}

@end
