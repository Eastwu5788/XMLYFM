//
//  XMLYBaseSecHeaderView.h
//  XMLYFM
//
//  Created by East_wu on 16/9/14.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMLYBaseSecHeaderView : UICollectionReusableView

+ (instancetype)sectionHeaderAwakeFromNib:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
+ (instancetype)sectionHeaderAwakeFromClass:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
@end
