//
//  XMLYRadioAPI.h
//  XMLYFM
//
//  Created by East_wu on 16/9/7.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseAPI.h"

@interface XMLYRadioAPI : XMLYBaseAPI

+ (void)requestRadioRecommend:(XMLYBaseAPICompletion)completion;

@end
