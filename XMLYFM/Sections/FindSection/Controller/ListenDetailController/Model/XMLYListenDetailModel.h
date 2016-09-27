//
//  XMLYListenDetailModel.h
//  XMLYFM
//
//  Created by East_wu on 16/9/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseModel.h"

@interface XMLYListenDetailOriginModel : XMLYBaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *coverSmall;

@end

@interface XMLYListenDetailItemModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger cid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *coverSmall;
@property (nonatomic, strong) XMLYListenDetailOriginModel *origin;
@property (nonatomic, copy) NSString *playPath32;
@property (nonatomic, copy) NSString *playPath64;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, assign) NSInteger createdAt;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, copy)   NSString  *nickname;
@property (nonatomic, assign) NSInteger favoritesCounts;
@property (nonatomic, assign) NSInteger playsCounts;
@property (nonatomic, assign) NSInteger commentsCounts;
@property (nonatomic, assign) NSInteger sharesCounts;

@property (nonatomic, assign) NSInteger titleHeight;
@property (nonatomic, assign) NSInteger cellHeight;

- (void)calculateFrameForItemCell;


@end

@interface XMLYListenDetailEditInfo : XMLYBaseModel

@property (nonatomic, assign) NSInteger specialId;
@property (nonatomic, assign) NSInteger contentType;
@property (nonatomic, copy)   NSString  *coverPathBig;
@property (nonatomic, copy)   NSString  *intro;
@property (nonatomic, copy)   NSString  *title;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, copy)   NSString  *nickname;
@property (nonatomic, copy)   NSString  *smallLogo;
@property (nonatomic, copy)   NSString  *personalSignature;


@property (nonatomic, assign) CGFloat nickNameWidth;
@property (nonatomic, assign) CGFloat introHeight;
@property (nonatomic, assign) CGFloat cellHeight;

- (void)calculateFrameForInfoCell;

@end


@interface XMLYListenDetailModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger ret;
@property (nonatomic, strong) NSMutableArray<XMLYListenDetailItemModel *> *list;
@property (nonatomic, copy)   NSString  *msg;
@property (nonatomic, strong) XMLYListenDetailEditInfo *info;

- (void)calculateIntroCellHeight;

@end
