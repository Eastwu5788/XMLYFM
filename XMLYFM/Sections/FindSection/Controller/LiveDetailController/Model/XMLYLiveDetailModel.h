//
//  XMLYLiveDetailModel.h
//  XMLYFM
//
//  Created by East_wu on 16/9/14.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseModel.h"

@interface XMLYLivePlayUrl : XMLYBaseModel

@property (nonatomic, assign) NSInteger aacV164Size;
@property (nonatomic, assign) NSInteger aacV224Size;
@property (nonatomic, assign) NSInteger downloadSize;
@property (nonatomic, copy)   NSString  *downloadPath;
@property (nonatomic, assign) NSInteger mp3Size;
@property (nonatomic, assign) NSInteger mp3Size32;
@property (nonatomic, assign) NSInteger mp3Size64;
@property (nonatomic, copy)   NSString  *playPath;
@property (nonatomic, copy)   NSString  *playPath32;
@property (nonatomic, copy)   NSString  *playPath64;
@property (nonatomic, copy)   NSString  *playPathAacV164;
@property (nonatomic, copy)   NSString  *playPathAacV224;

@end

@interface XMLYLiveDetailActivity : XMLYBaseModel

@property (nonatomic, assign) NSInteger chatId;
@property (nonatomic, copy)   NSString  *coverPath;
@property (nonatomic, copy)   NSString  *desc;
@property (nonatomic, assign) NSInteger endTs;
@property (nonatomic, copy)   NSString  *focusCoverPath;
@property (nonatomic, assign) NSInteger cid;
@property (nonatomic, copy)   NSString  *name;
@property (nonatomic, assign) NSInteger onlineCount;
@property (nonatomic, strong) XMLYLivePlayUrl   *playUrl;
@property (nonatomic, assign) NSInteger remainTs;
@property (nonatomic, assign) NSInteger scheduleId;
@property (nonatomic, copy)   NSString  *shareUrl;
@property (nonatomic, copy)   NSString  *shortDescription;
@property (nonatomic, assign) NSInteger startTs;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger trackId;
@property (nonatomic, assign) NSInteger uid;

@property (nonatomic, assign) CGFloat  cellHeight;

- (void)calculateFrameForCell;

@end

@interface XMLYAnchorInfo : XMLYBaseModel

@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, assign) NSInteger followerCount;
@property (nonatomic, assign) NSInteger followingCount;
@property (nonatomic, assign) BOOL      isFollowed;
@property (nonatomic, assign) BOOL      isVerify;
@property (nonatomic, copy) NSString    *nickname;
@property (nonatomic, assign) NSInteger trackCount;
@property (nonatomic, assign) NSInteger uid;

@property (nonatomic, assign) CGFloat   nicknamewidth;

- (void)calculateFrameForCell;

@end

@interface XMLYActivitySchedules : XMLYBaseModel

@property (nonatomic, assign) NSInteger     *activityId;
@property (nonatomic, assign) NSInteger     endTs;
@property (nonatomic, assign) NSInteger     uid;
@property (nonatomic, strong) XMLYLivePlayUrl  *playUrl;
@property (nonatomic, assign) NSInteger     startTs;
@property (nonatomic, assign) NSInteger     status;
@property (nonatomic, copy)   NSString      *title;
@property (nonatomic, assign) NSInteger     trackId;

@end

@interface XMLYLiveDetailModel : XMLYBaseModel

@property (nonatomic, strong) XMLYLiveDetailActivity *activityDetail;
@property (nonatomic, strong) XMLYAnchorInfo   *anchorInfo;
@property (nonatomic, strong) NSMutableArray<XMLYActivitySchedules *> *activitySchedules;

- (void)calculateFrameForCell;

@end
