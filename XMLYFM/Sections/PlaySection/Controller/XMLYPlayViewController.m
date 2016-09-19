//
//  XMLYPlayViewController.m
//  XMLYFM
//
//  Created by East_wu on 16/8/8.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYPlayViewController.h"
#import "XMLYPlayAlbumTrackAPI.h"
#import "XMLYAnchorFooterView.h"
#import "XMLYPlayHeaderView.h"
#import "XMLYPlayIntroCell.h"
#import "XMLYCollMoreView.h"
#import "XMLYPlayCommentCell.h"
#import "XMLYPlayEditHeaderView.h"
#import "XMLYPlayEditRewardCell.h"
#import "XMLYAnchorHeaderView.h"
#import "XMLYPlayDBHelper.h"
#import "XMLYPlayAboutRecomCell.h"
#import "XMLYAudioItem.h"
#import "XMLYCollMoreView.h"
#import "XMLYPlayCommentCell.h"

static  NSInteger const kSectionIntro   = 0; //介绍
static  NSInteger const kSectionEditor  = 1; //编辑
static  NSInteger const kSectionRecom   = 2; //推荐
static  NSInteger const kSectionComment = 3; //点评


@interface XMLYPlayViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,XMLYAudioHelperDelegate,XMLYPlayHeaderViewDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, strong) XMLYPlayHeaderView    *headerView;
@property (nonatomic, strong) XMLYAudioHelper       *helper;

@end

@implementation XMLYPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavigationBar];
}

