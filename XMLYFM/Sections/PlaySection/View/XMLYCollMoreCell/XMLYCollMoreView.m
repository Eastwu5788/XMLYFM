//
//  XMLYCollMoreView.m
//  XMLYFM
//
//  Created by East_wu on 16/9/16.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYCollMoreView.h"

@interface XMLYCollMoreView ()

@property (nonatomic, weak) UIButton    *btn;

@end

@implementation XMLYCollMoreView

- (void)layoutSubviews {
    [super layoutSubviews];
    self.btn.frame = CGRectMake(0, 0, self.width, self.height);
}

#pragma mark - getter
- (UIButton *)btn {
    if(!_btn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = Hex(0xF9FAFB);
        [btn setTitleColor:Hex(0x98999A) forState:UIControlStateNormal];
        [btn setTitle:@"查看更多推荐" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:btn];
        _btn = btn;
    }
    return _btn;
}

@end
