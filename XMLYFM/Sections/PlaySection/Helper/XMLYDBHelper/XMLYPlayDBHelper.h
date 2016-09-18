//
//  XMLYPlayDBHelper.h
//  XMLYFM
//
//  Created by East_wu on 16/9/16.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLYPlayPageModel.h"
#import "XMLYBaseAudioModel.h"

//数据库表结构

@interface XMLYPlayDBHelper : NSObject

+ (instancetype)dbHelper;

- (void)saveCurrentPlayAudioInfo:(XMLYPlayPageModel *)playModel cachePath:(NSString *)path;

/* 更新上一次的播放数据 设置为未播放*/
- (void)updateLastPlayingRecordWithDuration:(NSInteger)time;

- (XMLYBaseAudioModel *)queryPlayingAudio;

@end
