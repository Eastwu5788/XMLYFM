//
//  XMLYHeaderIconView.m
//  XMLYFM
//
//  Created by East_wu on 16/8/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYHeaderIconView.h"
#import "UIImageView+YYWebImage.h"

@interface XMLYHeaderIconView ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageVie;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation XMLYHeaderIconView

- (void)setDetailModel:(XMLYFindDiscoverDetailModel *)detailModel {
    _detailModel = detailModel;
    
    self.titleLabel.text = _detailModel.title;
    
    [self.iconImageVie yy_setImageWithURL:[NSURL URLWithString:_detailModel.coverPath] options:YYWebImageOptionSetImageWithFadeAnimation];
}

+ (instancetype)headerIconView {
    NSString *identifier = NSStringFromClass([self class]);
    return [[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil].firstObject;
}


@end
