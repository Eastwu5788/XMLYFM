//
//  XMLYBaseAudioModel.h
//  XMLYFM
//
//  Created by East_wu on 16/9/18.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseModel.h"

@interface XMLYBaseAudioModel : XMLYBaseModel

@property (nonatomic, assign) NSInteger cid;
@property (nonatomic, assign) NSInteger album_id;
@property (nonatomic, assign) NSInteger track_id;
@property (nonatomic, copy)   NSString  *album_title;
@property (nonatomic, copy)   NSString  *track_title;
@property (nonatomic, copy)   NSString  *coverSmall;
@property (nonatomic, assign) NSInteger time_history;
@property (nonatomic, assign) NSInteger isPlaying;
@property (nonatomic, copy)   NSString  *cachePath;

@end
