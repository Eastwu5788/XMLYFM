//
//  XMLYFindCellStyleLive.h
//  XMLYFM
//
//  Created by East_wu on 16/8/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLYFindBaseCell.h"
#import "XMLYFindLiveModel.h"

@interface XMLYFindCellStyleLive : XMLYFindBaseCell

@property (nonatomic, strong) XMLYFindLiveModel *liveMoel;

+ (instancetype)findCellStyleLive:(UITableView *)tableView;

@end
