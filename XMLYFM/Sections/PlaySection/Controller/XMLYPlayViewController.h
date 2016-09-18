//
//  XMLYPlayViewController.h
//  XMLYFM
//
//  Created by East_wu on 16/8/8.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseController.h"
#import "XMLYPlayPageModel.h"
#import "XMLYAudioHelper.h"

@interface XMLYPlayViewController : XMLYBaseController

@property (nonatomic, strong) XMLYPlayPageModel *model;
@property (nonatomic, assign) DOUAudioStreamerStatus status;

@property (nonatomic, assign) NSInteger    progress;

@property (nonatomic, copy) void(^playViewControllerStatusChangeBlock)(DOUAudioStreamerStatus status);

+ (instancetype)playViewController;

- (void)startPlayWithAlbumID:(NSInteger)albumID trackID:(NSInteger)trackID cachePath:(NSString *)cachePath;

- (void)saveCurrentPlayHistory;

@end
