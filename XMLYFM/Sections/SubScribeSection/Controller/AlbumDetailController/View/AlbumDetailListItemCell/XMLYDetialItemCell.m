//
//  XMLYDetialItemCell.m
//  XMLYFM
//
//  Created by East_wu on 16/9/14.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYDetialItemCell.h"
#import "XMLYCountHelper.h"
#import "XMLYTimeHelper.h"

@interface XMLYDetialItemCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *playCountsButton;
@property (weak, nonatomic) IBOutlet UIButton *commentCountButton;
@property (weak, nonatomic) IBOutlet UIButton *playDurationButton;
@property (weak, nonatomic) IBOutlet UILabel *releaseAtLabel;

@end

@implementation XMLYDetialItemCell

- (void)setItemModel:(XMLYAlbumTrackItemModel *)itemModel {
    _itemModel = itemModel;
    
    [self.avatarImageView yy_setImageWithURL:[NSURL URLWithString:_itemModel.coverLarge] options:YYWebImageOptionSetImageWithFadeAnimation];
    
    self.titleLabel.text = _itemModel.title;
    
    [self.playCountsButton setTitle:[XMLYCountHelper countStringFromNSInter:_itemModel.playtimes] forState:UIControlStateNormal];
    
    [self.commentCountButton setTitle:[NSString stringWithFormat:@"%ld",_itemModel.comments] forState:UIControlStateNormal];
    
    [self.playDurationButton setTitle:@"12:30" forState:UIControlStateNormal];
    
    self.releaseAtLabel.text = [XMLYTimeHelper dataStringFromTimeInterval:_itemModel.createdAt / 1000 dataFormatter:@"YYYY-MM"];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.avatarImageView.layer.cornerRadius = 19.0f;
    self.avatarImageView.layer.masksToBounds = YES;
    //栅格化后，图层会被渲染成图片，并且缓存，再次使用时，不会重新渲染
    self.avatarImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.avatarImageView.layer.shouldRasterize = YES;
}

@end
