//
//  XMLYListenListCell.m
//  XMLYFM
//
//  Created by East_wu on 16/9/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYListenListCell.h"
#import "UIImageView+YYWebImage.h"

@interface XMLYListenListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (weak, nonatomic) IBOutlet UIView *sepLineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sepLineHeightConstraint;

@end

@implementation XMLYListenListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.sepLineHeightConstraint.constant = 0.5f;
    
    
}

- (void)hiddenSepLine:(BOOL)hidden {
    self.sepLineView.hidden = hidden;
}

- (void)setModel:(XMLYListenItemModel *)model {
    _model = model;
    
    [self.coverImageView yy_setImageWithURL:[NSURL URLWithString:_model.coverPathBig] options:YYWebImageOptionSetImageWithFadeAnimation];
    
    self.titleLabel.text = _model.title;
    
    self.subTitleLabel.text = _model.subtitle;
    
    self.countLabel.text = _model.footnote;
}

+ (instancetype)listenListCell:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
    return [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
}

@end
