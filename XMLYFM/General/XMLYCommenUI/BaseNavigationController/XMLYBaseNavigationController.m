//
//  XMLYBaseNavigationController.m
//  XMLYFM
//
//  Created by East_wu on 16/8/9.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseNavigationController.h"

@interface XMLYBaseNavigationController ()

@end

@implementation XMLYBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    NSDictionary *attributes = @{NSForegroundColorAttributeName: Hex(0x333333),NSFontAttributeName: [UIFont systemFontOfSize:18]};
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
    [[UINavigationBar appearance] setTintColor:Hex(0x333333)];
    
    UIImage *img = [[UIImage imageNamed:@"btn_back_n"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 18, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-1000, 0) forBarMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:img forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
}



@end
