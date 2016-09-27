//
//  XMLYPlayPageModel.h
//  XMLYFM
//
//  Created by East_wu on 16/9/15.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseModel.h"

@interface XMLYTrackInfoModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger  trackId;
@property (nonatomic, assign) NSInteger  uid;
@property (nonatomic, copy)   NSString   *playUrl64;
@property (nonatomic, copy)   NSString   *playUrl32;
@property (nonatomic, copy)   NSString   *playPathAacv164;
@property (nonatomic, copy)   NSString   *playPathAacv224;
@property (nonatomic, copy)   NSString   *title;
@property (nonatomic, assign) NSInteger  duration;
@property (nonatomic, assign) BOOL       isPaid;
@property (nonatomic, assign) BOOL       isFree;
@property (nonatomic, assign) BOOL       isAuthorized;
@property (nonatomic, assign) NSInteger  priceTypeId;
@property (nonatomic, assign) NSInteger  sampleDuration;
@property (nonatomic, assign) NSInteger  priceTypeEnum;
@property (nonatomic, strong) NSMutableArray  *priceTypes;
@property (nonatomic, assign) NSInteger  categoryId;
@property (nonatomic, assign) NSInteger  processState;
@property (nonatomic, assign) BOOL       isPublic;
@property (nonatomic, copy)   NSString   *images;
@property (nonatomic, assign) NSInteger  likes;
@property (nonatomic, assign) NSInteger  playtimes;
@property (nonatomic, assign) NSInteger  comments;
@property (nonatomic, assign) NSInteger  shares;
@property (nonatomic, assign) NSInteger  status;
@property (nonatomic, copy)   NSString   *categoryName;
@property (nonatomic, assign) NSInteger  bulletSwitchType;
@property (nonatomic, copy)   NSString   *playPathHq;
@property (nonatomic, copy)   NSString   *shortRichIntro;

@property (nonatomic, assign) CGFloat titleHeight;
@property (nonatomic, assign) CGFloat contentHeight;

@property (nonatomic, assign) CGFloat headerHeight;

- (void)calculateHeaderCellHeight;

@end

@interface XMLYAlbumInfoModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger  albumId;
@property (nonatomic, assign) NSInteger  categoryId;
@property (nonatomic, copy)   NSString   *title;
@property (nonatomic, copy)   NSString   *coverOrigin;
@property (nonatomic, copy)   NSString   *coverSmall;
@property (nonatomic, copy)   NSString   *coverMiddle;
@property (nonatomic, copy)   NSString   *coverLarge;
@property (nonatomic, copy)   NSString   *coverWebLarge;
@property (nonatomic, assign) NSInteger  createdAt;
@property (nonatomic, assign) NSInteger  updatedAt;
@property (nonatomic, assign) NSInteger  uid;
@property (nonatomic, copy)   NSString   *intro;
@property (nonatomic, copy)   NSString   *tags;
@property (nonatomic, assign) NSInteger  tracks;
@property (nonatomic, assign) NSInteger  shares;
@property (nonatomic, assign) BOOL       hasNew;
@property (nonatomic, assign) BOOL       isFavorite;
@property (nonatomic, assign) NSInteger  playTimes;
@property (nonatomic, assign) BOOL       isPaid;
@property (nonatomic, assign) NSInteger  status;
@property (nonatomic, assign) NSInteger  serializeStatus;

@end


@interface XMLYAssociationAlbumsInfoModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger  albumId;
@property (nonatomic, copy)   NSString   *title;
@property (nonatomic, copy)   NSString   *coverSmall;
@property (nonatomic, copy)   NSString   *coverMiddle;
@property (nonatomic, assign) NSInteger  updatedAt;
@property (nonatomic, assign) NSInteger  uid;
@property (nonatomic, copy)   NSString   *recSrc;
@property (nonatomic, copy)   NSString   *recTrack;
@property (nonatomic, copy)   NSString   *intro;
@property (nonatomic, assign) BOOL       isPaid;

@property (nonatomic, assign) CGFloat titleHight;
@property (nonatomic, assign) CGFloat subTitleHeight;
@property (nonatomic, assign) CGFloat cellHeight;

- (void)calculateHeightFroCell;

@end


@interface XMLYAlbumUserInfoModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger  uid;
@property (nonatomic, copy)   NSString   *nickname;
@property (nonatomic, assign) BOOL       isVerified;
@property (nonatomic, copy)   NSString   *smallLogo;
@property (nonatomic, assign) NSInteger  followers;
@property (nonatomic, assign) NSInteger  tracks;
@property (nonatomic, assign) NSInteger  albums;

@property (nonatomic, assign) CGFloat nicknameWidth;

- (void)calculateFrameForUser;

@end

@interface XMLYComentInfoItemModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger  cid;
@property (nonatomic, assign) NSInteger  track_id;
@property (nonatomic, assign) NSInteger  uid;
@property (nonatomic, copy)   NSString   *nickname;
@property (nonatomic, copy)   NSString   *smallHeader;
@property (nonatomic, copy)   NSString   *content;
@property (nonatomic, assign) NSInteger  createdAt;
@property (nonatomic, assign) NSInteger  updatedAt;
@property (nonatomic, assign) NSInteger  parentId;
@property (nonatomic, assign) NSInteger  likes;

@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, assign) CGFloat cellHeight;

- (void)calculateFrameForCell;

@end

@interface XMLYCommentInfoModel : XMLYBaseModel

@property (nonatomic, strong) NSMutableArray<XMLYComentInfoItemModel *>    *list;
@property (nonatomic, assign) NSInteger  pageId;
@property (nonatomic, assign) NSInteger  pageSize;
@property (nonatomic, assign) NSInteger  maxPageId;
@property (nonatomic, assign) NSInteger  totalCount;

- (void)calculateFrameForCell;

@end

@interface XMLYTrackRewardInfoItemModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger cid;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, copy)   NSString  *nickname;
@property (nonatomic, copy)   NSString  *amount;
@property (nonatomic, assign) NSInteger paymentTime;
@property (nonatomic, assign) NSInteger sn;
@property (nonatomic, copy)   NSString  *smallLogo;

@end

@interface XMLYTrackRewardInfoModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, assign) BOOL      isOpen;
@property (nonatomic, assign) NSInteger numOfRewards;
@property (nonatomic, strong) NSMutableArray<XMLYTrackRewardInfoItemModel *> *rewords;


@end



@interface XMLYPlayPageModel : XMLYBaseModel

@property (nonatomic, strong) XMLYTrackInfoModel *trackInfo;
@property (nonatomic, strong) XMLYAlbumInfoModel *albumInfo;
@property (nonatomic, strong) NSMutableArray<XMLYAssociationAlbumsInfoModel *> *associationAlbumsInfo;
@property (nonatomic, strong) XMLYAlbumUserInfoModel     *userInfo;
@property (nonatomic, strong) XMLYCommentInfoModel       *commentInfo;
@property (nonatomic, strong) XMLYTrackRewardInfoModel  *trackRewardInfo;
@property (nonatomic, strong) NSMutableDictionary       *countInfo;

- (void)calculateFrameForCell;

@end
