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

@end

@implementation XMLYSubScribeNavView

+ (instancetype)subScribeNavView {
    XMLYSubScribeNavView *view = [[XMLYSubScribeNavView alloc] init];
    return view;
}

- (instancetype)init {
    if(self = [super init]) {
        
    }
    return self;
}


- (UIButton *)recommendButton {
    if(!_recommendButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"推荐" forState:UIControlStateNormal];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
        }];
    }
    return _recommendButton;
}

@end
