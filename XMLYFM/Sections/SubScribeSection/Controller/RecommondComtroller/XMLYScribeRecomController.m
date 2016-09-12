//
//  XMLYScribeRecomController.m
//  XMLYFM
//
//  Created by East_wu on 16/9/9.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYScribeRecomController.h"
#import "XMLYScribeRecomModel.h"
#import "XMLYScribeRecomAPI.h"
#import "XMLYScribeREcomCell.h"
#import "XMLYAlbumDetailController.h"
#import "Masonry.h"

@interface XMLYScribeRecomController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) XMLYScribeRecomModel *model;
@end

@implementation XMLYScribeRecomController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Hex(0xf3f3f3);
    [self requestDataSourceWithPage:1];
}



#pragma mark - HTTPRequest
- (void)requestDataSourceWithPage:(NSInteger)page {
    [XMLYScribeRecomAPI requestScribeRecomData:page completion:^(id response, NSString *message, BOOL success) {
        if(success && [response isKindOfClass:[NSDictionary class]]) {
            self.model = [XMLYScribeRecomModel xr_modelWithDictionary:(NSDictionary *)response[@"data"]];
            [self.model calculateFrameForItems];
            [self.tableView reloadData];
        }
    }];
}


#pragma makr - UITableViewDelegate/UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMLYScribeRecomItemModel *itemModel = [self.model.list objectAtIndex:indexPath.row];
    return itemModel.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMLYScribeRecomItemModel *itemModel = [self.model.list objectAtIndex:indexPath.row];
    XMLYScribeRecomCell *cell = [XMLYScribeRecomCell scribeRecomCell:tableView];
    cell.model = itemModel;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XMLYAlbumDetailController *album = [[XMLYAlbumDetailController alloc] init];
    album.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:album animated:YES];
}

#pragma mark - UITableVeiw 

- (UITableView *)tableView {
    if(!_tableView) {
        UITableView *tab = [[UITableView alloc] init];
        tab.delegate = self;
        tab.dataSource = self;
        tab.backgroundColor = self.view.backgroundColor;
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tab];
        _tableView =tab;
        [tab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
    }
    return _tableView;
}

@end
