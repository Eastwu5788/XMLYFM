//
//  XMLYFindAnchorController.m
//  XMLYFM
//
//  Created by East_wu on 16/8/10.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYFindAnchorController.h"
#import "XMLYFindAnchorModel.h"
#import "XMLYAnchorSignerCell.h"
#import "XMLYAnchorNormalCell.h"
#import "XMLYAnchorFooterView.h"
#import "XMLYAnchorHeaderView.h"
#import "XMLYAnchorFlowLayout.h"
#import "XMLYAnchorAPI.h"

static NSString *const kSectionHeader = @"UICollectionElementKindSectionHeader";
static NSString *const kSectionFooter = @"UICollectionElementKindSectionFooter";

@interface XMLYFindAnchorController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) XMLYFindAnchorModel *model;

@end

@implementation XMLYFindAnchorController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Hex(0xf0f0f0);
    [self requestDataSource];
}

#pragma mark - HTTPRequest
/**
 *  请求数据
 */
- (void)requestDataSource {
    [XMLYAnchorAPI requestAnchorData:^(id response, NSString *message, BOOL success) {
        if(success) {
            self.model = [XMLYFindAnchorModel xr_modelWithJSON:response];
            [self.model createDataSource];
            [self.collectionView reloadData];
        }
    }];
}



#pragma mark - Private

- (void)configSubviews {
}

#pragma mark - UICollectionViewDelegate/UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.model.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    XMLYAnchorSectionModel *model = self.model.dataSource[section];
    NSInteger count = model.list.count;
    return count - count % 3; //保证每一行是3的倍数
}

//item size 210 x 320
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XMLYAnchorSectionModel *model = self.model.dataSource[indexPath.section];
    if(model.displayStyle == 2) {
        return CGSizeMake(kScreenWidth, 90);
    }
    
    CGFloat width = kScreenWidth / 3.0f;
    CGFloat height = 32.0 * width / 21.0;
    return CGSizeMake(width, height);
}

//footer size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(kScreenWidth, 10);
}

//header size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kScreenWidth, 40);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XMLYAnchorSectionModel *model = self.model.dataSource[indexPath.section];
    XMLYAnchorCellModel *cellModel = model.list[indexPath.row];
    if(model.displayStyle == 2) {
        XMLYAnchorSignerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XMLYAnchorSignerCell" forIndexPath:indexPath];
        cell.model = cellModel;
        return cell;
    }
    else {
        XMLYAnchorNormalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XMLYAnchorNormalCell" forIndexPath:indexPath];
        cell.model = cellModel;
        return cell;
    }
}

//footer header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if([kind isEqualToString:kSectionHeader] ) {
        XMLYAnchorSectionModel *model = self.model.dataSource[indexPath.section];
        XMLYAnchorHeaderView *header = [XMLYAnchorHeaderView anchorHeaderView:collectionView atIndexPath:indexPath];
        header.model = model;
        return header;
    } else if([kind isEqualToString:kSectionFooter]){
        XMLYAnchorFooterView *footer = [XMLYAnchorFooterView anchorFooterView:collectionView atIndexPath:indexPath];
        return footer;
    }
    return nil;
}



#pragma mark - getter

- (UICollectionView *)collectionView {
    if(!_collectionView) {
        CGRect frame = self.view.frame;
        XMLYAnchorFlowLayout *layout = [[XMLYAnchorFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *col = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        [col registerNib:[UINib nibWithNibName:@"XMLYAnchorSignerCell" bundle:nil] forCellWithReuseIdentifier:@"XMLYAnchorSignerCell"];
        [col registerNib:[UINib nibWithNibName:@"XMLYAnchorNormalCell" bundle:nil] forCellWithReuseIdentifier:@"XMLYAnchorNormalCell"];
        col.delegate = self;
        col.dataSource = self;
        col.backgroundColor = Hex(0xf0f0f0);
        _collectionView = col;
        [self.view addSubview:col];
    }
    return _collectionView;
}


@end
