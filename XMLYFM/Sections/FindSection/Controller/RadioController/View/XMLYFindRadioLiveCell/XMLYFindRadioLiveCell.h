//
//  XMLYFindRadioLiveCell.h
//  XMLYFM
//
//  Created by East_wu on 16/9/7.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLYFindRadioViewModel.h"

@interface XMLYFindRadioLiveCell : UITableViewCell

@property (nonatomic, strong) XMLYFindRadioInfoModel *liveInfoModel;

+ (instancetype)findRadioLiveCell:(UITableView *)tableView;

@end
