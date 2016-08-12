//
//  XMLYFindRecomHeader.m
//  XMLYFM
//
//  Created by East_wu on 16/8/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYFindRecomHeader.h"
#import "UIImageView+YYWebImage.h"
#import "UIView+Extension.h"
#import "XMLYNotification.h"
#import "XMLYFindRecommendHelper.h"
#import "XMLYHeaderIconView.h"

@interface XMLYFindRecomHeader () <UIScrollViewDelegate>

/**
 *  上方的广告轮播图
 */
@property (weak, nonatomic) IBOutlet UIScrollView *adverScrollView;

/**
 *  下方的类别轮播图
 */
@property (weak, nonatomic) IBOutlet UIScrollView *cateScrollView;

@end

@implementation XMLYFindRecomHeader

- (void)setModel:(XMLYFindFocusImagesModel *)model {
    _model = model;
    
    [self.adverScrollView removeAllSubViews];
    
    self.adverScrollView.contentSize = CGSizeMake(kScreenWidth * _model.list.count, 150);
    
    for(NSInteger index = 0; index <= _model.list.count; index++) {
        
        XMLYFindFocusImageDetailModel *detail = index == _model.list.count ? _model.list.firstObject : [_model.list objectAtIndex:index];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(kScreenWidth * index, 0, kScreenWidth, 150);
        [imageView yy_setImageWithURL:[NSURL URLWithString:detail.pic] options:YYWebImageOptionSetImageWithFadeAnimation];
        
        [self.adverScrollView addSubview:imageView];
    }
}

// 71 * 90
- (void)setDiscoverModel:(XMLYFindDiscoverColumnsModel *)discoverModel {
    _discoverModel = discoverModel;
    
    [self.cateScrollView removeAllSubViews];
    
    self.cateScrollView.contentSize = CGSizeMake(71 * _discoverModel.list.count, 90);
    
    for(NSInteger index = 0; index < _discoverModel.list.count; index++) {
        XMLYFindDiscoverDetailModel *detailModel = [_discoverModel.list objectAtIndex:index];
        XMLYHeaderIconView *iconView = [XMLYHeaderIconView headerIconView];
        iconView.detailModel = detailModel;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(71 * index, 0, 71, 90)];
        [view addSubview:iconView];
        [self.cateScrollView addSubview:view];
    }
    
}

- (void)timerChanged {
    if(!_model) {
        return;
    }
    NSInteger curIndex = self.adverScrollView.contentOffset.x / kScreenWidth;
    [self.adverScrollView setContentOffset:CGPointMake((curIndex + 1)* kScreenWidth, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger curPage = self.adverScrollView.contentOffset.x / kScreenWidth;
    if(curPage == self.model.list.count) {
        [self.adverScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [[XMLYFindRecommendHelper helper] destoryHeaderTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [[XMLYFindRecommendHelper helper] startHeadTimer];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.adverScrollView.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timerChanged) name:kNotificationFindRecommendHeaderTimer object:nil];
}


+ (instancetype)findRecomHeader {
    NSString *identifer = NSStringFromClass([self class]);
    return [[NSBundle mainBundle] loadNibNamed:identifer owner:nil options:nil].firstObject;
}



@end
