//
//  XMLYSizeHelper.m
//  XMLYFM
//
//  Created by East_wu on 16/9/20.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYSizeHelper.h"

static NSString *XMLYDiskSpaceFreeString(int64_t size) {
    
    
    if(size < 1024) { //B
        return [NSString stringWithFormat:@"%lldB",size];
    } //KB
    else if (size < 1024.0 * 1024.0) {
        return [NSString stringWithFormat:@"%.1fKB",size / 1024.0f];
    }
    else if (size < 1024.0 * 1024.0 * 1024.0) {
        return [NSString stringWithFormat:@"%.1fMB",size / (1024.0 * 1024.0)];
    } else {
        return [NSString stringWithFormat:@"%.1fG",size / (1024.0 * 1024.0 * 1024.0)];
    }
}

@implementation XMLYSizeHelper

+ (NSString *)sizeStringFromInt64:(int64_t)size {
    return XMLYDiskSpaceFreeString(size);
}

@end
