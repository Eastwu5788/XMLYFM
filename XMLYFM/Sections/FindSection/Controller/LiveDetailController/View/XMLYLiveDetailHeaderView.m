//
//  XMLYLiveDetailHeaderView.m
//  XMLYFM
//
//  Created by East_wu on 16/9/14.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYLiveDetailHeaderView.h"
#import "YYText.h"

@interface XMLYTimeDownItemView : UIView

@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *introLabel;


@end


@implementation XMLYTimeDownItemView


//55 * 38
- (void)layoutSubviews {
    [super layoutSubviews];
    
    //时间标签
    self.timeLabel.frame = CGRectMake(5, 0, 31, self.height);
    
    //天数介绍
    self.introLabel.frame = CGRectMake(self.width - 18, 0, 18, self.height);
}

#pragma mark - getter

- (UILabel *)introLabel {
    if(!_introLabel) {
        UILabel *lab = [[UILabel alloc] init];
        lab.font = [UIFont systemFontOfSize:11];
        lab.textAlignment = NSTextAlignmentRight;
        lab.textColor = [UIColor whiteColor];
        lab.text = @"天";
        [self addSubview:lab];
        _introLabel = lab;
    }
    return _introLabel;
}

- (UILabel *)timeLabel {
    if(!_timeLabel) {
        UILabel *lab = [[UILabel alloc] init];
        lab.font = [UIFont boldSystemFontOfSize:15.0f];
        lab.textColor = [UIColor whiteColor];
        lab.text = @"00";
        lab.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.35];
        lab.layer.cornerRadius = 3.0f;
        lab.layer.borderWidth = 1.0f;
        lab.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3].CGColor;
        [self addSubview:lab];
        _timeLabel = lab;
    }
    return _timeLabel;
}

@end


@interface XMLYTimeDownView : UIView

@property (nonatomic, weak) UILabel *firstLabel;
@property (nonatomic, weak) XMLYTimeDownItemView *dayView;
@property (nonatomic, weak) XMLYTimeDownItemView *hourView;
@property (nonatomic, weak) XMLYTimeDownItemView *minutesView;
@property (nonatomic, weak) XMLYTimeDownItemView *secondView;

@end

@implementation XMLYTimeDownView

#pragma mark - getter



- (UILabel *)firstLabel {
    if(!_firstLabel) {
        UILabel *lab = [[UILabel alloc] init];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.font = [UIFont systemFontOfSize:11];
        lab.text = @"还有";
        lab.textColor = [UIColor whiteColor];
        [self addSubview:lab];
        _firstLabel = lab;
    }
    return _firstLabel;
}

@end




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
    self.backgroundColor = [UIColor redColor];
    [self configTimeDownLabelText:@"还有 00 天 22 时 53 分 08 秒"];
    return self;
}



- (void)configTimeDownLabelText:(NSString *)oriString {
    NSMutableAttributedString *mutStr = [[NSMutableAttributedString alloc] initWithString:oriString];
    
    [mutStr setYy_font:[UIFont systemFontOfSize:12]];
    [mutStr setYy_color:[UIColor whiteColor]];
    
    
   
    
    //特殊变大字体
    UIColor *strokeColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9f];
    YYTextBorder *border = [YYTextBorder borderWithLineStyle:YYTextLineStyleSingle lineWidth:0.5f strokeColor:strokeColor];
    border.fillColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];

    border.cornerRadius = 2.0f;
    for (NSString *rangStr in self.specialRangeArr) {
        NSRange range = NSRangeFromString(rangStr);
        [mutStr yy_setTextBackgroundBorder:border range:range]; //天前面
        [mutStr yy_setFont:[UIFont boldSystemFontOfSize:15] range:range];
    }
    
    self.timeDownLabel.attributedText = mutStr;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.timeDownLabel.frame = CGRectMake(0, 0, self.frame.size.width, 50);
}



#pragma mark - getter
- (YYLabel *)timeDownLabel {
    if(!_timeDownLabel) {
        YYLabel *lab = [YYLabel new];
        lab.textAlignment = NSTextAlignmentCenter;
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








