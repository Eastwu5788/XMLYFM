//
//  XMLYFindRadioLiveCell.m
//  XMLYFM
//
//  Created by East_wu on 16/9/7.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYFindRadioLiveCell.h"
#import "UIImageView+YYWebImage.h"

static force_inline NSString *XMLYGetNumberAndTextFromNSInteger(NSInteger num) {
    if(num < 10000) {
        return [NSString stringWithFormat:@"%ld",(long)num];
    }else {
        CGFloat fot = num / 10000.0f;
        return [NSString stringWithFormat:@"%.1f万人",fot];
    }
}

static

@interface XMLYFindRadioLiveCell ()

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *usersLabel;

@end

@implementation XMLYFindRadioLiveCell

- (void)setLiveInfoModel:(XMLYFindRadioInfoModel *)liveInfoModel {
    _liveInfoModel = liveInfoModel;
    
    self.titleLabel.text = _liveInfoModel.name;
    [self.coverImageView yy_setImageWithURL:[NSURL URLWithString:_liveInfoModel.coverLarge] options:YYWebImageOptionSetImageWithFadeAnimation];
    self.authorLabel.text = [NSString stringWithFormat:@"直播中：%@",_liveInfoModel.programName];
    self.usersLabel.text = [NSString stringWithFormat:@"收听人数：%@",XMLYGetNumberAndTextFromNSInteger(_liveInfoModel.playCount)];
}


+ (instancetype)findRadioLiveCell:(UITableView *)tableView {
    NSString *identifier = NSStringFromClass(self);
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifier];
    return [tableView dequeueReusableCellWithIdentifier:identifier];
}

@end
