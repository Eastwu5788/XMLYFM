//
//  XMLYDownAlbumCell.m
//  XMLYFM
//
//  Created by East_wu on 16/9/20.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYDownAlbumCell.h"
#import "XMLYSizeHelper.h"

@interface XMLYDownAlbumCell ()

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UIButton *albumCounts;
@property (weak, nonatomic) IBOutlet UIButton *albumSize;


@end

@implementation XMLYDownAlbumCell

- (void)setAlbumModel:(XMLYAlbumModel *)albumModel {
    _albumModel = albumModel;
    
    [self.coverImageView yy_setImageWithURL:[NSURL URLWithString:_albumModel.coverMiddle] options:YYWebImageOptionSetImageWithFadeAnimation];
    
    self.titleLabel.text = _albumModel.title;
    
    self.authorLabel.text = _albumModel.nickname;
    
    [self.albumCounts setTitle:[NSString stringWithFormat:@"%ld集",_albumModel.tracks] forState:UIControlStateNormal];
    
    [self.albumSize setTitle:[XMLYSizeHelper sizeStringFromInt64:_albumModel.downloadSize] forState:UIControlStateNormal];
}

@end
