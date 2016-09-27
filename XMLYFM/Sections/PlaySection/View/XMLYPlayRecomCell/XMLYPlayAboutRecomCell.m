//
//  XMLYPlayAboutRecomCell.m
//  XMLYFM
//
//  Created by East_wu on 16/9/18.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYPlayAboutRecomCell.h"
#import "XMLYCountHelper.h"

@interface XMLYPlayAboutRecomCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumLabel;

@property (weak, nonatomic) IBOutlet UIView *sepView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subTitleHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHeightConstratin;

@end

@implementation XMLYPlayAboutRecomCell

- (void)setShowSep:(BOOL)showSep {
    _showSep = showSep;
    
    self.sepView.hidden = !_showSep;
}

- (void)setModel:(XMLYAssociationAlbumsInfoModel *)model {
    _model = model;
    
    
    [self.avatarImageView yy_setImageWithURL:[NSURL URLWithString:_model.coverMiddle] options:YYWebImageOptionSetImageWithFadeAnimation];
    
    self.titleHeightConstratin.constant  = _model.titleHight;
    self.subTitleHeightConstraint.constant = _model.subTitleHeight;
    
    self.titleLabel.text = _model.title;
    
    self.subTitleLabel.text = _model.intro;
    
    self.countLabel.text = @"232.9万";
    
    self.albumLabel.text = @"110集";
}

@end
