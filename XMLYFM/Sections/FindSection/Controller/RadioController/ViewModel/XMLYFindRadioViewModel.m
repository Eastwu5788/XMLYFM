//
//  XMLYFindRadioViewModel.m
//  XMLYFM
//
//  Created by East_wu on 16/9/7.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYFindRadioViewModel.h"
#import "XMLYRadioAPI.h"

static NSString *const kFindRadioUpdateContentSiganl = @"kFindRadioViewModelContentUpdateSignal";
static NSInteger kSectionTel   = 0;  //电台section
static NSInteger kSectionLocal = 1;  //本地section
static NSInteger kSectionTop   = 2;  //排行榜section


@interface XMLYFindRadioViewModel ()

@property (nonatomic, strong) RACSubject *updateContentSignal;

@end

@implementation XMLYFindRadioViewModel

- (instancetype)init {
    self = [super init];
    self.updateContentSignal = [[RACSubject subject] setNameWithFormat:kFindRadioUpdateContentSiganl];
    return self;
}

- (void)refreshDataSource {
    @weakify(self);
    [self requestRadioDetail:^{
        @strongify(self);
        [(RACSubject *)self.updateContentSignal sendNext:nil];
    }];
}

- (XMLYFindRadioInfoModel *)infoModelForCellAtIndexPath:(NSIndexPath *)indexPath {
    XMLYFindRadioInfoModel *infoModel = nil;
    if(indexPath.section == kSectionLocal) {
        infoModel = self.model.localRadios[indexPath.row];
    } else {
        infoModel = self.model.topRadios[indexPath.row];
    }
    return infoModel;
}


- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    if(section == kSectionTel) {
        return 1;
    }
    else if(section == kSectionLocal) {
        return self.model.localRadios.count;
    }
    else if(section == kSectionTop && self.model.topRadios.count >= 3){
        return 3;
    }
    return self.model.topRadios.count;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == kSectionTel) {
        if(self.model.style == XMLYFindRadioTelCellStyleHidden) {
            return 200;
        } else {
            return 293;
        }
    }
    else {
        return 85.0f;
    }
}

- (CGFloat)heightForHeaderInSection:(NSInteger)section {
    if(section == kSectionTel) {
        return 0.01f;
    }
    else {
        return 40.0f;
    }
}

- (CGFloat)heightForFooterInSection:(NSInteger)section {
    return 10.0f;
}

#pragma mark - HTTPRequest
- (void)requestRadioDetail:(void(^)(void))completion {
    @weakify(self);
    [XMLYRadioAPI requestRadioRecommend:^(id response, NSString *message, BOOL success) {
        @strongify(self);
        if(success && [response isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)response;
            self.model = [XMLYFindRadioModel xr_modelWithDictionary:dic[@"data"]];
        }
        if(completion) completion();
    }];
}

@end
