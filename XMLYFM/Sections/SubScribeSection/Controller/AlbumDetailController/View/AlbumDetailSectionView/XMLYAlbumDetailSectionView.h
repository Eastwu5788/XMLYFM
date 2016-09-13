//
//  XMLYAlbumDetailSectionView.h
//  XMLYFM
//
//  Created by East_wu on 16/9/13.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLYAlbumListModel.h"

typedef NS_ENUM(NSInteger, XMLYAlbumDetailStyle) {
    XMLYAlbumDetailStyleDetail   = 0, //详情
    XMLYAlbumDetailStyleList     = 1, //节目列表
};

@interface XMLYAlbumDetailSectionView : UIView

@property (nonatomic, assign) XMLYAlbumDetailStyle style;
@property (nonatomic, strong) XMLYAlbumModel       *albumModel;

@property (nonatomic, copy) void(^sectionButtonClicBlock)(XMLYAlbumDetailSectionView *secView, XMLYAlbumDetailStyle style);

+ (instancetype)albumDetailSectionView;
- (instancetype)initAlbumDetailSectionView;

@end
