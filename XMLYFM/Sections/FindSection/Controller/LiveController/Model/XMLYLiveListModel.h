//
//  XMLYLiveListModel.h
//  XMLYFM
//
//  Created by East_wu on 16/9/11.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseModel.h"


@interface XMLYLiveListItemModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger chatId;
@property (nonatomic, copy)   NSString  *coverPath;
@property (nonatomic, assign) NSInteger endTs;
@property (nonatomic, assign) NSInteger cid;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, assign) NSInteger onlineCount;
@property (nonatomic, assign) NSInteger playCount;
@property (nonatomic, assign) NSInteger scheduleId;
@property (nonatomic, copy)   NSString  *shortDescription;
@property (nonatomic, assign) NSInteger startTs;
@property (nonatomic, assign) NSInteger status;

@end

@interface XMLYLiveListModel : XMLYBaseModel

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger totalSize;

@end
