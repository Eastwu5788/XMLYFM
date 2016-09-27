//
//  XMLYCountHelper.m
//  XMLYFM
//
//  Created by East_wu on 16/9/14.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYCountHelper.h"

static force_inline NSString *XMLYGetPlyCount(NSInteger num) {
    if(num < 10000) {
        return [NSString stringWithFormat:@"%ld",(long)num];
    }else {
        CGFloat fot = num / 10000.0f;
        return [NSString stringWithFormat:@"%.1f万",fot];
    }
}

@implementation XMLYCountHelper

+ (NSString *)countStringFromNSInter:(NSInteger)count {
    return XMLYGetPlyCount(count);
}

@end
