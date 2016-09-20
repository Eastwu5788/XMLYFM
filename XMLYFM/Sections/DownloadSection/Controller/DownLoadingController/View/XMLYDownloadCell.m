//
//  XMLYDownloadCell.m
//  XMLYFM
//
//  Created by East_wu on 16/9/20.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYDownloadCell.h"
#import "XMLYCountHelper.h"

@interface XMLYDownloadCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *editLabel;
@property (weak, nonatomic) IBOutlet UIButton *playTimesBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentTimesBtn;
@property (weak, nonatomic) IBOutlet UIButton *durationBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *downloadStatusLabel;

@property (weak, nonatomic) IBOutlet UIView *progressSection;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *progressSectionHeight;


@end

@implementation XMLYDownloadCell

- (void)setModel:(XMLYDownTaskModel *)model {
    _model = model;
    
    
    [self setTrackModel:_model.trackModel];
}

- (void)setTrackModel:(XMLYAlbumTrackItemModel *)trackModel {
    _trackModel = trackModel;
    
    NSURL *url = [NSURL URLWithString:_trackModel.coverMiddle];
    [self.iconImageView yy_setImageWithURL:url options:YYWebImageOptionSetImageWithFadeAnimation];
    
    self.titleLabel.text = _trackModel.title;
    
    self.editLabel.text =  [NSString stringWithFormat:@"by %@",_trackModel.nickname];
    
    [self.playTimesBtn setTitle:[XMLYCountHelper countStringFromNSInter:_trackModel.playtimes] forState:UIControlStateNormal];
    
    [self.commentTimesBtn setTitle:[XMLYCountHelper countStringFromNSInter:_trackModel.comments] forState:UIControlStateNormal];
    
    NSInteger hour = _trackModel.duration / 3600;
    NSInteger minutes = (_trackModel.duration % 3600) / 60;
    NSInteger second = (_trackModel.duration % 3600 % 60);
    [self.durationBtn setTitle:[NSString stringWithFormat:@"%02ld:%02ld:%02ld",hour,minutes,second] forState:UIControlStateNormal];
    
}

- (void)hideProgressView {
    self.progressSectionHeight.constant = 0.0f;
    self.progressSection.hidden = YES;
}

- (void)refreshProgress:(NSInteger)download expected:(NSInteger)expected {
    CGFloat proGress = download / expected;
    NSLog(@"proGress:%f",proGress);
    [self.progressView setProgress:proGress animated:YES];
    
    CGFloat down = download / (1024.0f * 1024.0f);
    CGFloat expt = expected / (1024.0f * 1024.0f);
    self.downloadStatusLabel.text = [NSString stringWithFormat:@"%.1fM/%.1fM",down,expt];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.iconImageView.layer.cornerRadius = 20.0f;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.backgroundColor = Hex(0xf0f0f0);
    
    self.iconImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.iconImageView.layer.shouldRasterize = YES;
}

@end
