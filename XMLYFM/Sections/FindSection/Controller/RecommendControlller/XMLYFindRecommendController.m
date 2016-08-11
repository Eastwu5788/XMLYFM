//
//  XMLYFindRecommendController.m
//  XMLYFM
//
//  Created by East_wu on 16/8/10.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYFindRecommendController.h"
#import "ReactiveCocoa.h"
#import "Masonry.h"
#import "XMLYFindRecomViewModel.h"

@interface XMLYFindRecommendController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView              *tableView;

@property (nonatomic, strong) XMLYFindRecomViewModel *viewModel;

@end

@implementation XMLYFindRecommendController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
    @weakify(self);
    [self.viewModel.updateContentSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
    
    [self.viewModel refreshDataSource];
}



#pragma mark - UITableViewDelegate/UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfItemsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[UITableViewCell alloc] init];
}


#pragma mark - UITableView

- (UITableView *)tableView {
    if(!_tableView) {
        UITableView *tab = [[UITableView alloc] init];
        tab.delegate = self;
        tab.dataSource = self;
        [self.view addSubview:tab];
        [tab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
    }
    return _tableView;
}

- (XMLYFindRecomViewModel *)viewModel {
    if(!_viewModel) {
        _viewModel = [[XMLYFindRecomViewModel alloc] init];
    }
    return _viewModel;
}


@end
