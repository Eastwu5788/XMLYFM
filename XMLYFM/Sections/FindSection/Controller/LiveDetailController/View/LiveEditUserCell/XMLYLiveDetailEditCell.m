//
//  XMLYLiveDetialEditCell.m
//  XMLYFM
//
//  Created by East_wu on 16/9/15.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYLiveDetailEditCell.h"
#import "XMLYCountHelper.h"

@interface XMLYLiveDetailEditCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *attentionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vipImageView;
@property (weak, nonatomic) IBOutlet UIButton *attentionButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nicknameWidthConstraint;

@end

@implementation XMLYLiveDetailEditCell

- (void)setAnchorInfo:(XMLYAnchorInfo *)anchorInfo {
    _anchorInfo = anchorInfo;
    
    [self.avatarImageView yy_setImageWithURL:[NSURL URLWithString:_anchorInfo.avatar] options:YYWebImageOptionSetImageWithFadeAnimation];
    
    self.nicknameLabel.text = _anchorInfo.nickname;
    
    self.attentionLabel.text = [NSString stringWithFormat:@"已被%@人关注",[XMLYCountHelper countStringFromNSInter:_anchorInfo.followerCount]];
    
    
    self.nicknameWidthConstraint.constant = _anchorInfo.nicknamewidth;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.avatarImageView.layer.cornerRadius = 22.5f;
    self.avatarImageView.layer.masksToBounds = YES;

    //栅格化后，图层会被渲染成图片，并且缓存，再次使用时，不会重新渲染
    self.avatarImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.avatarImageView.layer.shouldRasterize = YES;
}

@end
