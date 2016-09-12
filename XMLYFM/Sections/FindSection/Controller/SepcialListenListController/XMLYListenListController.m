//
//  XMLYListenListController.m
//  XMLYFM
//
//  Created by East_wu on 16/9/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYListenListController.h"
#import "XMLYAnchorHeaderView.h"
#import "XMLYAnchorFooterView.h"
#import "XMLYListenListCell.h"
#import "XMLYListenListAPI.h"
#import "XMLYListenListModel.h"
#import "XMLYTimeHelper.h"
#import "ReactiveCocoa/RACEXTScope.h"
#import "XMLYListenDetailController.h"

@interface XMLYListenListController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation XMLYListenListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"精品听单";
    [self requestDataSourceWithPage:1];
}

#pragma mark - HTTP
- (void)requestDataSourceWithPage:(NSInteger)page {
    @weakify(self);
    [XMLYListenListAPI requestListenListWithPage:page completion:^(id response, NSString *message, BOOL success) {
        @strongify(self);
        XMLYListenListModel *model = [XMLYListenListModel xr_modelWithJSON:response];
        [self dealWithModel:model isRefresh:page == 1];
    }];
}

/**
 *  将模型转换成二维数组
 */
- (void)dealWithModel:(XMLYListenListModel *)model isRefresh:(BOOL)isRefresh {
    
    XMLYListenListModel *monthModel;
    
    if(isRefresh || self.dataSource.count == 0) {
        [self.dataSource removeAllObjects];
        monthModel = [[XMLYListenListModel alloc] init];
    } else {
        monthModel = self.dataSource.lastObject;
    }
    
    for(NSInteger i = 0, max = model.list.count; i < max; i++) {
        XMLYListenItemModel *itemModel = model.list[i];
        NSString *timeStr = [XMLYTimeHelper dataStringFromTimeInterval:itemModel.releasedAt / 1000 dataFormatter:@"MM/YYYY"];
        //当前月份值不存在，则表示是新数据，直接插入
        if(!monthModel.timeStr || monthModel.timeStr.length == 0) {
            monthModel.timeStr = timeStr;
            [monthModel.list addObject:itemModel];
        //当前月份存在，并且与item的月份相同，则插入
        } else if(monthModel.timeStr && [monthModel.timeStr isEqualToString:timeStr]) {
            [monthModel.list addObject:itemModel];
        } else {
            //老月份加入数组
            [self.dataSource addObject:[monthModel copy]];
            //开启新月份
            monthModel = [[XMLYListenListModel alloc] init];
        }
        //
        if(i == max - 1 && [monthModel.timeStr isEqualToString:timeStr]) {
            [self.dataSource addObject:[monthModel copy]];
        }
    }
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate/UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    XMLYListenListModel *listModel = self.dataSource[section];
    return listModel.list.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kScreenWidth, 85.0f);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(kScreenWidth, 10.0f);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kScreenWidth, 40.0f);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XMLYListenListModel *listModel = self.dataSource[indexPath.section];
    XMLYListenListCell *cell = [XMLYListenListCell listenListCell:collectionView atIndexPath:indexPath];
    [cell hiddenSepLine:(indexPath.row == listModel.list.count - 1)];
    cell.model = listModel.list[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if([kind isEqualToString:kSectionHeader]) {
        XMLYListenListModel *listModel = self.dataSource[indexPath.section];
        XMLYAnchorHeaderView *header = [XMLYAnchorHeaderView anchorHeaderView:collectionView atIndexPath:indexPath];
        [header configHeaderTitle:listModel.timeStr showMore:NO];
        return header;
    } else {
        XMLYAnchorFooterView *footer = [XMLYAnchorFooterView anchorFooterView:collectionView atIndexPath:indexPath];
        return footer;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    XMLYListenListModel *listModel = self.dataSource[indexPath.section];
    XMLYListenItemModel *itemModel = listModel.list[indexPath.row];
    XMLYListenDetailController *con = [[XMLYListenDetailController alloc] init];
    con.detailId = itemModel.specialId;
    con.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:con animated:YES];
}


#pragma mark - getter
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
        [self.view bringSubviewToFront:self.playView];
        _collectionView = col;
    }
    return _collectionView;
}

- (NSMutableArray *)dataSource {
    if(!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

@end
