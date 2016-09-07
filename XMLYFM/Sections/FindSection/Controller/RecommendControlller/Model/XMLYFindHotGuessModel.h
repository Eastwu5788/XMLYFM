//
//  XMLYFindHotGuessModel.h
//  XMLYFM
//
//  Created by East_wu on 16/8/11.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseModel.h"
#import "XMLYFindRecommendModel.h"
#import "XRModel.h"

@class XMLYFindDiscoverProperityModel,XMLYFindDiscoverColumnsModel,XMLYFindDiscoverDetailModel,XMLYFindGuessMode,XMLYCityColumnModel,XMLYHotRecommend,XMLYHotRecommendItemModel;

/**
 *  热门、推荐模型
 */
@interface XMLYFindHotGuessModel : XMLYBaseModel

//
@property (nonatomic, assign) NSInteger ret;

@property (nonatomic, strong) XMLYFindDiscoverColumnsModel *discoveryColumns;

@property (nonatomic, strong) XMLYFindGuessMode            *guess;

@property (nonatomic, strong) XMLYCityColumnModel          *cityColumn;

@property (nonatomic, strong) XMLYHotRecommend             *hotRecommends;

@end

#pragma mark - 发现新奇

@interface XMLYFindDiscoverColumnsModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger         ret;

@property (nonatomic, copy)   NSString          *title;

@property (nonatomic, strong) NSMutableArray<XMLYFindDiscoverDetailModel *>    *list;

@end

@interface XMLYFindDiscoverDetailModel : XMLYBaseModel

@property (nonatomic, copy)   NSString          *title;

@property (nonatomic, copy)   NSString          *subtitle;

@property (nonatomic, copy)   NSString          *coverPath;

@property (nonatomic, copy)   NSString          *contentType;

@property (nonatomic, copy)   NSString          *url;

@property (nonatomic, copy)   NSString          *sharePic;

@property (nonatomic, assign) BOOL              enableShare;

@property (nonatomic, assign) BOOL              isExternalUrl;

@property (nonatomic, strong) XMLYFindDiscoverProperityModel  *properties;

@end

@interface XMLYFindDiscoverProperityModel : XMLYBaseModel

@property (nonatomic, copy)   NSString           *contentType;

@property (nonatomic, assign) NSInteger          rankingListId;

@property (nonatomic, assign) BOOL               isPaid;

@property (nonatomic, copy)   NSString           *key;

@end

#pragma mark - 猜你喜欢

@interface XMLYFindGuessMode : XMLYBaseModel

@property (nonatomic, assign) BOOL              hasMore;

@property (nonatomic, copy)   NSString          *title;

@property (nonatomic, strong) NSMutableArray    *list;

@end

#pragma mark - 城市相册

@interface XMLYCityColumnModel : XMLYBaseModel

@property (nonatomic, assign) BOOL                                                  hasMore;

@property (nonatomic, copy)   NSString                                              *title;

@property (nonatomic, assign) NSInteger                                             count;

@property (nonatomic, strong) NSMutableArray<XMLYFindEditorRecommendDetailModel *>  *list;

@property (nonatomic, copy)   NSString                                              *contentType;

@property (nonatomic, copy)   NSString                                              *code;

@end


#pragma mark - 热门推荐

@interface XMLYHotRecommend : XMLYBaseModel

@property (nonatomic, assign) NSInteger    ret;

@property (nonatomic, copy)   NSString     *title;

@property (nonatomic, strong) NSMutableArray<XMLYHotRecommendItemModel *>   *list;

@end


@interface XMLYHotRecommendItemModel : XMLYBaseModel

@property (nonatomic, copy) NSString    *title;

@property (nonatomic, copy) NSString    *contentType;

@property (nonatomic, assign) BOOL      isFinished;

@property (nonatomic, assign) NSInteger categoryId;

@property (nonatomic, assign) NSInteger categoryType;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) BOOL      hasMore;

@property (nonatomic, strong) NSMutableArray<XMLYFindEditorRecommendDetailModel *>    *list;

@property (nonatomic, assign) BOOL      filterSupported;

@property (nonatomic, assign) BOOL      isPaid;

@end





