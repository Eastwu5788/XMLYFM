//
//  XMLYListenInfoHeaderView.h
//  XMLYFM
//
//  Created by East_wu on 16/9/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLYListenDetailModel.h"

@interface XMLYListenInfoHeaderView : UICollectionReusableView

@property (nonatomic, strong) XMLYListenDetailEditInfo *infoModel;

+ (instancetype)listenInfoHeaderView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

@end
