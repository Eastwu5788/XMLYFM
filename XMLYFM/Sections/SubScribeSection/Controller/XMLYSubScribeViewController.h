//
//  XMLYSubScribeViewController.h
//  XMLYFM
//
//  Created by East_wu on 16/8/8.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLYFindBaseController.h"

typedef NS_ENUM(NSInteger, XMLYSubScirbeStyle) {
    XMLYSubScirbeStyleScribe   = 0,  //订阅听
    XMLYSubScirbeStyleDownload = 1, //下载听
};

@interface XMLYSubScribeViewController : XMLYFindBaseController

//现在是从storyboard加载控制器，过段时间全部换成纯代码加载，订阅听和下载听可以共用一个控制器
+ (instancetype)subScribeViewController:(XMLYSubScirbeStyle)style;

@end
