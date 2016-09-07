//
//  XMLYFindCategoryViewModel.m
//  XMLYFM
//
//  Created by East_wu on 16/9/7.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYFindCategoryViewModel.h"
#import "XMLYCategoryAPI.h"
#import "XMLYFindAPI.h"


static NSString *const kUpdateSiganlName = @"kFindCategoryViewModelUpdateSignalName";


@interface XMLYFindCategoryViewModel ()

@property (nonatomic, strong) RACSubject *updateContentSignal;

@end

@implementation XMLYFindCategoryViewModel

- (instancetype)init {
    if(self = [super init]) {
        self.updateContentSignal = [[RACSubject subject] setNameWithFormat:kUpdateSiganlName];
    }
    return self;
}

/**
 *  请求刷新数据
 */
- (void)refreshDataSource {
    @weakify(self)
    RACSignal *signalItems = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self requestCategoryItems:^{
            [subscriber sendNext:nil];
        }];
        return nil;
    }];
    
    RACSignal *signalFooter = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self requestFoorAds:^{
            [subscriber sendNext:nil];
        }];
        return nil;
    }];
    
    /**
     *  头部应该还有一个广告的接口，但是我没有找到，暂时用这个接口代替一下
     */
    RACSignal *signalRecommend = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self requestRecommendList:^{
            [subscriber sendNext:nil];
        }];
        return nil;
    }];
    
    [[RACSignal combineLatest:@[signalItems,signalFooter,signalRecommend]] subscribeNext:^(id x) {
        @strongify(self);
        [(RACSubject *)self.updateContentSignal sendNext:nil];
    }];
}


- (XMLYListItemModel *)itemModelWithIndexPath:(NSIndexPath *)indexPath left:(BOOL)isleft {
    NSInteger index = indexPath.section * 6; //section
    index += indexPath.row * 2;      //row
    index = isleft ? index+1 : index + 2; //left right
    if(self.model.list.count <= index) {
        return nil;
    }
    return self.model.list[index];
}

/**
 *  计算section
 */
- (NSInteger)numberOfSection {
    NSInteger sec = self.model.list.count / 6;
    NSInteger sub = self.model.list.count % 6;
    return sub > 0 ? sec + 1 : sec;
}

/**
 *  计算section中的row
 */
- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    NSInteger sec = self.model.list.count / 6;
    if(section < sec) {
        return 3;
    } else {
        return (self.model.list.count % 6) / 2;
    }
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45.0f;
}

- (CGFloat)heightForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return 0;
    }
    else {
        return 10;
    }
}

#pragma mark - HTTP
- (void)requestFoorAds:(void(^)(void))completion {
    [XMLYCategoryAPI requestFootBanner:^(id response, NSString *message, BOOL success) {
        if(success) {
            self.adModel = [XMLYCategoryFooterModel xr_modelWithJSON:response];
        }
        if(completion) {
            completion();
        }
    }];
}

- (void)requestCategoryItems:(void(^)(void))completion {
    [XMLYCategoryAPI requestCategory:^(id response, NSString *message, BOOL success) {
        if(success) {
            XMLYCategoryModel *model = [XMLYCategoryModel xr_modelWithJSON:response];
            self.model = model;
        }
        if(completion) {
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
