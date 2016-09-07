//
//  XMLYFindCategoryCell.m
//  XMLYFM
//
//  Created by East_wu on 16/9/7.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYFindCategoryCell.h"
#import "UIImageView+YYWebImage.h"

@interface XMLYFindCategoryCell ()

@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@property (weak, nonatomic) IBOutlet UIView *seprateLineView;


@end

@implementation XMLYFindCategoryCell

- (void)setLeftModel:(XMLYListItemModel *)leftModel {
    _leftModel = leftModel;
    if(!_leftModel) return;
    
    self.leftLabel.text = _leftModel.title;
    [self.leftImageView yy_setImageWithURL:[NSURL URLWithString:_leftModel.coverPath] options:YYWebImageOptionSetImageWithFadeAnimation];
}

- (void)setRightModel:(XMLYListItemModel *)rightModel {
    _rightModel = rightModel;
    if(!rightModel) return;
    self.rightLabel.text = _rightModel.title;
    [self.rightImageView yy_setImageWithURL:[NSURL URLWithString:_rightModel.coverPath] options:YYWebImageOptionSetImageWithFadeAnimation];
}

- (void)configSubViews {
    
}

+ (instancetype)findCategoryCell:(UITableView *)tableView {
    NSString *identifier = NSStringFromClass(self);
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifier];
    XMLYFindCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    [cell configSubViews];
    return cell;
}

@end
