//
//  XMLYSubScribeViewController.m
//  XMLYFM
//
//  Created by East_wu on 16/8/8.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYSubScribeViewController.h"
#import "XMLYScribeRecomController.h"
#import "XMLYScribeMeScrController.h"
#import "XMLYScribeHistoryController.h"
#import "XMLYDownAlbumController.h"
#import "XMLYDownloadingController.h"
#import "XMLYDownVoiceController.h"
#import "XMLYSubScribeNavView.h"
#import "Masonry.h"

@interface XMLYSubScribeViewController () <UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property (nonatomic, strong) XMLYSubScribeNavView *nav;
@property (nonatomic, weak) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSArray            *controllers;

@property (nonatomic, assign) XMLYSubScirbeStyle style;

@end

@implementation XMLYSubScribeViewController


+ (instancetype)subScribeViewController:(XMLYSubScirbeStyle)style {
    return [[self alloc] initSubScribeViewWithStyle:style];
}

- (instancetype)initSubScribeViewWithStyle:(XMLYSubScirbeStyle)style {
    self = [super init];
    self.style = style;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
}

- (void)configSubViews {
    [self.navigationController.navigationBar addSubview:self.nav];

    [self.pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom).offset(-49);
    }];
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
    [self.nav transToControllerAtIndex:index];
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
        if(self.style == XMLYSubScirbeStyleScribe) {
            _controllers = @[[[XMLYScribeRecomController alloc] init],
                             [[XMLYScribeMeScrController alloc] init],
                             [[XMLYScribeHistoryController alloc] init]];
        } else {
            _controllers = @[[[XMLYDownAlbumController alloc] init],
                             [[XMLYDownVoiceController alloc] init],
                             [[XMLYDownloadingController alloc] init]];

        }
    }
    return _controllers;
}

/**
 *  加载导航栏子视图
 */
- (XMLYSubScribeNavView *)nav {
    if(!_nav) {
        NSArray *arr = self.style == XMLYSubScirbeStyleScribe ? @[@"推荐",@"订阅",@"历史"] : @[@"专辑",@"声音",@"下载中"];
        _nav = [XMLYSubScribeNavView subScribeNavViewWithTitles:arr];
        __weak typeof (self) wself = self;
        _nav.subScribeNavViewDidSubClick = ^(XMLYSubScribeNavView *view, NSInteger index) {
            __weak typeof (wself) self = wself;
            [self navigationDidSelectedControllerIndex:index];
        };
    }
    return _nav;
}


@end
