//
//  XMLYFindCategoryCell.h
//  XMLYFM
//
//  Created by East_wu on 16/9/7.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLYCategoryModel.h"

@interface XMLYFindCategoryCell : UITableViewCell

@property (nonatomic, strong) XMLYListItemModel *leftModel;
@property (nonatomic, strong) XMLYListItemModel *rightModel;

+ (instancetype)findCategoryCell:(UITableView *)tableView;

@end
