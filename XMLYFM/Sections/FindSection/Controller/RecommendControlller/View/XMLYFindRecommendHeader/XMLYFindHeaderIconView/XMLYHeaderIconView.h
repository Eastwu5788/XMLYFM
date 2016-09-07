//
//  XMLYHeaderIconView.h
//  XMLYFM
//
//  Created by East_wu on 16/8/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLYFindHotGuessModel.h"

@interface XMLYHeaderIconView : UIView

@property (nonatomic, strong) XMLYFindDiscoverDetailModel *detailModel;

+ (instancetype)headerIconView;

- (void)configWithTitle:(NSString *)title localImageName:(NSString *)imageName;

@end
