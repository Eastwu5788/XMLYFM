//
//  XMLYDownloadCell.h
//  XMLYFM
//
//  Created by East_wu on 16/9/20.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseTableViewCell.h"
#import "XMLYDownTaskModel.h"

@interface XMLYDownloadCell : XMLYBaseTableViewCell

@property (nonatomic, strong) XMLYDownTaskModel *model;

@property (nonatomic, strong) XMLYAlbumTrackItemModel *trackModel;

- (void)hideProgressView;

- (void)refreshProgress:(NSInteger)download expected:(NSInteger)expected;

@end
