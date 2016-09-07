//
//  XMLYFindRadioViewModel.h
//  XMLYFM
//
//  Created by East_wu on 16/9/7.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ReactiveCocoa.h"
#import "XMLYFindRadioModel.h"



@interface XMLYFindRadioViewModel : NSObject

//更新数据的信号量
@property (nonatomic, readonly) RACSignal *updateContentSignal;
@property (nonatomic, strong) XMLYFindRadioModel *model;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)heightForHeaderInSection:(NSInteger)section;
- (CGFloat)heightForFooterInSection:(NSInteger)section;

- (void)refreshDataSource;

- (XMLYFindRadioInfoModel *)infoModelForCellAtIndexPath:(NSIndexPath *)indexPath;


@end
