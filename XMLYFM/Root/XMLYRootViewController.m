//
//  XMLYRootViewController.m
//  XMLYFM
//
//  Created by East_wu on 16/8/8.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYRootViewController.h"

#define kStoryBoardFind         @"Find"
#define kStoryBoardSubScribe    @"SubScribe"
#define kStoryBoardPlay         @"Play"
#define kStoryBoardDownLoad     @"DownLoad"
#define kStoryBoardMine         @"Mine"

@interface XMLYRootViewController ()

// 正常图片数组
@property (nonatomic, strong) NSMutableArray *normalImageArray;

//选中状态下的图片数组
@property (nonatomic, strong) NSMutableArray *selectedImageArray;

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
            btn.frame = CGRectMake(kScreenWidth / 2.0 - kTabBarHeight / 2.0 - 5 , -10, kTabBarHeight + 10, kTabBarHeight + 10);
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
    
    UIButton *playBtn = [self.bgImageView viewWithTag:102];
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar_np_shadow"]];
    CGFloat btnW = playBtn.frame.size.width + 6;
    img.frame = CGRectMake( -3 , -3, btnW , btnW * 13.0f / 15.0f);
    [playBtn addSubview:img];
    
    [self tabBarItemSelected:[self.bgImageView viewWithTag:100]];
}




- (void)tabBarItemSelected:(UIButton *)btn {
    btn.selected = YES;
    self.selectedIndex = btn.tag - 100;
    btn.userInteractionEnabled = NO;
    for(UIButton *sbtn in self.bgImageView.subviews) {
        if(sbtn.tag == btn.tag) {
            continue;
        }
        sbtn.selected = NO;
        sbtn.userInteractionEnabled = YES;
    }
}


- (void)configSubControllers {
    self.tabBar.hidden = YES;
    
    UINavigationController *findNav = [self navigationControllerWithIdentifier:kStoryBoardFind];
    UINavigationController *subScrNav = [self navigationControllerWithIdentifier:kStoryBoardSubScribe];
    UINavigationController *playNav = [self navigationControllerWithIdentifier:kStoryBoardPlay];
    UINavigationController *downNav = [self navigationControllerWithIdentifier:kStoryBoardDownLoad];
    UINavigationController *meNav   = [self navigationControllerWithIdentifier:kStoryBoardMine];
    
    self.viewControllers = @[findNav,subScrNav,playNav,downNav,meNav];
}


/**
 *  根据StoryBoard的名称生成控制器
 */
- (UINavigationController *)navigationControllerWithIdentifier:(NSString *)identifier {
    UINavigationController *nav = [[UIStoryboard storyboardWithName:identifier bundle:nil] instantiateInitialViewController];
    return nav;
}


#pragma mark - getter


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
