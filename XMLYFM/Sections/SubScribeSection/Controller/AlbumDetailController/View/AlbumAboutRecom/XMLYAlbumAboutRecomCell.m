//
//  XMLYAlbumAboutRecomCell.m
//  XMLYFM
//
//  Created by East_wu on 16/9/13.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYAlbumAboutRecomCell.h"


static force_inline NSString *XMLYGetPlyCount(NSInteger num) {
    if(num < 10000) {
        return [NSString stringWithFormat:@"%ld",(long)num];
    }else {
        CGFloat fot = num / 10000.0f;
        return [NSString stringWithFormat:@"%.1f万",fot];
    }
}

@class XMLYAlbumAboutItemView;

@interface XMLYAlbumAboutRecomCell ()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIButton *showMoreButton;

@property (nonatomic, strong) NSMutableArray    *resufulSubViewArry;

@end

@implementation XMLYAlbumAboutRecomCell


- (void)setRecsModel:(XMLYAlbumRecsModel *)recsModel {
    _recsModel = recsModel;
    
    self.titleLabel.frame = _recsModel.titleLabelFrame;
    
    for(NSInteger i = 0, max = self.resufulSubViewArry.count; i < max; i++) {
        XMLYAlbumAboutItemView *itemView = self.resufulSubViewArry[i];
        if(i < _recsModel.subItemFrameArray.count) {
            NSString *frameStr = _recsModel.subItemFrameArray[i];
            itemView.frame = CGRectFromString(frameStr);
            
            XMLYAlbumRecsItemModel *itemModel = _recsModel.list[i];
            itemView.itemModel = itemModel;
            
            itemView.hidden = NO;
        } else {
            itemView.itemModel = nil;
            itemView.frame = CGRectZero;
            itemView.hidden = YES;
        }
    }
    
    self.showMoreButton.frame = _recsModel.showMoreButtonFrame;
}

#pragma mark - getter

- (NSMutableArray *)resufulSubViewArry {
    if(!_resufulSubViewArry) {
        _resufulSubViewArry = [NSMutableArray new];
        for(NSInteger i = 0; i < 3; i++) {
            XMLYAlbumAboutItemView *view = [[XMLYAlbumAboutItemView alloc] init];
            [self addSubview:view];
            [_resufulSubViewArry addObject:view];
        }
    }
    return _resufulSubViewArry;
}

- (UIButton *)showMoreButton {
    if(!_showMoreButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = Hex(0xF9FAFB);
        [btn setTitle:@"查看更多内容" forState:UIControlStateNormal];
        [btn setTitleColor:Hex(0xA2A3A4) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:btn];
        _showMoreButton = btn;
    }
    return _showMoreButton;
}

- (UILabel *)titleLabel {
    if(!_titleLabel) {
        UILabel *lab = [[UILabel alloc] init];
        lab.text = @"相关推荐";
        lab.textColor = Hex(0x000000);
        lab.font = [UIFont systemFontOfSize:14];
        lab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:lab];
        _titleLabel = lab;
    }
    return _titleLabel;
}


@end



@implementation XMLYAlbumAboutItemView

- (void)setItemModel:(XMLYAlbumRecsItemModel *)itemModel {
    _itemModel = itemModel;
    
    if(_itemModel == nil) {
        self.bgImageView.frame = CGRectZero;
        self.coverImageView.frame = CGRectZero;
        self.titleLabel.frame = CGRectZero;
        self.introLabel.frame = CGRectZero;
        self.playCountButton.frame = CGRectZero;
        self.albumButton.frame = CGRectZero;
        self.arrowImageView.frame = CGRectZero;
        return;
    }
    
    self.bgImageView.frame = _itemModel.bgImageViewFrame;
    
    self.coverImageView.frame = _itemModel.coverImageViewFrame;
    [self.coverImageView yy_setImageWithURL:[NSURL URLWithString:_itemModel.coverMiddle] options:YYWebImageOptionSetImageWithFadeAnimation];
    
    self.titleLabel.frame = _itemModel.titleLabelFrame;
    self.titleLabel.text = _itemModel.title;
    
    self.introLabel.frame = _itemModel.introLabelFrame;
    self.introLabel.text = _itemModel.intro;
    
    self.playCountButton.frame = _itemModel.playButtonFrame;
    [self.playCountButton setTitle:XMLYGetPlyCount(_itemModel.playsCounts) forState:UIControlStateNormal];
    
    self.albumButton.frame = _itemModel.albumButtonFrame;
    [self.albumButton setTitle:[NSString stringWithFormat:@"%ld集",(long)_itemModel.tracks] forState:UIControlStateNormal];

    self.arrowImageView.frame = _itemModel.arrowImageViewFrame;
}

#pragma mark - getter

- (UIImageView *)arrowImageView {
    if(!_arrowImageView) {
        UIImageView *arr = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_arrow"]];
        [self addSubview:arr];
        _arrowImageView = arr;
    }
    return _arrowImageView;
}

- (UIButton *)albumButton {
    if(!_albumButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"album_tracks"] forState:UIControlStateNormal];
        [btn setTitle:@"122集" forState:UIControlStateNormal];
        [btn setTitleColor:Hex(0xA2A3A4) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [self addSubview:btn];
        _albumButton = btn;
    }
    return _albumButton;
}

//播放量
- (UIButton *)playCountButton {
    if(!_playCountButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"sound_playtimes"] forState:UIControlStateNormal];
        [btn setTitle:@"189.3万" forState:UIControlStateNormal];
        [btn setTitleColor:Hex(0xA2A3A4) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [self addSubview:btn];
        _playCountButton = btn;
    }
    return _playCountButton;
}



//播放量图片
- (UIImageView *)playImageView {
    if(!_playImageView) {
        UIImageView *img = [[UIImageView alloc] init];
        img.image = [UIImage imageNamed:@"sound_playtimes"];
        [self addSubview:img];
        _playImageView = img;
    }
    return _playImageView;
}

//简介
- (UILabel *)introLabel {
    if(!_introLabel) {
        UILabel *lab = [[UILabel alloc] init];
        lab.font = [UIFont systemFontOfSize:12];
        lab.textColor = Hex(0xB8B9BA);
        lab.numberOfLines = 0;
        lab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:lab];
        _introLabel = lab;
    }
    return _introLabel;
}

//标题
- (UILabel *)titleLabel {
    if(!_titleLabel) {
        UILabel *lab = [[UILabel alloc] init];
        lab.textColor = Hex(0x4B4C4D);
        lab.font = [UIFont systemFontOfSize:15];
        lab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:lab];
        _titleLabel = lab;
    }
    return _titleLabel;
}

//封面
- (UIImageView *)coverImageView {
    if(!_coverImageView) {
        UIImageView *cover = [[UIImageView alloc] init];
        [self addSubview:cover];
        _coverImageView = cover;
    }
    return _coverImageView;
}

//后方的背景
- (UIImageView *)bgImageView {
    if(!_bgImageView) {
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"album_cover_bg"]];
        [self addSubview:img];
        _bgImageView = img;
    }
    return _bgImageView;
}

@end






