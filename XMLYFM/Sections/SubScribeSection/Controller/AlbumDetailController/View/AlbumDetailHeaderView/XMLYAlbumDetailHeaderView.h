//
//  XMLYAlbumDetailHeaderView.h
//  XMLYFM
//
//  Created by East_wu on 16/9/13.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLYAlbumListModel.h"

@interface XMLYAlbumDetailHeaderView : UIView

@property (nonatomic, strong) XMLYAlbumModel *albumModel;

+ (instancetype)albumDetailHeaderViewWithFrame:(CGRect)frame;
- (instancetype)initAlbumDetailHeaderViewWithFrame:(CGRect)frame;


@end
