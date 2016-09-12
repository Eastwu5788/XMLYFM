//
//  XMLYListenRecomCell.m
//  XMLYFM
//
//  Created by East_wu on 16/9/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYListenEditInfoCell.h"
#import "UIImageView+YYWebImage.h"

@interface XMLYListenEditInfoCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;

@end

@implementation XMLYListenEditInfoCell

- (void)setInfoModel:(XMLYListenDetailEditInfo *)infoModel {
    _infoModel = infoModel;
    
    [self.iconImageView yy_setImageWithURL:[NSURL URLWithString:_infoModel.smallLogo] options:YYWebImageOptionSetImageWithFadeAnimation];
    
    self.nicknameLabel.text = _infoModel.nickname;
    self.introLabel.text = _infoModel.personalSignature;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.iconImageView.layer.cornerRadius = 22.5f;
    self.iconImageView.layer.borderColor = Hex(0xf0f0f0).CGColor;
    self.iconImageView.layer.borderWidth = 0.5f;
    self.iconImageView.layer.masksToBounds = YES;
    
    //栅格化后，图层会被渲染成图片，并且缓存，再次使用时，不会重新渲染
    self.iconImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.iconImageView.layer.shouldRasterize = YES;
}

+ (instancetype)listenEditInfoCell:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = NSStringFromClass(self);
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
    return [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
}

@end
