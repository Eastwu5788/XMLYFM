//
//  XMLYListenEditInfoCell.m
//  XMLYFM
//
//  Created by East_wu on 16/9/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYListenRecomCell.h"
#import "UIImageView+YYWebImage.h"
#import "XMLYTimeHelper.h"

static force_inline NSString *XMLYGetPlyCount(NSInteger num) {
    if(num < 10000) {
        return [NSString stringWithFormat:@"%ld人",(long)num];
    }else {
        CGFloat fot = num / 10000.0f;
        return [NSString stringWithFormat:@"%.1f万人",fot];
    }
}

@interface XMLYListenRecomCell ()

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *editNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLengthLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelHeightConstraint;

@end

@implementation XMLYListenRecomCell

- (void)setItemModel:(XMLYListenDetailItemModel *)itemModel {
    _itemModel = itemModel;
    
    [self.logoImageView yy_setImageWithURL:[NSURL URLWithString:_itemModel.coverSmall] options:YYWebImageOptionSetImageWithFadeAnimation];
    
    self.titleLabel.text = _itemModel.title;
    
    self.editNameLabel.text = [NSString stringWithFormat:@"by %@",_itemModel.nickname];
    
    self.playCountLabel.text = XMLYGetPlyCount(_itemModel.playsCounts);
    
    self.commentLabel.text = [NSString stringWithFormat:@"%ld",(long)_itemModel.commentsCounts];
    
    self.timeLabel.text = [XMLYTimeHelper dataStringWithTimeInterval:_itemModel.createdAt / 1000];
    
    self.titleLabelHeightConstraint.constant = _itemModel.titleHeight;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.logoImageView.layer.cornerRadius = 20.0f;
    self.logoImageView.layer.masksToBounds = YES;
    
    //栅格化后，图层会被渲染成图片，并且缓存，再次使用时，不会重新渲染
    self.logoImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.logoImageView.layer.shouldRasterize = YES;
}

+ (instancetype)listenRecomCell:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = NSStringFromClass(self);
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
    return [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
}

@end
