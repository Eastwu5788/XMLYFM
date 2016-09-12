//
//  XMLYAnchorHeaderView.h
//  XMLYFM
//
//  Created by East_wu on 16/9/8.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLYFindAnchorModel.h"

@interface XMLYAnchorHeaderView : UICollectionReusableView

@property (nonatomic, strong) XMLYAnchorSectionModel *model;


+ (instancetype)anchorHeaderView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;


- (void)configHeaderTitle:(NSString *)title showMore:(BOOL)showMore;

@end
