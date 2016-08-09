//
//  XMLYBaseAPI.h
//  XMLYFM
//
//  Created by East_wu on 16/8/9.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLYBaseRequest.h"

typedef void(^XMLYBaseAPICompletion)(id response,NSString *message,BOOL success);

@interface XMLYBaseAPI : NSObject

+ (NSMutableDictionary *)params;

@end
