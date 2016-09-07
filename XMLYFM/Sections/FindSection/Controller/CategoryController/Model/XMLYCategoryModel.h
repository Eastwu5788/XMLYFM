//
//  XMLYCategoryModel.h
//  XMLYFM
//
//  Created by East_wu on 16/9/7.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseModel.h"
#import "XMLYFindHotGuessModel.h"
#import "XRModel.h"


@interface XMLYListItemModel : XMLYBaseModel 

@property (nonatomic, assign) NSInteger *cid;
@property (nonatomic, copy)   NSString  *title;
@property (nonatomic, copy)   NSString  *coverPath;

@end

@interface XMLYCategoryModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger ret;
@property (nonatomic, strong) XMLYFindDiscoverColumnsModel *discoveryColumns;
@property (nonatomic, strong) NSMutableArray <XMLYListItemModel *> *list;

@end


