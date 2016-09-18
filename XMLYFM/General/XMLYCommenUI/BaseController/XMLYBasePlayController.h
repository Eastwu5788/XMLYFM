//
//  XMLYBasePlayController.h
//  XMLYFM
//
//  Created by East_wu on 16/9/11.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseController.h"
#import "XMLYPlayDBHelper.h"
#import "XMLYBaseAudioModel.h"
#import "XMLYPlayViewController.h"
#import "XMLYBaseNavigationController.h"

@interface XMLYBasePlayView : UIView

@property (nonatomic, weak) UIImageView *iconImage;
@property (nonatomic, weak) UIButton    *playBtn;
@property (nonatomic, weak) UIImageView *bgImageView;

@property (nonatomic, copy) void(^playButtonClickBlock)(UIButton *btn);

// 开始旋转
- (void)startRotateIconImage;
// 停止旋转
- (void)stopRotateIconImage;

@end

@interface XMLYBasePlayController : XMLYBaseController

@property (nonatomic, weak) XMLYBasePlayView *playView;

@property (nonatomic, strong) XMLYPlayViewController    *playViewController;
@property (nonatomic, strong) XMLYBaseAudioModel        *audioModel;

@end
