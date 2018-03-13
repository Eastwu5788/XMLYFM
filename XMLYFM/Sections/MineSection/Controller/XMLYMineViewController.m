//
//  XMLYMineViewController.m
//  XMLYFM
//
//  Created by East_wu on 16/8/8.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYMineViewController.h"
#import "XMLYMineHeaderView.h"
#import "SVWebViewController.h"
#import "XMLYSettingController.h"

static NSString *const kFreeTraficURL = @"http://hybrid.ximalaya.com/api/telecom/index?app=iting&device=iPhone&impl=com.gemd.iting&telephone=%28null%29&version=5.4.27";

static NSString *const kMeSubScribe   = @"我的订阅";
static NSString *const kMePlayHistory = @"播放历史";

static NSString *const kMeHasBuy      = @"我的已购";
static NSString *const kMeWallet      = @"我的钱包";

static NSString *const kMeXMLYStore   = @"喜马拉雅商城";
static NSString *const kMeStoreOrder  = @"我的商城订单";
static NSString *const kMeCoupon      = @"我的优惠券";
static NSString *const kMeGameCenter  = @"游戏中心";
static NSString *const kMeSmartDevice = @"智能硬件设备";

static NSString *const kMeFreeTrafic  = @"免流量服务";
static NSString *const kMeFeedBack    = @"意见反馈";
static NSString *const kMeSetting     = @"设置";



@interface XMLYMineViewController () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *titlesArray;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) XMLYMineHeaderView *headerView;
@property (nonatomic, weak)  UIView   *statusBackView;

@end

@implementation XMLYMineViewController {
    BOOL _lightFlag;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Hex(0xf3f3f3);
    self.automaticallyAdjustsScrollViewInsets = NO;
    _lightFlag = YES;
    [self.tableView bringSubviewToFront:self.headerView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if(_lightFlag) {
        return UIStatusBarStyleLightContent;
    }else {
        return UIStatusBarStyleDefault;
    }
}

#pragma mark - Private
/**
 *  跳转到免费流量服务页面
 */
- (void)trans2FreeTraficService {
    SVWebViewController *web = [[SVWebViewController alloc] initWithAddress:kFreeTraficURL];
    web.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:web animated:YES];
}

/**
 *  跳转到设置页面
 */
- (void)trans2SettingController {
    XMLYSettingController *set = [[XMLYSettingController alloc] init];
    set.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:set animated:YES];
}

#pragma mark - UITableViewDelegate/UITableViewdatSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titlesArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *subArr = self.titlesArray[section];
    return subArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *subTextArr = self.titlesArray[indexPath.section];
    NSArray *imgArr = self.imageArray[indexPath.section];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = subTextArr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor colorWithRed:0.00f green:0.00f blue:0.00f alpha:1.00f];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageView.image = [UIImage imageNamed:imgArr[indexPath.row]];
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor = Hex(0xf3f3f3);
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *text = cell.textLabel.text;
    if([text isEqualToString:kMeFreeTrafic]) { //免费流量服务
        [self trans2FreeTraficService];
    }else if([text isEqualToString:kMeSetting]) {
        [self trans2SettingController];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY <= 0) {
        self.headerView.frame = CGRectMake(offsetY / 2.0, offsetY, kScreenWidth - offsetY, 288 - offsetY);
    }
    
    if(offsetY < 200.0f) {
        self.statusBackView.alpha = 0.0f;
        [self setStatusBarStyle:YES];
    }else if(offsetY >= 200.0f && offsetY < 220) {
        CGFloat alpha = (offsetY - 200) / 20.0f;
        [self.view bringSubviewToFront:self.statusBackView];
        self.statusBackView.alpha = alpha;
    } else {
        self.statusBackView.alpha = 1.0f;
        [self.view bringSubviewToFront:self.statusBackView];
        [self setStatusBarStyle:NO];
    }
}

- (void)setStatusBarStyle:(BOOL)isLight {
    if(isLight && _lightFlag == NO) {
        _lightFlag = YES;
        [self setNeedsStatusBarAppearanceUpdate];
    }else if(!isLight && _lightFlag == YES) {
        _lightFlag = NO;
        [self setNeedsStatusBarAppearanceUpdate];
    }
}


#pragma mark - getter

- (UIView *)statusBackView {
    if(!_statusBackView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
        view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.95f];
        [self.view addSubview:view];
        [self.view bringSubviewToFront:view];
        _statusBackView = view;
    }
    return _statusBackView;
}

- (XMLYMineHeaderView *)headerView {
    if(!_headerView) {
        _headerView = [[XMLYMineHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 288)];
        self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 288)];
        [self.tableView addSubview:_headerView];
    }
    return _headerView;
}

- (NSArray *)titlesArray {
    if(!_titlesArray) {
        _titlesArray = @[@[kMeSubScribe,kMePlayHistory],
                         @[kMeHasBuy,kMeWallet],
                         @[kMeXMLYStore,kMeStoreOrder,kMeCoupon,kMeGameCenter,kMeSmartDevice],
                         @[kMeFreeTrafic,kMeFeedBack,kMeSetting]
                        ];
    }
    return _titlesArray;
}

- (NSArray *)imageArray {
    if(!_imageArray) {
        _imageArray = @[@[@"me_setting_favAlbum",@"me_setting_playhis"],
                        @[@"me_setting_boughttracks",@"me_setting_account"],
                        @[@"me_setting_store",@"me_setting_myorder",@"me_setting_coupon",@"me_setting_game",@"me_setting_device"],
                        @[@"me_setting_union",@"me_setting_feedback",@"me_setting_setting"]];
    }
    return _imageArray;
}


- (UITableView *)tableView {
    if(!_tableView) {
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height - kTabBarHeight)
                                                        style:UITableViewStyleGrouped];
        tab.delegate = self;
        tab.dataSource = self;
        tab.backgroundColor = Hex(0xf3f3f3);
        [self.view addSubview:tab];
        _tableView = tab;
    }
    return _tableView;
}

@end
