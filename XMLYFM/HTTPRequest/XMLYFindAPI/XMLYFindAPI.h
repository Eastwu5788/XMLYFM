//
//  XMLYFindAPI.h
//  XMLYFM
//
//  Created by East_wu on 16/8/9.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLYBaseAPI.h"

@interface XMLYFindAPI : XMLYBaseAPI

+ (void)requestRecommends:(XMLYBaseAPICompletion)completion;

+ (void)requestHotAndGuess:(XMLYBaseAPICompletion)completion;

+ (void)requestLiveRecommend:(XMLYBaseAPICompletion)completion;

@end
