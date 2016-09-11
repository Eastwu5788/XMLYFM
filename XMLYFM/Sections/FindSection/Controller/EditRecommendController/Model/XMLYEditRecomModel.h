//
//  XMLYEditRecomModel.h
//  XMLYFM
//
//  Created by East_wu on 16/9/11.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYScribeRecomModel.h"

@interface XMLYEditRecomItemModel : XMLYScribeRecomItemModel

@property (nonatomic, copy)   NSString *intro;
@property (nonatomic, copy)   NSString *albumCoverUrl1290;
@property (nonatomic, copy)   NSString *coverSmall;
@property (nonatomic, assign) NSInteger isFinished;
@property (nonatomic, assign) BOOL     isPaid;
@property (nonatomic, assign) NSInteger commentsCount;
@property (nonatomic, assign) NSInteger priceTypeId;

@end

@interface XMLYEditRecomModel : XMLYScribeRecomModel

@property (nonatomic, assign) NSInteger ret;
@property (nonatomic, assign) NSInteger maxPageId;
@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, assign) NSInteger pageId;
@property (nonatomic, assign) NSInteger pageSize;




@end
