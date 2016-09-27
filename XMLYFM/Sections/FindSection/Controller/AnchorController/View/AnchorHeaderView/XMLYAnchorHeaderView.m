//
//  XMLYAnchorHeaderView.m
//  XMLYFM
//
//  Created by East_wu on 16/9/8.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYAnchorHeaderView.h"

@interface XMLYAnchorHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *moreButton;

@end

@implementation XMLYAnchorHeaderView

- (void)setModel:(XMLYAnchorSectionModel *)model {
    _model = model;
    self.titleLabel.text = _model.title;
}

- (void)configHeaderTitle:(NSString *)title showMore:(BOOL)showMore {
    self.titleLabel.text = title;
    self.moreButton.hidden = !showMore;
}

+ (instancetype)anchorHeaderView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = NSStringFromClass(self);
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [collectionView registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier];
    return [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier forIndexPath:indexPath];
}

@end
