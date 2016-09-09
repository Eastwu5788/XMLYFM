//
//  XMLYFindCellStyleLive.m
//  XMLYFM
//
//  Created by East_wu on 16/8/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYFindCellStyleLive.h"
#import "UIImageView+YYWebImage.h"
#import "XMLYNotification.h"
#import "XMLYFindREcommendHelper.h"

@interface XMLYFindCellStyleLive () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *moreImageView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *peopleCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *subContentLabel;

@end

@implementation XMLYFindCellStyleLive

#pragma mark - setter

- (void)setLiveMoel:(XMLYFindLiveModel *)liveMoel {
    
    if(_liveMoel != nil) {
        return;
    }
    
    _liveMoel = liveMoel;
    
    self.titleLabel.text = @"现场直播";
    
    self.scrollView.contentSize = CGSizeMake((kScreenWidth - 20) * (_liveMoel.data.count + 1), 108);
    
    [self removeAllSubviewsInScrollView];

    for(NSInteger index = 0; index <= _liveMoel.data.count; index ++) {
        
        XMLYFindLiveDetailModel *detailModel = index == _liveMoel.data.count ? [_liveMoel.data objectAtIndex:0] : [_liveMoel.data objectAtIndex:index];
        if(index == 0) {
            [self setLabelText:detailModel];
        }
        
        UIImageView *image = [[UIImageView alloc] init];
        image.frame = CGRectMake((kScreenWidth - 20) * index, 0, kScreenWidth - 20, 108);
        [self.scrollView addSubview:image];
        
        [image yy_setImageWithURL:[NSURL URLWithString:detailModel.coverPath] options:YYWebImageOptionSetImageWithFadeAnimation];
    }
}

#pragma mark - private

/**
 *  移除所有子图片
 */
- (void)removeAllSubviewsInScrollView{
    for(UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
}

/**
 *  计数器发生变化
 */
- (void)changeStatus {
    if(!_liveMoel) {
        return;
    }
    
    //计算当前应该显示第i条数据
    NSInteger curIndex = self.scrollView.contentOffset.x / (kScreenWidth - 20);
    
    [self.scrollView setContentOffset:CGPointMake((curIndex + 1) * (kScreenWidth - 20), 0) animated:YES];
    
    //改变文本
    XMLYFindLiveDetailModel *curModel = curIndex + 1 == self.liveMoel.data.count ? [self.liveMoel.data objectAtIndex:0] : [self.liveMoel.data objectAtIndex:curIndex];
    [self setLabelText:curModel];
}


//设置文字标题

- (void)setLabelText:(XMLYFindLiveDetailModel *)model {
    self.peopleCountLabel.text = [NSString stringWithFormat:@"%ld人参加",(long)model.playCount];
    self.contentLabel.text = model.name;
    self.subContentLabel.text = model.shortDescription;
}


#pragma mark - system

- (void)awakeFromNib {
    [super awakeFromNib];
    self.scrollView.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeStatus) name:kNotificationFindRecommendLiveTimer object:nil];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger curPage = scrollView.contentOffset.x / (kScreenWidth - 20);
    if(curPage == self.liveMoel.data.count) {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [[XMLYFindRecommendHelper helper] destoryLiveTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [[XMLYFindRecommendHelper helper] startLiveTimer];
}

#pragma mark - Public

+ (XMLYFindBaseCell *)findCell:(UITableView *)tableView {
    return [self findCellStyleLive:tableView];
}

+ (instancetype)findCellStyleLive:(UITableView *)tableView {
    NSString *identifer = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:identifer bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifer];
    return [tableView dequeueReusableCellWithIdentifier:identifer];
}


@end
