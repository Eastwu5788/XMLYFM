//
//  XMLYAlbumAboutRecomCell.h
//  XMLYFM
//
//  Created by East_wu on 16/9/13.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseTableViewCell.h"
#import "XMLYAlbumDetailModel.h"


@interface XMLYAlbumAboutItemView : UIView

@property (nonatomic, weak) UIImageView *bgImageView;
@property (nonatomic, weak) UIImageView *coverImageView;
@property (nonatomic, weak) UILabel     *titleLabel;
@property (nonatomic, weak) UILabel     *introLabel;
@property (nonatomic, weak) UIImageView *playImageView;
@property (nonatomic, weak) UILabel     *playLabel;
@property (nonatomic, weak) UIImageView *albumImageView;

@property (nonatomic, weak) UIButton     *playCountButton;
@property (nonatomic, weak) UIButton     *albumButton;

@property (nonatomic, weak) UILabel     *albumLabel;
@property (nonatomic, weak) UIImageView *arrowImageView;

@property (nonatomic, strong) XMLYAlbumRecsItemModel *itemModel;

@end



@interface XMLYAlbumAboutRecomCell : XMLYBaseTableViewCell

@property (nonatomic, strong) XMLYAlbumRecsModel *recsModel;

@end
