//
//  XMLYSubFindFactory.h
//  XMLYFM
//
//  Created by East_wu on 16/8/10.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLYFindBaseController.h"

typedef NS_ENUM(NSInteger, XMLYSubFindType) {
    XMLYSubFindTypeRecommend   =   0,  //推荐
    XMLYSubFindTypeCategory    =   1,  //分类
    XMLYSubFindTypeRadio       =   2,  //广播
    XMLYSubFindTypeRank        =   3,  //榜单
    XMLYSubFindTypeAnchor      =   4,  //主播
    XMLYSubFindTypeUnknown     =   5,  //未知
};

@interface XMLYSubFindFactory : NSObject

/**
 *  生成子控制器
 *  @param identifier 自控制器的唯一文字标识
 */
+ (XMLYFindBaseController *)subFindControllerWithIdentifier:(NSString *)identifier;

@end
