//
//  XMLYSecHeaStyleTitle.m
//  XMLYFM
//
//  Created by East_wu on 16/9/14.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYSecHeaStyleTitle.h"

@interface XMLYSecHeaStyleTitle ()

@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation XMLYSecHeaStyleTitle


- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}


- (void)layoutSubviews {
    [super layoutSubviews];

    if(!self.title)  return ;
    self.titleLabel.frame = CGRectMake(10, 0, 200, self.height);
}

#pragma mark - UILabel

- (UILabel *)titleLabel {
    if(!_titleLabel) {
        UILabel *lab = [[UILabel alloc] init];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.font = [UIFont systemFontOfSize:13];
        lab.textColor = Hex(0x313233);
        [self addSubview:lab];
        _titleLabel = lab;
    }
    return _titleLabel;
}

@end
