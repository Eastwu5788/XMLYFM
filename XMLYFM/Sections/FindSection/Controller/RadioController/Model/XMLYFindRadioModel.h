//
//  XMLYFindRadioModel.h
//  XMLYFM
//
//  Created by East_wu on 16/9/7.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseModel.h"
#import "XRModel.h"

typedef NS_ENUM(NSInteger, XMLYFindRadioTelCellStyle) {
    XMLYFindRadioTelCellStyleHidden = 0, //隐藏
    XMLYFindRadioTelCellStyleShow   = 1, //显示全部
};

@interface XMLYFindRadioCategoryItem : XMLYBaseModel

@property (nonatomic, assign) NSInteger cid;
@property (nonatomic, copy) NSString  *name;

@end

@interface XMLYPlayModel : XMLYBaseModel
@property (nonatomic, copy) NSString *aac24;
@property (nonatomic, copy) NSString *aac64;
@property (nonatomic, copy) NSString *ts24;
@property (nonatomic, copy) NSString *ts64;
@end

@interface XMLYFindRadioInfoModel : XMLYBaseModel

@property (nonatomic, copy) NSString *coverLarge;
@property (nonatomic, copy) NSString *coverSmall;
@property (nonatomic, assign) NSInteger fmUid;
@property (nonatomic, assign) NSInteger cid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger playCount;
@property (nonatomic, assign) NSInteger programId;
@property (nonatomic, copy) NSString *programName;
@property (nonatomic, assign) NSInteger programScheduleId;

@end

@interface XMLYFindRadioModel : XMLYBaseModel

@property (nonatomic, assign) XMLYFindRadioTelCellStyle style;

@property (nonatomic, strong) NSMutableArray<XMLYFindRadioCategoryItem *> *categories;
@property (nonatomic, strong) NSMutableArray<XMLYFindRadioInfoModel *> *localRadios;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, strong) NSMutableArray<XMLYFindRadioInfoModel *> *topRadios;

@end
