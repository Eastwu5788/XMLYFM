//
//  XMLYRootViewController.m
//  XMLYFM
//
//  Created by East_wu on 16/8/8.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYRootViewController.h"
#import "XMLYBaseNavigationController.h"
#import "XMLYPlayViewController.h"

#define kStoryBoardFind         @"Find"
#define kStoryBoardSubScribe    @"SubScribe"
#define kStoryBoardPlay         @"Play"
#define kStoryBoardDownLoad     @"DownLoad"
#define kStoryBoardMine         @"Mine"

@interface XMLYRootViewController () <UITabBarControllerDelegate,UINavigationControllerDelegate>

// 正常图片数组
@property (nonatomic, strong) NSMutableArray *normalImageArray;

//选中状态下的图片数组
@property (nonatomic, strong) NSMutableArray *selectedImageArray;

@property (nonatomic, strong) NSArray *controllerIdentiferArray;

//后方的背景图片
@property (nonatomic, weak)   UIImageView    *bgImageView;

@end

@implementation XMLYRootViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self createCustomeTabBar];
    [self configSubControllers];
}


- (void)createCustomeTabBar {
    //1.隐藏系统Tabbar
    self.tabBar.hidden = YES;
    
    CGFloat width = kScreenWidth / 5.0f;
    
    for(NSInteger index = 0; index < 5; index++ ) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if(index == 2) {
            btn.frame = CGRectMake((kScreenWidth -width-10)/2.0 , -10, width + 10, kTabBarHeight + 10);
            [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_np_normal"] forState:UIControlStateNormal];
        }
        else{
            btn.frame = CGRectMake(width * index, 0, width, kTabBarHeight);
        }

        btn.tag = 100 + index;
        btn.adjustsImageWhenHighlighted = NO;
        [btn setImage:[self.normalImageArray objectAtIndex:index] forState:UIControlStateNormal];
        [btn setImage:[self.selectedImageArray objectAtIndex:index] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(tabBarItemSelected:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.bgImageView addSubview:btn];
    }
    
//    UIButton *playBtn = [self.bgImageView viewWithTag:102];
//    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar_np_shadow"]];
//    CGFloat btnW = playBtn.frame.size.width + 6;
//    img.frame = CGRectMake( -3 , -3, btnW , btnW * 13.0f / 15.0f);
//    [playBtn addSubview:img];
   
    [self tabBarItemSelected:[self.bgImageView viewWithTag:100]];
}


- (void)tabBarItemSelected:(UIButton *)btn {
<<<<<<< HEAD
    btn.selected = YES;
    self.selectedIndex = btn.tag - 100;
    btn.userInteractionEnabled = NO;
    for(UIButton *sbtn in self.bgImageView.subviews) {
        if(sbtn.tag == btn.tag)continue;
        sbtn.selected = NO;
        sbtn.userInteractionEnabled = YES;
    }
=======
   btn.selected = YES;
   btn.userInteractionEnabled = NO;
   for(UIButton *sbtn in self.bgImageView.subviews) {
      if(sbtn.tag == btn.tag) {
         continue;
      }
      sbtn.selected = NO;
      sbtn.userInteractionEnabled = YES;
   }
   if([self versionTabBarSelectedIndex:btn.tag - 100]) {
      self.selectedIndex = btn.tag - 100;
   }else{
      btn.selected = NO;
      btn.userInteractionEnabled = YES;
   }
>>>>>>> Eastwu5788/master
}


- (void)configSubControllers {
   
    NSMutableArray *arr = [NSMutableArray new];
    [self.controllerIdentiferArray enumerateObjectsUsingBlock:^(NSString *identifier, NSUInteger idx, BOOL * _Nonnull stop) {
        XMLYBaseNavigationController *navi = [self navigationControllerWithIdentifier:identifier];
        navi.delegate = self;
        [arr addObject:navi];
    }];
    
    self.viewControllers = arr;
}


/**
 *  根据StoryBoard的名称生成控制器
 */
- (XMLYBaseNavigationController *)navigationControllerWithIdentifier:(NSString *)identifier {
    XMLYBaseNavigationController *nav = [[UIStoryboard storyboardWithName:identifier bundle:nil] instantiateInitialViewController];
    return nav;
}



#pragma mark - UITabBarControllerDelegate



- (BOOL)versionTabBarSelectedIndex:(NSInteger)index {
   if(index == 2) {
      XMLYPlayViewController *con = [XMLYPlayViewController playViewController];
      XMLYBaseNavigationController *navi = [[XMLYBaseNavigationController alloc] initWithRootViewController:con];
      [self presentViewController:navi animated:YES completion:nil];
      return NO;
   }
   return YES;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (viewController.hidesBottomBarWhenPushed) {
        self.bgImageView.hidden = YES;
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.tabBar.hidden = YES;
    if (!viewController.hidesBottomBarWhenPushed) {
        self.bgImageView.hidden = NO;
        
    }
}













#pragma mark - getter

- (NSArray *)controllerIdentiferArray {
    if(!_controllerIdentiferArray) {
        _controllerIdentiferArray = @[kStoryBoardFind,kStoryBoardSubScribe,kStoryBoardPlay,kStoryBoardDownLoad,kStoryBoardMine];
    }
    return _controllerIdentiferArray;
}

/**
 *  选中的图片
 */
- (NSMutableArray *)selectedImageArray {
    if(!_selectedImageArray) {
        _selectedImageArray = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"tabbar_find_h"],
                                                                      [UIImage imageNamed:@"tabbar_sound_h"],
                                                                      [UIImage imageNamed:@"tabbar_np_playnon"],
                                                                      [UIImage imageNamed:@"tabbar_download_h"],
                                                                      [UIImage imageNamed:@"tabbar_me_h"], nil];
    }
    return _selectedImageArray;
}


/**
 *  正常的图片
 */
- (NSMutableArray *)normalImageArray {
    if(!_normalImageArray) {
        _normalImageArray = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"tabbar_find_n"],
                                                                    [UIImage imageNamed:@"tabbar_sound_n"],
                                                                    [UIImage imageNamed:@"tabbar_np_playnon"],
                                                                    [UIImage imageNamed:@"tabbar_download_n"],
                                                                    [UIImage imageNamed:@"tabbar_me_n"],nil];
    }
    return _normalImageArray;
}


/**
 *  加载tabBar后方的背景视图
 */
- (UIImageView *)bgImageView {
    if(!_bgImageView) {
        UIImageView *img = [[UIImageView alloc] init];
        img.frame = CGRectMake(0, kScreenHeight - kTabBarHeight, kScreenWidth, kTabBarHeight);
        img.image = [UIImage imageNamed:@"tabbar_bg"];
        img.userInteractionEnabled = YES;
        [self.view addSubview:img];
        _bgImageView = img;
    }
    return _bgImageView;
}



@end
