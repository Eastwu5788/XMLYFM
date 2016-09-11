//
//  XMLYEditRecomAPI.h
//  XMLYFM
//
//  Created by East_wu on 16/9/11.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseAPI.h"

@interface XMLYEditRecomAPI : XMLYBaseAPI

+ (void)requestEditRecomWithPage:(NSInteger)page completion:(XMLYBaseAPICompletion)completion;

@end
