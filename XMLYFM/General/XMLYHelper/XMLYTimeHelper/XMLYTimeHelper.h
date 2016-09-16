//
//  XMLYTimeHelper.h
//  XMLYFM
//
//  Created by East_wu on 16/9/7.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLYTimeHelper : NSObject

/**
 *  返回早安、午安、晚安
 */
+ (NSString *)getHelloStringByLocalTime;

+ (NSString *)dataStringFromTimeInterval:(NSTimeInterval)time dataFormatter:(NSString *)formatter;

+ (NSString *)dataStringWithTimeInterval:(NSTimeInterval)time;

//
+ (NSString *)timeFromTimeInterval:(NSTimeInterval)timeInterval;

@end
