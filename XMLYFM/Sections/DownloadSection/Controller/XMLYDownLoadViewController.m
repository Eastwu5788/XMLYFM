//
//  XMLYDownLoadViewController.m
//  XMLYFM
//
//  Created by East_wu on 16/8/8.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYDownLoadViewController.h"
#import "XMLYSubScribeNavView.h"
#import "XMLYDownAlbumController.h"
#import "XMLYDownloadingController.h"
#import "XMLYDownVoiceController.h"
#import "YYWebImageManager.h"
#import "YYDiskCache.h"
#import "XMLYSizeHelper.h"
#import "Masonry.h"


/// Free disk space in bytes.
static int64_t XMLYDiskSpaceFree() {
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return -1;
    int64_t space =  [[attrs objectForKey:NSFileSystemFreeSize] longLongValue];
    if (space < 0) space = -1;
    return space;
}





@interface XMLYDownLoadViewController () <UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property (nonatomic, strong) XMLYSubScribeNavView      *navView;
@property (nonatomic, weak)   UIPageViewController      *pageViewController;
@property (nonatomic, strong) NSArray                   *controllers;
@property (nonatomic, weak)   UILabel                   *storageLabel;

@end

@implementation XMLYDownLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Hex(0xf3f3f3);
    [self configSubViews];
}
- (void)configSubViews {
    [self.navigationController.navigationBar addSubview:self.navView];
    
    [self.storageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.view.mas_top);
        make.height.mas_equalTo(25.0f);
    }];
    
    [self.pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.storageLabel.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom).offset(-49);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupStorageCostLabel];
}

- (void)setupStorageCostLabel {
    CGFloat cost = [self totalCostForStorage];
    NSString *free = [XMLYSizeHelper sizeStringFromInt64:XMLYDiskSpaceFree()];
    NSString *title = [NSString stringWithFormat:@"已占用空间%.1fM,可用空间%@",cost,free];
    self.storageLabel.text = title;
}

//当前总使用量
- (CGFloat)totalCostForStorage {
    return ([self sizeForYYWebImage] + [self sizeForVoiceCache]) / (1024.0 * 1024.0);
}

//查找YYWebImage的缓存
- (NSInteger)sizeForYYWebImage {
   return [[YYWebImageManager sharedManager].cache.diskCache totalCost];
}

//查找音频缓存
- (NSInteger)sizeForVoiceCache {
    NSString *localPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    localPath = [localPath stringByAppendingPathComponent:@"XMLYAudioPathCache"];
    
    int64_t size = 0;
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSDirectoryEnumerator *fileEnumer = [manager enumeratorAtPath:localPath];
    for(NSString *fileName in fileEnumer) {
        NSString *filePath = [localPath stringByAppendingPathComponent:fileName];
        NSDictionary *dic = [manager attributesOfItemAtPath:filePath error:nil];
        size += [[dic objectForKey:NSFileSize] longLongValue];
     }
    
    return size;
}


#pragma mark - UIPageViewControllerDelegate/UIPageViewControllerDelegate
/**
 *  当前控制器的上一个控制器
 */
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self indexForViewController:viewController];
    if(index == 0 || index == NSNotFound) {
        return nil;
    }
    return [self.controllers objectAtIndex:index - 1];
}

/**
 *  当前控制器的下一个控制器
 */
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self indexForViewController:viewController];
    if(index == NSNotFound || index == self.controllers.count - 1) {
        return nil;
    }
    return [self.controllers objectAtIndex:index + 1];
}

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed {
    UIViewController *viewController = self.pageViewController.viewControllers[0];
    NSUInteger index = [self indexForViewController:viewController];
    [self.navView transToControllerAtIndex:index];
}

#pragma mark - private
/**
 *  某一个控制器的index
 */
- (NSInteger)indexForViewController:(UIViewController *)controller {
    return [self.controllers indexOfObject:controller];
}


- (void)navigationDidSelectedControllerIndex:(NSInteger)index {
    [self.pageViewController setViewControllers:@[[self.controllers objectAtIndex:index]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

#pragma mark - Getter
/**
 *  加载UIPageViewController
 */
- (UIPageViewController *)pageViewController {
    if(!_pageViewController) {
        UIPageViewController *pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                                                   navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                                                 options:nil];
        [pageViewController willMoveToParentViewController:self];
        pageViewController.delegate = self;
        pageViewController.dataSource = self;
        [self addChildViewController:pageViewController];
        [self.view addSubview:pageViewController.view];
        [pageViewController setViewControllers:@[self.controllers.firstObject]
                                     direction:UIPageViewControllerNavigationDirectionForward
                                      animated:YES
                                    completion:nil];
        _pageViewController = pageViewController;
    }
    return _pageViewController;
}

/**
 *  加载子控制器
 */
- (NSArray *)controllers {
    if(!_controllers) {
        _controllers = @[[[XMLYDownAlbumController alloc] init],
                         [[XMLYDownVoiceController alloc] init],
                         [[XMLYDownloadingController alloc] init]];
    }
    return _controllers;
}


#pragma mark - Getter

- (UILabel *)storageLabel {
    if(!_storageLabel) {
        UILabel *lab = [[UILabel alloc] init];
        lab.textColor = [UIColor whiteColor];
        lab.font = [UIFont systemFontOfSize:10];
        lab.backgroundColor = [UIColor colorWithRed:0.65f green:0.63f blue:0.60f alpha:1.00f];
        lab.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:lab];
        _storageLabel = lab;
    }
    return _storageLabel;
}

- (XMLYSubScribeNavView *)navView {
    if(!_navView) {
        _navView = [XMLYSubScribeNavView subScribeNavViewWithTitles:@[@"专辑",@"声音",@"下载中"]];
        __weak typeof (self) wself = self;
        _navView.subScribeNavViewDidSubClick = ^(XMLYSubScribeNavView *view, NSInteger index) {
            __weak typeof (wself) self = wself;
            [self navigationDidSelectedControllerIndex:index];
        };
    }
    return _navView;
}

@end
