//
//  XRClassInfo.h
//  XRModel
//
//  Created by East_wu on 16/8/25.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  Foundation 的Encoding类型
 */
typedef NS_OPTIONS(NSUInteger, XREncodingType){
    XREncodingTypeMask                  =  0xFF,  // mask    类型
    XREncodingTypeUnknown               =  0,     // unknown 类型
    XREncodingTypeVoid                  =  1,     // void    类型
    XREncodingTypeBool                  =  2,     // BOOL    类型
    XREncodingTypeInt8                  =  3,     // Int8    类型
    XREncodingTypeUInt8                 =  4,     // UInt8   类型
    XREncodingTypeInt16                 =  5,     // Int
    XREncodingTypeUInt16                =  6,     //
    XREncodingTypeInt32                 =  7,
    XREncodingTypeUInt32                =  8,
    XREncodingTypeInt64                 =  9,
    XREncodingTypeUInt64                =  10,
    XREncodingTypeFloat                 =  11,
    XREncodingTypeDouble                =  12,
    XREncodingTypeLongDouble            =  13,
    XREncodingTypeObject                =  14,
    XREncodingTypeClass                 =  15,
    XREncodingTypeSEL                   =  16,
    XREncodingTypeBlock                 =  17,
    XREncodingTypePointer               =  18,
    XREncodingTypeStruct                =  19,
    XREncodingTypeUnion                 =  20,
    XREncodingTypeCString               =  21,
    XREncodingTypeCArray                =  22,
    
    XREncodingTypeQualifierMask         = 0xFF00,
    XREncodingTypeQualifierConst        = 1 << 8,
    XREncodingTypeQualifierIn           = 1 << 9,
    XREncodingTypeQualifierInout        = 1 << 10,
    XREncodingTypeQualifierOut          = 1 << 11,
    XREncodingTypeQualifierBycopy       = 1 << 12,
    XREncodingTypeQualifierByref        = 1 << 13,
    XREncodingTypeQualifierOneway       = 1 << 14,
    
    XREncodingTypePropertyMask          = 0xFF0000,
    XREncodingTypePropertyReadonly      = 1 << 16,
    XREncodingTypePropertyCopy          = 1 << 17,
    XREncodingTypePropertyRetain        = 1 << 18,
    XREncodingTypePropertyNonatomic     = 1 << 19,
    XREncodingTypePropertyWeak          = 1 << 20,
    XREncodingTypePropertyCustomGetter  = 1 << 21,
    XREncodingTypePropertyCustomSetter  = 1 << 22,
    XREncodingTypePropertyDynamic       = 1 << 23,
};

#pragma mark - 属性参数信息 Ivar
/**
 *  存储对象的实例变量信息
 *  @property = ivar + getter + setter
 */
@interface XRClassIvarInfo : NSObject

@property (nonatomic, assign, readonly) Ivar        ivar;     //对象的实例变量
@property (nonatomic, strong, readonly) NSString    *name;    //名字
@property (nonatomic, assign, readonly) ptrdiff_t   offset;   //存储成员变量的偏移量   ptrdiff_t类型通常用来保存两个指针减法操作的结果
@property (nonatomic, strong, readonly) NSString    *typeEncoding;  //类型编码
@property (nonatomic, assign, readonly) XREncodingType type;   //Ivar的类型

/**
 *  创建并返回一个Ivar的信息存储类
 */
- (instancetype)initWithIvar:(Ivar)ivar;

@end


#pragma mark - 方法信息 Method
/**
 *  存储对象中的方法的信息类
 */
@interface XRClassMethodInfo : NSObject

@property (nonatomic, assign, readonly) Method      method;     //原始方法
@property (nonatomic, strong, readonly) NSString    *name;      //方法名称
@property (nonatomic, assign, readonly) SEL         sel;        //方法的选择器
@property (nonatomic, assign, readonly) IMP         imp;        //指向方法实现的指针，每一个方法都有一个对应的IMP
@property (nonatomic, strong, readonly) NSString    *typeEncoding; // 方法的参数和返回值类型
@property (nonatomic, strong, readonly) NSString    *returnTypeEncoding; // 方法返回值类型
@property (nullable, nonatomic, strong, readonly) NSArray<NSString *> *argumentTypeEncodings; //方法的参数类型数组  可空

/**
 *  传入Method获得方法的所有信息 生成信息类
 */
- (instancetype)initWithMethod:(Method)method;

@end

#pragma mark - 属性信息类

@interface XRClassPropertyInfo : NSObject

@property (nonatomic, assign, readonly) objc_property_t property; //属性类型，指向objc_property结构体
@property (nonatomic, strong, readonly) NSString        *name;    //属性名称
@property (nonatomic, assign, readonly) XREncodingType  type;     //属性类型
@property (nonatomic, strong, readonly) NSString        *typeEncoding; //属性类型编码
@property (nonatomic, strong, readonly) NSString        *ivarName;   //ivar名称
@property (nullable, nonatomic, assign, readonly) Class cls;         //
@property (nullable, nonatomic, strong, readonly) NSArray<NSString *> *protocols; //协议
@property (nonatomic, assign, readonly) SEL getter;               //该属性的getter方法
@property (nonatomic, assign, readonly) SEL setter;               //该属性的setter方法

/**
 *  创建属性信息类 解析属性
 *  @param property 所要处理的属性
 */
- (instancetype)initWithProperty:(objc_property_t)property;

@end


@interface XRClassInfo : NSObject

@property (nonatomic, assign, readonly) Class cls;  //原始需要处理的类对象
@property (nullable, nonatomic, assign, readonly) Class superCls; //原始需要处理的类的父类对象
@property (nullable, nonatomic, assign, readonly) Class metaCls;  //当前类的原类对象
@property (nonatomic, readonly) BOOL  isMeta;   //判断一个类是否是一个元类
@property (nonatomic, strong, readonly) NSString  *name;  //类名称
@property (nullable, nonatomic, strong, readonly) XRClassInfo *superClassInfo;  //该类的父类的类信息
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *,XRClassIvarInfo *> *ivarInfos; //存储每一个属性的基本信息  key->iVar名称
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *,XRClassMethodInfo *> *methodInfos; //存储该类的所有的方法的信息 key->method名称
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *,XRClassPropertyInfo *> *propertyInfos; //存储   key->property名称
/**
 *  获得一个类的类信息 并加以缓存
 *  在出错的情况下有可能会返回nil
 */
+ (nullable instancetype)classInfoWithClass:(Class)cls;

/**
 *  是否需要更新存储的类基本信息
 *  如果返回了YES，则需要停止调用改类的实例，并调用classInfoWithClass或者classInfoWithClassName方法
 *  用于更新类信息
 */
- (BOOL)needUpdate;

/**
 *  设置需要更新
 */
- (void)setNeedUpdate;

/**
 *  根据类名称生成类的信息
 *  @param className 类名称
 */
+ (nullable instancetype)classInfoWithClassName:(NSString *)className;

NS_ASSUME_NONNULL_END

@end
