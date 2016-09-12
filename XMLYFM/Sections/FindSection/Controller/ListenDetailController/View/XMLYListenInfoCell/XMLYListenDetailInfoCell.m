//
//  XMLYListenDetailInfoCell.m
//  XMLYFM
//
//  Created by East_wu on 16/9/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYListenDetailInfoCell.h"
#import "UIImageView+YYWebImage.h"

@interface XMLYListenDetailInfoCell ()

@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *introLabelHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nicknameWidthConstraint;

@end

@implementation XMLYListenDetailInfoCell

- (void)setInfoModel:(XMLYListenDetailEditInfo *)infoModel {
    _infoModel = infoModel;
    
    self.introLabel.text = _infoModel.intro;
    
    self.nickNameLabel.text = _infoModel.nickname;
    
    [self.avatarImageView yy_setImageWithURL:[NSURL URLWithString:_infoModel.smallLogo] options:YYWebImageOptionSetImageWithFadeAnimation];
    
    self.introLabelHeight.constant = _infoModel.introHeight;
    self.nicknameWidthConstraint.constant = _infoModel.nickNameWidth;
}

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.avatarImageView.layer.cornerRadius = 7.0f;
    self.avatarImageView.layer.masksToBounds = YES;
    //栅格化后，图层会被渲染成图片，并且缓存，再次使用时，不会重新渲染
    self.avatarImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.avatarImageView.layer.shouldRasterize = YES;
}

+ (instancetype)listenDetailInfoCell:(UICollectionView *)view atIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = NSStringFromClass(self);
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [view registerNib:nib forCellWithReuseIdentifier:identifier];
    return [view dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
}

@end
