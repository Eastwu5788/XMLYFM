//
//  XMLYScribeHistoryController.m
//  XMLYFM
//
//  Created by East_wu on 16/9/9.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYScribeHistoryController.h"
#import "UIScrollView+EmptyDataSet.h"
#import "XMLYBaseAudioModel.h"
#import "XMLYPlayDBHelper.h"
#import "XMLYAudioHistoryCell.h"
#import "XMLYAudioHistoryHeaderView.h"
#import "XMLYPlayViewController.h"
#import "XMLYBaseNavigationController.h"
#import "Masonry.h"

@interface XMLYScribeHistoryController () <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray    *dataSource;
@property (nonatomic, strong) XMLYAudioHistoryHeaderView    *headerView;

@end

@implementation XMLYScribeHistoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Hex(0xf3f3f3);
    [self configEmptyStatus];
    [self queryHistoryFromDB];
}

- (void)configEmptyStatus {
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
}

// 从数据库中查找播放记录
- (void)queryHistoryFromDB {
    self.dataSource = [[XMLYPlayDBHelper dbHelper] queryPlayHistory];
    [self.tableView reloadData];
}

#pragma mark - DZNEmptyDataSetSource/DZNEmptyDataSetDelegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"noData_play_history"];
}



#pragma mark - UITableViewDelegate/UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 103.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMLYAudioHistoryCell *cell = [XMLYAudioHistoryCell cellFromNib:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.audioModel = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XMLYBaseAudioModel *model = self.dataSource[indexPath.row];
    
    XMLYPlayViewController *controller = [XMLYPlayViewController playViewController];
    controller.progress = model.time_history;
    [controller startPlayWithAlbumID:model.album_id trackID:model.track_id cachePath:model.cachePath];
    XMLYBaseNavigationController *nav = [[XMLYBaseNavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - UITableView

- (XMLYAudioHistoryHeaderView *)headerView {
    if(!_headerView) {
        XMLYAudioHistoryHeaderView *head = [[XMLYAudioHistoryHeaderView alloc] init];
        head.frame = CGRectMake(0, 0, kScreenWidth, 44);
        [self.view addSubview:head];
        _headerView = head;
    }
    return _headerView;
}

- (UITableView *)tableView {
    if(!_tableView) {
        UITableView *tab = [[UITableView alloc] init];
        tab.delegate = self;
        tab.dataSource = self;
        tab.backgroundColor = Hex(0xf3f3f3);
        tab.tableHeaderView = [self headerView];
        tab.tableFooterView = [UIView new];
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tab];
        _tableView = tab;
        [tab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
    }
    return _tableView;
}


@end
