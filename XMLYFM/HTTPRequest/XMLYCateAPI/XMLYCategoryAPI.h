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
 http://mobile.ximalaya.com/mobile/discovery/v2/categories?channel=ios-b1&code=43_110000_1100&device=iPhone&picVersion=13&scale=2&version=5.4.21
 */
+ (void)requestCategory:(XMLYBaseAPICompletion)completion;

/**
 *  发现栏目中得FootView的请求地址
 http://fdfs.xmcdn.com/group18/M08/56/38/wKgJKleZZHnQy_erAAD2J0HXzKc240.jpg
 *
 *  @param completion <#completion description#>
 */
+ (void)requestFootBanner:(XMLYBaseAPICompletion)completion;

@end
