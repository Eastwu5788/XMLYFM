//
//  XMLYBaseCollectionViewCell.h
//  XMLYFM
//
//  Created by East_wu on 16/9/15.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMLYBaseCollectionViewCell : UICollectionViewCell

+ (instancetype)collectionViewCellFromNib:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
+ (instancetype)collectionViewCellFromClass:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;


@end
