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

@class XMLYFindCellStyleLive;

@protocol XMLYFindCellStyleLiveDelegate <NSObject>

- (void)findCellStyleLiveCell:(XMLYFindCellStyleLive *)cell didMoreButtonClick:(XMLYFindLiveModel *)model;

@end

@interface XMLYFindCellStyleLive : XMLYFindBaseCell

@property (nonatomic, strong) XMLYFindLiveModel *liveMoel;

@property (nonatomic, weak) __weak id<XMLYFindCellStyleLiveDelegate> delegate;

+ (instancetype)findCellStyleLive:(UITableView *)tableView;

@end
