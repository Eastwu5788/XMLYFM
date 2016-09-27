//
//  XMLYDownloadingController.m
//  XMLYFM
//
//  Created by East_wu on 16/9/9.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYDownloadingController.h"
#import "UIScrollView+EmptyDataSet.h"
#import "XMLYDownloadManager.h"
#import "XMLYDownloadCell.h"
#import "Masonry.h"

@interface XMLYDownloadingController () <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,XMLYDownloadManagerDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end


@implementation XMLYDownloadingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Hex(0xf3f3f3);
    
    [self configEmptyStatus];
    [XMLYDownloadManager manager].delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.dataSource = [[XMLYDownloadManager manager] downloadTasks];
    [self.tableView reloadData];
}

- (void)configEmptyStatus {
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
}


#pragma mark - DZNEmptyDataSetSource/DZNEmptyDataSetDelegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"noData_downloading"];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSString *text = @"去看看";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:13.0f],
                                 NSForegroundColorAttributeName: [UIColor colorWithRed:0.00f green:0.00f blue:0.00f alpha:1.00f],
                                 NSParagraphStyleAttributeName: paragraph,
                                 NSBackgroundColorAttributeName: [UIColor whiteColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}



#pragma mark - UITableViewDelegate/UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 147.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMLYDownTaskModel *model = self.dataSource[indexPath.row];
    XMLYDownloadCell *cell = [XMLYDownloadCell cellFromNib:tableView];
    cell.model = model;
    return cell;
}

#pragma mark - XMLYDownloadManagerDelegate

// 下载进度发生变化的回调
- (void)downloadProgress:(NSInteger)downloaded expected:(NSInteger)expected trackID:(NSInteger)track_id albumID:(NSInteger)album_id {
    NSLog(@"---%ld album_id:%ld downloaded:%ld",track_id,album_id,downloaded);
    if(downloaded == expected) {
        [self removeFinishedCell:track_id];
        return;
    }
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"trackModel.trackId == %ld",track_id];
    NSArray *result = [self.dataSource filteredArrayUsingPredicate:predicate];
    
    if(result.count == 0) return;
    
    XMLYDownTaskModel *model = result.firstObject;
    XMLYDownloadCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[self.dataSource indexOfObject:model] inSection:0]];
    [cell refreshProgress:downloaded expected:expected];
}

// 移除下载完成的cell
- (void)removeFinishedCell:(NSInteger)track_id {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"trackModel.trackId == %ld",track_id];
    NSArray *result = [self.dataSource filteredArrayUsingPredicate:predicate];

    if(result.count == 0) return;
    
    XMLYDownTaskModel *model = result.firstObject;
    NSInteger index = [self.dataSource indexOfObject:model];
    [self.dataSource removeObject:model];
    
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
}

#pragma mark - UITableView

- (UITableView *)tableView {
    if(!_tableView) {
        UITableView *tab = [[UITableView alloc] init];
        tab.delegate = self;
        tab.dataSource = self;
        tab.backgroundColor = Hex(0xf3f3f3);
        tab.tableFooterView = [UIView new];
        [self.view addSubview:tab];
        _tableView = tab;
        [tab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
    }
    return _tableView;
}



@end
