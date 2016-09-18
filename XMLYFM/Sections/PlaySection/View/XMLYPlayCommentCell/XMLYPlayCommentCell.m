//
//  XMLYPlayCommentCell.m
//  XMLYFM
//
//  Created by East_wu on 16/9/16.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYPlayCommentCell.h"
#import "XMLYTimeHelper.h"

@interface XMLYPlayCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sepHeightConstraint;

@end

@implementation XMLYPlayCommentCell


- (void)setModel:(XMLYComentInfoItemModel *)model {
    _model = model;
    
    [self.avatarImageView yy_setImageWithURL:[NSURL URLWithString:_model.smallHeader] options:YYWebImageOptionSetImageWithFadeAnimation];
    
    self.titleLabel.text = _model.nickname;
    
    self.timeLabel.text = [XMLYTimeHelper dataStringFromTimeInterval:_model.createdAt dataFormatter:@"MM-dd"];
    
    self.countLabel.text = [NSString stringWithFormat:@"%ld",_model.likes];
    
    self.contentHeightConstraint.constant = _model.contentHeight;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.avatarImageView.layer.cornerRadius = 22.0f;
    self.avatarImageView.layer.masksToBounds = YES;
    self.avatarImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.avatarImageView.layer.shouldRasterize = YES;
    
    self.sepHeightConstraint.constant = 0.5f;
}

@end
