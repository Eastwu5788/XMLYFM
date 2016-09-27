//
//  XMLYPlayIntroCell.m
//  XMLYFM
//
//  Created by East_wu on 16/9/16.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYPlayIntroCell.h"
#import "XMLYCountHelper.h"
#import "XMLYTimeHelper.h"

@interface XMLYPlayIntroCell ()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *playCountLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) UIButton *showAllBtn;

@end

@implementation XMLYPlayIntroCell

- (void)setModel:(XMLYPlayPageModel *)model {
    _model = model;
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.titleLabel.text = _model.trackInfo.title;
    self.titleLabel.frame = CGRectMake(10, 15, self.width - 20, _model.trackInfo.titleHeight);
    
    self.playCountLabel.text = [NSString stringWithFormat:@"26.7万次播放"];
    self.playCountLabel.frame = CGRectMake(10, self.titleLabel.bottom + 13, 100, 12);
    
    self.timeLabel.text = [XMLYTimeHelper dataStringFromTimeInterval:_model.albumInfo.createdAt / 1000 dataFormatter:@"MM-dd"];
    self.timeLabel.frame = CGRectMake(self.playCountLabel.right + 10, self.playCountLabel.top, 100, 12);
    
    self.contentLabel.text = _model.trackInfo.shortRichIntro;
    self.contentLabel.frame = CGRectMake(10, self.timeLabel.bottom + 15, self.width - 30, _model.trackInfo.contentHeight);
    
    
    self.showAllBtn.frame = CGRectMake(self.centerX - 45, self.contentLabel.bottom + 30, 90, 30);
}


#pragma mark - getter

//查看全文按钮
- (UIButton *)showAllBtn {
    if(!_showAllBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"查看全文" forState:UIControlStateNormal];
        [btn setTitleColor:Hex(0x676869) forState:UIControlStateNormal];
        btn.layer.cornerRadius = 3.0f;
        btn.layer.borderWidth = 1.0f;
        btn.layer.borderColor = Hex(0xE8E9EA).CGColor;
        [self addSubview:btn];
        _showAllBtn = btn;
    }
    return _showAllBtn;
}


//内容标签
- (UILabel *)contentLabel {
    if(!_contentLabel) {
        UILabel *lab = [[UILabel alloc] init];
        lab.font = [UIFont systemFontOfSize:15];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.textColor = Hex(0x343536);
        lab.numberOfLines = 0;
        [self addSubview:lab];
        _contentLabel = lab;
    }
    return _contentLabel;
}

//时间标签
- (UILabel *)timeLabel {
    if(!_timeLabel) {
        UILabel *lab = [[UILabel alloc] init];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.font = [UIFont systemFontOfSize:10];
        lab.textColor = Hex(0x999A9B);
        [self addSubview:lab];
        _timeLabel = lab;
    }
    return _timeLabel;
}

//播放量标签
- (UILabel *)playCountLabel {
    if(!_playCountLabel) {
        UILabel *lab = [[UILabel alloc] init];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.font = [UIFont systemFontOfSize:12];
        lab.textColor = Hex(0x999A9B);
        [self addSubview:lab];
        _playCountLabel = lab;
    }
    return _playCountLabel;
}

//标题标签
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
