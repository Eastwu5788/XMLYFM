//
//  XMLYFindRecomViewModel.m
//  XMLYFM
//
//  Created by East_wu on 16/8/10.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYFindRecomViewModel.h"
#import "XMLYFindAPI.h"
#import "MJExtension.h"


#define kFindRecomUpdateSignalName @"XMLYFindRecomViewModelUpdateContentSignal"

#define kSectionEditCommen  0   //小编推荐
#define kSectionLive        1   //现场直播
#define kSectionGuess       2   //猜你喜欢
#define kSectionCityColumn  3   //城市歌单
#define kSectionSpecial     4   //精品听单
#define kSectionAdvertise   5   //推广
#define kSectionHotCommends 6   //热门推荐
#define kSectionMore        7   //更多分类


#define kSectionHeight        230.0
#define kSectionLiveHeight    227.0
#define kSectionSpecialHeight 219.0
#define kSectionMoreHeight    60.0

@interface XMLYFindRecomViewModel ()

@property (nonatomic, strong) RACSubject *updateContentSignal;


@end

@implementation XMLYFindRecomViewModel

- (instancetype)init {
    if(self = [super init]) {
        self.updateContentSignal = [[RACSubject subject] setNameWithFormat:kFindRecomUpdateSignalName];
    }
    return self;
}


#pragma mark - public

- (void)refreshDataSource {
    
    @weakify(self);
    RACSignal *signalRecommend = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self requestRecommendList:^{
            [subscriber sendNext:nil];
        }];
        return nil;
    }];
    
    RACSignal *signalHotAndGuess = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self requestHotAndGuessList:^{
            [subscriber sendNext:nil];
        }];
        return nil;
    }];
    
    RACSignal *signalLiving = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self requestLiving:^{
            [subscriber sendNext:nil];
        }];
        return nil;
    }];
    
    [[RACSignal combineLatest:@[signalRecommend,signalHotAndGuess,signalLiving]] subscribeNext:^(id x) {
        @strongify(self);
        [(RACSubject *)self.updateContentSignal sendNext:nil];
    }];
}


- (NSInteger)numberOfSections {
    return 8;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section {
    if(section == kSectionEditCommen) {
        return 1;
    }
    else if(section == kSectionLive) {
        return self.liveModel.data.count == 0 ? 0 : 1;
    }
    else if(section == kSectionGuess) {
        return self.hotGuessModel.guess.list.count == 0 ? 0 : 1;
    }
    else if(section == kSectionCityColumn) {
        return self.hotGuessModel.cityColumn.list.count == 0 ? 0 : 1;
    }
    else if(section == kSectionSpecial) {
        return self.recommendModel.specialColumn.list == 0 ? 0 : 1;
    }
    else if(section == kSectionAdvertise) {
        return 0; //暂时未找到接口
    }
    else if(section == kSectionHotCommends) {
        return self.hotGuessModel.hotRecommends.list.count;
    }
    else if(section == kSectionMore) {
        return 1;
    }
    return 0;
}


- (CGFloat)heightForRowAtIndex:(NSIndexPath *)indexPath {
    if(indexPath.section == kSectionEditCommen) {
        return kSectionHeight;
    }
    else if(indexPath.section == kSectionLive) {
        return self.liveModel.data.count == 0 ? 0 : kSectionLiveHeight;
    }
    else if(indexPath.section == kSectionGuess) {
        return self.hotGuessModel.guess.list.count == 0 ? 0 : kSectionHeight;
    }
    else if(indexPath.section == kSectionCityColumn) {
        return self.hotGuessModel.cityColumn.list.count == 0 ? 0 : kSectionHeight;
    }
    else if(indexPath.section == kSectionSpecial) {
        return self.recommendModel.specialColumn.list == 0 ? 0 : kSectionSpecialHeight;
    }
    else if(indexPath.section == kSectionAdvertise) {
        return 0; //暂时未找到接口
    }
    else if(indexPath.section == kSectionHotCommends) {
        return kSectionHeight;
    }
    else if(indexPath.section == kSectionMore) {
        return kSectionMoreHeight;
    }
    return 0;
}

#pragma mark - NetRequest 
/**
 *  请求正在直播数据
 */
- (void)requestLiving:(void(^)())completion {
    [XMLYFindAPI requestLiveRecommend:^(id response, NSString *message, BOOL success) {
        if(success) {
            [XMLYFindLiveModel mj_setupObjectClassInArray:^NSDictionary *{
                return @{
                         @"data":@"XMLYFindLiveDetailModel"
                         };
            }];
            self.liveModel = [XMLYFindLiveModel mj_objectWithKeyValues:response];
        }
        if(completion){
            completion();
        }
    }];
}

/**
 *  请求热门、猜你喜欢部分的数据
 */
- (void)requestHotAndGuessList:(void(^)())completion {
    [XMLYFindAPI requestHotAndGuess:^(id response, NSString *message, BOOL success) {
        if(success) {
            [XMLYFindDiscoverColumnsModel mj_setupObjectClassInArray:^NSDictionary *{
                return @{
                         @"list":@"XMLYFindDiscoverDetailModel"
                         };
            }];

            [XMLYHotRecommend mj_setupObjectClassInArray:^NSDictionary *{
                return @{
                         @"list":@"XMLYHotRecommendItemModel"
                         };
            }];
            
            [XMLYCityColumnModel mj_setupObjectClassInArray:^NSDictionary *{
                return @{
                         @"list":@"XMLYFindEditorRecommendDetailModel"
                         };
            }];
            
            [XMLYHotRecommendItemModel mj_setupObjectClassInArray:^NSDictionary *{
                return @{
                         @"list":@"XMLYFindEditorRecommendDetailModel"
                         };
            }];
            self.hotGuessModel = [XMLYFindHotGuessModel mj_objectWithKeyValues:response];
        }
        if(completion){
            completion();
        }
    }];
}


/**
 *  请求热门动态数据
 */
- (void)requestRecommendList:(void(^)())completion {
    [XMLYFindAPI requestRecommends:^(id response, NSString *message, BOOL success) {
        if(success) {
            [XMLYFindEditorRecommendAlbumModel mj_setupObjectClassInArray:^NSDictionary *{
                return @{
                         @"list":@"XMLYFindEditorRecommendDetailModel"
                         };
            }];
            
            [XMLYFindFocusImagesModel mj_setupObjectClassInArray:^NSDictionary *{
                return @{
                         @"list":@"XMLYFindFocusImageDetailModel"
                         };
            }];
            
            [XMLYSpecialColumnModel mj_setupObjectClassInArray:^NSDictionary *{
                return @{
                         @"list":@"XMLYSpecialColumnDetailModel"
                         };
            }];
            
            self.recommendModel = [XMLYFindRecommendModel mj_objectWithKeyValues:response];
        }

        if(completion) {
            completion();
        }
    }];
}



@end
