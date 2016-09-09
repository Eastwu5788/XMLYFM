//
//  XMLYFindRankModel.h
//  XMLYFM
//
//  Created by East_wu on 16/9/8.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseModel.h"
#import "XMLYFIndRecommendModel.h"
#import "XRModel.h"


@interface XMLYFindRankItemModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger cid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *contentType;

@end

@interface XMLYFindRankDetailModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger ret;
@property (nonatomic, assign) NSInteger maxPageId;
@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, assign) NSInteger pageId;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, strong) NSMutableArray    *list;
@property (nonatomic, assign) NSInteger rankingListId;
@property (nonatomic, copy)   NSString  *coverPath;
@property (nonatomic, copy)   NSString  *title;
@property (nonatomic, copy)   NSString  *subtitle;
@property (nonatomic, copy)   NSString  *key;
@property (nonatomic, assign) NSInteger orderNum;
@property (nonatomic, copy)   NSString  *countryType;
@property (nonatomic, copy)   NSString  *rankingRuleRule;
@property (nonatomic, assign) NSInteger period;
@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, assign) NSInteger firstId;
@property (nonatomic, copy)   NSString  *firstTitle;
@property (nonatomic, copy)   NSString  *calcPeriod;
@property (nonatomic, assign) NSInteger top;
@property (nonatomic, strong) NSMutableArray<XMLYFindRankItemModel *> *firstKResults;



@end

@interface XMLYFindRankListModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger ret;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, copy) NSString  *title;
@property (nonatomic, strong) NSMutableArray<XMLYFindRankDetailModel *> *list;

@end

@interface XMLYFindRankModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger ret;
//二维数组，榜单->榜单列表
@property (nonatomic, strong) NSMutableArray<XMLYFindRankListModel *> *datas;

@property (nonatomic, strong) XMLYFindFocusImagesModel *focusImages;

@property (nonatomic, copy)   NSString *msg;

@end
