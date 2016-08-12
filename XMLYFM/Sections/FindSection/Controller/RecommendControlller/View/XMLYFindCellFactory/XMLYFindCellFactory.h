//
//  XMLYFindCellFactory.h
//  XMLYFM
//
//  Created by East_wu on 16/8/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLYFindBaseCell.h"

typedef NS_ENUM(NSInteger, XMLYFindCellStyle) {
    XMLYFindCellStyleFeeStyle     =  0,  //类似付费精品
    XMLYFindCellStyleLiveStyle    =  1,  //正在直播
    XMLYFindCellStyleSpecialStyle =  2,  //精品听单
    XMLYFindCellStyleMoreStyle    =  3,  //查看更多分类
};


@interface XMLYFindCellFactory : NSObject

/**
 *  传入需要创建的样式，由工厂类生成特定样式的cell
 */
+ (XMLYFindBaseCell *)createCellByFactory:(UITableView *)tableView style:(XMLYFindCellStyle)style;

@end
