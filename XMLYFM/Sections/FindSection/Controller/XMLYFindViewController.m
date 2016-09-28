//
//  XMLYFindViewController.m
//  XMLYFM
//
//  Created by East_wu on 16/8/8.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYFindViewController.h"
#import "XMLYFindSubTitleView.h"
#import "Masonry.h"
#import "XMLYFindBaseController.h"
#import "XMLYSubFindFactory.h"

#define kXMLYBGGray [UIColor colorWithRed:0.92f green:0.93f blue:0.93f alpha:1.00f]

@interface XMLYFindViewController () <UIPageViewControllerDelegate,UIPageViewControllerDataSource,XMLYFindSubTitleViewDelegate>

@property (weak, nonatomic) IBOutlet XMLYFindSubTitleView *subTitleView;

@property (nonatomic, strong) NSMutableArray     *subTitleArray;

@property (nonatomic, strong) NSMutableArray     *controllers;

@property (nonatomic, weak) UIPageViewController *pageViewController;

@end

@implementation XMLYFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kXMLYBGGray;
    self.subTitleView.delegate = self;
    self.subTitleView.titleArray = self.subTitleArray;
    [self configSubViews];
}

- (void)configSubViews {
    [self.pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.subTitleView.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom).offset(-49);
    }];
}

#pragma mark - XMLYFindSubTitleViewDelegate
- (void)findSubTitleViewDidSelected:(XMLYFindSubTitleView *)titleView atIndex:(NSInteger)index title:(NSString *)title {
    [self.pageViewController setViewControllers:@[[self.controllers objectAtIndex:index]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}


#pragma mark - UIPageViewControllerDelegate/UIPageViewControllerDataSource 

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self indexForViewController:viewController];
    if(index == 0 || index == NSNotFound) {
        return nil;
    }
    return [self.controllers objectAtIndex:index - 1];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self indexForViewController:viewController];
    if(index == NSNotFound || index == self.controllers.count - 1) {
        return nil;
    }
    return [self.controllers objectAtIndex:index + 1];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return self.controllers.count;
}



- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    UIViewController *viewController = self.pageViewController.viewControllers[0];
    NSUInteger index = [self indexForViewController:viewController];
    [self.subTitleView trans2ShowAtIndex:index];
}



#pragma mark - private

- (NSInteger)indexForViewController:(UIViewController *)controller {
    return [self.controllers indexOfObject:controller];
}


#pragma mark - getter

- (UIPageViewController *)pageViewController {
    if(!_pageViewController) {
    
        UIPageViewController *page = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        page.delegate = self;
        page.dataSource = self;
        [page setViewControllers:@[[self.controllers firstObject]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        [self addChildViewController:page];
        [self.view addSubview:page.view];
        _pageViewController = page;
    }
    return _pageViewController;
}

- (NSMutableArray *)controllers {
    if(!_controllers) {
        _controllers = [[NSMutableArray alloc] init];
        for(NSString *title in self.subTitleArray) {
            XMLYFindBaseController *con = [XMLYSubFindFactory subFindControllerWithIdentifier:title];
            [_controllers addObject:con];
        }
    }
    return _controllers;
}


/**
 *  分类标题数组
 */
- (NSMutableArray *)subTitleArray {
    if(!_subTitleArray) {
        _subTitleArray = [[NSMutableArray alloc] initWithObjects:@"推荐",@"分类",@"广播",@"榜单",@"主播",@"测试",nil];
    }
    return _subTitleArray;
}


@end
