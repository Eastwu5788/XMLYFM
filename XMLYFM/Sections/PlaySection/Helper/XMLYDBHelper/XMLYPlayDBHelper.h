//
//  XMLYPlayDBHelper.h
//  XMLYFM
//
//  Created by East_wu on 16/9/16.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLYPlayPageModel.h"


//数据库表结构


@interface XMLYPlayDBHelper : NSObject

+ (instancetype)dbHelper;

- (void)saveCurrentPlayAudioInfo:(XMLYPlayPageModel *)playModel;

/* 更新上一次的播放数据 设置为未播放*/
- (void)updateLastPlayingRecord;

@end
