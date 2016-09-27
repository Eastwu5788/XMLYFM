//
//  XMLYPlayHeaderView.m
//  XMLYFM
//
//  Created by East_wu on 16/9/15.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYPlayHeaderView.h"
#import "XMLYCountHelper.h"
#import "XMLYTimeHelper.h"


@class XMLYPlayControlView;

//头部的介绍 icon、标题、订阅
@interface XMLYPlayHeaderIntroView : UIView

@property (nonatomic, weak) UIImageView *iconImageView;     //图标
@property (nonatomic, weak) UILabel     *titleLabel;        //标题
@property (nonatomic, weak) UILabel     *scribeCountLabel;  //订阅数量文本
@property (nonatomic, weak) UIButton    *scribeButton;      //订阅按钮

@property (nonatomic, strong) XMLYPlayPageModel *model;

@end

@implementation XMLYPlayHeaderIntroView

- (void)setModel:(XMLYPlayPageModel *)model {
    _model = model;
    
    [self.iconImageView yy_setImageWithURL:[NSURL URLWithString:_model.albumInfo.coverSmall] options:YYWebImageOptionSetImageWithFadeAnimation];
    
    self.titleLabel.text = _model.albumInfo.title;
    
    self.scribeCountLabel.text = [NSString stringWithFormat:@"%@人订阅",[XMLYCountHelper countStringFromNSInter:73948]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat centY = self.height / 2.0f;
    //icon图标的位置
    self.iconImageView.frame = CGRectMake(10, centY - 15, 30, 30);
    
    //订阅按钮
    self.scribeButton.frame = CGRectMake(self.width - 75, centY - 12.5, 65, 25);
    
    //订阅标签
    self.scribeCountLabel.frame = CGRectMake(self.scribeButton.left - 85, centY - 7, 80, 14);
    
    //标题
    CGFloat titX = self.iconImageView.right + 10;
    CGFloat titW = self.scribeCountLabel.left - 10 - titX;
    self.titleLabel.frame = CGRectMake(titX, centY - 7.5f, titW, 15);
}

#pragma mark - getter
//订阅按钮
- (UIButton *)scribeButton {
    if(!_scribeButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"play_album_unfav_n"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"play_album_fav_n"] forState:UIControlStateSelected];
        [self addSubview:btn];
        _scribeButton = btn;
    }
    return _scribeButton;
}

//订阅量标签
- (UILabel *)scribeCountLabel {
    if(!_scribeCountLabel) {
        UILabel *lab = [UILabel new];
        lab.textAlignment = NSTextAlignmentRight;
        lab.font = [UIFont systemFontOfSize:12];
        lab.textColor = Hex(0x98999A);
        [self addSubview:lab];
        _scribeCountLabel = lab;
    }
    return _scribeCountLabel;
}


//标题标签
- (UILabel *)titleLabel {
    if(!_titleLabel) {
        UILabel *lab = [UILabel new];
        lab.textColor = Hex(0x020304);
        lab.font = [UIFont systemFontOfSize:15];
        [self addSubview:lab];
        _titleLabel = lab;
    }
    return _titleLabel;
}

//专辑图标
- (UIImageView *)iconImageView {
    if(!_iconImageView) {
        UIImageView *img = [UIImageView new];
        img.backgroundColor = Hex(0xf0f0f0);
        [self addSubview:img];
        _iconImageView = img;
    }
    return _iconImageView;
}

@end


//当前播放状态
@interface XMLYPlayStateView : UIView

@property (nonatomic, weak) UIImageView *coverImageView;
@property (nonatomic, weak) UIView      *alphaView;
@property (nonatomic, weak) UILabel     *curTimeLabel;
@property (nonatomic, weak) UILabel     *allTimeLabel;
@property (nonatomic, weak) UIButton    *barrageButton; //弹幕按钮
@property (nonatomic, weak) UISlider    *slider;

@property (nonatomic, strong) XMLYPlayPageModel *model;

