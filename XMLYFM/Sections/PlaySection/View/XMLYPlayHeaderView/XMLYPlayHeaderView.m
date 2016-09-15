//
//  XMLYPlayHeaderView.m
//  XMLYFM
//
//  Created by East_wu on 16/9/15.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYPlayHeaderView.h"

//头部的介绍 icon、标题、订阅
@interface XMLYPlayHeaderIntroView : UIView

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel     *titleLabel;
@property (nonatomic, weak) UILabel     *scribeCountLabel;
@property (nonatomic, weak) UIButton    *scribeButton;

@end

@implementation XMLYPlayHeaderIntroView

#pragma mark - getter



@end


//当前播放状态
@interface XMLYPlayStateView : UIView

@property (nonatomic, weak) UIImageView *coverImageView;
@property (nonatomic, weak) UIView      *alphaView;
@property (nonatomic, weak) UILabel     *curTimeLabel;
@property (nonatomic, weak) UILabel     *allTimeLabel;
@property (nonatomic, weak) UIButton    *barrageButton; //弹幕按钮
@property (nonatomic, weak) UIProgressView  *progressView;

@end

@implementation XMLYPlayStateView


@end

//控制器view
@interface XMLYPlayControlView : UIView

@property (nonatomic, weak) UIButton    *playListBtn;
@property (nonatomic, weak) UIButton    *goBackBtn;
@property (nonatomic, weak) UIButton    *stateBtn;
@property (nonatomic, weak) UIButton    *goForwardBtn;
@property (nonatomic, weak) UIButton    *timingBtn;

@end

@implementation XMLYPlayControlView

@end

@interface XMLYPlayHeaderView ()

@property (nonatomic, weak) XMLYPlayHeaderIntroView *introView;
@property (nonatomic, weak) XMLYPlayStateView       *stateView;
@property (nonatomic, weak) XMLYPlayControlView     *controlView;
@property (nonatomic, weak) UIView                  *sepView;

@end

@implementation XMLYPlayHeaderView


@end
