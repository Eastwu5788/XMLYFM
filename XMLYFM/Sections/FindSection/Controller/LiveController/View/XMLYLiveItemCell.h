//
//  XMLYLiveItemCell.h
//  XMLYFM
//
//  Created by East_wu on 16/9/11.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLYLiveListModel.h"

@interface XMLYLiveItemCell : UICollectionViewCell

@property (nonatomic, strong) XMLYLiveListItemModel *model;

+ (instancetype)liveItemCellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

@end
