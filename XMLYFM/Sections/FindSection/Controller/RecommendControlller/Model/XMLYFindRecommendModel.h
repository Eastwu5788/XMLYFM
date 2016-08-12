//
//  XMLYFindRecommendModel.h
//  XMLYFM
//
//  Created by East_wu on 16/8/10.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseModel.h"

@class XMLYFindEditorRecommendAlbumModel,XMLYFindEditorRecommendDetailModel,XMLYFindFocusImagesModel,XMLYFindFocusImageDetailModel,XMLYSpecialColumnModel,XMLYSpecialColumnDetailModel;

@interface XMLYFindRecommendModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger                         ret;

@property (nonatomic, strong) XMLYFindEditorRecommendAlbumModel *editorRecommendAlbums;

@property (nonatomic, strong) XMLYFindFocusImagesModel          *focusImages;

@property (nonatomic, strong) XMLYSpecialColumnModel            *specialColumn;

@property (nonatomic, copy)   NSString                          *msg;

@end

@interface XMLYFindEditorRecommendAlbumModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger  ret;

/**
 *  标题 例如:小编推荐
 */
@property (nonatomic, copy)   NSString   *title;
/**
 *  是否有更多
 */
@property (nonatomic, assign) BOOL       hasMore;

@property (nonatomic, copy)   NSString   *msg;

/**
 *  小编推荐信息列表
 */
@property (nonatomic, strong) NSMutableArray<XMLYFindEditorRecommendDetailModel *> *list;


@end


/**
 *  精品听单模型
 */
@interface XMLYSpecialColumnModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger ret;

@property (nonatomic, copy)   NSString  *title;

@property (nonatomic, assign) BOOL      hasMore;

@property (nonatomic, strong) NSMutableArray<XMLYSpecialColumnDetailModel *>  *list;

@end


/**
 *  精品订单详情模型
 */
@interface XMLYSpecialColumnDetailModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger columnType;

@property (nonatomic, assign) NSInteger specialId;

@property (nonatomic, copy)   NSString  *title;

@property (nonatomic, copy)   NSString  *subtitle;

@property (nonatomic, copy)   NSString  *footnote;

@property (nonatomic, copy)   NSString  *coverPath;

@property (nonatomic, assign) NSInteger contentType;

@end

/**
 *  轮播图模型 存储数组
 */
@interface XMLYFindFocusImagesModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger ret;

@property (nonatomic, copy)   NSString  *title;

@property (nonatomic, strong) NSMutableArray<XMLYFindFocusImageDetailModel *>      *list;

@end


/**
 *  轮播图详情数组
 */
@interface XMLYFindFocusImageDetailModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger cid;

@property (nonatomic, copy)   NSString  *shortTitle;

@property (nonatomic, copy)   NSString  *longTitle;

@property (nonatomic, copy)   NSString  *pic;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger uid;

@property (nonatomic, assign) NSInteger albumId;

@property (nonatomic, assign) BOOL      isShare;

@property (nonatomic, assign) BOOL      is_External_url;

@end



@interface XMLYFindEditorRecommendDetailModel : XMLYBaseModel
/**
 *  唯一标识
 */
@property (nonatomic, assign) NSInteger  cid;
/**
 *  相册标识
 */
@property (nonatomic, assign) NSInteger  albumId;
/**
 *  用户标识
 */
@property (nonatomic, assign) NSInteger  uid;
/**
 *  介绍
 */
@property (nonatomic, copy)   NSString   *intro;
/**
 *  昵称
 */
@property (nonatomic, copy)   NSString   *nickname;
/**
 *  相册封面290px像素地址
 */
@property (nonatomic, copy)   NSString   *albumCoverUrl290;
/**
 *  小封面地址
 */
@property (nonatomic, copy)   NSString   *coverSmall;
/**
 *  中等封面地址
 */
@property (nonatomic, copy)   NSString   *coverMiddle;
/**
 *  大封面地址
 */
@property (nonatomic, copy)   NSString   *coverLarge;
/**
 *  标题
 */
@property (nonatomic, copy)   NSString   *title;
/**
 *  标记文本
 */
@property (nonatomic, copy)   NSString   *tags;

@property (nonatomic, assign) NSInteger  tracks;
/**
 *  播放量
 */
@property (nonatomic, assign) NSInteger  playsCounts;

@property (nonatomic, assign) NSInteger  isFinished;

@property (nonatomic, assign) NSInteger  serialState;

@property (nonatomic, assign) NSInteger  trackId;

@property (nonatomic, copy)   NSString   *trackTitle;

/**
 *  是否支付过
 */
@property (nonatomic, assign) BOOL       isPaid;
/**
 *  评论数量
 */
@property (nonatomic, assign) NSInteger  commentsCount;

@property (nonatomic, assign) NSInteger  priceTypeId;
@property (nonatomic, assign) NSInteger  priceTypeEnum;

@end



