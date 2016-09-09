//
//  XMLYRankAPI.h
//  XMLYFM
//
//  Created by East_wu on 16/9/8.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseAPI.h"

@interface XMLYRankAPI : XMLYBaseAPI

/**
 *  请求排行榜页面的数据
 *  @param completion 完成回调
 */
+ (void)requestRankresponse:(XMLYBaseAPICompletion)completion;

@end
