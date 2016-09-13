//
//  XMLYAlbumIntroDetailModel.h
//  XMLYFM
//
//  Created by East_wu on 16/9/13.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseModel.h"

@interface XMLYAlbumIntroModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger albumId;
@property (nonatomic, copy)   NSString  *intro;
@property (nonatomic, copy)   NSString  *introRich;
@property (nonatomic, copy)   NSString  *tags;


#pragma mark - Frame
@property (nonatomic, assign) CGRect   titleLabelFrame;
@property (nonatomic, assign) CGRect   introlLabelFrame;
@property (nonatomic, assign) CGRect   showMoreButtonFrame;
@property (nonatomic, assign) CGRect   sepViewFrame;

@property (nonatomic, assign) CGFloat  cellHeight;

- (void)calculateIntrolCellFrame;

@end


@interface XMLYAlbumEditUserModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, copy)   NSString  *nickname;
@property (nonatomic, assign) BOOL      isVerified;
@property (nonatomic, copy)   NSString  *smallLogo;
@property (nonatomic, assign) BOOL      isFollowed;
@property (nonatomic, assign) NSInteger followers;
@property (nonatomic, assign) NSInteger followings;
@property (nonatomic, assign) NSInteger tracks;
@property (nonatomic, assign) NSInteger albums;
@property (nonatomic, copy)   NSString  *personDescribe;
@property (nonatomic, copy)   NSString  *personalSignature;

#pragma mark - Frame
@property (nonatomic, assign) CGFloat nicknameWidth;
@property (nonatomic, assign) CGFloat introlHeight;
@property (nonatomic, assign) CGFloat cellHeight;

- (void)calculateEditUserCellFrame;

@end

@interface XMLYAlbumRecsItemModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger albumId;
@property (nonatomic, copy)   NSString  *title;
@property (nonatomic, copy)   NSString  *coverSmall;
@property (nonatomic, copy)   NSString  *coverMiddle;
@property (nonatomic, copy)   NSString  *updateAt;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, copy)   NSString  *intro;
@property (nonatomic, assign) NSInteger tracks;
@property (nonatomic, assign) NSInteger playTimes;
@property (nonatomic, assign) NSInteger playsCounts;
@property (nonatomic, assign) BOOL      isPaid;
@property (nonatomic, assign) NSInteger priceTypeId;
@property (nonatomic, copy)   NSString  *displayPrice;
@property (nonatomic, copy)   NSString  *displayDiscountedPrice;
@property (nonatomic, assign) NSInteger totalTrackCount;
@property (nonatomic, assign) CGFloat   price;
@property (nonatomic, assign) CGFloat   discountedPrice;
@property (nonatomic, assign) CGFloat   score;
@property (nonatomic, assign) NSInteger commentsCount;
@property (nonatomic, copy)   NSString  *recSrc;
@property (nonatomic, copy)   NSString  *recTrack;
@property (nonatomic, assign) NSInteger priceTypeEnum;

#pragma mark - Frame
@property (nonatomic, assign) CGRect    bgImageViewFrame;
@property (nonatomic, assign) CGRect    coverImageViewFrame;
@property (nonatomic, assign) CGRect    titleLabelFrame;
@property (nonatomic, assign) CGRect    introLabelFrame;
@property (nonatomic, assign) CGRect    playButtonFrame;
@property (nonatomic, assign) CGRect    albumButtonFrame;
@property (nonatomic, assign) CGRect    arrowImageViewFrame;
@property (nonatomic, assign) CGFloat   cellHeight;

- (void)calculateRecsItemModelFrame;

@end

@interface XMLYAlbumRecsModel : XMLYBaseModel

@property (nonatomic, strong) NSMutableArray<XMLYAlbumRecsItemModel *> *list;
@property (nonatomic, assign) NSInteger pageId;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger maxPageId;
@property (nonatomic, assign) NSInteger totalCount;

#pragma mark - Frame
@property (nonatomic, assign) CGRect         titleLabelFrame;
@property (nonatomic, strong) NSMutableArray *subItemFrameArray;
@property (nonatomic, assign) CGRect         showMoreButtonFrame;
@property (nonatomic, assign) CGFloat        cellHeight;

- (void)calculateRecsFrame;

@end

@interface XMLYAlbumDetailModel : XMLYBaseModel

@property (nonatomic, strong) XMLYAlbumIntroModel    *detail;
@property (nonatomic, strong) XMLYAlbumEditUserModel *user;
@property (nonatomic, strong) XMLYAlbumRecsModel     *recs;

- (void)calculateFrameForCells;

@end
