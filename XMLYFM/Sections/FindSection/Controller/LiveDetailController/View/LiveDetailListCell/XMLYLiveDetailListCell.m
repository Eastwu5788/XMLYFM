//
//  XMLYLiveDetailListCell.m
//  XMLYFM
//
//  Created by East_wu on 16/9/15.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYLiveDetailListCell.h"
#import "XMLYTimeHelper.h"

@interface XMLYLiveDetailListCell ()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UIButton  *appointButton;
@property (nonatomic, weak) UIView   *sepLine;

@end

@implementation XMLYLiveDetailListCell

- (void)setItemModel:(XMLYActivitySchedules *)itemModel {
    _itemModel = itemModel;
    
    self.titleLabel.text = _itemModel.title;
    
    NSString *start = [XMLYTimeHelper dataStringFromTimeInterval:_itemModel.startTs / 1000 dataFormatter:@"yyyy.MM.dd HH:mm"];
    NSString *end = [XMLYTimeHelper dataStringFromTimeInterval:_itemModel.endTs / 1000 dataFormatter:@"HH:mm"];
    NSString *time = [NSString stringWithFormat:@"%@ - %@",start,end];
    self.timeLabel.text = time;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor whiteColor];
    self.appointButton.frame = CGRectMake(self.width - 57, self.height / 2 - 12, 51, 24);
    
    self.titleLabel.frame = CGRectMake(10, 8, self.appointButton.left - 20, 15);
    
    self.timeLabel.frame = CGRectMake(10, self.titleLabel.bottom + 5, self.titleLabel.width, 12);
    
    self.sepLine.frame = CGRectMake(0, self.height - 0.5, self.width, 0.5f);
}

#pragma mark - getter

//预约按钮
- (UIButton *)appointButton {
    if(!_appointButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"回听" forState:UIControlStateNormal];
        [btn setTitleColor:Hex(0xEE5B2A) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:11];
        btn.layer.cornerRadius = 3.0f;
        btn.layer.borderWidth = 0.5f;
        btn.layer.borderColor = Hex(0xEE5B2A).CGColor;
        [self addSubview:btn];
        _appointButton = btn;
    }
    return _appointButton;
}


//时间标签
- (UILabel *)timeLabel {
    if(!_timeLabel) {
        UILabel *lab = [[UILabel alloc] init];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.font = [UIFont systemFontOfSize:10];
        lab.textColor = Hex(0x9D9E9F);
        [self addSubview:lab];
        _timeLabel = lab;
    }
    return _timeLabel;
}

//标题
- (UILabel *)titleLabel {
    if(!_titleLabel) {
        UILabel *lab = [[UILabel alloc] init];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.font = [UIFont systemFontOfSize:14];
        lab.textColor = Hex(0x010101);
        [self addSubview:lab];
        _titleLabel = lab;
    }
    return _titleLabel;
}

- (UIView *)sepLine {
    if(!_sepLine) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = Hex(0xf0f0f0);
        [self addSubview:view];
        _sepLine = view;
    }
    return _sepLine;
}


@end
