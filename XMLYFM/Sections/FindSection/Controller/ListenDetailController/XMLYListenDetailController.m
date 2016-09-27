//
//  XMLYListenDetailController.m
//  XMLYFM
//
//  Created by East_wu on 16/9/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYListenDetailController.h"
#import "XMLYAnchorFooterView.h"
#import "XMLYAnchorHeaderView.h"
#import "XMLYListenDetailModel.h"
#import "XMLYListenDetailAPI.h"
#import "XMLYListenInfoHeaderView.h"
#import "XMLYListenDetailInfoCell.h"
#import "XMLYListenRecomCell.h"
#import "XMLYListenEditInfoCell.h"


static NSInteger const kSectionInfo  = 0; //介绍
static NSInteger const kSectionRecom = 1; //推荐
static NSInteger const kSectionBoard = 2; //留言板


@interface XMLYListenDetailController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, strong) XMLYListenDetailModel *detailModel;

@end

@implementation XMLYListenDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self collectionView];
    [self configNavigationController];
}

- (void)setDetailId:(NSInteger)detailId {
    _detailId = detailId;
    [self requestListenDetailWithID:detailId];
}

#pragma makr - HTTP
- (void)requestListenDetailWithID:(NSInteger)cid {
    [XMLYListenDetailAPI requestListenDetailAPI:cid completion:^(id response, NSString *message, BOOL success) {
        self.detailModel = [XMLYListenDetailModel xr_modelWithJSON:response];
        
        [self.detailModel calculateIntroCellHeight];
        [self.collectionView reloadData];
    }];
}

#pragma mark - Private
- (void)configNavigationController {
    self.title = @"听单";
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 64, 44);
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -30)];
    [btn setImage:[UIImage imageNamed: @"icon_share_n"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"icon_share_h"] forState:UIControlStateHighlighted];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

#pragma mark - UICollectionViewDelegate/UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(section == kSectionRecom) {
        return self.detailModel.list.count;
    }
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == kSectionInfo) {
        return CGSizeMake(kScreenWidth, self.detailModel.info.cellHeight);
    } else if(indexPath.section == kSectionRecom) {
        XMLYListenDetailItemModel *itemModel = self.detailModel.list[indexPath.row];
        return CGSizeMake(kScreenWidth, itemModel.cellHeight);
    }
    return CGSizeMake(kScreenWidth, 75.0f);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(kScreenWidth, 10.0f);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if(section == kSectionInfo) {
       return CGSizeMake(kScreenWidth, 70.0f);
    }
    return CGSizeMake(kScreenWidth, 40.0f);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == kSectionInfo) {
        XMLYListenDetailInfoCell *cell = [XMLYListenDetailInfoCell listenDetailInfoCell:collectionView atIndexPath:indexPath];
        cell.infoModel = self.detailModel.info;
        return cell;
    }else if(indexPath.section == kSectionRecom) {
        XMLYListenRecomCell *cell = [XMLYListenRecomCell listenRecomCell:collectionView atIndexPath:indexPath];
        cell.itemModel = self.detailModel.list[indexPath.row];
        return cell;
    }else if(indexPath.section == kSectionBoard){
        XMLYListenEditInfoCell *cell = [XMLYListenEditInfoCell listenEditInfoCell:collectionView atIndexPath:indexPath];
        cell.infoModel = self.detailModel.info;
        return cell;
    }
    return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if([kind isEqualToString:kSectionFooter]) {
        XMLYAnchorFooterView *footer = [XMLYAnchorFooterView anchorFooterView:collectionView atIndexPath:indexPath];
        return footer;
    } else if(indexPath.section == kSectionBoard || indexPath.section == kSectionRecom) {
        XMLYAnchorHeaderView *header = [XMLYAnchorHeaderView anchorHeaderView:collectionView atIndexPath:indexPath];
        [header configHeaderTitle:indexPath.section == kSectionRecom ? @"听单推荐" : @"给小编留言" showMore:NO];
        return header;
    } else if(indexPath.section == kSectionInfo){
        XMLYListenInfoHeaderView *headerView = [XMLYListenInfoHeaderView listenInfoHeaderView:collectionView atIndexPath:indexPath];
        headerView.infoModel = self.detailModel.info;
        return headerView;
    }
    return nil;
}



#pragma mark - getter

- (UICollectionView *)collectionView {
    if(!_collectionView) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.scrollDirection = UICollectionViewScrollDirectionVertical;
        flow.minimumLineSpacing = 0;
        flow.minimumInteritemSpacing = 0;
        
        UICollectionView *col = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) collectionViewLayout:flow];
        col.delegate = self;
        col.dataSource = self;
        col.backgroundColor = Hex(0xf3f3f3);
        [self.view addSubview:col];
        [self.view bringSubviewToFront:self.playView];
        _collectionView = col;
    }
    return _collectionView;
}


@end
