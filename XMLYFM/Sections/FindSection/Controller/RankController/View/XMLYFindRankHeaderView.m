//
//  XMLYFindRankHeaderView.m
//  XMLYFM
//
//  Created by East_wu on 16/9/8.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYFindRankHeaderView.h"
#import "UIView+Extension.h"
#import "UIImageView+YYWebImage.h"

@interface XMLYFindRankHeaderView ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation XMLYFindRankHeaderView


+ (XMLYFindRankHeaderView *)findRankHeaderView {
    return [[self alloc] initFindRankHeaderView];
}

- (XMLYFindRankHeaderView *)initFindRankHeaderView {
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, 150.0f)];
    [self configSubViews];
    return self;
}

- (void)setFocosImageModel:(XMLYFindFocusImagesModel *)focosImageModel {
    _focosImageModel = focosImageModel;
    if(_focosImageModel.list.count == 0) return;
    
    [self.scrollView removeAllSubViews];
    for(NSInteger i = 0, max = _focosImageModel.list.count; i <= max; i++) {
        UIImageView *img = [[UIImageView alloc] init];
        img.frame = CGRectMake(i * kScreenWidth, 0, kScreenWidth, self.scrollView.frame.size.height);
        NSString *url = i == max ? ((XMLYFindFocusImageDetailModel *)_focosImageModel.list.firstObject).pic : ((XMLYFindFocusImageDetailModel *)_focosImageModel.list[i]).pic;
        [img yy_setImageWithURL:[NSURL URLWithString:url] options:YYWebImageOptionSetImageWithFadeAnimation];
        [self.scrollView addSubview:img];
    }
    self.scrollView.contentSize = CGSizeMake(kScreenWidth * _focosImageModel.list.count, self.scrollView.frame.size.height);
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger curPage = self.scrollView.contentOffset.x / kScreenWidth;
    if(curPage == self.focosImageModel.list.count) {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
}


- (void)configSubViews {
    [self scrollView];
}

#pragma mark - UIScrollView 

- (UIScrollView *)scrollView {
    if(!_scrollView) {
        UIScrollView *src = [[UIScrollView alloc] init];
        src.frame = CGRectMake(0, 0, kScreenWidth, self.frame.size.height);
        src.delegate = self;
        src.showsHorizontalScrollIndicator = NO;
        src.pagingEnabled = YES;
        src.backgroundColor = Hex(0xf0f0f0);
        [self addSubview:src];
        _scrollView = src;
    }
    return _scrollView;
}

@end
