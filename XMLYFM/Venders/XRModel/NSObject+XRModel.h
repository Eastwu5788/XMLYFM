//
//  NSObject+XRModel.h
//  XRModel
//
//  Created by East_wu on 16/8/25.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (XRModel)

/**
 *  将json数据转换成模型
 *  可接受数据类型: NSDictionary、NSString、NSData
 */
+ (instancetype)xr_modelWithJSON:(id)json;
/**
 *  将NSDictionary字典转换成模型 xr_modelWithJSON最终调用的是此方法
 */
+ (instancetype)xr_modelWithDictionary:(NSDictionary *)dictionary;
/**
 *  通过json设置对象的属性
 */
- (BOOL)xr_modelSetWithJSON:(id)json;

/**
 *  通过字典设置模型对象的属性
 */
- (BOOL)xr_modelSetWithDictionary:(NSDictionary *)dic;

/**
 *  根据模型生成JSON对象
 */
- (nullable id)xr_modelToJSONObject;

/**
 *  模型转换成JSON二进制
 */
- (nullable NSData *)xr_modelToJSONData;

/**
 *  模型转换成JSON字符串
 */
- (nullable NSString *)xr_modelToJSONString;

/**
 *  复制一个模型
 */
- (nullable id)xr_modelCopy;
/**
 *  实现NSCodin
 */
- (void)xr_modelEncodeWithCoder:(NSCoder *)aCoder;
- (id)xr_modelInitWithCoder:(NSCoder *)aDecoder;

- (NSString *)xr_modelDescription;

@end


@protocol XRModel <NSObject>

@optional


/**
 *  代理
 *  获取用户体统的黑名单  在模型转换的的时候所有的黑名单中的属性都将会被忽略
 */
+ (nullable NSArray<NSString *> *)modelPropertyBlacklist;

/**
 *  代理
 *  向用户获取白名单，不在白名单中的属性在模型转换的时候将会被忽略
 */
+ (nullable NSArray<NSString *> *)modelPropertyWhitelist;

/**
 *  代理
 *  向用户获取类的属性映射 exp: @"userInfo": @"XRUserInfo"
 */
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass;

/**
 *  如果需要创建一个不同类的实例，则需要实现该函数
 */
+ (nullable Class)modelCustomClassForDictionary:(NSDictionary *)dictionary;

/**
 *  json Key与属性名转换映射
 */
- (nullable NSDictionary<NSString *,id> *)modelCustomPropertyMapper;

- (NSDictionary *)modelCustomWillTransformFromDictionary:(NSDictionary *)dic;
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic;
- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic;
@end

NS_ASSUME_NONNULL_END