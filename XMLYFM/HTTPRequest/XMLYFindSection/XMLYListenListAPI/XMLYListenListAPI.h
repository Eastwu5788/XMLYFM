//
//  XMLYListenListAPI.h
//  XMLYFM
//
//  Created by East_wu on 16/9/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseAPI.h"

@interface XMLYListenListAPI : XMLYBaseAPI

+ (void)requestListenListWithPage:(NSInteger)page completion:(XMLYBaseAPICompletion)completion;

@end
