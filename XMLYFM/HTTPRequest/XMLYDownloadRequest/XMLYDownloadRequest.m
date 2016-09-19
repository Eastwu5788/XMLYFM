//
//  XMLYDownloadRequest.m
//  XMLYFM
//
//  Created by East_wu on 16/9/19.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYDownloadRequest.h"

@implementation XMLYDownloadRequest

+ (NSURLSessionDownloadTask *)requestDownloadFromURL:(NSString *)url progress:(downloadProgress )progress destination:(NSString *)destinationPath completion:(downloadCompletion)completion {
    // 地址
    NSURL *subUrl = [NSURL URLWithString:url];
    if(!subUrl) return nil;
    
    // 配置
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:subUrl];
    
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        if(progress) {
            progress(downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL fileURLWithPath:destinationPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if(completion) {
            completion(response,filePath,error);
        }
    }];
    
    [task resume];
    
    return task;
}


@end
