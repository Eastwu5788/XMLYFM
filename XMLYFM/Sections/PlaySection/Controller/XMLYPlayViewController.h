//
//  XMLYPlayViewController.h
//  XMLYFM
//
//  Created by East_wu on 16/8/8.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseController.h"

@interface XMLYPlayViewController : XMLYBaseController

+ (instancetype)playViewController;

- (void)startPlayWithAlbumID:(NSInteger)albumID trackID:(NSInteger)trackID;

@end
