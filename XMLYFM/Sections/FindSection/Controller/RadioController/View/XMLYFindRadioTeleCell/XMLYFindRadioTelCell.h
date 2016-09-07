//
//  XMLYFindRadioTelCell.h
//  XMLYFM
//
//  Created by East_wu on 16/9/7.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLYFindRadioModel.h"

@interface XMLYFindRadioTelCell : UITableViewCell

@property (nonatomic, strong) XMLYFindRadioModel *model;

@property (nonatomic, copy) void(^showMoreOrHiddenBlock)(XMLYFindRadioTelCell *cell);

+ (instancetype)findRadioTelCell:(UITableView *)tableView;

@end
