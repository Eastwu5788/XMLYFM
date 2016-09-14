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
@property (nonatomic, strong) NSArray *charSpaceArr;

@end

@implementation XMLYLiveDetailHeaderView

- (instancetype)init {
    self = [super init];
    self.backgroundColor = [UIColor redColor];
    [self configTimeDownLabelText:@"还有00天22时53分08秒"];
    return self;
}



- (void)configTimeDownLabelText:(NSString *)oriString {
    NSMutableAttributedString *mutStr = [[NSMutableAttributedString alloc] initWithString:oriString];
    
    [mutStr setYy_font:[UIFont systemFontOfSize:12]];
    [mutStr setYy_color:[UIColor whiteColor]];
    
    
    for(NSString *rangeStr in self.charSpaceArr) {
        NSRange range = NSRangeFromString(rangeStr);
        [mutStr yy_setKern:[NSNumber numberWithInteger:5] range:range];
    }
   
    
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

- (NSArray *)charSpaceArr {
    if(!_charSpaceArr) {
        _charSpaceArr = @[NSStringFromRange(NSMakeRange(1, 1)),
                          NSStringFromRange(NSMakeRange(3, 1)),
                          NSStringFromRange(NSMakeRange(4, 1)),
                          NSStringFromRange(NSMakeRange(6, 1)),
                          NSStringFromRange(NSMakeRange(7, 1)),
                          NSStringFromRange(NSMakeRange(9, 1)),
                          NSStringFromRange(NSMakeRange(10, 1)),
                          NSStringFromRange(NSMakeRange(12, 1))];
    }
    return _charSpaceArr;
}


- (NSArray *)specialRangeArr {
    if(!_specialRangeArr) {
        _specialRangeArr = @[NSStringFromRange(NSMakeRange(2, 2)),
                             NSStringFromRange(NSMakeRange(5, 2)),
                             NSStringFromRange(NSMakeRange(8, 2)),
                             NSStringFromRange(NSMakeRange(11, 2))];
    }
    return _specialRangeArr;
}

@end
