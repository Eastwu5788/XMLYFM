//
//  XMLYScribeRecomCell.h
//  XMLYFM
//
//  Created by East_wu on 16/9/9.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLYScribeRecomModel.h"

@interface XMLYScribeRecomCell : UITableViewCell

@property (nonatomic, strong) XMLYScribeRecomItemModel *model;

+ (instancetype)scribeRecomCell:(UITableView *)tableView;

@end
