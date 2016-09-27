//
//  XMLYBaseTableViewCell.m
//  XMLYFM
//
//  Created by East_wu on 16/9/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseTableViewCell.h"

@implementation XMLYBaseTableViewCell

+ (instancetype)cellFromNib:(UITableView *)tableView {
    NSString *identifier = NSStringFromClass(self);
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifier];
    return [tableView dequeueReusableCellWithIdentifier:identifier];
}

+ (instancetype)cellFromClass:(UITableView *)tableView {
    NSString *identifier = NSStringFromClass(self);
    [tableView registerClass:self forCellReuseIdentifier:identifier];
    return [tableView dequeueReusableCellWithIdentifier:identifier];
}


@end
