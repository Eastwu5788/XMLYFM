//
//  XMLYDownVoiceController.m
//  XMLYFM
//
//  Created by East_wu on 16/9/9.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYDownVoiceController.h"
#import "UIScrollView+EmptyDataSet.h"
#import "XMLYDownloadDBHelper.h"
#import "XMLYDownloadManager.h"
#import "XMLYDownloadCell.h"
#import "XMLYBaseNavigationController.h"
#import "XMLYPlayViewController.h"
#import "Masonry.h"

@interface XMLYDownVoiceController () <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation XMLYDownVoiceController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Hex(0xf3f3f3);
    
    [self configEmptyStatus];
}

- (void)configEmptyStatus {
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadDownloadVoiceHistory];
}

- (void)loadDownloadVoiceHistory {
    NSArray *tracks = [[XMLYDownloadDBHelper helper] queryTracksFromDownloadHistory];
    self.dataSource = [[NSMutableArray alloc] init];
    for(NSNumber *number in tracks){
        XMLYAlbumTrackItemModel *model = [[XMLYDownloadManager manager] taskModelTrackFromAlbumID:number.integerValue];
        [self.dataSource addObject:model];
    }
    [self.tableView reloadData];
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
    return 117.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMLYDownloadCell *cell = [XMLYDownloadCell cellFromNib:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.trackModel = self.dataSource[indexPath.row];
    [cell hideProgressView];
    return cell;
}


// 播放本地音频
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XMLYAlbumTrackItemModel *model = self.dataSource[indexPath.row];
    XMLYPlayViewController *view = [XMLYPlayViewController playViewController];
    XMLYBaseNavigationController *nav = [[XMLYBaseNavigationController alloc] initWithRootViewController:view];
    [view startPlayLocalAudioWithTrackModel:model];
    [self presentViewController:nav animated:YES completion:nil];
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
