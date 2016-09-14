//
//  XMLYAlbumDetailController.m
//  XMLYFM
//
//  Created by East_wu on 16/9/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYAlbumDetailController.h"
#import "XMLYAlbumDetailHeaderView.h"
#import "XMLYAlbumDetailSectionView.h"
#import "ReactiveCocoa.h"
#import "XMLYAlbumDetailModel.h"
#import "XMLYAlbumDetailAPI.h"
#import "XMLYAlbumListModel.h"
#import "XMLYAlbumDetailCell.h"
#import "XMLYAlbumEditIntroCell.h"
#import "XMLYAlbumAboutRecomCell.h"
#import "XMLYDetaillistHeaderCell.h"
#import "XMLYDetialItemCell.h"

@interface XMLYAlbumDetailController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) XMLYAlbumDetailHeaderView *headerView;

@property (nonatomic, assign) XMLYAlbumDetailStyle style;

@property (nonatomic, strong) XMLYAlbumDetailModel  *detailModel;

@property (nonatomic, strong) XMLYAlbumListModel    *listModel;

@end

@implementation XMLYAlbumDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"专辑详情";
    [self requestDataSource];
}

- (void)changeDetailStyle:(XMLYAlbumDetailStyle)style {
    if(self.style == style) return;
    self.style = style;
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}


#pragma mark - HTTP

- (void)requestDataSource{
    
    @weakify(self);
    RACSignal *signalList = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
       [self requestAlbumList:^{
           [subscriber sendNext:nil];
       }];
        return nil;
    }];
    
    RACSignal *signalDetail = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
       [self requestAlbumDetail:^{
           [subscriber sendNext:nil];
       }];
        return nil;
    }];
    
    [[RACSignal combineLatest:@[signalList,signalDetail]] subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
        self.headerView.albumModel = self.listModel.album;
    }];
    
}

- (void)requestAlbumList:(void(^)(void))completion {
    [XMLYAlbumDetailAPI requestAlbumWithID:self.albumId trackId:18556415 tab:@"订阅听" stat:@"推荐" position:1 completion:^(id response, NSString *message, BOOL success) {
        if(success && [response isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = response[@"data"];
            self.listModel = [XMLYAlbumListModel xr_modelWithJSON:dic];
        }
        if(completion){
            completion();
        }
    }];
}

- (void)requestAlbumDetail:(void(^)(void))completion {
    [XMLYAlbumDetailAPI requestAlbumDetail:self.albumId tab:@"订阅听" stat:@"推荐" position:1 completion:^(id response, NSString *message, BOOL success) {
        if(success && [response isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = response[@"data"];
            self.detailModel = [XMLYAlbumDetailModel xr_modelWithJSON:dic];
            [self.detailModel calculateFrameForCells];
        }
        if(completion){
            completion();
        }
    }];
}


#pragma mark - UITableViewDelegate/UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.style == XMLYAlbumDetailStyleDetail) {
        return 3;  //详情
    } else {
        return self.listModel.tracks.list.count + 1;  //节目列表
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.style == XMLYAlbumDetailStyleList) {
        if(indexPath.row == 0) {
            return 40.0f;
        }else{
            return 71.0f;
        }
    }
    
    if(indexPath.row == 0) {
        return self.detailModel.detail.cellHeight;
    }else if(indexPath.row == 1) {
        return self.detailModel.user.cellHeight;
    }else{
        return self.detailModel.recs.cellHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.style == XMLYAlbumDetailStyleDetail) {
        if(indexPath.row == 0) {
            XMLYAlbumDetailCell *cell = [XMLYAlbumDetailCell cellFromClass:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.detailModel.detail;
            return cell;
        }else if(indexPath.row == 1) {
            XMLYAlbumEditIntroCell *cell = [XMLYAlbumEditIntroCell cellFromNib:tableView];
            cell.userModel = self.detailModel.user;
            return cell;
        }else{
            XMLYAlbumAboutRecomCell *cell = [XMLYAlbumAboutRecomCell cellFromClass:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.recsModel = self.detailModel.recs;
            return cell;
        }
    } else {
        if(indexPath.row == 0) {
            XMLYDetaillistHeaderCell *cell = [XMLYDetaillistHeaderCell cellFromNib:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.albumModel = self.listModel.album;
            return cell;
        } else {
            XMLYDetialItemCell *cell = [XMLYDetialItemCell cellFromNib:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.itemModel = self.listModel.tracks.list[indexPath.row - 1];
            return cell;
        }
    }
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    XMLYAlbumDetailSectionView *view = [XMLYAlbumDetailSectionView albumDetailSectionView];
    view.frame = CGRectMake(0, 0, kScreenWidth, 50.0f);
    view.style = self.style;
    view.albumModel = self.listModel.album;
    @weakify(self);
    view.sectionButtonClicBlock = ^(XMLYAlbumDetailSectionView *sectionView, XMLYAlbumDetailStyle style) {
        @strongify(self);
        [self changeDetailStyle:style];
    };
    return view;
}



#pragma mark - getter

//UITableView
- (UITableView *)tableView {
    if(!_tableView) {
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
        tab.delegate = self;
        tab.dataSource = self;
        tab.tableHeaderView = self.headerView;
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;
        tab.backgroundColor = Hex(0xf3f3f3);
        [self.view addSubview:tab];
        [self.view bringSubviewToFront:self.playView];
        _tableView = tab;
    }
    return _tableView;
}

//头部视图
- (XMLYAlbumDetailHeaderView *)headerView {
    if(!_headerView) {
        _headerView = [XMLYAlbumDetailHeaderView albumDetailHeaderViewWithFrame:CGRectMake(0, 0, kScreenWidth, 220)];
    }
    return _headerView;
}

@end
