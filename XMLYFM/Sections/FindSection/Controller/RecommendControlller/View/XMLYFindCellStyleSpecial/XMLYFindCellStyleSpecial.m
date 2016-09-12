//
//  XMLYFindCellStyleSpecial.m
//  XMLYFM
//
//  Created by East_wu on 16/8/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYFindCellStyleSpecial.h"
#import "UIImageView+YYWebImage.h"

@interface XMLYFindCellStyleSpecial ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconUpImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleUpLabel;

@property (weak, nonatomic) IBOutlet UILabel *subTitleUpLabel;

@property (weak, nonatomic) IBOutlet UILabel *introlUpLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconDownImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleDownLabel;

@property (weak, nonatomic) IBOutlet UILabel *subTitleDownLabel;

@property (weak, nonatomic) IBOutlet UILabel *introDownLabel;
@end

@implementation XMLYFindCellStyleSpecial


- (void)setSpecialModel:(XMLYSpecialColumnModel *)specialModel {
    _specialModel = specialModel;
    
    self.titleLabel.text = _specialModel.title;
    
    for(NSInteger index = 0; index < _specialModel.list.count; index++ ){
        XMLYSpecialColumnDetailModel *model = [_specialModel.list objectAtIndex:index];
        NSURL *url = [NSURL URLWithString:model.coverPath];
        if(index == 0) {
            [self.iconUpImageView yy_setImageWithURL:url options:YYWebImageOptionSetImageWithFadeAnimation];
            self.titleUpLabel.text = model.title;
            self.subTitleUpLabel.text = model.subtitle;
            self.introlUpLabel.text = model.footnote;
        }else if(index == 1) {
            [self.iconDownImageView yy_setImageWithURL:url options:YYWebImageOptionSetImageWithFadeAnimation];
            self.titleDownLabel.text = model.title;
            self.subTitleDownLabel.text = model.subtitle;
            self.introDownLabel.text = model.footnote;
        }
    }
}

- (IBAction)showMoreButtonClick:(id)sender {
    if([self.delegate respondsToSelector:@selector(findCellStyleSpecial:didMoreButtonClickWithModel:)]) {
        [self.delegate findCellStyleSpecial:self didMoreButtonClickWithModel:self.specialModel];
    }
}

+ (instancetype)findCell:(UITableView *)tableView {
    return [self findCellStyleSpecial:tableView];
}

+ (instancetype)findCellStyleSpecial:(UITableView *)tableView {
    NSString *identifier = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifier];
    return [tableView dequeueReusableCellWithIdentifier:identifier];
}

@end
