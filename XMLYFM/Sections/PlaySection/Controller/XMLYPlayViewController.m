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

static  NSInteger const kSectionIntro   = 0; //介绍
static  NSInteger const kSectionEditor  = 1; //编辑
static  NSInteger const kSectionRecom   = 2; //推荐
static  NSInteger const kSectionComment = 3; //点评


@interface XMLYPlayViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) XMLYPlayPageModel *model;

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
    [XMLYPlayAlbumTrackAPI requestPlayAlbumTrackDetailWithAblumID:albumID trackUID:trackID completion:^(id response, NSString *message, BOOL success) {
        if(success) {
            self.model = [XMLYPlayPageModel xr_modelWithJSON:response];
            [self.collectionView reloadData];
        }
    }];
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
        return self.model.associationAlbumsInfo.count + 1;
    }else if(section == kSectionComment) {
        return self.model.commentInfo.list.count + 1;
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
        return CGSizeZero;
    }else if(section == kSectionEditor) {
        return CGSizeMake(kScreenWidth, 65.0f);
    }else if(section == kSectionComment || section == kSectionRecom) {
        return CGSizeMake(kScreenWidth, 40.0f);
    }
    return CGSizeZero;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if(kind == kSectionHeader) {
        return nil;
    } else {
        XMLYAnchorFooterView *footer = [XMLYAnchorFooterView anchorFooterView:collectionView atIndexPath:indexPath];
        return footer;
    }
}


#pragma mark - getter

- (UICollectionView *)collectionView {
    if(!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        CGRect frame = CGRectMake(0, 447, kScreenWidth, kScreenHeight - 511);
        UICollectionView *col = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        col.delegate = self;
        col.dataSource = self;
        [self.view addSubview:col];
        _collectionView = col;
    }
    return _collectionView;
}

@end
