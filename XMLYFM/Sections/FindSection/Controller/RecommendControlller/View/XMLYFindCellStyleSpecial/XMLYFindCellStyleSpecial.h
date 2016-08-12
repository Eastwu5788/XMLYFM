//
//  XMLYFindCellStyleSpecial.h
//  XMLYFM
//
//  Created by East_wu on 16/8/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLYFindBaseCell.h"
#import "XMLYFindRecommendModel.h"

@interface XMLYFindCellStyleSpecial : XMLYFindBaseCell

@property (nonatomic, strong) XMLYSpecialColumnModel *specialModel;

+ (instancetype)findCellStyleSpecial:(UITableView *)tableView;

@end
