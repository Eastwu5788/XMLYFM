//
//  XMLYLiveItemCell.m
//  XMLYFM
//
//  Created by East_wu on 16/9/11.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYLiveItemCell.h"
#import "UIIMageView+YYWebImage.h"
#import "NSString+Extension.h"

static force_inline NSString *XMLYGetPlyCount(NSInteger num) {
    if(num < 10000) {
        return [NSString stringWithFormat:@"%ld人次参与",(long)num];
    }else {
        CGFloat fot = num / 10000.0f;
        return [NSString stringWithFormat:@"%.1f万人次参与",fot];
    }
}

@interface XMLYLiveItemCell ()

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *countLabelWidthConstraint;

@end

@implementation XMLYLiveItemCell

- (void)setModel:(XMLYLiveListItemModel *)model {
    _model = model;
    
    [self.logoImageView yy_setImageWithURL:[NSURL URLWithString:_model.coverPath] options:YYWebImageOptionSetImageWithFadeAnimation];
    
    self.titleLabel.text = _model.name;
    self.subTitleLabel.text = _model.shortDescription;
    
    NSString *showText = XMLYGetPlyCount(_model.playCount);
    CGFloat width = [showText sizeForFont:[UIFont systemFontOfSize:9] size:CGSizeMake(300, 16) mode:NSLineBreakByCharWrapping].width;
    
    self.countLabelWidthConstraint.constant = width + 10.0f;
    
    self.countLabel.text = showText;
}


+ (instancetype)liveItemCellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath{
    NSString *identifier = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
    return [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.countLabel.layer.cornerRadius = 3.0f;
    self.countLabel.layer.borderWidth = 0.2f;
    self.countLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.countLabel.layer setMasksToBounds:YES];
}

@end
