//
//  XMLYDownloadManager.h
//  XMLYFM
//
//  Created by East_wu on 16/9/19.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLYDownTaskModel.h"

typedef NS_ENUM(NSInteger, XMLYDownloadError) {
    XMLYDownloadErrorExists       = 0,  //当前下载任务以存在
    XMLYDownloadErrorIllegalInput = 1, //输入非法
    XMLYDownloadErrorDefined      = 1,  //当前不允许下载
    XMLYDownloadErrorMemoryNeed   = 2,  //内存不足
    XMLYDownloadErrorUnknown      = 3,  //未知错误
};

@interface XMLYDownloadManager : NSObject

+ (instancetype)manager;

/*
 * 设置一次最多有多少条下载任务
 * 默认是2条
 */
@property (nonatomic, assign) NSInteger maxDownloadCount;

/* 
 * 新增一个下载任务
 * 如果当前任务已存在，则会返回false
 * 下载任务创建成功 返回yes
 */
- (void)addDownloadTask:(XMLYDownTaskModel *)taskModel completion:(void(^)(BOOL success,XMLYDownloadError error))completion;

/*
 * 查询当前正在进行的所有下载任务
 */
- (NSMutableArray<XMLYDownTaskModel *> *)downloadTasks;

@end
