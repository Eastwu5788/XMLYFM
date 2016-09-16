//
//  XMLYAudioItem.h
//  XMLYFM
//
//  Created by East_wu on 16/9/16.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOUAudioFile.h"

@interface XMLYAudioItem : NSObject <DOUAudioFile>

@property (nonatomic, strong) NSURL *audioFileURL;
//@property (nonatomic, strong) NSString  *audioFileHost;
//@property (nonatomic, strong) DOUAudioFilePreprocessor *audioFilePreprocessor;

@end