//进度变化
- (void)audioDurationChange:(NSTimeInterval)currentTime duration:(NSTimeInterval)duration;
//下载进度变化
- (void)audioBufferStatusChange:(NSUInteger)receivedLength expectedLength:(NSUInteger)expectedLength downloadSpeed:(NSUInteger)downloadSpeed;


@end

@implementation XMLYPlayStateView

#pragma mark - public

//进度变化
- (void)audioDurationChange:(NSTimeInterval)currentTime duration:(NSTimeInterval)duration {
    if(duration == 0) {
        self.curTimeLabel.text = @"00:00";
        self.allTimeLabel.text = @"00:00";
        [self.slider setValue:0.0f animated:NO];
    } else {
        [self.slider setValue:currentTime / duration animated:YES];
        self.curTimeLabel.text = [XMLYTimeHelper timeFromTimeInterval:currentTime];
        self.allTimeLabel.text = [XMLYTimeHelper timeFromTimeInterval:duration];
    }
}

//下载进度变化
- (void)audioBufferStatusChange:(NSUInteger)receivedLength expectedLength:(NSUInteger)expectedLength downloadSpeed:(NSUInteger)downloadSpeed {
    
}



#pragma mark - set

- (void)setModel:(XMLYPlayPageModel *)model {
    _model = model;
    
    [self.coverImageView yy_setImageWithURL:[NSURL URLWithString:_model.albumInfo.coverOrigin] options:YYWebImageOptionSetImageWithFadeAnimation];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //封面
    self.coverImageView.frame = CGRectMake(0, 0, self.width, self.height - 5);
    
    self.alphaView.frame = self.coverImageView.frame;
    
    self.slider.frame = CGRectMake(-2, self.height - 10, self.width + 4, 10);

    self.curTimeLabel.frame = CGRectMake(5, self.coverImageView.bottom - 22, 40, 12);
    
    self.allTimeLabel.frame = CGRectMake(self.width - 45, self.curTimeLabel.top, 40, 12);
    
    self.barrageButton.frame = CGRectMake(self.width - 43, self.allTimeLabel.top - 30, 23, 25);
}

#pragma mark - getter

- (UISlider *)slider {
    if(!_slider) {
        UISlider *sid = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        [sid setThumbImage:[UIImage imageNamed:@"tumb_video"] forState:UIControlStateNormal];
        [self addSubview:sid];
        _slider = sid;
    }
    return _slider;
}

//时间总长度
- (UILabel *)allTimeLabel {
    if(!_allTimeLabel) {
        UILabel *lab = [[UILabel alloc] init];
        lab.textAlignment = NSTextAlignmentRight;
        lab.textColor = [UIColor whiteColor];
        lab.font = [UIFont systemFontOfSize:10];
        lab.text = @"00:00";
        [self addSubview:lab];
        _allTimeLabel = lab;
    }
    return _allTimeLabel;
}

//当前播放的时间
- (UILabel *)curTimeLabel {
    if(!_curTimeLabel) {
        UILabel *lab = [[UILabel alloc] init];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.textColor = [UIColor whiteColor];
        lab.font = [UIFont systemFontOfSize:10];
        lab.text = @"00:00";
        [self addSubview:lab];
        _curTimeLabel = lab;
    }
    return _curTimeLabel;
}

//弹幕
- (UIButton *)barrageButton {
    if(!_barrageButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"np_danmu_bg"] forState:UIControlStateNormal];
        [self addSubview:btn];
        _barrageButton = btn;
    }
    return _barrageButton;
}

//半透明蒙版
- (UIView *)alphaView {
    if(!_alphaView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.35];
        [self addSubview:view];
        _alphaView = view;
    }
    return _alphaView;
}

//封面
- (UIImageView *)coverImageView {
    if(!_coverImageView) {
        UIImageView *img = [[UIImageView alloc] init];
        img.contentMode = UIViewContentModeScaleAspectFill;
        img.layer.masksToBounds = YES;
        [self addSubview:img];
        _coverImageView = img;
    }
    return _coverImageView;
}

@end

