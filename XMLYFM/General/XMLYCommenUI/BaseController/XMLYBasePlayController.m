//
//  XMLYBasePlayController.m
//  XMLYFM
//
//  Created by East_wu on 16/9/11.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBasePlayController.h"
#import "UIIMageView+YYWebImage.h"
#import "Masonry.h"



@implementation XMLYBasePlayView

- (void)playButtonClick:(id)obj {
    if(self.playButtonClickBlock) {
        self.playButtonClickBlock(obj);
    }
}

// 开始旋转
- (void)startRotateIconImage {
    
    [self.iconImage.layer removeAllAnimations];
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2];
    rotationAnimation.duration = 10.0f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    [self.iconImage.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

// 停止旋转
- (void)stopRotateIconImage {
    [self.iconImage.layer removeAllAnimations];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.bgImageView.frame = self.bounds;
    
    CGFloat space = (self.frame.size.width - 48) / 2.0f;
    
    self.iconImage.frame = CGRectMake(space, space, 48.0f, 48.0f);
    
    self.playBtn.frame = CGRectMake(space - 2, space - 2 , 52.0f, 52.0f);
    [self bringSubviewToFront:self.iconImage];
    [self bringSubviewToFront:self.playBtn];
}

#pragma mark - UIButton
- (UIButton *)playBtn {
    if(!_playBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.cornerRadius = 26.0f;
        btn.layer.masksToBounds = YES;
        [btn addTarget:self action:@selector(playButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:@"tabbar_np_play"] forState:UIControlStateNormal];
        [self addSubview:btn];
        _playBtn = btn;
    }
    return _playBtn;
}

- (UIImageView *)iconImage {
    if(!_iconImage) {
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar_np_playnon"]];
        img.layer.cornerRadius = 24.0f;
        img.layer.masksToBounds = YES;
        img.userInteractionEnabled = YES;
        [self addSubview:img];
        _iconImage = img;
    }
    return _iconImage;
}

- (UIImageView *)bgImageView {
    if(!_bgImageView) {
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar_np_normal"]];
        [self addSubview:img];
        _bgImageView = img;
    }
    return _bgImageView;
}

@end


@interface XMLYBasePlayController ()


@end

@implementation XMLYBasePlayController

// 代理
- (void)trans2PlayViewController:(UIButton *)btn {
    if(self.playViewController.model == nil && self.audioModel) {
        self.playViewController.progress = self.audioModel.time_history;
        [self.playViewController startPlayWithAlbumID:self.audioModel.album_id trackID:self.audioModel.track_id cachePath:self.audioModel.cachePath];
    }
    XMLYBaseNavigationController *nav = [[XMLYBaseNavigationController alloc] initWithRootViewController:self.playViewController];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self playView];
    [self setUpPlayingStatus];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(self.playViewController.model && self.playViewController.status == DOUAudioStreamerPlaying) {
        [self.playView startRotateIconImage];
    }
}

- (void)setUpPlayingStatus {
    @weakify(self);
    self.playViewController = [XMLYPlayViewController playViewController];
    self.playViewController.playViewControllerStatusChangeBlock = ^(DOUAudioStreamerStatus status) {
        @strongify(self);
        [self configPlayViewWithModel:self.playViewController.model status:status];
    };
    //当前模型存在
    if(self.playViewController.model) {
        [self configPlayViewWithModel:self.playViewController.model status:self.playViewController.status];
    }else{
        self.audioModel = [[XMLYPlayDBHelper dbHelper] queryPlayingAudio];
        [self.playView.iconImage yy_setImageWithURL:[NSURL URLWithString:self.audioModel.coverSmall] placeholder:[UIImage imageNamed:@"find_usercover"]];
        [self.playView.playBtn setImage:[UIImage imageNamed:@"tabbar_np_play"] forState:UIControlStateNormal];
    }
}

- (void)configPlayViewWithModel:(XMLYPlayPageModel *)model status:(DOUAudioStreamerStatus)status {
    NSURL *url = [NSURL URLWithString:self.playViewController.model.albumInfo.coverSmall];
    [self.playView.iconImage yy_setImageWithURL:url placeholder:[UIImage imageNamed:@"find_usercover"]];
    if(self.playViewController.status == DOUAudioStreamerPlaying) {
        [self.playView.playBtn setImage:[UIImage imageNamed:@"toolbar_pause_n"] forState:UIControlStateNormal];
        [self.playView startRotateIconImage];
    } else {
        [self.playView.playBtn setImage:[UIImage imageNamed:@"tabbar_np_play"] forState:UIControlStateNormal];
        [self.playView stopRotateIconImage];
    }
}



#pragma mark - Getter

- (XMLYBasePlayView *)playView {
    if(!_playView) {
        XMLYBasePlayView *view = [[XMLYBasePlayView alloc] init];
        @weakify(self);
        view.playButtonClickBlock = ^(UIButton *btn) {
            @strongify(self);
            [self trans2PlayViewController:btn];
        };
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(63.0f, 63.0f));
            make.bottom.mas_equalTo(self.view.mas_bottom);
            make.centerX.mas_equalTo(self.view.mas_centerX);
        }];
        _playView = view;
    }
    return _playView;
}

@end
