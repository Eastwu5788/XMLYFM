//
//  XMLYAlbumDetailView.m
//  XMLYFM
//
//  Created by East_wu on 16/9/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYAlbumDetailView.h"

static NSInteger const kSectionIntro  = 0; //内容简介
static NSInteger const kSectionEditor = 1; //主播介绍
static NSInteger const kSectionAlbum  = 2; //专辑标签
static NSInteger const kSectionAbout  = 3; //相关推荐

@interface XMLYAlbumDetailView () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation XMLYAlbumDetailView

+ (instancetype)albumDetailViewWithFrame:(CGRect)frame {
    return [[self alloc] initAlbumDetailViewWithFrame:frame];
}

- (instancetype)initAlbumDetailViewWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self tableView];
    return self;
}

#pragma mark  - UITableViewDelegate/UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == kSectionIntro) {
        return 2;
    }else if(section == kSectionEditor || section == kSectionAlbum) {
        return 1;
    }else {
        return 4;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == kSectionIntro && indexPath.row == 0) {
        return 150;
    }else if(indexPath.section == kSectionIntro && indexPath.row == 1) {
        return 45; //查看更多内容
    }else if(indexPath.section == kSectionEditor) {
        return 144.0f;
    }else if(indexPath.section == kSectionAlbum) {
        return 53.0f;
    }else if(indexPath.section == kSectionAbout && indexPath.row == 3) {
        return 45.0f; //查看更多推荐
    }else{
        return 100.0f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"text:%ld",indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10.0f)];
    view.backgroundColor = Hex(0xf3f3f3);
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40.0f)];
    view.backgroundColor = [UIColor blueColor];
    return view;
}




#pragma mark  - UITableView

- (UITableView *)tableView {
    if(!_tableView) {
        UITableView *tab = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        tab.delegate = self;
        tab.dataSource = self;
        _tableView = tab;
        [self addSubview:tab];
    }
    return _tableView;
}

@end
