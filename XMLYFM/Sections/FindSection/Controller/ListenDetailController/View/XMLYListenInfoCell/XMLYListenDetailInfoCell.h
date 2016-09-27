//
//  XMLYListenDetailInfoCell.h
//  XMLYFM
//
//  Created by East_wu on 16/9/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLYListenDetailModel.h"

@interface XMLYListenDetailInfoCell : UICollectionViewCell

@property (nonatomic, strong) XMLYListenDetailEditInfo *infoModel;

+ (instancetype)listenDetailInfoCell:(UICollectionView *)view atIndexPath:(NSIndexPath *)indexPath;

@end
