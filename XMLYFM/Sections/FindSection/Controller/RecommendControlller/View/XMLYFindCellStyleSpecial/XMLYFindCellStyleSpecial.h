//
//  XMLYFindCellStyleSpecial.h
//  XMLYFM
//
//  Created by East_wu on 16/8/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLYFindBaseCell.h"
#import "XMLYFindRecommendModel.h"

@class XMLYFindCellStyleSpecial;

@protocol XMLYFindCellStyleSpecialDelegate <NSObject>

/**
 *  查看更多按钮的点击事件
 */
- (void)findCellStyleSpecial:(XMLYFindCellStyleSpecial *)cell didMoreButtonClickWithModel:(XMLYSpecialColumnModel *)model;

@end


/**
 *  这个cell需要大改
 */

@interface XMLYFindCellStyleSpecial : XMLYFindBaseCell

@property (nonatomic, strong) XMLYSpecialColumnModel *specialModel;

@property (nonatomic, weak) __weak id<XMLYFindCellStyleSpecialDelegate> delegate;

+ (instancetype)findCellStyleSpecial:(UITableView *)tableView;

@end
