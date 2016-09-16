//
//  XMLYPlayViewController.m
//  XMLYFM
//
//  Created by East_wu on 16/8/8.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYPlayViewController.h"
#import "XMLYPlayAlbumTrackAPI.h"
#import "XMLYPlayPageModel.h"
#import "XMLYAnchorFooterView.h"
#import "XMLYPlayHeaderView.h"
#import "XMLYPlayIntroCell.h"
#import "XMLYCollMoreView.h"
#import "XMLYPlayCommentCell.h"
#import "XMLYPlayEditHeaderView.h"
#import "XMLYPlayEditRewardCell.h"
#import "XMLYAnchorHeaderView.h"
#import "XMLYPlayDBHelper.h"
#import "XMLYAudioHelper.h"
#import "XMLYAudioItem.h"

static  NSInteger const kSectionIntro   = 0; //介绍
static  NSInteger const kSectionEditor  = 1; //编辑
static  NSInteger const kSectionRecom   = 2; //推荐
static  NSInteger const kSectionComment = 3; //点评


@interface XMLYPlayViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,XMLYAudioHelperDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) XMLYPlayPageModel *model;
@property (nonatomic, strong) XMLYPlayHeaderView    *headerView;
@property (nonatomic, strong) XMLYAudioHelper       *helper;

@end

@implementation XMLYPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavigationBar];
}

+ (instancetype)playViewController {
    static XMLYPlayViewController *play = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        play = [[XMLYPlayViewController alloc] init];
    });
    return play;
}

#pragma mark - HTTP
- (void)startPlayWithAlbumID:(NSInteger)albumID trackID:(NSInteger)trackID {
    @weakify(self);
    [XMLYPlayAlbumTrackAPI requestPlayAlbumTrackDetailWithAblumID:albumID trackUID:trackID completion:^(id response, NSString *message, BOOL success) {
        @strongify(self);
        if(success) {
            //模型转换
            self.model = [XMLYPlayPageModel xr_modelWithJSON:response];
            //保存当前播放信息
            [[XMLYPlayDBHelper dbHelper] saveCurrentPlayAudioInfo:self.model];
            //刷新UICollectionView
            [self.collectionView reloadData];
            //播放音频
            [self startPlayAudioWithAudioURL:self.model.trackInfo.playPathAacv164 localPath:nil];
        }
    }];
}

- (void)startPlayAudioWithAudioURL:(NSString *)url localPath:(NSString *)localPath {    
    XMLYAudioItem *item = [[XMLYAudioItem alloc] init];
    item.audioFileURL = [NSURL URLWithString:url];
    
    //开始播放音频
    [self.helper startPlayAudioWithItem:item];
}

#pragma mark - private
- (void)configNavigationBar {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 44, 44);
    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [leftButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"navidrop_arrow_down_h"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 44, 44);
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20);
    [rightButton setImage:[UIImage imageNamed:@"icon_share_h"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)backButtonClick:(UIButton *)btn {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UICollectionViewDelegate/UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(section == kSectionIntro || section == kSectionEditor) {
        return 1;
    }else if(section == kSectionRecom) {
        return 4;
    }else if(section == kSectionComment) {
        return 4;
    }
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == kSectionIntro) {
        return CGSizeMake(kScreenWidth, 277.0f);
    }else if(indexPath.section == kSectionEditor) {
        return CGSizeMake(kScreenWidth, 170.0f);
    }else if(indexPath.section == kSectionRecom) {
        return CGSizeMake(kScreenWidth, 119.0f);
    }else if(indexPath.section == kSectionComment) {
        return CGSizeMake(kScreenWidth, 94.0f);
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(kScreenWidth, 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if(section == kSectionIntro) {
        return CGSizeMake(kScreenWidth, 447);
    }else if(section == kSectionEditor) {
        return CGSizeMake(kScreenWidth, 65.0f);
    }else if(section == kSectionComment || section == kSectionRecom) {
        return CGSizeMake(kScreenWidth, 40.0f);
    }
    return CGSizeZero;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == kSectionIntro) {
        XMLYPlayIntroCell *cell = [XMLYPlayIntroCell collectionViewCellFromClass:collectionView atIndexPath:indexPath];
        return cell;
    }else if(indexPath.section == kSectionEditor) {
        XMLYPlayEditRewardCell *cell = [XMLYPlayEditRewardCell collectionViewCellFromClass:collectionView atIndexPath:indexPath];
        return cell;
    }else if(indexPath.section == kSectionRecom) {
        XMLYPlayCommentCell *cell = [XMLYPlayCommentCell collectionViewCellFromClass:collectionView atIndexPath:indexPath];
        return cell;
    }else{
        XMLYPlayCommentCell *cell = [XMLYPlayCommentCell collectionViewCellFromClass:collectionView atIndexPath:indexPath];
        return cell;
    }
    return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if([kind isEqualToString:kSectionHeader]) {
        if(indexPath.section == kSectionIntro) {
            if(!self.headerView) {
                self.headerView = [XMLYPlayHeaderView sectionHeaderAwakeFromClass:collectionView atIndexPath:indexPath];
                self.headerView.model = self.model;
                return self.headerView;
            } else {
                return self.headerView;
            }
        }else if(indexPath.section == kSectionEditor) {
            XMLYPlayEditHeaderView *header = [XMLYPlayEditHeaderView sectionHeaderAwakeFromClass:collectionView atIndexPath:indexPath];
            return header;
        }else if(indexPath.section == kSectionRecom) {
            XMLYAnchorHeaderView *header = [XMLYAnchorHeaderView anchorHeaderView:collectionView atIndexPath:indexPath];
            [header configHeaderTitle:@"相关推荐" showMore:NO];
            return header;
        }else{
            XMLYAnchorHeaderView *header = [XMLYAnchorHeaderView anchorHeaderView:collectionView atIndexPath:indexPath];
            [header configHeaderTitle:@"评论" showMore:NO];
            return header;
        }
    } else {
        XMLYAnchorFooterView *footer = [XMLYAnchorFooterView anchorFooterView:collectionView atIndexPath:indexPath];
        return footer;
    }
}

#pragma mark - XMLYAudioHelper
- (void)audioHelperStatuChange:(DOUAudioStreamerStatus)status {
    [self.headerView audioStatusChanged:status];
}

- (void)audioHelperDurationChange:(NSTimeInterval)currentTime duration:(NSTimeInterval)duration {
    [self.headerView audioDurationChange:currentTime duration:duration];
}

- (void)audioHelperBufferStatusChange:(NSUInteger)receivedLength expectedLength:(NSUInteger)expectedLength downloadSpeed:(NSUInteger)downloadSpeed {
    [self.headerView audioBufferStatusChange:receivedLength expectedLength:expectedLength downloadSpeed:downloadSpeed];
}


#pragma mark - getter



- (XMLYAudioHelper *)helper {
    if(!_helper) {
        _helper = [XMLYAudioHelper helper];
        _helper.delegate = self;
    }
    return _helper;
}

- (UICollectionView *)collectionView {
    if(!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        CGRect frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64);
        UICollectionView *col = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        col.delegate = self;
        col.dataSource = self;
        col.backgroundColor = Hex(0xf3f3f3);
        [self.view addSubview:col];
        _collectionView = col;
    }
    return _collectionView;
}

@end
