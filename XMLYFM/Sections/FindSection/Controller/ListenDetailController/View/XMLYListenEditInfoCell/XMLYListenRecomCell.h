//
//  XMLYListenEditInfoCell.h
//  XMLYFM
//
//  Created by East_wu on 16/9/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLYListenDetailModel.h"

@interface XMLYListenRecomCell : UICollectionViewCell

@property (nonatomic, strong) XMLYListenDetailItemModel *itemModel;

+ (instancetype)listenRecomCell:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

@end
