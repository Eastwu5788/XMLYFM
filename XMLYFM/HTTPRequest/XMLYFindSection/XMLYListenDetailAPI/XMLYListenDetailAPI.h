//
//  XMLYListenDetailAPI.h
//  XMLYFM
//
//  Created by East_wu on 16/9/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseAPI.h"

@interface XMLYListenDetailAPI : XMLYBaseAPI

+ (void)requestListenDetailAPI:(NSInteger)cid completion:(XMLYBaseAPICompletion)completion;

@end
