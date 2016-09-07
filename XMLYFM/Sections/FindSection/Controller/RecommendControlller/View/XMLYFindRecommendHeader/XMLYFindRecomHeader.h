//
//  XMLYFindRecomHeader.h
//  XMLYFM
//
//  Created by East_wu on 16/8/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLYFindRecommendModel.h"
#import "XMLYFindHotGuessModel.h"

@interface XMLYFindRecomHeader : UIView

/**
 *  轮播图模型
 */
@property (nonatomic, strong) XMLYFindFocusImagesModel *model;

/**
 *  下方轮播图模型
 */
@property (nonatomic, strong) XMLYFindDiscoverColumnsModel  *discoverModel;


+ (instancetype)findRecomHeader;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)new UNAVAILABLE_ATTRIBUTE;

@end
