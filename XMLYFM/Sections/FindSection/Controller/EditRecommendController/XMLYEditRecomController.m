//
//  XMLYEditRecomController.m
//  XMLYFM
//
//  Created by East_wu on 16/9/11.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYEditRecomController.h"
#import "XMLYEditRecomModel.h"
#import "XMLYScribeRecomCell.h"
#import "XMLYEditRecomAPI.h"

@interface XMLYEditRecomController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) XMLYEditRecomModel *model;

@end

@implementation XMLYEditRecomController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"小编推荐";
    [self requestEditRecommend:0];
}


#pragma mark - HTTP 
- (void)requestEditRecommend:(NSInteger)page {
    [XMLYEditRecomAPI requestEditRecomWithPage:page completion:^(id response, NSString *message, BOOL success) {
        if(success) {
            self.model = [XMLYEditRecomModel xr_modelWithJSON:response];
            [self.model calculateFrameForItems];
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - UITableViewDelegate/UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMLYEditRecomItemModel *model = self.model.list[indexPath.row];
    return model.cellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMLYEditRecomItemModel *model = self.model.list[indexPath.row];
    XMLYScribeRecomCell *cell = [XMLYScribeRecomCell scribeRecomCell:tableView];
    cell.editRecomModel = model;
    return cell;
}



#pragma mark - getter

- (UITableView *)tableView {
    if(!_tableView) {
        UITableView *tab = [[UITableView alloc] initWithFrame:self.view.bounds];
        tab.delegate = self;
        tab.dataSource = self;
        tab.backgroundColor = Hex(0xf3f3f3);
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tab];
        [self.view bringSubviewToFront:self.playView];
        _tableView = tab;
    }
    return _tableView;
}


@end
