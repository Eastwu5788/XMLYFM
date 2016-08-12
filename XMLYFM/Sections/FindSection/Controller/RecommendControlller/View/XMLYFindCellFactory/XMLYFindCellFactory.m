//
//  XMLYFindCellFactory.m
//  XMLYFM
//
//  Created by East_wu on 16/8/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYFindCellFactory.h"
#import "XMLYFindCellStyleFee.h"
#import "XMLYFindCellStyleLive.h"
#import "XMLYFindCellStyleSpecial.h"
#import "XMLYFindCellStyleMore.h"

@implementation XMLYFindCellFactory

/**
 *  传入需要创建的样式，由工厂类生成特定样式的cell
 */
+ (XMLYFindBaseCell *)createCellByFactory:(UITableView *)tableView style:(XMLYFindCellStyle)style {
    XMLYFindBaseCell *baseCell;
    if(style == XMLYFindCellStyleFeeStyle) {
        baseCell = [XMLYFindCellStyleFee findCell:tableView];
    }
    else if(style == XMLYFindCellStyleLiveStyle) {
        baseCell = [XMLYFindCellStyleLive findCell:tableView];
    }
    else if(style == XMLYFindCellStyleSpecialStyle) {
        baseCell = [XMLYFindCellStyleSpecial findCell:tableView];
    }
    else if(style == XMLYFindCellStyleMoreStyle) {
        baseCell = [XMLYFindCellStyleMore findCell:tableView];
    }
    else{
        baseCell = [XMLYFindBaseCell findCell:tableView];
    }
    return baseCell;
}

@end
