//
//  XMLYLiveDetailIntroCell.m
//  XMLYFM
//
//  Created by East_wu on 16/9/15.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYLiveDetailIntroCell.h"

@interface XMLYLiveDetailIntroCell ()

@property (nonatomic, weak) UILabel *introLabel;

@end

@implementation XMLYLiveDetailIntroCell

- (void)setActivityModel:(XMLYLiveDetailActivity *)activityModel {
    _activityModel  = activityModel;
    
    self.introLabel.text = _activityModel.desc;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.introLabel.frame = CGRectMake(10, 16, self.width - 20, self.height - 32);
}

#pragma mark - getter
- (UILabel *)introLabel {
    if(!_introLabel) {
        UILabel *lab = [[UILabel alloc] init];
        lab.font = [UIFont systemFontOfSize:13];
        lab.textColor = Hex(0x929394);
        lab.numberOfLines = 0;
        [self addSubview:lab];
        _introLabel = lab;
    }
    return _introLabel;
}


@end
