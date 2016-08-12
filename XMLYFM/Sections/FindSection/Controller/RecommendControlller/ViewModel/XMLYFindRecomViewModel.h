//
//  XMLYFindRecomViewModel.h
//  XMLYFM
//
//  Created by East_wu on 16/8/10.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"
#import "XMLYFindRecommendModel.h"
#import "XMLYFindLiveModel.h"
#import "XMLYFindHotGuessModel.h"

@interface XMLYFindRecomViewModel : NSObject

//更新数据的信号量
@property (nonatomic, readonly) RACSignal *updateContentSignal;

/**
 *  直播数据动态
 */
@property (nonatomic, strong) XMLYFindLiveModel      *liveModel;

/**
 *  推荐数据动态
 */
@property (nonatomic, strong) XMLYFindRecommendModel *recommendModel;

/**
 *  推荐、热门
 */
@property (nonatomic, strong) XMLYFindHotGuessModel  *hotGuessModel;

- (void)refreshDataSource;

- (NSInteger)numberOfSections;
- (NSInteger)numberOfItemsInSection:(NSInteger)section;
- (CGFloat)heightForRowAtIndex:(NSIndexPath *)indexPath;

@end
