//
//  XMLYListenListCell.h
//  XMLYFM
//
//  Created by East_wu on 16/9/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLYListenListModel.h"

@interface XMLYListenListCell : UICollectionViewCell

@property (nonatomic, strong) XMLYListenItemModel *model;

- (void)hiddenSepLine:(BOOL)hidden;

+ (instancetype)listenListCell:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

@end
