//
//  XMLYFindCellStyleMore.m
//  XMLYFM
//
//  Created by East_wu on 16/8/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYFindCellStyleMore.h"

@implementation XMLYFindCellStyleMore


+ (instancetype)findCell:(UITableView *)tableView {
    return [self findCellStyleMore:tableView];
}

+ (instancetype)findCellStyleMore:(UITableView *)tableView {
    NSString *identifier = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifier];
    return [tableView dequeueReusableCellWithIdentifier:identifier];
}

@end
