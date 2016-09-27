//
//  XMLYPlayAlbumTrackAPI.h
//  XMLYFM
//
//  Created by East_wu on 16/9/15.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseAPI.h"

@interface XMLYPlayAlbumTrackAPI : XMLYBaseAPI

/*
 *  请求相册音频详情
 */
+ (void)requestPlayAlbumTrackDetailWithAblumID:(NSInteger)albumID trackUID:(NSInteger)trackID completion:(XMLYBaseAPICompletion)completion;

@end
