//
//  XMLYPlayIntroCell.m
//  XMLYFM
//
//  Created by East_wu on 16/9/16.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYPlayIntroCell.h"

@interface XMLYPlayIntroCell ()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *playCountLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) UIButton *showAllBtn;

@end

@implementation XMLYPlayIntroCell


#pragma mark - getter
- (UILabel *)titleLabel {
    if(!_titleLabel) {
        UILabel *lab = [[UILabel alloc] init];
        lab.textColor = Hex(0x323334);
        lab.font = [UIFont systemFontOfSize:20];
        lab.numberOfLines = 0;
        [self addSubview:lab];
        _titleLabel = lab;
    }
    return _titleLabel;
}

@end
