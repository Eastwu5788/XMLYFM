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

/**
 *  请求精品歌单、小编推荐数据
 */
+ (void)requestRecommends:(XMLYBaseAPICompletion)completion;

/**
 *  请求发现新奇、猜你喜欢等数据
 */
+ (void)requestHotAndGuess:(XMLYBaseAPICompletion)completion;

/**
 *  请求正在直播等数据
 */
+ (void)requestLiveRecommend:(XMLYBaseAPICompletion)completion;
/**
 *  请求推荐中的banner
 */
+ (void)requestFooterAd:(XMLYBaseAPICompletion)completion;

@end
