//
//  XMLYFindRankController.m
//  XMLYFM
//
//  Created by East_wu on 16/8/10.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYFindRankController.h"
#import "XMLYRadioSectionHeaderView.h"
#import "XMLYFindRadioLiveCell.h"
#import "XMLYFindRankModel.h"
#import "XMLYFindRankHeaderView.h"
#import "XMLYRankAPI.h"

@interface XMLYFindRankController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) XMLYFindRankModel *model;

@property (nonatomic, strong) XMLYFindRankHeaderView *headerView;

@property (nonatomic, weak) UITableView     *tableView;

@end

@implementation XMLYFindRankController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Hex(0xf3f3f3);
    [self requestRankDetails];
}


#pragma mark - HTTP
/**
 *  请求Rank排行版数据
 */
- (void)requestRankDetails {
    [XMLYRankAPI requestRankresponse:^(id response, NSString *message, BOOL success) {
        if(success) {
            self.model = [XMLYFindRankModel xr_modelWithJSON:response];
            [self.tableView reloadData];
            self.headerView.focosImageModel = self.model.focusImages;
        }
    }];
}


#pragma mark - UITableViewDelegate/UITableViewDataSource 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.model.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    XMLYFindRankListModel *model = self.model.datas[section];
    return model.list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMLYFindRankListModel *listModel = self.model.datas[indexPath.section];
    XMLYFindRadioLiveCell *cell = [XMLYFindRadioLiveCell findRadioLiveCell:tableView];
    cell.rankDetailModel = listModel.list[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    XMLYFindRankListModel *model = self.model.datas[section];
    XMLYRadioSectionHeaderView *view = [XMLYRadioSectionHeaderView sectionHeaderWithModel:model showMore:NO];
    view.frame = CGRectMake(0, 0, kScreenWidth, 40);
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor = Hex(0xf0f0f0);
    return view;
}


#pragma mark - Getter

- (XMLYFindRankHeaderView *)headerView {
    if(!_headerView) {
        _headerView = [XMLYFindRankHeaderView findRankHeaderView];
    }
    return _headerView;
}

- (UITableView *)tableView {
    if(!_tableView) {
        UITableView *tab = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        tab.delegate = self;
        tab.dataSource = self;
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;
        tab.tableHeaderView = [self headerView];
        [self.view addSubview:tab];
        _tableView = tab;
    }
    return _tableView;
}


@end
