//
//  XMLYFindRadioController.m
//  XMLYFM
//
//  Created by East_wu on 16/8/10.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYFindRadioController.h"
#import "XMLYFindRadioViewModel.h"

@interface XMLYFindRadioController ()

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) XMLYFindRadioViewModel *viewModel;

@end

@implementation XMLYFindRadioController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Hex(0xf3f3f3);
    
    
}



@end
