//
//  XMLYFindRecomViewModel.h
//  XMLYFM
//
//  Created by East_wu on 16/8/10.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@interface XMLYFindRecomViewModel : NSObject

//更新数据的信号量
@property (nonatomic, readonly) RACSignal *updateContentSignal;

- (void)refreshDataSource;

- (NSInteger)numberOfSections;
- (NSInteger)numberOfItemsInSection:(NSInteger)section;

@end
