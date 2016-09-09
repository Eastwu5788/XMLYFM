//
//  XMLYFindRadioLiveCell.h
//  XMLYFM
//
//  Created by East_wu on 16/9/7.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLYFindRadioViewModel.h"
#import "XMLYFindRankModel.h"

/**
 *  很多地方都用到了这个Cell，以后会专门抽出来封装一下
 */

@interface XMLYFindRadioLiveCell : UITableViewCell

@property (nonatomic, strong) XMLYFindRadioInfoModel *liveInfoModel;

@property (nonatomic, strong) XMLYFindRankDetailModel *rankDetailModel;

+ (instancetype)findRadioLiveCell:(UITableView *)tableView;

@end
