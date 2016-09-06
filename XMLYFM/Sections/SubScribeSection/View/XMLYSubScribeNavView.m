//
//  XMLYSubScribeNavView.m
//  XMLYFM
//
//  Created by East_wu on 16/8/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYSubScribeNavView.h"
#import "Masonry.h"


@interface XMLYSubScribeNavView ()

/**
 *  推荐按钮
 */
@property (nonatomic, weak) UIButton *recommendButton;
/**
 *  订阅按钮
 */
@property (nonatomic, weak) UIButton *subScribeButton;
/**
 *  历史按钮
 */
@property (nonatomic, weak) UIButton *historyButton;
/**
 *  小滑块
 */
@property (nonatomic, weak) UIView   *sliderView;

@property (nonatomic, assign) CGFloat navigationItemWidth;

@end

@implementation XMLYSubScribeNavView

+ (instancetype)subScribeNavView {
    XMLYSubScribeNavView *view = [[XMLYSubScribeNavView alloc] init];
    return view;
}

- (instancetype)init {
    if(self = [super init]) {
        self.navigationItemWidth = kScreenWidth / 3.0f;
        [self subScribeButton];
        [self recommendButton];
        [self historyButton];
    }
    return self;
}

- (UIButton *)subScribeButton {
    if(!_subScribeButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"订阅" forState:UIControlStateNormal];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(self.navigationItemWidth, 44));
            make.top.equalTo(self.mas_top);
            make.centerX.equalTo(self);
        }];
        _subScribeButton = btn;
    }
    return _subScribeButton;
}

- (UIButton *)recommendButton {
    if(!_recommendButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"推荐" forState:UIControlStateNormal];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.subScribeButton.mas_left);
            make.top.mas_equalTo(self.mas_top);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
        _recommendButton = btn;
    }
    return _recommendButton;
}

- (UIButton *)historyButton {
    if(!_historyButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"历史" forState:UIControlStateNormal];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.subScribeButton.mas_right);
            make.right.mas_equalTo(self.mas_right);
            make.top.mas_equalTo(self.mas_top);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
    }
    return _historyButton;
}

@end
