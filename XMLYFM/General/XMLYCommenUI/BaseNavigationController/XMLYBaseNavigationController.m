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
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName: Hex(0x333333),NSFontAttributeName: [UIFont systemFontOfSize:18]};
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
    [[UINavigationBar appearance] setTintColor:Hex(0x333333)];
}



@end
