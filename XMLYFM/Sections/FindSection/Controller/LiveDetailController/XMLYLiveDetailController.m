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
    //[self requestLiveDetail:_liveID];
}

#pragma mark - Private 
- (void)configNavigationBar {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 64, 44);
    [leftButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"navidrop_arrow_down_h"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];

    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 64, 44);
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
            [self.collectionView reloadData];
        }
    }];
}

#pragma mark - UICollectionViewDelegate/UICollectionViewDateSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(section == 2) {
        return self.detailModel.activitySchedules.count;
    }
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
    
    }else if(indexPath.section == 1) {
        return CGSizeMake(kScreenWidth, 63.0f);
    }
    return CGSizeMake(kScreenWidth, 52.0f);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(kScreenWidth, 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return CGSizeZero;
    }
    return CGSizeMake(kScreenWidth, 40);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if([kind isEqualToString:kSectionFooter]) {
        XMLYAnchorFooterView *footer = [XMLYAnchorFooterView anchorFooterView:collectionView atIndexPath:indexPath];
        return footer;
    }else{
        XMLYSecHeaStyleTitle *header = [XMLYSecHeaStyleTitle sectionHeaderAwakeFromClass:collectionView atIndexPath:indexPath];
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
        
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) collectionViewLayout:layout];
        view.delegate = self;
        view.dataSource = self;
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
