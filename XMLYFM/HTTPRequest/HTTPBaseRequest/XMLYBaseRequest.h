//
//  XMLYBaseRequest.h
//  XMLYFM
//
//  Created by East_wu on 16/8/9.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, XMLYHTTPType) {
    XMLYHTTPTypeGET,
    XMLYHTTPTypePOST,
};


typedef void(^XMLYHTTPRequestCompletion)(id responseObject, NSString *message, BOOL success);

@interface XMLYBaseRequest : NSObject

/**
 *  设置请求地址
 */
+ (instancetype)requestWithURL:(NSString *)url;

/**
 *  发送网络请求
 *  @param methodType 请求方式 GET POST
 *  @param params     传入参数
 *  @param completion 完成请求回调
 */
- (NSURLSessionDataTask *)startWithMethod:(XMLYHTTPType)methodType
                                   params:(id)params
                               completion:(XMLYHTTPRequestCompletion)completion;

@end
