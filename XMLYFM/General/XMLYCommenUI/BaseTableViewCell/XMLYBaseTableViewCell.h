//
//  XMLYBaseTableViewCell.h
//  XMLYFM
//
//  Created by East_wu on 16/9/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMLYBaseTableViewCell : UITableViewCell

+ (instancetype)cellFromNib:(UITableView *)tableView;
+ (instancetype)cellFromClass:(UITableView *)tableView;

@end
