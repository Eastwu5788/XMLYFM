//
//  XMLYFindCategoryController.m
//  XMLYFM
//
//  Created by East_wu on 16/8/10.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYFindCategoryController.h"
#import "XMLYFindCategoryViewModel.h"
#import "XMLYFindRecomHeader.h"
#import "XMLYFindCategoryCell.h"
#import "Masonry.h"

@interface XMLYFindCategoryController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) XMLYFindCategoryViewModel *viewModel;
@property (nonatomic, strong) XMLYFindRecomHeader       *headerView;
@property (nonatomic, strong) UIView                    *header;

@end

@implementation XMLYFindCategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Hex(0xf3f3f3);
    [self setUpSignal];
}

/**
 *  设置ViewModel的信号量
 */
- (void)setUpSignal {
    @weakify(self);
    [self.viewModel.updateContentSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
        
        self.headerView.discoverModel = self.viewModel.model.discoveryColumns;
        self.headerView.model = self.viewModel.recommendModel.focusImages;
    }];
    [self.viewModel refreshDataSource];
}

#pragma mark - UITableViewDelegate/UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  [self.viewModel numberOfSection];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel heightForRowAtIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMLYFindCategoryCell *cell = [XMLYFindCategoryCell findCategoryCell:tableView];
    cell.leftModel = [self.viewModel itemModelWithIndexPath:indexPath left:YES];
    cell.rightModel = [self.viewModel itemModelWithIndexPath:indexPath left:NO];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section == 0) return nil;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10.0f)];
    view.backgroundColor = Hex(0xf3f3f3);
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self.viewModel heightForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

#pragma mark - getter

- (UIView *)header {
    if(!_header) {
        _header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
        [_header addSubview:self.headerView];
    }
    return _header;
}

- (XMLYFindRecomHeader *)headerView {
    if(!_headerView) {
        _headerView = [XMLYFindRecomHeader findRecomHeader];
        _headerView.frame = CGRectMake(0, 0, kScreenWidth, 250);
    }
    return _headerView;
}



/**
 *  初始化UITableView
 */
- (UITableView *)tableView {
    if(!_tableView) {
        UITableView *tab = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        tab.delegate = self;
        tab.dataSource = self;
        tab.tableHeaderView = [self header];
        tab.backgroundColor = Hex(0xf3f3f3);
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tab];
        _tableView = tab;
    }
    return _tableView;
}

/**
 *  初始化ViewModel
 */
- (XMLYFindCategoryViewModel *)viewModel {
    if(!_viewModel) {
        _viewModel = [[XMLYFindCategoryViewModel alloc] init];
    }
    return _viewModel;
}


@end
