//
//  XMLYAudioHistoryHeaderView.m
//  XMLYFM
//
//  Created by East_wu on 16/9/19.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYAudioHistoryHeaderView.h"

@interface XMLYAudioHistoryHeaderView ()

@property (nonatomic, weak) UIButton    *selectDelete; //选择删除
@property (nonatomic, weak) UIButton    *allDelete; //一键清空

@end

@implementation XMLYAudioHistoryHeaderView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.width / 2.0f;
    
    self.selectDelete.frame = CGRectMake(0, 0, width, self.height);
    
    self.allDelete.frame = CGRectMake(width , 0, width, self.height);
}

#pragma mark - getter

// 一键清空
- (UIButton *)allDelete {
    if(!_allDelete) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"btn_downloadsound_clear_n"] forState:UIControlStateNormal];
        [self addSubview:btn];
        _allDelete = btn;
    }
    return _allDelete;
}


// 选择删除
- (UIButton *)selectDelete {
    if(!_selectDelete) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"btn_select_listened_n"] forState:UIControlStateNormal];
        [self addSubview:btn];
        _selectDelete = btn;
    }
    return _selectDelete;
}

@end
