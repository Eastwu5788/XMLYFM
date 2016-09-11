//
//  XMLYScribeRecomCell.m
//  XMLYFM
//
//  Created by East_wu on 16/9/9.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYScribeRecomCell.h"
#import "UIImageView+YYWebImage.h"

static force_inline NSString *XMLYGetFans(NSInteger num) {
    if(num < 10000) {
        return [NSString stringWithFormat:@"%ld",(long)num];
    }else {
        CGFloat fot = num / 10000.0f;
        return [NSString stringWithFormat:@"%.1f万人",fot];
    }
}

@interface XMLYScribeRecomCell ()

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *playTimesLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sepHeightConstraint;

@end

@implementation XMLYScribeRecomCell

- (void)setEditRecomModel:(XMLYEditRecomItemModel *)editRecomModel {
    _editRecomModel = editRecomModel;
    
    [self.coverImageView yy_setImageWithURL:[NSURL URLWithString:_editRecomModel.coverLarge] options:YYWebImageOptionSetImageWithFadeAnimation];
    self.titleLabel.text = _editRecomModel.title;
    self.titleHeightConstraint.constant = _editRecomModel.titleLabelHeight;
    
    self.subTitleLabel.text = _editRecomModel.intro;
    
    self.playTimesLabel.text = XMLYGetFans(_editRecomModel.playsCounts);
    self.albumLabel.text = [NSString stringWithFormat:@"%ld集",(long)_editRecomModel.tracks];
    
}

- (void)setModel:(XMLYScribeRecomItemModel *)model {
    _model = model;
    
    [self.coverImageView yy_setImageWithURL:[NSURL URLWithString:_model.coverLarge] options:YYWebImageOptionSetImageWithFadeAnimation];
    self.titleLabel.text = _model.title;
    self.titleHeightConstraint.constant = _model.titleLabelHeight;
    
    self.subTitleLabel.text = _model.recReason;
    
    self.playTimesLabel.text = XMLYGetFans(_model.playsCounts);
    
    self.albumLabel.text = [NSString stringWithFormat:@"%ld集",(long)_model.tracks];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.sepHeightConstraint.constant = 0.5f;
}

+ (instancetype)scribeRecomCell:(UITableView *)tableView {
    NSString *identifier = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifier];
    return [tableView dequeueReusableCellWithIdentifier:identifier];
}

@end
