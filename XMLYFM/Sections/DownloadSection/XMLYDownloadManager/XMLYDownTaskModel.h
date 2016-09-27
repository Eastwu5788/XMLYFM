//
//  XMLYDownTaskModel.h
//  XMLYFM
//
//  Created by East_wu on 16/9/19.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseModel.h"
#import "XMLYAlbumListModel.h"

@interface XMLYDownTaskModel : XMLYBaseModel

@property (nonatomic, strong) XMLYAlbumModel *albumModel;
@property (nonatomic, strong) XMLYAlbumTrackItemModel *trackModel;

@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;

@property (nonatomic, copy)   NSString  *destinationLocaoPath;

//@property (nonatomic, copy) void(^downloadTaskDownloadProgress)(NSInteger downloadedCount,NSInteger expectedCount);
//@property (nonatomic, copy) void(^downloadTaskCompletion)(NSURLResponse *response, NSURL *filePath, NSError *error);



@end