- (void)dealloc {
//    NSTimeInterval duration = [self.helper audioProgress];
//    [self.helper destoryAudioStream];
//    [[XMLYPlayDBHelper dbHelper] updateLastPlayingRecordWithDuration:duration];
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
- (void)startPlayWithAlbumID:(NSInteger)albumID trackID:(NSInteger)trackID cachePath:(NSString *)cachePath{
    @weakify(self);
    [XMLYPlayAlbumTrackAPI requestPlayAlbumTrackDetailWithAblumID:albumID trackUID:trackID completion:^(id response, NSString *message, BOOL success) {
        @strongify(self);
        if(success) {
            //模型转换
            self.model = [XMLYPlayPageModel xr_modelWithJSON:response];
            [self.model calculateFrameForCell];
            //刷新UICollectionView
            [self.collectionView reloadData];
            //播放音频
            [self startPlayAudioWithAudioURL:self.model.trackInfo.playPathAacv164 localPath:cachePath];
        }
    }];
}

- (void)startPlayAudioWithAudioURL:(NSString *)url localPath:(NSString *)localPath {
    XMLYAudioItem *item = [[XMLYAudioItem alloc] init];
    item.audioFileURL = [NSURL URLWithString:url];
    
    // 先将上一次播放数据置为已播放
    if(_helper) {
        NSTimeInterval duration = [self.helper audioProgress];
        [[XMLYPlayDBHelper dbHelper] updateLastPlayingRecordWithDuration:duration];
    }
    
    //开始播放音频
    [self.helper startPlayAudioWithItem:item withProgress:self.progress];
    //保存当前播放信息
    [[XMLYPlayDBHelper dbHelper] saveCurrentPlayAudioInfo:self.model cachePath:self.helper.cachePath];
}

- (void)saveCurrentPlayHistory {
    if(_helper) {
        CGFloat progress = [self.helper audioProgress];
        [[XMLYPlayDBHelper dbHelper] updateLastPlayingRecordWithDuration:progress];
    }
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

#pragma mark - XMLYPlayHeaderViewDelegate
- (void)playHeaderView:(XMLYPlayHeaderView *)view didStatuButtonClick:(UIButton *)btn {
    [self.helper actionPlayPaush];
}

- (void)playHeaderView:(XMLYPlayHeaderView *)view didPreButtonClick:(UIButton *)btn {
    
}

- (void)playHeaderView:(XMLYPlayHeaderView *)view didNextButtonClick:(UIButton *)btn {

}

#pragma mark - UICollectionViewDelegate/UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(section == kSectionIntro || section == kSectionEditor) {
        return 1;
    }else if(section == kSectionRecom) {
        return self.model.associationAlbumsInfo.count + 1;
    }else if(section == kSectionComment) {
        return self.model.commentInfo.list.count + 1;
    }
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == kSectionIntro) {
        return CGSizeMake(kScreenWidth, self.model.trackInfo.headerHeight);
    }else if(indexPath.section == kSectionEditor) {
        return CGSizeMake(kScreenWidth, 170.0f);
    }else if(indexPath.section == kSectionRecom) {
        if(indexPath.row < self.model.associationAlbumsInfo.count) {
            XMLYAssociationAlbumsInfoModel *model = self.model.associationAlbumsInfo[indexPath.row];
            return CGSizeMake(kScreenWidth, model.cellHeight);
        }else{
            return CGSizeMake(kScreenWidth, 44.0f);
        }
    }else if(indexPath.section == kSectionComment) {
        if(indexPath.row < self.model.commentInfo.list.count) {
            XMLYComentInfoItemModel *model = self.model.commentInfo.list[indexPath.row];
            return CGSizeMake(kScreenWidth, model.cellHeight);
        }else{
            return CGSizeMake(kScreenWidth, 44.0f);
        }
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
        cell.model = self.model;
        return cell;
    }else if(indexPath.section == kSectionEditor) {
        XMLYPlayEditRewardCell *cell = [XMLYPlayEditRewardCell collectionViewCellFromClass:collectionView atIndexPath:indexPath];
        cell.model = self.model.trackRewardInfo;
        return cell;
    }else if(indexPath.section == kSectionRecom) {
        if(indexPath.row < self.model.associationAlbumsInfo.count) {
            XMLYAssociationAlbumsInfoModel *model = self.model.associationAlbumsInfo[indexPath.row];
            XMLYPlayAboutRecomCell *cell = [XMLYPlayAboutRecomCell collectionViewCellFromNib:collectionView atIndexPath:indexPath];
            cell.model = model;
            cell.showSep = indexPath.row != self.model.associationAlbumsInfo.count - 1;
            return cell;
        }else{
            XMLYCollMoreView *moreView = [XMLYCollMoreView collectionViewCellFromClass:collectionView atIndexPath:indexPath];
            return moreView;
        }
    }else if(indexPath.section == kSectionComment){
        if(indexPath.row < self.model.commentInfo.list.count) {
            XMLYComentInfoItemModel *model = self.model.commentInfo.list[indexPath.row];
            XMLYPlayCommentCell *cell = [XMLYPlayCommentCell collectionViewCellFromNib:collectionView atIndexPath:indexPath];
            cell.model = model;
            return cell;
        }else{
            XMLYCollMoreView *moreView = [XMLYCollMoreView collectionViewCellFromClass:collectionView atIndexPath:indexPath];
            return moreView;
        }
    }
    return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if([kind isEqualToString:kSectionHeader]) {
        if(indexPath.section == kSectionIntro) {
            if(!self.headerView) {
                self.headerView = [XMLYPlayHeaderView sectionHeaderAwakeFromClass:collectionView atIndexPath:indexPath];
                self.headerView.model = self.model;
                self.headerView.delegate = self;
                return self.headerView;
            } else {
                return self.headerView;
            }
        }else if(indexPath.section == kSectionEditor) {
            XMLYPlayEditHeaderView *header = [XMLYPlayEditHeaderView sectionHeaderAwakeFromClass:collectionView atIndexPath:indexPath];
            header.model = self.model.userInfo;
            return header;
        }else if(indexPath.section == kSectionRecom) {
            XMLYAnchorHeaderView *header = [XMLYAnchorHeaderView anchorHeaderView:collectionView atIndexPath:indexPath];
            [header configHeaderTitle:@"相关推荐" showMore:NO];
            return header;
        }else{
            XMLYAnchorHeaderView *header = [XMLYAnchorHeaderView anchorHeaderView:collectionView atIndexPath:indexPath];
            NSString *str = [NSString stringWithFormat:@"听众点评（%ld）",self.model.commentInfo.totalCount];
            [header configHeaderTitle:str showMore:NO];
            return header;
        }
    } else {
        XMLYAnchorFooterView *footer = [XMLYAnchorFooterView anchorFooterView:collectionView atIndexPath:indexPath];
        return footer;
    }
}

#pragma mark - XMLYAudioHelper
- (void)audioHelperStatuChange:(DOUAudioStreamerStatus)status {
    self.status = status;
    if(self.playViewControllerStatusChangeBlock) {
        self.playViewControllerStatusChangeBlock(self.status);
    }
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
