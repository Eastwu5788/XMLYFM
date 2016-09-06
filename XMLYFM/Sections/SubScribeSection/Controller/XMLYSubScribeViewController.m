//
//  XMLYSubScribeViewController.m
//  XMLYFM
//
//  Created by East_wu on 16/8/8.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYSubScribeViewController.h"
#import "XMLYSubScribeNavView.h"

@interface XMLYSubScribeViewController ()

@property (nonatomic, strong) XMLYSubScribeNavView *nav;

@end

@implementation XMLYSubScribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (void)configNavigationView {
    [self.navigationController.navigationBar addSubview:[self nav]];    
}


- (XMLYSubScribeNavView *)nav {
    if(!_nav) {
        _nav = [XMLYSubScribeNavView subScribeNavView];
    }
    return _nav;
}


@end
