//
//  XMLYCategoryAPI.h
//  XMLYFM
//
//  Created by East_wu on 16/8/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseAPI.h"

@interface XMLYCategoryAPI : XMLYBaseAPI

/**
 *  类别中的分类和banner下方的按钮
 */
+ (void)requestCategory:(XMLYBaseAPICompletion)completion;

/**
 *  发现栏目中得FootView的请求地址
 *
 *  @param completion <#completion description#>
 */
+ (void)requestFootBanner:(XMLYBaseAPICompletion)completion;

@end
