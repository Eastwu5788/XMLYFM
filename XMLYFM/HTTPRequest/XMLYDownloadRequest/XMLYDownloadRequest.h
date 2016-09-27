//
//  XMLYDownloadRequest.h
//  XMLYFM
//
//  Created by East_wu on 16/9/19.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseRequest.h"
#import "AFNetworking.h"

typedef void(^downloadCompletion)(NSURLResponse *response,NSURL *filePath,NSError *error);
typedef void(^downloadProgress)(NSInteger completedUnitCount,NSInteger totalUnitCount);

@interface XMLYDownloadRequest : XMLYBaseRequest

+ (NSURLSessionDownloadTask *)requestDownloadFromURL:(NSString *)url progress:(downloadProgress)progress destination:(NSString *)destinationPath completion:(downloadCompletion)completion;

@end
