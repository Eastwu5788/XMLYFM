//
//  XMLYPlayEditRewardCell.m
//  XMLYFM
//
//  Created by East_wu on 16/9/16.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYPlayEditRewardCell.h"

@interface XMLYIconTextView : UIView

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *textLabel;

@property (nonatomic, strong) XMLYTrackRewardInfoItemModel *itemModel;

@end

@implementation XMLYIconTextView

- (void)setItemModel:(XMLYTrackRewardInfoItemModel *)itemModel {
    _itemModel = itemModel;
    
    [self.iconImageView yy_setImageWithURL:[NSURL URLWithString:_itemModel.smallLogo] placeholder:[UIImage imageNamed:@"find_radio_default"]];
    
    self.textLabel.text = [NSString stringWithFormat:@"￥%@",_itemModel.amount];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.iconImageView.frame = CGRectMake(self.width / 2 - 17.5, 5, 35, 35);
    
    self.textLabel.frame = CGRectMake(0, self.height - 11, self.width, 11);
}


#pragma mark - getter

// 文本
- (UILabel *)textLabel {
    if(!_textLabel) {
        UILabel *lab = [[UILabel alloc] init];
        lab.font = [UIFont systemFontOfSize:10];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = Hex(0xA8A9AA);
        [self addSubview:lab];
        _textLabel = lab;
    }
    return _textLabel;
}


// 图标
- (UIImageView *)iconImageView {
    if(!_iconImageView) {
        UIImageView *img = [[UIImageView alloc] init];
        img.layer.cornerRadius = 17.5f;
        img.layer.masksToBounds = YES;
        img.layer.rasterizationScale = [UIScreen mainScreen].scale;
        img.layer.shouldRasterize = YES;
        [self addSubview:img];
        _iconImageView = img;
    }
    return _iconImageView;
}

@end


@interface XMLYPlayEditRewardCell ()

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel     *countLabel;

@end

@implementation XMLYPlayEditRewardCell

- (void)setModel:(XMLYTrackRewardInfoModel *)model {
    _model = model;
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.countLabel.text = [NSString stringWithFormat:@"%ld人打赏",_model.numOfRewards];

    CGFloat space = (kScreenWidth - _model.rewords.count * 35.0f) / (_model.rewords.count + 1);
    [self removeAllResufulView];
    for(NSInteger i = 0, max = _model.rewords.count; i < max; i++) {
        XMLYTrackRewardInfoItemModel *item = _model.rewords[i];
        XMLYIconTextView *view = [[XMLYIconTextView alloc] init];
        view.frame = CGRectMake(space + (35.0f + space) * i, self.height - 70, 35.0f, 55.0f);
        view.itemModel = item;
        [self addSubview:view];
    }
    
}

- (void)removeAllResufulView {
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj isKindOfClass:[XMLYIconTextView class]]) {
            [obj removeFromSuperview];
        }
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.iconImageView.frame = CGRectMake(self.centerX - 26, 18, 52, 52);
    
    self.countLabel.frame = CGRectMake(self.centerX - 50, self.iconImageView.bottom + 5, 100, 11);

}

// 打赏数量标签
- (UILabel *)countLabel {
    if(!_countLabel) {
        UILabel *lab = [[UILabel alloc] init];
        lab.font = [UIFont systemFontOfSize:10];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = Hex(0xFA6240);
        [self addSubview:lab];
        _countLabel = lab;
    }
    return _countLabel;
}

// icon
- (UIImageView *)iconImageView {
    if(!_iconImageView) {
        UIImageView *img = [[UIImageView alloc] init];
        img.image = [UIImage imageNamed:@"rewardButtonImage"];
        [self addSubview:img];
        _iconImageView = img;
    }
    return _iconImageView;
}


@end
