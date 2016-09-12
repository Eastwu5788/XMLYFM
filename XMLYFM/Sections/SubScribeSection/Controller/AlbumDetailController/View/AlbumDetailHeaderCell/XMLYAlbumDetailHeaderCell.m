//
//  XMLYAlbumDetailHeaderCell.m
//  XMLYFM
//
//  Created by East_wu on 16/9/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYAlbumDetailHeaderCell.h"

@interface XMLYAlbumDetailHeaderCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *editorLabel;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;

@property (weak, nonatomic) IBOutlet UIButton *categoryLabel;
@property (weak, nonatomic) IBOutlet UIButton *albumButton;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;

@end

@implementation XMLYAlbumDetailHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
    self.albumButton.layer.cornerRadius = 3.0f;
    self.albumButton.layer.borderColor = [UIColor colorWithRed:0.88f green:0.45f blue:0.33f alpha:1.00f].CGColor;
    self.albumButton.layer.borderWidth = 0.5f;
    
    self.downloadButton.layer.cornerRadius = 3.0f;
    self.downloadButton.layer.borderWidth = 0.5f;
    self.downloadButton.layer.borderColor = [UIColor colorWithRed:0.88f green:0.45f blue:0.33f alpha:1.00f].CGColor;
}

@end
