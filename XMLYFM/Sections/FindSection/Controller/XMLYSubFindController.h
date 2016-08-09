//
//  XMLYSubFindController.h
//  XMLYFM
//
//  Created by East_wu on 16/8/9.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseController.h"

typedef NS_ENUM(NSInteger, XMLYSubFindType) {
    XMLYSubFindTypeRecommend   =   0,  //推荐
    XMLYSubFindTypeCategory    =   1,  //分类
    XMLYSubFindTypeRadio       =   2,  //广播
    XMLYSubFindTypeRank        =   3,  //榜单
    XMLYSubFindTypeAnchor      =   4,  //主播
    XMLYSubFindTypeUnknown     =   5,  //未知
};

@interface XMLYSubFindController : XMLYBaseController


@property (nonatomic, assign) XMLYSubFindType  subFindType;

/**
 *  根据标题生成不同的控制器
 */
+ (instancetype)subFindControllerWithTitle:(NSString *)title;

@end
