//
//  XMLYAlbumEditIntroCell.m
//  XMLYFM
//
//  Created by East_wu on 16/9/13.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYAlbumEditIntroCell.h"

static force_inline NSString *XMLYGetPlyCount(NSInteger num) {
    if(num < 10000) {
        return [NSString stringWithFormat:@"已被%ld人关注",(long)num];
    }else {
        CGFloat fot = num / 10000.0f;
        return [NSString stringWithFormat:@"已被%.1f万人关注",fot];
    }
}


@interface XMLYAlbumEditIntroCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vipImageView;
@property (weak, nonatomic) IBOutlet UILabel *attentionsLabel;
@property (weak, nonatomic) IBOutlet UIButton *attentionButton;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *introHeightConstratin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nicknameWidthConstraint;


@end


@implementation XMLYAlbumEditIntroCell

- (void)setUserModel:(XMLYAlbumEditUserModel *)userModel {
    _userModel = userModel;
    
    [self.avatarImageView yy_setImageWithURL:[NSURL URLWithString:_userModel.smallLogo] options:YYWebImageOptionSetImageWithFadeAnimation];
    
    self.nicknameLabel.text = _userModel.nickname;
    self.nicknameWidthConstraint.constant = _userModel.nicknameWidth;
    
    self.attentionsLabel.text =  XMLYGetPlyCount(_userModel.followers);
    
    self.introLabel.text = _userModel.personalSignature;
    self.introHeightConstratin.constant = _userModel.introlHeight;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.avatarImageView.layer.cornerRadius = 22.0f;
    self.avatarImageView.layer.masksToBounds = YES;
    //栅格化后，图层会被渲染成图片，并且缓存，再次使用时，不会重新渲染
    self.avatarImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.avatarImageView.layer.shouldRasterize = YES;
}

@end
