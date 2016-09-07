//
//  XMLYFindCategoryViewModel.h
//  XMLYFM
//
//  Created by East_wu on 16/9/7.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"
#import "XMLYCategoryModel.h"
#import "XMLYCategoryFooterModel.h"

@interface XMLYFindCategoryViewModel : NSObject

@property (nonatomic, readonly) RACSignal *updateContentSignal;

@property (nonatomic, strong) XMLYCategoryModel *model;
@property (nonatomic, strong) XMLYCategoryFooterModel *adModel;
@property (nonatomic, strong) XMLYFindRecommendModel *recommendModel;

- (NSInteger)numberOfSection;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)heightForHeaderInSection:(NSInteger)section;

- (void)refreshDataSource;

- (XMLYListItemModel *)itemModelWithIndexPath:(NSIndexPath *)indexPath left:(BOOL)isleft;

@end