@protocol XMLYPlayControlDelegate <NSObject>

// 播放、暂停按钮点击事件回调
- (void)playControlView:(XMLYPlayControlView *)view didStatusButtonClick:(UIButton *)btn;

// 上一个按钮点击事件
- (void)playControlView:(XMLYPlayControlView *)view didPreButtonClick:(UIButton *)btn;

// 下一个按钮点击事件
- (void)playControlView:(XMLYPlayControlView *)view didNextButtonClick:(UIButton *)btn;

@end

//控制器view
@interface XMLYPlayControlView : UIView

@property (nonatomic, weak) UIButton    *playListBtn;
@property (nonatomic, weak) UIButton    *goBackBtn;
@property (nonatomic, weak) UIButton    *stateBtn;
@property (nonatomic, weak) UIButton    *goForwardBtn;
@property (nonatomic, weak) UIButton    *timingBtn;

@property (nonatomic, weak) __weak id<XMLYPlayControlDelegate> delegate;

@property (nonatomic, strong) XMLYPlayPageModel *model;

@end

@implementation XMLYPlayControlView

#pragma mark - public

//状态变化
- (void)audioStatusChanged:(DOUAudioStreamerStatus)status {
    if(status == DOUAudioStreamerPlaying) {
//        self.stateBtn
//        [self.stateBtn setImage:[UIImage imageNamed:@"toolbar_pause_n_p"] forState:UIControlStateNormal];
        self.stateBtn.selected = YES;
    }else if(status == DOUAudioStreamerPaused) {
        self.stateBtn.selected = NO;
       // [self.stateBtn setImage:[UIImage imageNamed:@"tabbar_np_playnon"] forState:UIControlStateNormal];
    }
}

#pragma mark - sys

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.stateBtn.frame = CGRectMake(kScreenWidth / 2.0 - 22.5f, self.height / 2.0 - 22.5f, 45, 45);
    
    self.goBackBtn.frame = CGRectMake(self.stateBtn.left - 47, self.height / 2.0 - 7.5, 15, 15);
    
    self.goForwardBtn.frame = CGRectMake(self.stateBtn.right + 32, self.goBackBtn.top, self.goBackBtn.width, self.goBackBtn.height);
    
    self.playListBtn.frame = CGRectMake(12, self.height / 2.0 - 18, 36, 36);
    
    self.timingBtn.frame = CGRectMake(kScreenWidth - 48, self.playListBtn.top, self.playListBtn.width,self.playListBtn.height);
}

#pragma mark - private

- (void)statusButtonClick:(UIButton *)btn {
    if([self.delegate respondsToSelector:@selector(playControlView:didStatusButtonClick:)]) {
        [self.delegate playControlView:self didStatusButtonClick:btn];
    }
}


- (void)preButtonClick:(UIButton *)btn {
    if([self.delegate respondsToSelector:@selector(playControlView:didPreButtonClick:)]) {
        [self.delegate playControlView:self didPreButtonClick:btn];
    }
}


- (void)nextButtonClick:(UIButton *)btn {
    if([self.delegate respondsToSelector:@selector(playControlView:didNextButtonClick:)]) {
        [self.delegate playControlView:self didNextButtonClick:btn];
    }
}


#pragma mark - getter

//定时关闭按钮
- (UIButton *)timingBtn {
    if(!_timingBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"toolbar_clock_n_p"] forState:UIControlStateNormal];
        [self addSubview:btn];
        _timingBtn = btn;
    }
    return _timingBtn;
}

//下一个按钮
- (UIButton *)goForwardBtn {
    if(!_goForwardBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"toolbar_next_n_p"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(nextButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _goForwardBtn = btn;
    }
    return _goForwardBtn;
}

//暂停、播放按钮
- (UIButton *)stateBtn {
    if(!_stateBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabbar_np_playnon"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"toolbar_pause_n_p"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(statusButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _stateBtn = btn;
    }
    return _stateBtn;
}

- (UIButton *)goBackBtn {
    if(!_goBackBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"toolbar_prev_n_p"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(preButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _goBackBtn = btn;
    }
    return _goBackBtn;
}

//播放列表按钮
- (UIButton *)playListBtn {
    if(!_playListBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"toolbar_playinglist_n_p"] forState:UIControlStateNormal];
        [self addSubview:btn];
        _playListBtn = btn;
    }
    return _playListBtn;
}

