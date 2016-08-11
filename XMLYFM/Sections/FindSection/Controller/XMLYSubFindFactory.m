//
//  XMLYSubFindFactory.m
//  XMLYFM
//
//  Created by East_wu on 16/8/10.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYSubFindFactory.h"
#import "XMLYFindRecommendController.h"    //推荐
#import "XMLYFindRankController.h"         //榜单
#import "XMLYFindRadioController.h"        //广播
#import "XMLYFindCategoryController.h"     //分类
#import "XMLYFindAnchorController.h"       //主播

@implementation XMLYSubFindFactory

/**
 *  生成子控制器
 *  @param identifier 自控制器的唯一文字标识
 */
+ (XMLYFindBaseController *)subFindControllerWithIdentifier:(NSString *)identifier {
    XMLYSubFindType findType = [self typeFromTitle:identifier];
    
    XMLYFindBaseController *controller = nil;
    
    if(findType == XMLYSubFindTypeRecommend) {
        controller = [[XMLYFindRecommendController alloc] init];        //推荐
    }
    else if(findType == XMLYSubFindTypeCategory) {
        controller = [[XMLYFindCategoryController alloc] init];         //分类
    }
    else if(findType == XMLYSubFindTypeRadio) {
        controller = [[XMLYFindRadioController alloc] init];            //广播
    }
    else if(findType == XMLYSubFindTypeRank) {
        controller = [[XMLYFindRankController alloc] init];             //榜单
    }
    else if(findType == XMLYSubFindTypeAnchor) {
        controller = [[XMLYFindAnchorController alloc] init];           //主播
    }
    else {
        controller = [[XMLYFindBaseController alloc] init];              //未知
    }
    
    return controller;
}



/**
 *  根据唯一标识符范围类型
 */
+ (XMLYSubFindType)typeFromTitle:(NSString *)title {
    if([title isEqualToString:@"推荐"]) {
        return XMLYSubFindTypeRecommend;
    }else if([title isEqualToString:@"分类"]) {
        return XMLYSubFindTypeCategory;
    }else if([title isEqualToString:@"广播"]) {
        return XMLYSubFindTypeRadio;
    }else if([title isEqualToString:@"榜单"]) {
        return XMLYSubFindTypeRank;
    }else if([title isEqualToString:@"主播"]) {
        return XMLYSubFindTypeAnchor;
    }else{
        return XMLYSubFindTypeUnknown;;
    }
}

@end
