//
//  XMLYFindRadioController.m
//  XMLYFM
//
//  Created by East_wu on 16/8/10.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYFindRadioController.h"
#import "XMLYFindRadioViewModel.h"
#import "XMLYFindRadioLiveCell.h"
#import "XMLYFindRadioTelCell.h"
#import "XMLYRadioSectionHeaderView.h"


static NSInteger kSectionTel   = 0;  //电台section


static force_inline XMLYRadioSectionHeaderViewStyle XMLYGetSectionHeaderStyle(NSInteger section) {
    switch (section) {
        case 1: return XMLYRadioSectionHeaderViewStyleLocal;
        case 2: return XMLYRadioSectionHeaderViewStyleTop;
        default: return XMLYRadioSectionHeaderViewStyleHistory;
    }
}

@interface XMLYFindRadioController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) XMLYFindRadioViewModel *viewModel;

@end

@implementation XMLYFindRadioController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Hex(0xf3f3f3);
    [self configSignal];
}

- (void)configSignal {
    @weakify(self);
    [self.viewModel.updateContentSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
    [self.viewModel refreshDataSource];
}

#pragma mark - Private

- (void)userClickShowMoreOrHiddenBun {
    if( self.viewModel.model.style == XMLYFindRadioTelCellStyleHidden ) {
        self.viewModel.model.style = XMLYFindRadioTelCellStyleShow;
    }
    else {
        self.viewModel.model.style = XMLYFindRadioTelCellStyleHidden;
    }
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}

#pragma mark - UITableViewDelegate/UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfRowsInSection:section];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel heightForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self.viewModel heightForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [self.viewModel heightForFooterInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    @weakify(self);
    if(indexPath.section == kSectionTel) {
        XMLYFindRadioTelCell *cell = [XMLYFindRadioTelCell findRadioTelCell:tableView];
        cell.model = self.viewModel.model;
        cell.showMoreOrHiddenBlock = ^(XMLYFindRadioTelCell *blockCell) {
            @strongify(self);
            [self userClickShowMoreOrHiddenBun];
        };
        return cell;
    }
    
    XMLYFindRadioLiveCell *cell = [XMLYFindRadioLiveCell findRadioLiveCell:tableView];
    cell.liveInfoModel = [self.viewModel infoModelForCellAtIndexPath:indexPath];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section == kSectionTel) return nil;
    XMLYRadioSectionHeaderViewStyle style = XMLYGetSectionHeaderStyle(section);
    XMLYRadioSectionHeaderView *view = [XMLYRadioSectionHeaderView radioSectionHeaderViewWithSection:style location:self.viewModel.model.location];
    view.frame = CGRectMake(0, 0, kScreenWidth, 44);
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor = Hex(0xf3f3f3);
    return view;
}


#pragma mark - getter 

- (XMLYFindRadioViewModel *)viewModel {
    if(!_viewModel) {
        _viewModel = [[XMLYFindRadioViewModel alloc] init];
    }
    return _viewModel;
}


/**
 *  加载UITableView
 */
- (UITableView *)tableView {
    if(!_tableView) {
        UITableView *tab = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        tab.delegate = self;
        tab.dataSource = self;
        tab.backgroundColor = [UIColor whiteColor];
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tab];
        _tableView = tab;
    }
    return _tableView;
}



@end
