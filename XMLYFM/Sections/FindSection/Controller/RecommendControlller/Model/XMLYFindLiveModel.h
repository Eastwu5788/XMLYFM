//
//  XMLYFindLiveModel.h
//  XMLYFM
//
//  Created by East_wu on 16/8/10.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseModel.h"

@class XMLYFindLiveDetailModel;

@interface XMLYFindLiveModel : XMLYBaseModel

@property (nonatomic, strong) NSMutableArray<XMLYFindLiveDetailModel *> *data;

@property (nonatomic, assign) NSInteger  ret;

@end


@interface XMLYFindLiveDetailModel : XMLYBaseModel

/**
 *  频道ID
 */
@property (nonatomic, assign) NSInteger chatId;

/**
 *  封面路径
 */
@property (nonatomic, copy)   NSString  *coverPath;

/**
 *  未知参数
 */
@property (nonatomic, assign) NSInteger endTs;

/**
 *  唯一标识
 */
@property (nonatomic, assign) NSInteger cid;

/**
 *  名称
 */
@property (nonatomic, copy)   NSString  *name;

/**
 *  联网数量
 */
@property (nonatomic, assign) NSInteger onlineCount;

/**
 *  播放量
 */
@property (nonatomic, assign) NSInteger playCount;

/**
 *  未知参数
 */
@property (nonatomic, assign) NSInteger scheduleId;

/**
 *  短描述
 */
@property (nonatomic, copy)   NSString  *shortDescription;

@property (nonatomic, assign) NSInteger startTs;
@property (nonatomic, assign) NSInteger status;

@end
