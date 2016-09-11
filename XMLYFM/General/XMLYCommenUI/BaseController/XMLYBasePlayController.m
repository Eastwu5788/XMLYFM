//
//  XMLYBasePlayController.m
//  XMLYFM
//
//  Created by East_wu on 16/9/11.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBasePlayController.h"
#import "Masonry.h"



@implementation XMLYBasePlayView



- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.bgImageView.frame = self.bounds;
    
    CGFloat space = (self.frame.size.width - 48) / 2.0f;
    
    self.playButton.frame = CGRectMake(space, space, 48.0f, 48.0f);
}

#pragma mark - UIButton
- (UIButton *)playButton {
    if(!_playButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabbar_np_playnon"] forState:UIControlStateNormal];
        [self addSubview:btn];
        _playButton = btn;
    }
    return _playButton;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self playView];
}

#pragma mark - Getter

- (XMLYBasePlayView *)playView {
    if(!_playView) {
        XMLYBasePlayView *view = [[XMLYBasePlayView alloc] init];
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
