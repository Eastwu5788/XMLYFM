//
//  XMLYFindRecomViewModel.m
//  XMLYFM
//
//  Created by East_wu on 16/8/10.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYFindRecomViewModel.h"
#import "XMLYFindAPI.h"

#define kFindRecomUpdateSignalName @"XMLYFindRecomViewModelUpdateContentSignal"

#define kSectionEditCommen  0   //小编推荐
#define kSectionLive        1   //现场直播
#define kSectionGuess       2   //猜你喜欢
#define kSectionCityColumn  3   //城市歌单
#define kSectionSpecial     4   //精品听单
#define kSectionAdvertise   5   //推广
#define kSectionHotCommends 6   //热门推荐
#define kSectionMore        7   //更多分类

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
    return 0;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section {
    if(section == kSectionHotCommends) {
        return 0;
    }
    return 0;
}

#pragma mark - NetRequest 

- (void)requestLiving:(void(^)())completion {
    [XMLYFindAPI requestLiveRecommend:^(id response, NSString *message, BOOL success) {
        if(success) {
        
        }
        NSLog(@"直播动态:%@",response);
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
        }
        NSLog(@"猜你喜欢:%@",response);
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
            
        }
        NSLog(@"热门动态:%@",response);
        if(completion) {
            completion();
        }
    }];
}



@end
