//
//  XMLYAlbumListModel.h
//  XMLYFM
//
//  Created by East_wu on 16/9/13.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseModel.h"

@interface XMLYAlbumTrackItemModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger trackId;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, copy)   NSString  *playUrl64;
@property (nonatomic, copy)   NSString  *playUrl32;
@property (nonatomic, copy)   NSString  *playPathHq;
@property (nonatomic, copy)   NSString  *playPathAacv164;
@property (nonatomic, copy)   NSString  *playPathAacv224;
@property (nonatomic, copy)   NSString  *title;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, assign) NSInteger albumId;
@property (nonatomic, assign) BOOL      isPaid;
@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, assign) NSInteger processState;
@property (nonatomic, assign) NSInteger createdAt;
@property (nonatomic, copy)   NSString  *coverSmall;
@property (nonatomic, copy)   NSString  *coverMiddle;
@property (nonatomic, copy)   NSString  *coverLarge;
@property (nonatomic, copy)   NSString  *nickname;
@property (nonatomic, copy)   NSString  *smallLogo;
@property (nonatomic, assign) NSInteger userSource;
@property (nonatomic, assign) NSInteger opType;
@property (nonatomic, copy)   NSString  *commentId;
@property (nonatomic, assign) BOOL      isPublic;
@property (nonatomic, assign) NSInteger likes;
@property (nonatomic, assign) NSInteger playtimes;
@property (nonatomic, assign) NSInteger comments;
@property (nonatomic, assign) NSInteger shares;
@property (nonatomic, assign) NSInteger status;

@end

@interface XMLYAlbumTracksModel : XMLYBaseModel

@property (nonatomic, strong) NSMutableArray<XMLYAlbumTrackItemModel *> *list;
@property (nonatomic, assign) NSInteger pageId;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger maxPageId;
@property (nonatomic, assign) NSInteger totalCount;

@end

@interface XMLYAlbumModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger albumId;
@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, copy)   NSString  *categoryName;
@property (nonatomic, copy)   NSString  *title;
@property (nonatomic, copy)   NSString  *coverOrigin;
@property (nonatomic, copy)   NSString  *coverSmall;
@property (nonatomic, copy)   NSString  *coverLarge;
@property (nonatomic, copy)   NSString  *coverMiddle;
@property (nonatomic, copy)   NSString  *coverWebLarge;
@property (nonatomic, copy)   NSString  *coverLargePop;
@property (nonatomic, assign) NSInteger createdAt;
@property (nonatomic, assign) NSInteger updatedAt;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, copy)   NSString  *nickname;
@property (nonatomic, assign) BOOL      isVerified;
@property (nonatomic, copy)   NSString  *avatarPath;
@property (nonatomic, copy)   NSString  *intro;
@property (nonatomic, copy)   NSString  *introRich;
@property (nonatomic, copy)   NSString  *tags;
@property (nonatomic, assign) NSInteger tracks;
@property (nonatomic, assign) NSInteger shares;
@property (nonatomic, assign) BOOL      hasNew;
@property (nonatomic, assign) BOOL      isFavorite;
@property (nonatomic, assign) NSInteger playTimes;
@property (nonatomic, assign) NSInteger lastUptrackAt;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger serializeStatus;
@property (nonatomic, assign) NSInteger serialState;
@property (nonatomic, assign) NSInteger playTrackId;
@property (nonatomic, assign) BOOL      isRecordDesc;
@property (nonatomic, assign) BOOL      isPaid;
@property (nonatomic, copy)   NSString  *other_title;
@property (nonatomic, copy)   NSString  *detailCoverPath;

@end

@interface XMLYAlbumUserModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, copy)   NSString  *nickname;

@end

@interface XMLYAlbumListModel : XMLYBaseModel

@property (nonatomic, strong) XMLYAlbumModel        *album;
@property (nonatomic, strong) XMLYAlbumUserModel    *user;
@property (nonatomic, strong) XMLYAlbumTracksModel  *tracks;
@property (nonatomic, copy)   NSString              *viewTab;

@end
