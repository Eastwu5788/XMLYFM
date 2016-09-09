//
//  XMLYAnchorNormalCell.m
//  XMLYFM
//
//  Created by East_wu on 16/9/8.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYAnchorNormalCell.h"
#import "UIImageView+YYWebImage.h"

@interface XMLYAnchorNormalCell()

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;


@end

@implementation XMLYAnchorNormalCell

- (void)setModel:(XMLYAnchorCellModel *)model {
    _model = model;
    [self.coverImageView yy_setImageWithURL:[NSURL URLWithString:_model.largeLogo] placeholder:[UIImage imageNamed:@"find_radio_default"]];
    
    self.titleLabel.text = _model.nickname;
    self.describeLabel.text = _model.verifyTitle;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.coverImageView.layer.borderWidth = 0.5f;
    self.coverImageView.layer.borderColor = [UIColor colorWithRed:0.94f green:0.95f blue:0.95f alpha:1.00f].CGColor;
}

@end
