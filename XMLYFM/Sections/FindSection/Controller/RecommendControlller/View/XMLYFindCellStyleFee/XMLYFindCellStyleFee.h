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

@class XMLYFindCellStyleFee;


@protocol XMLYFindCellStyleFeeDelegate <NSObject>

/**
 *  更多按钮的点击事件
 */
- (void)findCellStyleFeeCellDidMoreClick:(XMLYFindCellStyleFee *)cell;

@end

//此cell需要重新设计，有很多地方可以服用，应该写成UICollectionView，而不应该是UITableView

/**
 *  三张横版图片类型的cell，类似 付费精品
 */
@interface XMLYFindCellStyleFee : XMLYFindBaseCell

@property (nonatomic, weak) __weak id<XMLYFindCellStyleFeeDelegate> delegate;

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

