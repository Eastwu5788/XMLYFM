//
//  XMLYDetaillistHeaderCell.m
//  XMLYFM
//
//  Created by East_wu on 16/9/14.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYDetaillistHeaderCell.h"


@interface XMLYDetaillistHeaderCell ()


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation XMLYDetaillistHeaderCell

- (void)setAlbumModel:(XMLYAlbumModel *)albumModel {
    _albumModel = albumModel;
    
    self.titleLabel.text = [NSString stringWithFormat:@"共%ld集",(long)_albumModel.tracks];
}

- (IBAction)albumButtonClick:(id)sender {
}
- (IBAction)sortButtonClick:(id)sender {
}

@end
