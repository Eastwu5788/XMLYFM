//
//  XMLYBaseAPI.m
//  XMLYFM
//
//  Created by East_wu on 16/8/9.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseAPI.h"

@implementation XMLYBaseAPI

+ (NSMutableDictionary *)params {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"iPhone" forKey:@"device"];
    return dic;
}

@end
