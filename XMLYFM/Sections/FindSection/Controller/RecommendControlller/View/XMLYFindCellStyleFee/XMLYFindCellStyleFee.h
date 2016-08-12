//
//  XMLYFindCellStyleFee.h
//  XMLYFM
//
//  Created by East_wu on 16/8/11.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLYFindBaseCell.h"
#import "XMLYFindRecommendModel.h"
#import "XMLYFindHotGuessModel.h"

/**
 *  三张横版图片类型的cell，类似 付费精品
 */

@interface XMLYFindCellStyleFee : XMLYFindBaseCell

/**
 *  小编推荐模型
 */
@property (nonatomic, strong) XMLYFindEditorRecommendAlbumModel *recommendModel;

/**
 *  城市
 */
@property (nonatomic, strong) XMLYCityColumnModel               *cityColumn;

/**
 *  热门推荐
 */
@property (nonatomic, strong) XMLYHotRecommendItemModel         *hotRecommedItemModel;

/**
 *  初始化方法
 */
+ (instancetype)findCellStyleFee:(UITableView *)tableView;

@end

