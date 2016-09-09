//
//  XMLYScribeRecomModel.h
//  XMLYFM
//
//  Created by East_wu on 16/9/9.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseModel.h"
#import "XRModel.h"

@interface XMLYScribeRecomItemModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger albumId;
@property (nonatomic, assign) NSInteger basedRelativeAlbumId;
@property (nonatomic, copy)   NSString  *coverLarge;
@property (nonatomic, copy)   NSString  *coverMiddle;
@property (nonatomic, copy)   NSString  *info;
@property (nonatomic, assign) NSInteger lastUptrackAt;
@property (nonatomic, assign) NSInteger lastUptrackId;
@property (nonatomic, copy)   NSString  *lastUptrackTitle;
@property (nonatomic, copy)   NSString  *nickname;
@property (nonatomic, assign) NSInteger playsCounts;
@property (nonatomic, copy)   NSString  *recReason;
@property (nonatomic, copy)   NSString  *recSrc;
@property (nonatomic, copy)   NSString  *recTrack;
@property (nonatomic, assign) NSInteger serialState;
@property (nonatomic, copy)   NSString  *tags;
@property (nonatomic, copy)   NSString  *title;
@property (nonatomic, assign) NSInteger trackId;
@property (nonatomic, copy)   NSString  *trackTitle;
@property (nonatomic, assign) NSInteger tracks;
@property (nonatomic, assign) NSInteger uid;

#pragma mark - CellFrame

@property (nonatomic, assign) CGFloat titleLabelHeight;
@property (nonatomic, assign) CGFloat cellHeight;



- (void)calculateFrameForCell;

@end

@interface XMLYScribeRecomModel : XMLYBaseModel

@property (nonatomic, assign) BOOL hasMore;

@property (nonatomic, strong) NSMutableArray<XMLYScribeRecomItemModel *> *list;

- (void)calculateFrameForItems;

@end
