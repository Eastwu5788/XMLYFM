//
//  XMLYAlbumDetailHeaderView.m
//  XMLYFM
//
//  Created by East_wu on 16/9/13.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYAlbumDetailHeaderView.h"

static force_inline NSString *XMLYGetPlyCount(NSInteger num) {
    if(num < 10000) {
        return [NSString stringWithFormat:@"%ld",(long)num];
    }else {
        CGFloat fot = num / 10000.0f;
        return [NSString stringWithFormat:@"%.1f万",fot];
    }
}


@interface XMLYAlbumDetailHeaderView ()

@property (nonatomic, weak) UIImageView *bgImageView;           //cover的封面
@property (nonatomic, weak) UIImageView *coverImageView;        //封面
@property (nonatomic, weak) UILabel     *titleLabel;            //标题
@property (nonatomic, weak) UILabel     *anchorLabel;           //主播
@property (nonatomic, weak) UILabel     *playCountsLabel;       //播放量
@property (nonatomic, weak) UILabel     *cateLabel;             //类别

@property (nonatomic, weak) UIButton    *albumButton;           //订阅专辑按钮
@property (nonatomic, weak) UIButton    *downButton;            //批量下载按钮

@property (nonatomic, weak) UIView      *sepView;               //分割条

@end

@implementation XMLYAlbumDetailHeaderView

+ (instancetype)albumDetailHeaderViewWithFrame:(CGRect)frame {
    return [[self alloc] initAlbumDetailHeaderViewWithFrame:frame];
}

- (instancetype)initAlbumDetailHeaderViewWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    [self configSubViews];
    return self;
}

- (void)configSubViews {
    [self bgImageView];
    [self coverImageView];
    [self titleLabel];
    [self anchorLabel];
    [self playCountsLabel];
    [self cateLabel];
    [self albumButton];
    [self downButton];
    [self bottom];
}

- (void)setAlbumModel:(XMLYAlbumModel *)albumModel {
    _albumModel = albumModel;
    
    [self.coverImageView yy_setImageWithURL:[NSURL URLWithString:_albumModel.coverLarge] options:YYWebImageOptionSetImageWithFadeAnimation];
    
    self.titleLabel.text = _albumModel.title;
    
    self.anchorLabel.text = [NSString stringWithFormat:@"主播：%@",_albumModel.nickname];
    
    self.playCountsLabel.text = [NSString stringWithFormat:@"播放：%@",XMLYGetPlyCount(_albumModel.playTimes)];
    
    self.cateLabel.text = [NSString stringWithFormat:@"分类：%@",_albumModel.categoryName];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //封面背景
    self.bgImageView.size = CGSizeMake(120, 120);
    self.bgImageView.origin = CGPointMake(12, 12);

    //封面   用法一
    self.coverImageView.size = CGSizeMake(94, 94);
    self.coverImageView.center = self.bgImageView.center;
    
    //标题  用法二
    CGFloat width = self.right - 17 - self.bgImageView.right;
    self.titleLabel.frame = CGRectMake(self.bgImageView.right + 5, self.coverImageView.top, width, 15);
    
    //主播  用法三
    self.anchorLabel.frame = CGRectMake(self.titleLabel.left, self.titleLabel.bottom + 10, self.titleLabel.width, 13);
    
    //播放量
    self.playCountsLabel.frame = CGRectMake(self.anchorLabel.left, self.anchorLabel.bottom + 10, self.anchorLabel.width, 13);
    
    //分类
    self.cateLabel.frame = CGRectMake(self.playCountsLabel.left, self.playCountsLabel.bottom + 10, self.playCountsLabel.width, 13);
    
    //
    CGFloat btnWidth = (kScreenWidth - 55) / 2.0f;
    self.albumButton.frame = CGRectMake(20, self.coverImageView.bottom + 33, btnWidth, 34);
    
    self.downButton.left = self.albumButton.right + 15;
    self.downButton.width = btnWidth;
    self.downButton.height = 34;
    self.downButton.top = self.albumButton.top;
    
    self.sepView.frame = CGRectMake(0, self.bottom - 10, self.width, 10);
}


#pragma mark - getter

- (UIView *)sepView {
    if(!_sepView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = Hex(0xEBECED);
        [self addSubview:view];
        _sepView = view;
    }
    return _sepView;
}

//批量下载按钮
- (UIButton *)downButton {
    if(!_downButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"批量下载" forState:UIControlStateNormal];
        [btn setTitleColor:Hex(0xE07456) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.layer.cornerRadius = 3.0f;
        btn.layer.borderColor = Hex(0xE07456).CGColor;
        btn.layer.borderWidth = 0.5f;
        [btn setImage:[UIImage imageNamed:@"me_setting_favAlbum"] forState:UIControlStateNormal];
        [self addSubview:btn];
        _downButton = btn;
    }
    return _downButton;
}

//订阅专辑
- (UIButton *)albumButton {
    if(!_albumButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"订阅专辑" forState:UIControlStateNormal];
        [btn setTitleColor:Hex(0xE07456) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.layer.cornerRadius = 3.0f;
        btn.layer.borderColor = Hex(0xE07456).CGColor;
        btn.layer.borderWidth = 0.5f;
        [btn setImage:[UIImage imageNamed:@"me_setting_favAlbum"] forState:UIControlStateNormal];
        [self addSubview:btn];
        _albumButton = btn;
    }
    return _albumButton;
}

//类别标签
- (UILabel *)cateLabel {
    if(!_cateLabel) {
        UILabel *lab = [[UILabel alloc] init];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.font = [UIFont systemFontOfSize:12];
        lab.textColor = [UIColor colorWithRed:0.58f green:0.59f blue:0.59f alpha:1.00f];
        [self addSubview:lab];
        _cateLabel = lab;
    }
    return _cateLabel;
}

//播放量标签
- (UILabel *)playCountsLabel {
    if(!_playCountsLabel) {
        UILabel *lab = [[UILabel alloc] init];
        lab.font = [UIFont systemFontOfSize:12];
        lab.textColor = [UIColor colorWithRed:0.58f green:0.59f blue:0.59f alpha:1.00f];
        lab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:lab];
        _playCountsLabel = lab;
    }
    return _playCountsLabel;
}

//主播标签
- (UILabel *)anchorLabel {
    if(!_anchorLabel) {
        UILabel *lab = [[UILabel alloc] init];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.font = [UIFont systemFontOfSize:12];
        lab.textColor = [UIColor colorWithRed:0.58f green:0.59f blue:0.59f alpha:1.00f];
        [self addSubview:lab];
        _anchorLabel = lab;
    }
    return _anchorLabel;
}

//标题标签
- (UILabel *)titleLabel {
    if(!_titleLabel) {
        UILabel *lab = [[UILabel alloc] init];
        lab.textColor = [UIColor colorWithRed:0.20f green:0.20f blue:0.21f alpha:1.00f];
        lab.font = [UIFont systemFontOfSize:15];
        lab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:lab];
        _titleLabel = lab;
    }
    return _titleLabel;
}

//相册封面
- (UIImageView *)coverImageView {
    if(!_coverImageView) {
        UIImageView *img = [[UIImageView alloc] init];
        img.backgroundColor = Hex(0xf0f0f0);
        [self addSubview:img];
        _coverImageView = img;
    }
    return _coverImageView;
}

//封面背景
- (UIImageView *)bgImageView {
    if(!_bgImageView) {
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"album_cover_bg"]];
        [self addSubview:img];
        _bgImageView = img;
    }
    return _bgImageView;
}

@end
