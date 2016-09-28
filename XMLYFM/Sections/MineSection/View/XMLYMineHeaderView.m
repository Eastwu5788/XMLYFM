//
//  XMLYMineHeaderView.m
//  XMLYFM
//
//  Created by East_wu on 16/9/9.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYMineHeaderView.h"

@interface XMLYMineHeaderView ()

@property (nonatomic, weak) UIImageView *backImageView;
@property (nonatomic, weak) UIView      *alphaView;
@property (nonatomic, weak) UIButton    *settingButton;
@property (nonatomic, weak) UIImageView *avatarImageView;
@property (nonatomic, weak) UIButton    *userNameButton;
@property (nonatomic, weak) UILabel     *subTitleLabel;
@property (nonatomic, weak) UIButton    *managerButton;
@property (nonatomic, weak) UIButton    *recordButton;

@end

@implementation XMLYMineHeaderView

- (instancetype)init {
    self = [super init];
    self.backgroundColor = [UIColor redColor];
    return self;
}

- (void)layoutSubviews { // height 288
    [super layoutSubviews];
    

    CGFloat hspace = (self.frame.size.width - kScreenWidth) / 2.0f;
    CGFloat centx = self.frame.size.width / 2.0f;
    
    //背景视图
    self.backImageView.frame = CGRectMake(hspace, 0, kScreenWidth, self.frame.size.height);
    self.alphaView.frame = CGRectMake(hspace, 0, kScreenWidth, self.frame.size.height);
    
    //节目管理
    self.managerButton.frame = CGRectMake(centx - 10 - 104.0f, self.frame.size.height - 36.0 - 37.0f, 104.0f, 37.0f);
    
    //录音按钮
    self.recordButton.frame = CGRectMake(centx + 10, self.managerButton.frame.origin.y, 104.0f, 37.0f);
    
    //子标题 
    self.subTitleLabel.frame = CGRectMake(centx - 150.0f, self.recordButton.frame.origin.y - 24.0f - 15.0f, 300, 15);
    
    //点击登录按钮
    self.userNameButton.frame = CGRectMake(centx - 100.0f, self.subTitleLabel.frame.origin.y - 10 - 18.0, 200.0f, 18.0f);
    
    //头像视图
    self.avatarImageView.frame = CGRectMake(centx - 45.0, self.userNameButton.frame.origin.y - 10 - 90.0, 90, 90);
    
    //设置按钮
    self.settingButton.frame = CGRectMake(12 + hspace, self.avatarImageView.frame.origin.y - 20, 20, 20);
    
}

#pragma mark - getter 
- (UIButton *)recordButton {
    if(!_recordButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"录音" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"ic_rec_w"] forState:UIControlStateNormal];
        btn.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.8f];
        btn.layer.cornerRadius = 5.0f;
        [self addSubview:btn];
        _recordButton = btn;
    }
    return _recordButton;
}



- (UIButton *)managerButton {
    if(!_managerButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"节目管理" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:[UIColor colorWithRed:0.36f green:0.36f blue:0.36f alpha:1.00f] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"ic_jmgl"] forState:UIControlStateNormal];
        btn.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];
        btn.layer.cornerRadius = 5.0f;
        [self addSubview:btn];
        _managerButton = btn;
    }
    return _managerButton;
}

/**
 *  子标题
 */
- (UILabel *)subTitleLabel {
    if(!_subTitleLabel) {
        UILabel *lab = [[UILabel alloc] init];
        lab.textColor = [UIColor whiteColor];
        lab.font = [UIFont systemFontOfSize:13];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = @"1秒登录，专享个性化服务";
        [self addSubview:lab];
        _subTitleLabel = lab;
    }
    return _subTitleLabel;
}

/**
 *  用户名按钮
 */
- (UIButton *)userNameButton {
    if(!_userNameButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:@"点击登录" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [self addSubview:btn];
        _userNameButton =btn;
    }
    return _userNameButton;
}

/**
 *  头像视图
 */
- (UIImageView *)avatarImageView {  //90 * 90
    if(!_avatarImageView) {
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"find_radio_default"]];
        img.layer.cornerRadius = 45.0f;
        img.layer.borderColor = [UIColor colorWithRed:0.76f green:0.69f blue:0.65f alpha:1.00f].CGColor;
        img.layer.borderWidth = 2.0f;
        img.layer.masksToBounds = YES;
        img.layer.rasterizationScale = [UIScreen mainScreen].scale;
        img.layer.shouldRasterize = YES;
        [self addSubview:img];
        _avatarImageView = img;
    }
    return _avatarImageView;
}

/**
 *  设置小按钮
 */
- (UIButton *)settingButton {
    if(!_settingButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"icon_setting"] forState:UIControlStateNormal];
        [self addSubview:btn];
        _settingButton = btn;
    }
    return _settingButton;
}


/**
 *  背景图上方的一层蒙版
 */
- (UIView *)alphaView {
    if(!_alphaView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = Hex(0x000000);
        view.alpha = 0.3f;
        [self addSubview:view];
        _alphaView = view;
    }
    return _alphaView;
}

/**
 *  后方的图片视图
 */
- (UIImageView *)backImageView {
    if(!_backImageView) {
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"find_radio_default"]];
        img.contentMode = UIViewContentModeScaleAspectFill;
        img.layer.masksToBounds = YES;
        [self addSubview:img];
        _backImageView = img;
       
    }
    return _backImageView;
}

@end
