//
//  XMLYAudioHistoryCell.m
//  XMLYFM
//
//  Created by East_wu on 16/9/19.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYAudioHistoryCell.h"


@interface XMLYAudioHistoryCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end

@implementation XMLYAudioHistoryCell

- (void)setAudioModel:(XMLYBaseAudioModel *)audioModel {
    _audioModel = audioModel;
    
    [self.avatarImageView yy_setImageWithURL:[NSURL URLWithString:_audioModel.coverSmall] options:YYWebImageOptionSetImageWithFadeAnimation];
    
    self.titleLabel.text = _audioModel.album_title;
    
    self.subTitleLabel.text = _audioModel.track_title;
    
    NSInteger minutes = _audioModel.time_history / 60;
    NSInteger seconds = _audioModel.time_history % 60;
    self.timeLabel.text = [NSString stringWithFormat:@"上次播放至: %02ld分%02ld秒",(long)minutes,seconds];
}

@end
