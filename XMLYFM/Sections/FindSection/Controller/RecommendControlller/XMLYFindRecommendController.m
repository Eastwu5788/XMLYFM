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
#import "XMLYFindRecommendModel.h"
#import "XMLYFindLiveModel.h"
#import "XMLYFindCellStyleFee.h"
#import "XMLYFindCellFactory.h"
#import "XMLYFindCellStyleLive.h"
#import "XMLYFindCellStyleSpecial.h"
#import "XMLYFindCellStyleMore.h"
#import "XMLYFindRecommendHelper.h"
#import "XMLYFindRecomHeader.h"
#import "XMLYEditRecomController.h"
#import "XMLYLiveListController.h"
#import "XMLYListenListController.h"

#define kSectionEditCommen  0   //小编推荐
#define kSectionLive        1   //现场直播
#define kSectionGuess       2   //猜你喜欢
#define kSectionCityColumn  3   //城市歌单
#define kSectionSpecial     4   //精品听单
#define kSectionAdvertise   5   //推广
#define kSectionHotCommends 6   //热门推荐
#define kSectionMore        7   //更多分类


@interface XMLYFindRecommendController () <UITableViewDelegate,UITableViewDataSource,XMLYFindCellStyleFeeDelegate,XMLYFindCellStyleLiveDelegate,XMLYFindCellStyleSpecialDelegate>

@property (nonatomic, weak) UITableView              *tableView;

@property (nonatomic, strong) XMLYFindRecomViewModel *viewModel;

@property (nonatomic, strong) XMLYFindRecomHeader    *headerView;

@property (nonatomic, strong) UIView                 *header;

@end

@implementation XMLYFindRecommendController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Hex(0xf3f3f3);
    
    @weakify(self);
    [self.viewModel.updateContentSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
       
        self.headerView.model = self.viewModel.recommendModel.focusImages;
        self.headerView.discoverModel = self.viewModel.hotGuessModel.discoveryColumns;
        
        [[XMLYFindRecommendHelper helper] startLiveTimer];
        [[XMLYFindRecommendHelper helper] startHeadTimer];
    }];
    
    [self.viewModel refreshDataSource];
}

- (void)dealloc {
    [[XMLYFindRecommendHelper helper] destoryAllTimer];
}

- (void)trans2EidtRecomController {
    XMLYEditRecomController *editRecom = [[XMLYEditRecomController alloc] init];
    editRecom.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:editRecom animated:YES];
}

#pragma makr - XMLYFindCellStyleFeeDelegate
- (void)findCellStyleFeeCellDidMoreClick:(XMLYFindCellStyleFee *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    switch (indexPath.section) {
        case kSectionEditCommen: {  //小编推荐
            [self trans2EidtRecomController];
        } break;
        default: break;
    }
}

#pragma makr - XMLYFindCellStyleLiveDelegate
- (void)findCellStyleLiveCell:(XMLYFindCellStyleLive *)cell didMoreButtonClick:(XMLYFindLiveModel *)model {
    XMLYLiveListController *con = [[XMLYLiveListController alloc] init];
    con.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:con animated:YES];
}

#pragma mark - XMLYFindCellStyleSpecialDelegate
- (void)findCellStyleSpecial:(XMLYFindCellStyleSpecial *)cell didMoreButtonClickWithModel:(XMLYSpecialColumnModel *)model {
    XMLYListenListController *list = [[XMLYListenListController alloc] init];
    list.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:list animated:YES];
}


#pragma mark - UITableViewDelegate/UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfItemsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == kSectionEditCommen) {
        XMLYFindCellStyleFee *editComm = (XMLYFindCellStyleFee *)[XMLYFindCellFactory createCellByFactory:tableView style:XMLYFindCellStyleFeeStyle];
        editComm.delegate = self;
        editComm.recommendModel = self.viewModel.recommendModel.editorRecommendAlbums;
        editComm.selectionStyle = UITableViewCellSelectionStyleNone;
        return editComm;
    }
    else if(indexPath.section == kSectionLive) {
        if(self.viewModel.liveModel.data.count != 0) {
            XMLYFindCellStyleLive *live = (XMLYFindCellStyleLive *)[XMLYFindCellFactory createCellByFactory:tableView style:XMLYFindCellStyleLiveStyle];
            live.liveMoel = self.viewModel.liveModel;
            live.delegate = self;
            live.selectionStyle = UITableViewCellSelectionStyleNone;
            return live;
        }
        else{
            return [[UITableViewCell alloc] init];
        }
    }
    else if(indexPath.section == kSectionGuess) {
        if(self.viewModel.hotGuessModel.guess.list.count != 0) {
            XMLYFindCellStyleFee *guessCell = (XMLYFindCellStyleFee *)[XMLYFindCellFactory createCellByFactory:tableView style:XMLYFindCellStyleFeeStyle];
            guessCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return guessCell;
        }else{
            return [[UITableViewCell alloc] init];
        }
    }
    else if(indexPath.section == kSectionCityColumn) {
        if(self.viewModel.hotGuessModel.cityColumn.list.count != 0) {
            XMLYFindCellStyleFee *cityCell = (XMLYFindCellStyleFee *)[XMLYFindCellFactory createCellByFactory:tableView style:XMLYFindCellStyleFeeStyle];
            cityCell.selectionStyle = UITableViewCellSelectionStyleNone;
            cityCell.cityColumn = self.viewModel.hotGuessModel.cityColumn;
            return cityCell;
        }else{
            return [[UITableViewCell alloc] init];
        }
    }
    else if(indexPath.section == kSectionSpecial) {
        if(self.viewModel.recommendModel.specialColumn.list != 0) {
            XMLYFindCellStyleSpecial *specialCell = (XMLYFindCellStyleSpecial *)[XMLYFindCellFactory createCellByFactory:tableView style:XMLYFindCellStyleSpecialStyle];
            specialCell.selectionStyle = UITableViewCellSelectionStyleNone;
            specialCell.delegate = self;
            specialCell.specialModel = self.viewModel.recommendModel.specialColumn;
            
            return specialCell;
        }else{
            return [[UITableViewCell alloc] init];
        }
    }
    else if(indexPath.section == kSectionAdvertise) {
        return [[UITableViewCell alloc] init]; //暂时未找到接口
    }
    else if(indexPath.section == kSectionHotCommends) {
        XMLYFindCellStyleFee *guessCell = (XMLYFindCellStyleFee *)[XMLYFindCellFactory createCellByFactory:tableView style:XMLYFindCellStyleFeeStyle];
        guessCell.selectionStyle = UITableViewCellSelectionStyleNone;
        XMLYHotRecommendItemModel *itemModel = [self.viewModel.hotGuessModel.hotRecommends.list objectAtIndex:indexPath.row];
        guessCell.hotRecommedItemModel = itemModel;
        return guessCell;
    }
    else if(indexPath.section == kSectionMore) {
        XMLYFindCellStyleMore *moreCell = (XMLYFindCellStyleMore *)[XMLYFindCellFactory createCellByFactory:tableView style:XMLYFindCellStyleMoreStyle];
        moreCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return moreCell;
    }
    return [[UITableViewCell alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel heightForRowAtIndex:indexPath];
}




#pragma mark - UITableView

- (UITableView *)tableView {
    if(!_tableView) {
        UITableView *tab = [[UITableView alloc] init];
        tab.delegate = self;
        tab.dataSource = self;
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;
        tab.tableHeaderView = [self header];
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


@end
