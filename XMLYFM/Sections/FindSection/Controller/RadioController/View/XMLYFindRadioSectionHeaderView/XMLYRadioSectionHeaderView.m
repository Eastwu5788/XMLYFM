//
//  XMLYRadioSectionHeaderView.m
//  XMLYFM
//
//  Created by East_wu on 16/9/7.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYRadioSectionHeaderView.h"
#import "Masonry.h"
#import "XMLYTimeHelper.h"



@interface XMLYRadioSectionHeaderView () {
    NSString *_location;
    XMLYRadioSectionHeaderViewStyle _style;
    
    XMLYFindRankListModel *_model;
}


@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel     *titleLabel;
@property (nonatomic, weak) UIImageView *moreImageView;

@end

@implementation XMLYRadioSectionHeaderView

/**
 *  初始化方法
 *  @param section  当前view所在的section
 *  @param location 当前用户所处的位置信息
 */
+ (instancetype)radioSectionHeaderViewWithSection:(XMLYRadioSectionHeaderViewStyle)style location:(nullable NSString *)location {
    XMLYRadioSectionHeaderView *header = [[XMLYRadioSectionHeaderView alloc] initRadioSectionHeaderViewWithSection:style location:location];
    return header;
}

- (instancetype)initRadioSectionHeaderViewWithSection:(XMLYRadioSectionHeaderViewStyle)style location:(nullable NSString *)location {
    self = [super init];
    self->_style = style;
    self->_location = location;
    [self configSubViews];
    return self;
}

+ (instancetype)sectionHeaderWithModel:(XMLYFindRankListModel *)model showMore:(BOOL)showMore {
    XMLYRadioSectionHeaderView *header = [[XMLYRadioSectionHeaderView alloc] initSectionHeaderWithModel:model showMore:showMore];
    return header;
}

- (instancetype)initSectionHeaderWithModel:(XMLYFindRankListModel *)model showMore:(BOOL)showMore {
    self = [super init];
    self.backgroundColor = [UIColor whiteColor];
    self->_model = model;
    [self configSubViewWithShowMore:showMore];
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"XMLYRadioSectionHeaderView Init Error" reason:@"Please use the designated initizalizer" userInfo:nil];
    return nil;
}

- (void)configSubViewWithShowMore:(BOOL)showMore {
    [self iconImageView];
    self.titleLabel.text = self->_model.title;
    self.moreImageView.hidden = !showMore;
}

- (void)configSubViews {
    [self iconImageView];
    [self titleLabel];
    if(self->_style == XMLYRadioSectionHeaderViewStyleLocal) {
        self.titleLabel.text = [NSString stringWithFormat:@"%@•%@",[XMLYTimeHelper getHelloStringByLocalTime],self->_location];
    }else if(self->_style == XMLYRadioSectionHeaderViewStyleTop) {
        self.titleLabel.text = @"排行榜";
    } else {
        self.titleLabel.text = @"播放历史";
    }
    [self moreImageView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat iconY = (self.frame.size.height - 10) / 2.0f;
    self.iconImageView.frame = CGRectMake(10, iconY, 10, 10);
    
    CGFloat labY = (self.frame.size.height - 17) / 2.0f;
    self.titleLabel.frame = CGRectMake(25, labY, 200, 17);
    
    CGFloat morY = (self.frame.size.height - 12) / 2.0f;
    self.moreImageView.frame = CGRectMake(kScreenWidth - 45, morY, 35, 12);
    
}


#pragma mark - getter

- (UIImageView *)moreImageView {
    if(!_moreImageView) {
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"liveRadioSectionMore_Normal"]];
        [self addSubview:img];
        _moreImageView = img;
    }
    return _moreImageView;
}

- (UILabel *)titleLabel {
    if(!_titleLabel) {
        UILabel *lab = [[UILabel alloc] init];
        lab.textColor = [UIColor colorWithRed:0.20f green:0.20f blue:0.21f alpha:1.00f];
        lab.font = [UIFont systemFontOfSize:15];
        [self addSubview:lab];
        _titleLabel = lab;
    }
    return _titleLabel;
}

- (UIImageView *)iconImageView {
    if(!_iconImageView) {
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"findsection_logo"]];
        [self addSubview:img];
        _iconImageView = img;
    }
    return _iconImageView;
}



@end
