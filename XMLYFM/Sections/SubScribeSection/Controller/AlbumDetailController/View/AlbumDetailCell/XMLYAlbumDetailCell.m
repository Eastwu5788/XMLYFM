//
//  XMLYAlbumDetailCell.m
//  XMLYFM
//
//  Created by East_wu on 16/9/13.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYAlbumDetailCell.h"

@interface XMLYAlbumDetailCell ()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *introLabel;
@property (nonatomic, weak) UIButton *showMoreButton;
@property (nonatomic, weak) UIView   *sepView;

@end

@implementation XMLYAlbumDetailCell


- (void)setModel:(XMLYAlbumIntroModel *)model {
    _model = model;
    
    //1.标题
    self.titleLabel.frame = _model.titleLabelFrame;
    
    //2.内容
    self.introLabel.frame = _model.introlLabelFrame;
    self.introLabel.text = _model.intro;
    
    //3.查看更多
    self.showMoreButton.frame = _model.showMoreButtonFrame;
    
    //4.分割线
    self.sepView.frame = _model.sepViewFrame;
}

#pragma mark - Getter
//底部分割
- (UIView *)sepView {
    if(!_sepView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = Hex(0xEBECED);
        [self addSubview:view];
        _sepView = view;
    }
    return _sepView;
}

//查看更多内容按钮
- (UIButton *)showMoreButton {
    if(!_showMoreButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = Hex(0xF9FAFB);
        [btn setTitle:@"查看更多内容" forState:UIControlStateNormal];
        [btn setTitleColor:Hex(0xA2A3A4) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:btn];
        _showMoreButton = btn;
    }
    return _showMoreButton;
}


//内容标签
- (UILabel *)introLabel {
    if(!_introLabel) {
        UILabel *lab = [[UILabel alloc] init];
        lab.textColor = Hex(0x636465);
        lab.font = [UIFont systemFontOfSize:15];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.numberOfLines = 0;
        [self addSubview:lab];
        _introLabel = lab;
    }
    return _introLabel;
}


//内容简介标签
- (UILabel *)titleLabel {
    if(!_titleLabel) {
        UILabel *lab = [[UILabel alloc] init];
        lab.text = @"内容简介";
        lab.textColor = Hex(0x000000);
        lab.font = [UIFont systemFontOfSize:14];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.numberOfLines = 0;
        [self addSubview:lab];
        _titleLabel = lab;
    }
    return _titleLabel;
}

@end
