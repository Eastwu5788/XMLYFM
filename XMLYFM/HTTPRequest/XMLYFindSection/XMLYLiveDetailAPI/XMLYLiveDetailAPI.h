//
//  XMLYLiveDetailAPI.h
//  XMLYFM
//
//  Created by East_wu on 16/9/14.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseAPI.h"

@interface XMLYLiveDetailAPI : XMLYBaseAPI

+ (void)requestLiveDetail:(NSInteger)liveID completion:(XMLYBaseAPICompletion)completion;

@end
