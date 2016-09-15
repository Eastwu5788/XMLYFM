//
//  XMLYLiveDetailHeaderView.m
//  XMLYFM
//
//  Created by East_wu on 16/9/14.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYLiveDetailHeaderView.h"
#import "YYText.h"


@interface XMLYLiveDetailHeaderView ()

@property (nonatomic, weak) UIImageView  *bgImageView;
@property (nonatomic, weak) UIView       *alphaView;
@property (nonatomic, weak) UILabel      *titleLabel;
@property (nonatomic, weak) YYLabel      *timeDownLabel;
@property (nonatomic, weak) UIButton     *appointButton;

@property (nonatomic, strong) NSArray *specialRangeArr;


@end

@implementation XMLYLiveDetailHeaderView

- (instancetype)init {
    self = [super init];
    self.backgroundColor = Hex(0xf0f0f0);
    [self configSubViews];
    return self;
}

- (void)configSubViews {
    [self bgImageView];
    [self alphaView];
    [self titleLabel];
    [self timeDownLabel];
    [self appointButton];
}

- (void)setActivityModel:(XMLYLiveDetailActivity *)activityModel {
    _activityModel = activityModel;
    
    self.titleLabel.text = @"直播已结束";
    
    [self configTimeDownLabelText:@"还有 00 天 22 时 53 分 08 秒"];
    
    [self.bgImageView yy_setImageWithURL:[NSURL URLWithString:_activityModel.coverPath] options:YYWebImageOptionSetImageWithFadeAnimation];
    
}

- (void)configTimeDownLabelText:(NSString *)oriString {
    NSMutableAttributedString *mutStr = [[NSMutableAttributedString alloc] initWithString:oriString];
    
    [mutStr setYy_font:[UIFont systemFontOfSize:12]];
    [mutStr setYy_color:[UIColor whiteColor]];
    [mutStr setYy_alignment:NSTextAlignmentCenter];
    
    //特殊变大字体
    UIColor *strokeColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9f];
    YYTextBorder *border = [YYTextBorder borderWithLineStyle:YYTextLineStyleSingle lineWidth:0.5f strokeColor:strokeColor];
    border.fillColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    border.insets = UIEdgeInsetsMake(-2, -1, -3, -1);

    border.cornerRadius = 2.0f;
    for (NSString *rangStr in self.specialRangeArr) {
        NSRange range = NSRangeFromString(rangStr);
        [mutStr yy_setTextBackgroundBorder:border range:range]; //天前面
        [mutStr yy_setFont:[UIFont boldSystemFontOfSize:18] range:range];
    }
    
    self.timeDownLabel.attributedText = mutStr;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    //背景图片
    self.bgImageView.frame = CGRectMake(0, 0, self.width, self.height);
    
    //半透明遮罩
    self.alphaView.frame = self.bgImageView.frame;
    
    //标题位置
    self.titleLabel.frame = CGRectMake(0, 20, self.width, 16);
    
    //倒计时标签
    self.timeDownLabel.frame = CGRectMake(0, self.centerY - 20, self.frame.size.width,40);
    
    //预约提醒
    self.appointButton.frame = CGRectMake(self.centerX - 43.5, self.height - 5 -35, 87, 35);
}



#pragma mark - getter

//预约提醒按钮
- (UIButton *)appointButton {
    if(!_appointButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"预约提醒" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.backgroundColor = Hex(0xFA5932);
        btn.layer.cornerRadius = 5.0f;
        [self addSubview:btn];
        _appointButton = btn;
    }
    return _appointButton;
}

//标题
- (UILabel *)titleLabel {
    if(!_titleLabel) {
        UILabel *lab = [[UILabel alloc] init];
        lab.font = [UIFont systemFontOfSize:13];
        lab.textColor = [UIColor whiteColor];
        lab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lab];
        _titleLabel = lab;
    }
    return _titleLabel;
}

//半透明视图
- (UIView *)alphaView {
    if(!_alphaView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.45];
        [self addSubview:view];
        _alphaView = view;
    }
    return _alphaView;
}

//背景图片
- (UIImageView *)bgImageView {
    if(!_bgImageView) {
        UIImageView *img = [[UIImageView alloc] init];
        img.contentMode = UIViewContentModeScaleAspectFill;
        img.layer.masksToBounds = YES;
        [self addSubview:img];
        _bgImageView = img;
    }
    return _bgImageView;
}

//倒计时标签
- (YYLabel *)timeDownLabel {
    if(!_timeDownLabel) {
        YYLabel *lab = [YYLabel new];
        [self addSubview:lab];
        _timeDownLabel = lab;
    }
    return _timeDownLabel;
}


- (NSArray *)specialRangeArr {
    if(!_specialRangeArr) {
        _specialRangeArr = @[NSStringFromRange(NSMakeRange(3, 2)),
                             NSStringFromRange(NSMakeRange(8, 2)),
                             NSStringFromRange(NSMakeRange(13, 2)),
                             NSStringFromRange(NSMakeRange(18, 2))];
    }
    return _specialRangeArr;
}

@end








