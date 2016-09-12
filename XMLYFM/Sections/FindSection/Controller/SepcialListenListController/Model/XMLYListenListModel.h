//
//  XMLYListenListModel.h
//  XMLYFM
//
//  Created by East_wu on 16/9/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseModel.h"
#import "XRModel.h"

@interface XMLYListenItemModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger cid;
@property (nonatomic, assign) NSInteger specialId;
@property (nonatomic, copy)   NSString  *title;
@property (nonatomic, copy)   NSString  *subtitle;
@property (nonatomic, copy)   NSString  *footnote;
@property (nonatomic, assign) NSInteger contentType;
@property (nonatomic, copy)   NSString  *coverPathSmall;
@property (nonatomic, copy)   NSString  *coverPathBig;
@property (nonatomic, assign) NSInteger releasedAt;
@property (nonatomic, assign) BOOL      isHot;

@end

@interface XMLYListenListModel : XMLYBaseModel 

@property (nonatomic, assign) NSInteger ret;
@property (nonatomic, assign) NSInteger maxPageId;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, assign) NSInteger pageId;
@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, copy) NSString *timeStr;

@property (nonatomic, strong) NSMutableArray<XMLYListenItemModel *> *list;

@end
