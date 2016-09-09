//
//  XMLYAnchorSignerCell.m
//  XMLYFM
//
//  Created by East_wu on 16/9/8.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYAnchorSignerCell.h"
#import "UIImageView+YYWebImage.h"
#import "NSString+Extension.h"

static force_inline NSString *XMLYGetFans(NSInteger num) {
    if(num < 10000) {
        return [NSString stringWithFormat:@"%ld",(long)num];
    }else {
        CGFloat fot = num / 10000.0f;
        return [NSString stringWithFormat:@"%.1f万人",fot];
    }
}

@interface XMLYAnchorSignerCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *introlLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *fansNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *attentionLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userNameWidthConstraint;

@end

@implementation XMLYAnchorSignerCell

- (void)setModel:(XMLYAnchorCellModel *)model {
    _model = model;
    
    [self.iconImageView yy_setImageWithURL:[NSURL URLWithString:_model.largeLogo] options:YYWebImageOptionSetImageWithFadeAnimation];
    self.titleLabel.text = _model.nickname;
    self.introlLabel.text = _model.verifyTitle;
    self.albumNumLabel.text = [NSString stringWithFormat:@"%ld",(long)_model.tracksCounts];
    self.fansNumLabel.text = XMLYGetFans(_model.followersCounts);
    
    CGSize size = [_model.nickname sizeForFont:[UIFont systemFontOfSize:16] size:CGSizeMake(300, 17) mode:NSLineBreakByCharWrapping];
    self.userNameWidthConstraint.constant = size.width + 2;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconImageView.layer.cornerRadius = 25.0f;
    self.iconImageView.layer.masksToBounds = YES;
    //栅格化后，图层会被渲染成图片，并且缓存，再次使用时，不会重新渲染
    self.iconImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.iconImageView.layer.shouldRasterize = YES;
}

@end