@end

@interface XMLYPlayHeaderView () <XMLYPlayControlDelegate>

@property (nonatomic, weak) XMLYPlayHeaderIntroView *introView;
@property (nonatomic, weak) XMLYPlayStateView       *stateView;
@property (nonatomic, weak) XMLYPlayControlView     *controlView;
@property (nonatomic, weak) UIView                  *sepView;

@end

@implementation XMLYPlayHeaderView

- (void)setModel:(XMLYPlayPageModel *)model {
    _model = model;
    self.backgroundColor = [UIColor whiteColor];
    self.introView.model = _model;
    self.stateView.model = _model;
    self.controlView.model = _model;
}

#pragma mark - setter
- (void)audioStatusChanged:(DOUAudioStreamerStatus)status {
    [self.controlView audioStatusChanged:status];
}

- (void)audioDurationChange:(NSTimeInterval)currentTime duration:(NSTimeInterval)duration {
    [self.stateView audioDurationChange:currentTime duration:duration];
}

- (void)audioBufferStatusChange:(NSUInteger)receivedLength expectedLength:(NSUInteger)expectedLength downloadSpeed:(NSUInteger)downloadSpeed {
    [self.stateView audioBufferStatusChange:receivedLength expectedLength:expectedLength downloadSpeed:downloadSpeed];
}

#pragma mark - XMLYPlayControlDelegate

- (void)playControlView:(XMLYPlayControlView *)view didStatusButtonClick:(UIButton *)btn {
    if([self.delegate respondsToSelector:@selector(playHeaderView:didStatuButtonClick:)]) {
        [self.delegate playHeaderView:self didStatuButtonClick:btn];
    }
}


- (void)playControlView:(XMLYPlayControlView *)view didNextButtonClick:(UIButton *)btn {
    if([self.delegate respondsToSelector:@selector(playHeaderView:didNextButtonClick:)]) {
        [self.delegate playHeaderView:self didNextButtonClick:btn];
    }
}

- (void)playControlView:(XMLYPlayControlView *)view didPreButtonClick:(UIButton *)btn {
    if([self.delegate respondsToSelector:@selector(playHeaderView:didPreButtonClick:)]) {
        [self.delegate playHeaderView:self didPreButtonClick:btn];
    }
}

#pragma mark - getter

//底部分割线
- (UIView *)sepView {
    if(!_sepView) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(12, self.bottom - 0.5f, kScreenWidth - 24, 0.5f);
        view.backgroundColor = Hex(0xf0f0f0);
        [self addSubview:view];
        _sepView = view;
    }
    return _sepView;
}

//控制部分
- (XMLYPlayControlView *)controlView {
    if(!_controlView) {
        XMLYPlayControlView *view = [[XMLYPlayControlView alloc] init];
        view.frame = CGRectMake(0, self.stateView.bottom, kScreenWidth, 66);
        view.delegate = self;
        [self addSubview:view];
        _controlView = view;
    }
    return _controlView;
}

//播放状态view
- (XMLYPlayStateView *)stateView {
    if(!_stateView) {
        XMLYPlayStateView *view = [[XMLYPlayStateView alloc] init];
        view.frame = CGRectMake(0, self.introView.bottom, kScreenWidth, 330);
        [self addSubview:view];
        _stateView = view;
    }
    return _stateView;
}


//介绍view
- (XMLYPlayHeaderIntroView *)introView {
    if(!_introView) {
        XMLYPlayHeaderIntroView *view = [[XMLYPlayHeaderIntroView alloc] init];
        view.frame = CGRectMake(0, 0, kScreenWidth, 50);
        [self addSubview:view];
        _introView = view;
    }
    return _introView;
}

@end
