//
//  XMLYLiveListController.m
//  XMLYFM
//
//  Created by East_wu on 16/9/11.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYLiveListController.h"
#import "XMLYAnchorFooterView.h"
#import "XMLYLiveListAPI.h"
#import "XMLYLiveListModel.h"
#import "XMLYLiveItemCell.h"
#import "XMLYBaseNavigationController.h"
#import "XMLYLiveDetailController.h"

@interface XMLYLiveListController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, strong) XMLYLiveListModel *model;

@end

@implementation XMLYLiveListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavigation];
    [self requestLiveListWithPage:1];
}


- (void)configNavigation {
    self.title = @"现场直播";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_search_n"]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(searchButtonClick)];
}

- (void)searchButtonClick {
    
}

#pragma mark - HTTP

- (void)requestLiveListWithPage:(NSInteger)page {
    [XMLYLiveListAPI requestLiveList:page completion:^(id response, NSString *message, BOOL success) {
        if(success && [response isKindOfClass:[NSDictionary class]]) {
            NSDictionary *subDic = response[@"data"];
            self.model = [XMLYLiveListModel xr_modelWithJSON:subDic];
            [self.collectionView reloadData];
        }
    }];
}


#pragma mark - UICollectionViewDelegate/UICollectionViewDataSource 


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.model.data.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

//320 * 185
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = kScreenWidth * 185.0f / 320.0f;
    return CGSizeMake(kScreenWidth, height);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(kScreenWidth, 15.0f);
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XMLYLiveListItemModel *model = self.model.data[indexPath.section];
    XMLYLiveItemCell *cell = [XMLYLiveItemCell liveItemCellWithCollectionView:collectionView indexPath:indexPath];
    cell.model = model;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if([kind isEqualToString:kSectionFooter]){
        XMLYAnchorFooterView *footer = [XMLYAnchorFooterView anchorFooterView:collectionView atIndexPath:indexPath];
        return footer;
    }
    return nil;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    XMLYLiveListItemModel *model = self.model.data[indexPath.section];
    XMLYLiveDetailController *detail = [[XMLYLiveDetailController alloc] init];
    detail.liveID = model.cid;
    XMLYBaseNavigationController *nav = [[XMLYBaseNavigationController alloc] initWithRootViewController:detail];
    [self presentViewController:nav animated:YES completion:nil];
}


#pragma mark - UICollectionView 

- (UICollectionView *)collectionView {
    if(!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        UICollectionView *col = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height) collectionViewLayout:layout];
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
