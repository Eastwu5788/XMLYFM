//
//  XMLYBaseRequest.m
//  XMLYFM
//
//  Created by East_wu on 16/8/9.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseRequest.h"
#import "AFNetworking.h"

@interface XMLYBaseRequest ()

@property (nonatomic, copy) NSString *urlString;

@property (nonatomic, copy) XMLYHTTPRequestCompletion completionBlock;

@property (nonatomic, strong) AFHTTPSessionManager    *sessionManager;

@end

@implementation XMLYBaseRequest

/**
 *  设置请求地址
 */
+ (instancetype)requestWithURL:(NSString *)url {
    XMLYBaseRequest *request = [[XMLYBaseRequest alloc] init];
    request.urlString = url;
    return request;
}

/**
 *  发送网络请求
 *  @param methodType 请求方式 GET POST
 *  @param params     传入参数
 *  @param completion 完成请求回调
 */
- (NSURLSessionDataTask *)startWithMethod:(XMLYHTTPType)methodType
                                   params:(id)params
                               completion:(XMLYHTTPRequestCompletion)completion {
    NSURLSessionDataTask *task = nil;
    self.completionBlock = completion;
    self.sessionManager = [self sessionManagerWithParams:params];
    if(methodType == XMLYHTTPTypeGET) {
        task = [self.sessionManager GET:[self.urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(self.completionBlock) {
                self.completionBlock(responseObject,nil,YES);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(self.completionBlock) {
                self.completionBlock(nil,nil,NO);
            }
        }];
    }else if(methodType == XMLYHTTPTypePOST) {
        task = [self.sessionManager POST:[self.urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(self.completionBlock) {
                self.completionBlock(responseObject,nil,YES);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(self.completionBlock) {
                self.completionBlock(nil,nil,NO);
            }
        }];
    }
    return nil;
}




- (AFHTTPSessionManager *)sessionManagerWithParams:(NSDictionary *)params {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = 30.0f;
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:config];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript", @"text/html", nil];
    return sessionManager;
}


@end
