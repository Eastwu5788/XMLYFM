//
//  XMLYLiveDetailController.m
//  XMLYFM
//
//  Created by East_wu on 16/9/14.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYLiveDetailController.h"
#import "XMLYLiveDetailAPI.h"
#import "XMLYLiveDetailModel.h"
#import "XMLYAnchorFooterView.h"
#import "XMLYSecHeaStyleTitle.h"
#import "XMLYLiveDetailHeaderView.h"
#import "XMLYLiveDetailIntroCell.h"
#import "XMLYLiveDetailEditCell.h"
#import "XMLYLiveDetailListCell.h"

static NSInteger const kSectionIntro = 0;
static NSInteger const kSectionEdit  = 1;
static NSInteger const kSectionList  = 2;

@interface XMLYLiveDetailController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) XMLYLiveDetailModel   *detailModel;
@property (nonatomic, weak) XMLYLiveDetailHeaderView *headerView;

@end

@implementation XMLYLiveDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavigationBar];
    [self headerView];
}

- (void)setLiveID:(NSInteger)liveID {
    _liveID = liveID;
    [self requestLiveDetail:_liveID];
}

#pragma mark - Private 
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

#pragma mark - HTTP

- (void)requestLiveDetail:(NSInteger)liveID {
    [XMLYLiveDetailAPI requestLiveDetail:liveID completion:^(id response, NSString *message, BOOL success) {
        if(success && [response isKindOfClass:[NSDictionary class]]) {
            self.detailModel = [XMLYLiveDetailModel xr_modelWithJSON:response[@"data"]];
            [self.detailModel calculateFrameForCell];
            self.title = self.detailModel.activityDetail.name;
            self.headerView.activityModel = self.detailModel.activityDetail;
            [self.collectionView reloadData];
        }
    }];
}

#pragma mark - UICollectionViewDelegate/UICollectionViewDateSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(section == kSectionList) {
        return self.detailModel.activitySchedules.count;
    }
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == kSectionIntro) {
        return CGSizeMake(kScreenWidth, self.detailModel.activityDetail.cellHeight);
    }else if(indexPath.section == kSectionEdit) {
        return CGSizeMake(kScreenWidth, 63.0f);
    }
    return CGSizeMake(kScreenWidth, 52.0f);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(kScreenWidth, 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if(section == kSectionIntro) {
        return CGSizeZero;
    }
    return CGSizeMake(kScreenWidth, 40);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == kSectionIntro) {
        XMLYLiveDetailIntroCell *cell = [XMLYLiveDetailIntroCell collectionViewCellFromClass:collectionView atIndexPath:indexPath];
        cell.activityModel = self.detailModel.activityDetail;
        return cell;
    }else if(indexPath.section == kSectionEdit) {
        XMLYLiveDetailEditCell *cell = [XMLYLiveDetailEditCell collectionViewCellFromNib:collectionView atIndexPath:indexPath];
        cell.anchorInfo = self.detailModel.anchorInfo;
        return cell;
    }
    XMLYLiveDetailListCell *cell = [XMLYLiveDetailListCell collectionViewCellFromClass:collectionView atIndexPath:indexPath];
    cell.itemModel = self.detailModel.activitySchedules[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if([kind isEqualToString:kSectionFooter]) {
        XMLYAnchorFooterView *footer = [XMLYAnchorFooterView anchorFooterView:collectionView atIndexPath:indexPath];
        return footer;
    }else{
        XMLYSecHeaStyleTitle *header = [XMLYSecHeaStyleTitle sectionHeaderAwakeFromClass:collectionView atIndexPath:indexPath];
        header.backgroundColor = [UIColor whiteColor];
        header.title = indexPath.section == 1 ? @"主播信息" : @"直播列表";
        return header;
    }
}



#pragma mark - getter
- (UICollectionView *)collectionView {
    if(!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 120, kScreenWidth, kScreenHeight - 184) collectionViewLayout:layout];
        view.delegate = self;
        view.dataSource = self;
        view.backgroundColor = Hex(0xf3f3f3);
        [self.view addSubview:view];
        _collectionView = view;
    }
    return _collectionView;
}

- (XMLYLiveDetailHeaderView *)headerView {
    if(!_headerView) {
        XMLYLiveDetailHeaderView *view = [[XMLYLiveDetailHeaderView alloc] init];
        view.frame = CGRectMake(0, 0, kScreenWidth, 120);
        [self.view addSubview:view];
        _headerView = view;
    }
    return _headerView;
}

@end
