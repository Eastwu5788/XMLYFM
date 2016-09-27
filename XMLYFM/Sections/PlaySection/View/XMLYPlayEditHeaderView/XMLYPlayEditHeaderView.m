//
//  XMLYPlayEditHeaderView.m
//  XMLYFM
//
//  Created by East_wu on 16/9/16.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYPlayEditHeaderView.h"
#import "XMLYCountHelper.h"

@interface XMLYPlayEditHeaderView ()

@property (nonatomic, weak) UIImageView *avatarImageView;
@property (nonatomic, weak) UILabel     *titleLabel;
@property (nonatomic, weak) UILabel     *attentionLabel;
@property (nonatomic, weak) UIImageView *vipImageView;
@property (nonatomic, weak) UIButton    *showMoreBtn;
@property (nonatomic, weak) UIView      *sepView;

@end

@implementation XMLYPlayEditHeaderView


- (void)setModel:(XMLYAlbumUserInfoModel *)model {
    _model = model;
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.showMoreBtn.frame = CGRectMake(10, 0, kScreenWidth - 20, 65.0f);
    
    self.avatarImageView.frame = CGRectMake(15, 10.0f, 45, 45);
    [self.avatarImageView yy_setImageWithURL:[NSURL URLWithString:_model.smallLogo] options:YYWebImageOptionSetImageWithFadeAnimation];
    
    self.titleLabel.frame = CGRectMake(self.avatarImageView.right + 12, self.avatarImageView.top + 10, _model.nicknameWidth, 15);
    self.titleLabel.text = _model.nickname;
    
    self.vipImageView.frame = CGRectMake(self.titleLabel.right + 5, self.titleLabel.top - 1, 16, 16);
    
    self.attentionLabel.frame = CGRectMake(self.avatarImageView.right + 12, self.titleLabel.bottom + 6, 200, 10);
    NSString *count = [XMLYCountHelper countStringFromNSInter:_model.followers];
    self.attentionLabel.text = [NSString stringWithFormat:@"已被%@人关注",count];
    
    self.sepView.frame = CGRectMake(0, 64.5f, kScreenWidth, 0.5f);
}

#pragma mark - getter

// 分割线
- (UIView *)sepView {
    if(!_sepView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = Hex(0xf0f0f0);
        [self addSubview:view];
        _sepView = view;
    }
    return _sepView;
}

// 更多按钮
- (UIButton *)showMoreBtn {
    if(!_showMoreBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"np_user_more"] forState:UIControlStateNormal];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [self addSubview:btn];
        _showMoreBtn = btn;
    }
    return _showMoreBtn;
}

// 关注人数量标签
- (UILabel *)attentionLabel {
    if(!_attentionLabel) {
        UILabel *lab = [[UILabel alloc] init];
        lab.font = [UIFont systemFontOfSize:12];
        lab.textColor = Hex(0x9A9B9C);
        [self addSubview:lab];
        _attentionLabel = lab;
    }
    return _attentionLabel;
}

// vip图片
- (UIImageView *)vipImageView {
    if(!_vipImageView) {
        UIImageView *img = [[UIImageView alloc] init];
        img.image = [UIImage imageNamed:@"me_fans_verifylogo"];
        [self addSubview:img];
        _vipImageView = img;
    }
    return _vipImageView;
}

// 标题
- (UILabel *)titleLabel {
    if(!_titleLabel) {
        UILabel *lab = [[UILabel alloc] init];
        lab.font = [UIFont systemFontOfSize:15];
        lab.textColor = Hex(0x464748);
        [self addSubview:lab];
        _titleLabel = lab;
    }
    return _titleLabel;
}

// 头像
- (UIImageView *)avatarImageView {
    if(!_avatarImageView) {
        UIImageView *img = [[UIImageView alloc] init];
        img.backgroundColor = Hex(0xf0f0f0);
        img.layer.cornerRadius = 22.5f;
        img.layer.masksToBounds = YES;
        //栅格化后，图层会被渲染成图片，并且缓存，再次使用时，不会重新渲染
        img.layer.rasterizationScale = [UIScreen mainScreen].scale;
        img.layer.shouldRasterize = YES;
        [self addSubview:img];
        _avatarImageView = img;
    }
    return _avatarImageView;
}

@end
