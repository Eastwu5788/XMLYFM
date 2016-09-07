//
//  XMLYCategoryFooterModel.h
//  XMLYFM
//
//  Created by East_wu on 16/9/7.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseModel.h"
#import "XRModel.h"

@interface XMLYCategoryFooterAdModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger adid;
@property (nonatomic, assign) NSInteger adtype;
@property (nonatomic, copy) NSString *apkUrl;
@property (nonatomic, assign) NSInteger adAuto;
@property (nonatomic, assign) NSInteger clickType;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, assign) NSInteger displayType;
@property (nonatomic, assign) NSInteger isShareFlag;
@property (nonatomic, copy)  NSString *link;
@property (nonatomic, assign) NSInteger linkType;
@property (nonatomic, assign) NSInteger loadingShowTime;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger openlinkType;
@property (nonatomic, assign) NSInteger position;
@property (nonatomic, copy) NSString *scheme;
@property (nonatomic, copy) NSString *sharedata;
@property (nonatomic, assign) NSInteger showstyle;
@property (nonatomic, copy) NSString *thirdStatUrl;

@end


@interface XMLYCategoryFooterModel : XMLYBaseModel

@property (nonatomic, strong) NSMutableArray *adTypes;

@property (nonatomic, strong) NSMutableArray <XMLYCategoryFooterAdModel *> *data;

@end
