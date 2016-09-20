//
//  XMLYDownAlbumController.m
//  XMLYFM
//
//  Created by East_wu on 16/9/9.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYDownAlbumController.h"
#import "UIScrollView+EmptyDataSet.h"
#import "XMLYDownloadDBHelper.h"
#import "XMLYDownloadManager.h"
#import "XMLYDownAlbumCell.h"
#import "Masonry.h"

@interface XMLYDownAlbumController () <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray    *dataSource;

@end

@implementation XMLYDownAlbumController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Hex(0xf3f3f3);
    [self configEmptyStatus];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadDataSourceFromDB];
}

- (void)loadDataSourceFromDB {
    NSArray *arr = [[XMLYDownloadDBHelper helper] queryAlbumsFromDownloadHistory];
    self.dataSource = [[NSMutableArray alloc] init];
    for(NSNumber *number in arr) {
        XMLYAlbumModel *model = [[XMLYDownloadManager manager] taskModelAlbumFromAlbumID:number.integerValue];
        model.downloadSize = [self totalSizeOfAlbum:model.albumId];
        [self.dataSource addObject:model];
    }
    [self.tableView reloadData];
}

/*
 * 从album中计算所有的下载的track的大小
 */
- (int64_t)totalSizeOfAlbum:(NSInteger)album_id {
    NSArray *track_idArr = [[XMLYDownloadDBHelper helper] queryTrackByAlbumFromDownloadHistory:album_id];
    int64_t size = 0;
    for(NSNumber *number in track_idArr) {
        XMLYAlbumTrackItemModel *model = [[XMLYDownloadManager manager] taskModelTrackFromAlbumID:number.integerValue];
        size += model.trackSize;
    }
    return size;
}

- (void)configEmptyStatus {
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
}


#pragma mark - DZNEmptyDataSetSource/DZNEmptyDataSetDelegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"noData_download"];
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
    return 85.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMLYDownAlbumCell *cell = [XMLYDownAlbumCell cellFromNib:tableView];
    cell.albumModel = self.dataSource[indexPath.row];
    return cell;
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
