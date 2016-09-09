//
//  XMLYFindAnchorModel.h
//  XMLYFM
//
//  Created by East_wu on 16/9/8.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseModel.h"
#import "XRModel.h"

@interface XMLYAnchorCellModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, copy) NSString  *nickname;
@property (nonatomic, copy) NSString  *smallLogo;
@property (nonatomic, copy) NSString  *middleLogo;
@property (nonatomic, copy) NSString  *largeLogo;
@property (nonatomic, assign) BOOL    isVerified;
@property (nonatomic, assign) NSInteger tracksCounts;
@property (nonatomic, assign) NSInteger followersCounts;
@property (nonatomic, copy) NSString  *personDescirbe;
@property (nonatomic, copy) NSString  *verifyTitle;

@end

@interface XMLYAnchorSectionModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger cid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger displayStyle;
@property (nonatomic, strong) NSMutableArray<XMLYAnchorCellModel *> *list;

@end

@interface XMLYFindAnchorModel : XMLYBaseModel

@property (nonatomic, strong) NSMutableArray<XMLYAnchorSectionModel *> *dataSource;

// 二维数组
@property (nonatomic, strong) NSMutableArray<XMLYAnchorSectionModel *> *famous;

@property (nonatomic, strong) NSMutableArray<XMLYAnchorSectionModel *> *normal;

- (void)createDataSource;

@end
