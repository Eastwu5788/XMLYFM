//
//  NSObject+XRModel.m
//  XRModel
//
//  Created by East_wu on 16/8/25.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "NSObject+XRModel.h"
#import "XRClassInfo.h"
#import <objc/message.h>


#define force_inline __inline__ __attribute__((always_inline))

/**
 *  Fundation框架的基本数据类型
 */
typedef NS_ENUM(NSUInteger, XREncodingNSType){
    XREncodingTypeNSUnknown           = 0, //未知类型
    XREncodingTypeNSString            = 1, //NSString 类型
    XREncodingTypeNSMutableString     = 2, //NSMutableString 类型
    XREncodingTypeNSValue             = 3, //NSValue 类型
    XREncodingTypeNSNumber            = 4, //NSNumber 类型
    XREncodingTypeNSDecimalNumber     = 5, //NSDecimalNumber 类型
    XREncodingTypeNSData              = 6, //NSData 类型
    XREncodingTypeNSMutableData       = 7, //NSMutableData 类型
    XREncodingTypeNSDate              = 8, //NSDate  类型
    XREncodingTypeNSURL               = 9, //NSURL  类型
    XREncodingTypeNSArray             = 10, //NSArray 类型
    XREncodingTypeNSMutableArray      = 11, //NSMutableArray 类型
    XREncodingTypeNSDictionary        = 12, //NSDictionary 类型
    XREncodingTypeNSMutableDictionary = 13, //NSMutableDictionary 类型
    XREncodingTypeNSSet               = 14, //NSSet 类型
    XREncodingTypeNSMutableSet        = 15, //NSMutableSet 类型
};

/**
 *  C函数 根据Class获取他的NSType
 */
static force_inline XREncodingNSType XRClassGetNSType(Class cls) {
    if(!cls) return XREncodingTypeNSUnknown;
    if([cls isSubclassOfClass:[NSMutableString class]]) return XREncodingTypeNSMutableString;
    if([cls isSubclassOfClass:[NSString class]]) return XREncodingTypeNSString;
    if([cls isSubclassOfClass:[NSDecimalNumber class]]) return XREncodingTypeNSDecimalNumber;
    if([cls isSubclassOfClass:[NSNumber class]]) return XREncodingTypeNSNumber;
    if([cls isSubclassOfClass:[NSValue class]]) return XREncodingTypeNSValue;
    if([cls isSubclassOfClass:[NSMutableData class]]) return XREncodingTypeNSMutableData;
    if([cls isSubclassOfClass:[NSData class]]) return XREncodingTypeNSData;
    if([cls isSubclassOfClass:[NSDate class]]) return XREncodingTypeNSDate;
    if([cls isSubclassOfClass:[NSURL class]]) return XREncodingTypeNSURL;
    if([cls isSubclassOfClass:[NSMutableArray class]]) return XREncodingTypeNSMutableArray;
    if([cls isSubclassOfClass:[NSArray class]]) return XREncodingTypeNSArray;
    if([cls isSubclassOfClass:[NSMutableDictionary class]]) return XREncodingTypeNSMutableDictionary;
    if([cls isSubclassOfClass:[NSDictionary class]]) return XREncodingTypeNSDictionary;
    if([cls isSubclassOfClass:[NSMutableSet class]]) return XREncodingTypeNSMutableSet;
    if([cls isSubclassOfClass:[NSSet class]]) return XREncodingTypeNSSet;
    return XREncodingTypeNSUnknown;
}

/**
 *  C函数，根据XREncodingType判断是否是Number类型
 */
static force_inline BOOL XREncodingTypeIsCNumber(XREncodingType type) {
    switch (type & XREncodingTypeMask) {
        case XREncodingTypeBool:
        case XREncodingTypeInt8:
        case XREncodingTypeUInt8:
        case XREncodingTypeInt16:
        case XREncodingTypeUInt16:
        case XREncodingTypeInt32:
        case XREncodingTypeUInt32:
        case XREncodingTypeInt64:
        case XREncodingTypeUInt64:
        case XREncodingTypeFloat:
        case XREncodingTypeDouble:
        case XREncodingTypeLongDouble: return YES;
        default: return NO;
    }
}

/**
 *  属性映射信息
 */
@interface XRModelPropertyMeta : NSObject {
    @package
    NSString *_name;        //属性名称
    XREncodingType _type;   //属性类型
    XREncodingNSType _nsType; //NS属性类型
    BOOL  _isCNumber;        //是否是C语言类型的数字
    Class _cls;              //属性的类
    Class _genericCls;       //属性映射的类
    SEL  _getter;            //getter方法
    SEL  _setter;            //setter方法
    BOOL _isKVCCompatible;   //
    BOOL _isStructAvailableForKeyedArchiver; //
    BOOL _hasCustomClassFromDictionary;  //
    
    NSString *_mappedToKey;   //加映射的对象
    NSArray *_mappedToKeyPath; //userInfo.nickname 这样的层层路径 存储了[@"userInfo",@"nickname"]
    NSArray *_mappedToKeyArray;
    XRClassPropertyInfo *_info;  //属性基本信息
    XRModelPropertyMeta *_next;  //
}
@end


static force_inline id XRValueForKeyPath(__unsafe_unretained NSDictionary *dic, __unsafe_unretained NSArray *keyPaths) {
    id value = nil;
    for(NSUInteger i = 0, max = keyPaths.count; i < max; i++) {
        value = dic[keyPaths[i]];
        if(i + 1 < max) {
            if([value isKindOfClass:[NSDictionary class]]) {
                dic = value;
            } else{
                return nil;
            }
        }
    }
    return value;
}

static force_inline id XRValueForMultikeys(__unsafe_unretained NSDictionary *dic,__unsafe_unretained NSArray *multiKeys) {
    id value = nil;
    for(NSString *key in multiKeys) {
        if([key isKindOfClass:[NSString class]]) {
            value = dic[key];
            if(value) break;
        } else  {
            value = XRValueForKeyPath(dic, (NSArray *)key);
            if(value) break;
        }
    }
    return value;
}


@implementation XRModelPropertyMeta
+ (instancetype)metaWithClassInfo:(XRClassInfo *)classInfo propertyInfo:(XRClassPropertyInfo *)propertyInfo generic:(Class)generic {
    //如果属性没有被映射，但是它实现了某一个代理，则它就相当于有了一个映射
    if(!generic && propertyInfo.protocols) {
        for(NSString *protocol in propertyInfo.protocols) {
            Class cls = objc_getClass(protocol.UTF8String);
            if(cls) {
                generic = cls;
                break;
            }
        }
    }
    
    XRModelPropertyMeta *meta = [self new];
    meta->_name = propertyInfo.name;
    meta->_type = propertyInfo.type;
    meta->_info = propertyInfo;
    meta->_genericCls = generic;
    
    //如果当前属性是一个对象，则需要获得NSNumber类型
    if((meta->_type & XREncodingTypeMask) == XREncodingTypeObject) {
        meta->_nsType = XRClassGetNSType(propertyInfo.cls);
    }
    else {
        meta->_isCNumber = XREncodingTypeIsCNumber(meta->_type);
    }
    
    //如果当前属性是一个结构体 判断结构体
    if((meta->_type & XREncodingTypeMask) == XREncodingTypeStruct) {
        static NSSet *types = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            NSMutableSet *set = [NSMutableSet new];
            
            // 32 bit
            [set addObject:@"{CGSize=ff}"];
            [set addObject:@"{CGPoint=ff}"];
            [set addObject:@"{CGRect={CGPoint=ff}{CGSize=ff}}"];
            [set addObject:@"{CGAffineTransform=ffffff}"];
            [set addObject:@"{UIEdgeInsets=ffff}"];
            [set addObject:@"{UIOffset=ff}"];
            // 64 bit
            [set addObject:@"{CGSize=dd}"];
            [set addObject:@"{CGPoint=dd}"];
            [set addObject:@"{CGRect={CGPoint=dd}{CGSize=dd}}"];
            [set addObject:@"{CGAffineTransform=dddddd}"];
            [set addObject:@"{UIEdgeInsets=dddd}"];
            [set addObject:@"{UIOffset=dd}"];
            types = set;
        });
        if([types containsObject:propertyInfo.typeEncoding]) {
            meta->_isStructAvailableForKeyedArchiver = YES;
        }
    }
    meta->_cls = propertyInfo.cls;
    
    //映射对象是一个不同的对象
    if(generic) {
        meta->_hasCustomClassFromDictionary = [generic respondsToSelector:@selector(modelCustomClassForDictionary:)];
    }
    //映射的对象类型未知
    else if(meta->_cls && meta->_nsType == XREncodingTypeNSUnknown) {
        meta->_hasCustomClassFromDictionary = [meta->_cls respondsToSelector:@selector(modelCustomClassForDictionary:)];
    }
    
    //设置setter和getter方法
    if(propertyInfo.getter) {
        if([classInfo.cls instancesRespondToSelector:propertyInfo.getter]) {
            meta->_getter = propertyInfo.getter;
        }
    }
    
    if(propertyInfo.setter) {
        if([classInfo.cls instancesRespondToSelector:propertyInfo.setter]) {
            meta->_setter = propertyInfo.setter;
        }
    }
    
    if(meta->_getter && meta->_setter) {
        switch (meta->_type & XREncodingTypeMask) {
            case XREncodingTypeBool:
            case XREncodingTypeInt8:
            case XREncodingTypeUInt8:
            case XREncodingTypeInt16:
            case XREncodingTypeUInt16:
            case XREncodingTypeInt32:
            case XREncodingTypeUInt32:
            case XREncodingTypeInt64:
            case XREncodingTypeUInt64:
            case XREncodingTypeFloat:
            case XREncodingTypeDouble:
            case XREncodingTypeObject:
            case XREncodingTypeClass:
            case XREncodingTypeBlock:
            case XREncodingTypeStruct:
            case XREncodingTypeUnion: {
                meta->_isKVCCompatible = YES;
            } break;
            default: break;
        }
    }
    
    return meta;
}
@end




/**
 *  模型的属性模型，存储了该类的所有属性
 *  @package framework外不可见
 */
@interface XRModelMeta : NSObject {
    @package
    XRClassInfo   *_classInfo;
    // key:  value:XRModelPropertyMeta
    NSDictionary  *_mapper;
    // Array<XRModelPropertyMeta>  该类的所有属性
    NSArray       *_allPropertyMetas;
    // Array<XRModelPropertyMeta>  属性对应的路径
    NSArray       *_keyPathPropertyMetas;
    // Array<XRModelPropertyMeta>  一个属性对象多个key
    NSArray       *_multiKeysPropertyMetas;
    // 映射的数量
    NSUInteger    _keyMappedCount;
    // 模型的类型
    XREncodingNSType      _nsType;
    
    // 属性中存在需要从字典转换成模型的字段
    BOOL  _hasCustomWillTransformFromDictionary;
    // 需要从字段转换成模型
    BOOL  _hasCustomTransformFromDictionary;
    // 需要从模型转换成字典
    BOOL  _hasCustomTransformToDictionary;
    // 需要
    BOOL  _hasCustomClassFromDictionary;
}

@end

@implementation XRModelMeta

/**
 *  解析出类的所有类的meta并缓存
 *
 *  成员方法记录在class 的method-list中， 类方法记录在meta-class中
 *  Class是实例对象的类类型。当我们向实例对象发送消息时（调用实例方法），我们在method-list中查找相应的函数
 *  如果没找到匹配的响应函数，则在该class的父类中的method-list中查找
 *
 *  关于CFMutableDictionaryRef: http://www.jianshu.com/p/23a46ac9e3ba
 *  关于dispatch_semaphore: http://www.jianshu.com/p/33a2dd3ba6a0
 */
+ (instancetype)metaWithClass:(Class)cls {
    //1.检查输入
    if(!cls) return nil;
    //2.创建用于缓存的数据结果
    static CFMutableDictionaryRef cache;
    static dispatch_once_t onceToken;
    //4.信号量 用于创建并发队列
    static dispatch_semaphore_t lock;
    dispatch_once(&onceToken, ^{
        cache = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        lock = dispatch_semaphore_create(1);
    });
    //5.使用semaphore锁，实现对CFMutableDictionaryRef进行加锁，保证同一时间只能有一次存取值得操作
    dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
    //6.取出缓存的值
    XRModelMeta *meta = CFDictionaryGetValue(cache, (__bridge const void *)(cls));
    dispatch_semaphore_signal(lock);
    if(!meta || meta->_classInfo.needUpdate) {
        //7.如果缓存中不存在或者取出的数据需要更新，则重新创建该类
        meta = [[XRModelMeta alloc] initWithClass:cls];
        if(meta) {
            //8.将新创建成功的数据存储到字典中 此处同样加了资源锁
            dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
            CFDictionarySetValue(cache, (__bridge const void *)(cls), (__bridge const void *)(meta));
            dispatch_semaphore_signal(lock);
        }
    }
    return meta;
}

/**
 *  初始化模型
 */
- (instancetype)initWithClass:(Class)cls {
    XRClassInfo *classInfo = [XRClassInfo classInfoWithClass:cls];
    if(!classInfo) return nil;;
    self = [super init];
    
    //获取用户提供的黑名单
    NSSet *blacklist = nil;
    if([cls respondsToSelector:@selector(modelPropertyBlacklist)]) {
        NSArray *properties = [(id<XRModel>)cls modelPropertyBlacklist];
        if(properties) {
            blacklist = [NSSet setWithArray:properties];
        }
    }
    
    //获取用户提供的白名单
    NSSet *whitelist = nil;
    if([cls respondsToSelector:@selector(modelPropertyWhitelist)]) {
        NSArray *properties = [(id<XRModel>)cls modelPropertyWhitelist];
        if(properties) {
            whitelist = [NSSet setWithArray:properties];
        }
    }
    
    //获取用户提供的属性类型映射 告诉XRModel某一个属性是另外一个类
    //genericMapper 存储了所有需要转换的属性，和转换后的类型 key:属性名 value:所对应的类
    NSDictionary *genericMapper = nil;
    if([cls respondsToSelector:@selector(modelContainerPropertyGenericClass)]) {
        //1.获取用户提供的映射表
        genericMapper = [(id<XRModel>)cls modelContainerPropertyGenericClass];
        if(genericMapper) {
            NSMutableDictionary *tmp = [NSMutableDictionary new];
            //2.对用户体统的映射表进行处理，过滤掉不符合要求的参数，并格式化
            [genericMapper enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                //过滤不符合要求的参数
                if(![key isKindOfClass:[NSString class]]) return;
                
                //如果用户提供的表值不是一个类，只是基本类型，则忽略
                Class meta = object_getClass(obj);
                if(!meta) return;
                
                //如果用户提供的是 key : Class 这种类型的， 直接存储
                if(class_isMetaClass(meta)) {
                    tmp[key] = obj;
                }
                //如果用户提供的obj仅是一个类名，则需要将类名转换成相应的类，然后再近些存储
                else if([obj isKindOfClass:[NSString class]]) {
                    Class cls = NSClassFromString(obj);
                    if(cls) {
                        tmp[key] = cls;
                    }
                }
            }];
            genericMapper = tmp;
        }
    }
    
    //从子类一层一层处理到父类
    NSMutableDictionary *allPropertyMetas = [NSMutableDictionary new];
    XRClassInfo *curClassInfo = classInfo;
    while (curClassInfo && curClassInfo.superCls != nil) {
        
        //对当前类、和父类中的每一个属性进行处理，
        for (XRClassPropertyInfo *propertyInfo in curClassInfo.propertyInfos.allValues) {
            if(!propertyInfo.name) continue;
            if(blacklist && [blacklist containsObject:propertyInfo.name]) continue; //忽略黑名单中的属性
            if(whitelist && ![whitelist containsObject:propertyInfo.name]) continue; //忽略不在白名单中的属性
            
            //需要处理的属性
            XRModelPropertyMeta *meta = [XRModelPropertyMeta metaWithClassInfo:classInfo propertyInfo:propertyInfo generic:genericMapper[propertyInfo.name]];
            if(!meta || !meta->_name) continue;
            if(!meta->_getter || !meta->_setter) continue;
            if(allPropertyMetas[meta->_name]) continue;
            
            allPropertyMetas[meta->_name] = meta;
        }
        
        curClassInfo = curClassInfo.superClassInfo;
    }
    
    //_allPropertyMetas存储了所有需要处理的属性信息
    if(allPropertyMetas.count) {
        _allPropertyMetas = allPropertyMetas.allValues.copy;
    }
    
    //处理类中的属性名与JSON中的key不对应的情况
    NSMutableDictionary *mapper = [NSMutableDictionary new];
    NSMutableArray *keyPathPropertyMetas = [NSMutableArray new];
    NSMutableArray *multiKeysPropertyMetas = [NSMutableArray new];
    if([cls respondsToSelector:@selector(modelCustomPropertyMapper)]) {
        //属性名称映射字典
        NSDictionary *customMapper = [(id <XRModel>)cls modelCustomPropertyMapper];
        [customMapper enumerateKeysAndObjectsUsingBlock:^(NSString  *propertyName, NSString *mappedToKey, BOOL * _Nonnull stop) {
            //如果该属性被标记为忽略，则需要处理
            XRModelPropertyMeta *propertyMeta = allPropertyMetas[propertyName];
            if(!propertyMeta) return ;
            //需要将前面的映射表删除，应为映射发生了变化
            [allPropertyMetas removeObjectForKey:propertyName];
            
            //key 转换成另一个key
            if([mappedToKey isKindOfClass:[NSString class]]) {
                //传入的是空值，则忽略
                if(mappedToKey.length == 0) return;
                
                //重置映射地址
                propertyMeta->_mappedToKey = mappedToKey;
                
                //去除空的路径 userInfo..nickname
                NSArray *keyPath = [mappedToKey componentsSeparatedByString:@"."];
                for(NSString *onePath in keyPath) {
                    if(onePath.length == 0) {
                        NSMutableArray *tmp = keyPath.mutableCopy;
                        [tmp removeObject:@""];
                        keyPath = tmp;
                        break;
                    }
                }
                
                //去除完成后，存储路径
                if(keyPath.count > 1) {
                    propertyMeta->_mappedToKeyPath = keyPath;
                    [keyPathPropertyMetas addObject:propertyMeta];
                }
                
                //把新的propertyMeta放到mapper字典中
                propertyMeta->_next = mapper[mappedToKey] ? : nil;
                //将处理后的propertyMeta存储到mapper中
                mapper[mappedToKey] = propertyMeta;
            }
            //处理多个json key对应一个 属性值的情况 @“userID” : @[@"id",@"ID",@"uid"]
            else if([mappedToKey isKindOfClass:[NSArray class]]) {
                NSMutableArray *mappedToKeyArray = [NSMutableArray new];
                for(NSString *oneKey in (NSArray *)mappedToKey) {
                    //去除不合法的情况
                    if(![oneKey isKindOfClass:[NSString class]]) continue;
                    if(oneKey.length == 0) continue;
                    //处理含有user.id的情况
                    NSArray *keyPath = [oneKey componentsSeparatedByString:@"."];
                    if(keyPath.count > 1) {
                        [mappedToKeyArray addObject:keyPath];
                    }else{
                        [mappedToKeyArray addObject:oneKey];
                    }
                    
                    if(!propertyMeta->_mappedToKey) {
                        propertyMeta->_mappedToKey = oneKey;
                        propertyMeta->_mappedToKeyPath = keyPath.count > 1 ? keyPath : nil;
                    }
                }
                if(!propertyMeta->_mappedToKey) return;
                
                //属性映射一个数组
                propertyMeta->_mappedToKeyArray = mappedToKeyArray;
                [multiKeysPropertyMetas addObject:propertyMeta];
                
                propertyMeta->_next = mapper[mappedToKey] ? : nil;
                mapper[mappedToKey] = propertyMeta;
            }
        }];
    }
    
    [allPropertyMetas enumerateKeysAndObjectsUsingBlock:^(NSString *name, XRModelPropertyMeta  *propertyMeta, BOOL * _Nonnull stop) {
        propertyMeta->_mappedToKey = name;
        propertyMeta->_next = mapper[name] ? : nil;
        mapper[name] = propertyMeta;
    }];
    
    if(mapper.count) _mapper = mapper;
    if(keyPathPropertyMetas) _keyPathPropertyMetas = keyPathPropertyMetas;
    if(multiKeysPropertyMetas) _multiKeysPropertyMetas = multiKeysPropertyMetas;
    
    _classInfo = classInfo;
    _keyMappedCount = _allPropertyMetas.count;
    _nsType = XRClassGetNSType(cls);
    _hasCustomWillTransformFromDictionary = ([cls instancesRespondToSelector:@selector(modelCustomWillTransformFromDictionary:)]);
    _hasCustomTransformFromDictionary = ([cls instancesRespondToSelector:@selector(modelCustomTransformFromDictionary:)]);
    _hasCustomTransformToDictionary = ([cls instancesRespondToSelector:@selector(modelCustomTransformToDictionary:)]);
    _hasCustomClassFromDictionary = ([cls respondsToSelector:@selector(modelCustomClassForDictionary:)]);
    
    return self;
}

@end

/**
 *  处理将value转换成NSNumberler类型
 */
static force_inline NSNumber *XRNumberCreateFromID(__unsafe_unretained id value) {
    /**
     *  初始化需要预处理的东西
     */
    static NSCharacterSet *dot;
    static NSDictionary *dic;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dot = [NSCharacterSet characterSetWithRange:NSMakeRange('.', 1)];
        dic = @{@"TRUE":@(YES),
                @"True":@(YES),
                @"true":@(YES),
                @"FALSE":@(NO),
                @"False":@(NO),
                @"false":@(NO),
                @"YES":@(YES),
                @"Yes":@(YES),
                @"yes":@(YES),
                @"NO":@(NO),
                @"No":@(NO),
                @"no":@(NO),
                @"NIL":(id)kCFNull,
                @"Nil":(id)kCFNull,
                @"nil":(id)kCFNull,
                @"NULL":(id)kCFNull,
                @"Null":(id)kCFNull,
                @"null":(id)kCFNull,
                @"(NULL)":(id)kCFNull,
                @"(Null)":(id)kCFNull,
                @"(null)":(id)kCFNull,
                @"<NULL>":(id)kCFNull,
                @"<Null>":(id)kCFNull,
                @"<null>":(id)kCFNull};
    });
    
    //检查用户输入
    if (!value || value == (id)kCFNull) return nil;
    //如果输入本来就是NSNumber类型，则不需要操作任何处理
    if ([value isKindOfClass:[NSNumber class]]) return value;
    //处理字符串，将字符串转换成NSNumber类型
    if ([value isKindOfClass:[NSString class]]) {
        //如果value是true,yes..这种类型，则直接处理
        NSNumber *num = dic[value];
        if(num) {
            if(num == (id)kCFNull) return nil;
            return num;
        }
        
        //如果字符串中有小数点， 则需要转换成浮点数 atof C函数
        if([(NSString *)value rangeOfCharacterFromSet:dot].location != NSNotFound) {
            const char *cstring = ((NSString *)value).UTF8String;
            if(!cstring) return nil;
            double num = atof(cstring);
            if(isnan(num) || isinf(num)) return nil;
            return @(num);
        }
        else {
            //把字符串转成长整型 atoll C函数
            const char *cstring = ((NSString *)value).UTF8String;
            if(!cstring) return nil;
            return @(atoll(cstring));
        }
    }
    return nil;
}

/**
 *  将Number属性转换成NSNumber
 *  @param model 需要处理的模型
 *  @param meta  属性模型
 */
static force_inline NSNumber *ModelCreateNumberFromProperty(__unsafe_unretained id model, __unsafe_unretained XRModelPropertyMeta *meta) {
    switch (meta->_type & XREncodingTypeMask) {
        case XREncodingTypeBool: {
            return @(((bool (*)(id, SEL))(void *)objc_msgSend)((id)model,meta->_getter));
        } break;
        case XREncodingTypeInt8: {
            return @(((int8_t (*)(id, SEL))(void *)objc_msgSend)((id)model,meta->_getter));
        } break;
        case XREncodingTypeUInt8: {
            return @(((uint8_t (*)(id, SEL))(void *)objc_msgSend)((id)model,meta->_getter));
        } break;
        case XREncodingTypeInt16: {
            return @(((int16_t (*)(id, SEL))(void *)objc_msgSend)((id)model,meta->_getter));
        } break;
        case XREncodingTypeUInt16: {
            return @(((uint16_t (*)(id, SEL))(void *)objc_msgSend)((id)model,meta->_getter));
        } break;
        case XREncodingTypeInt32: {
            return @(((int32_t (*)(id, SEL))(void *)objc_msgSend)((id)model,meta->_getter));
        } break;
        case XREncodingTypeUInt32: {
            return @(((uint32_t (*)(id, SEL))(void *)objc_msgSend)((id)model,meta->_getter));
        } break;
        case XREncodingTypeInt64: {
            return @(((int64_t (*)(id, SEL))(void *)objc_msgSend)((id)model,meta->_getter));
        } break;
        case XREncodingTypeUInt64: {
            return @(((uint64_t (*)(id, SEL))(void *)objc_msgSend)((id)model,meta->_getter));
        } break;
        case XREncodingTypeFloat: {
            float num = ((float (*)(id, SEL))(void *)objc_msgSend)((id)model,meta->_getter);
            if(isnan(num) || isinf(num)) return nil;
            return @(num);
        } break;
        case XREncodingTypeDouble: {
            double num = ((double (*)(id, SEL))(void *)objc_msgSend)((id)model,meta->_getter);
            if(isnan(num) || isinf(num)) return nil;
            return @(num);
        } break;
        case XREncodingTypeLongDouble: {
            double num = ((long double (*)(id, SEL))(void *)objc_msgSend)((id)model,meta->_getter);
            if(isnan(num) || isinf(num)) return nil;
            return @(num);
        } break;
        default: return nil;
    }
}

/**
 *  将NSNumber类型的属性赋值给属性
 *
 *  @param model 要操作的model
 *  @param num   需要赋值的参数
 *  @param meta  属性模型
 */
static force_inline void ModelSetNumberToProperty(__unsafe_unretained id model, __unsafe_unretained NSNumber *num, __unsafe_unretained XRModelPropertyMeta *meta) {
    switch (meta->_type & XREncodingTypeMask) {
        case XREncodingTypeBool: {
            ((void (*)(id, SEL, bool))(void *)objc_msgSend)((id)model, meta->_setter, num.boolValue);  //objc发消息调用setter方法将number赋值给model
        } break;
        case XREncodingTypeInt8: {
            ((void (*)(id, SEL, int8_t))(void *)objc_msgSend)((id)model, meta->_setter, (int8_t)num.charValue);
        } break;
        case XREncodingTypeUInt8: {
            ((void (*)(id, SEL, uint8_t))(void *)objc_msgSend)((id)model, meta->_setter, (uint8_t)num.unsignedCharValue);
        } break;
        case XREncodingTypeInt16: {
            ((void (*)(id, SEL, int16_t))(void *)objc_msgSend)((id)model, meta->_setter, (int16_t)num.shortValue);
        } break;
        case XREncodingTypeUInt16: {
            ((void (*)(id, SEL, uint16_t))(void *)objc_msgSend)((id)model, meta->_setter, (uint16_t)num.unsignedShortValue);
        } break;
        case XREncodingTypeInt32: {
            ((void (*)(id, SEL, int32_t))(void *)objc_msgSend)((id)model, meta->_setter, (int32_t)num.intValue);
        } break;
        case XREncodingTypeUInt32: {
            ((void (*)(id, SEL, uint32_t))(void *)objc_msgSend)((id)model, meta->_setter, (uint32_t)num.unsignedIntValue);
        } break;
        case XREncodingTypeInt64: {
            if([num isKindOfClass:[NSDecimalNumber class]]) {
                ((void (*)(id, SEL, int64_t))(void *)objc_msgSend)((id)model, meta->_setter, (int64_t)num.stringValue.longLongValue);
            } else {
                ((void (*)(id, SEL, uint64_t))(void *)objc_msgSend)((id)model, meta->_setter, (uint64_t)num.longLongValue);
            }
        } break;
        case XREncodingTypeUInt64: {
            if([num isKindOfClass:[NSDecimalNumber class]]) {
                ((void (*)(id, SEL, int64_t))(void *)objc_msgSend)((id)model, meta->_setter, (int64_t)num.stringValue.longLongValue);
            } else {
                ((void (*)(id, SEL, uint64_t))(void *)objc_msgSend)((id)model, meta->_setter, (uint64_t)num.unsignedLongLongValue);
            }
        } break;
        case XREncodingTypeFloat: {
            float f = num.floatValue;
            if(isnan(f) || isinf(f)) f = 0;
            ((void (*)(id, SEL, float))(void *)objc_msgSend)((id)model, meta->_setter,f);
        } break;
        case XREncodingTypeDouble: {
            double d = num.doubleValue;
            if(isnan(d) || isinf(d)) d = 0;
            ((void (*)(id, SEL, double))(void *)objc_msgSend)((id)model, meta->_setter, d);
        } break;
        case XREncodingTypeLongDouble: {
            long double d = num.doubleValue;
            if(isnan(d) || isinf(d)) d = 0;
            ((void (*)(id, SEL, double))(void *)objc_msgSend)((id)model, meta->_setter, (long double)d);
        } break;
        default: break;
    }
}

static force_inline NSDate *XRNSDateFromString(__unsafe_unretained NSString *string) {
    #define kParseNum 34
    typedef NSDate* (^XRNSDateParseBlock)(NSString *string);
    static XRNSDateParseBlock blocks[kParseNum + 1] = {0};
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            formatter.dateFormat = @"yyyy-MM-dd";
            blocks[10] = ^(NSString *string) { return [formatter dateFromString:string]; };
        }
        
        {
            NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
            formatter1.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter1.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            formatter1.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
            
            NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
            formatter2.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter2.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            formatter2.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            
            NSDateFormatter *formatter3 = [[NSDateFormatter alloc] init];
            formatter3.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter3.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            formatter3.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS";
            
            NSDateFormatter *formatter4 = [[NSDateFormatter alloc] init];
            formatter4.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter4.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            formatter4.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
            
            blocks[19] = ^(NSString *string) {
                if ([string characterAtIndex:10] == 'T') {
                    return [formatter1 dateFromString:string];
                } else {
                    return [formatter2 dateFromString:string];
                }
            };
            
            blocks[23] = ^(NSString *string) {
                if ([string characterAtIndex:10] == 'T') {
                    return [formatter3 dateFromString:string];
                } else {
                    return [formatter4 dateFromString:string];
                }
            };
        }
        
        {
            /*
             2014-01-20T12:24:48Z        // Github, Apple
             2014-01-20T12:24:48+0800    // Facebook
             2014-01-20T12:24:48+12:00   // Google
             2014-01-20T12:24:48.000Z
             2014-01-20T12:24:48.000+0800
             2014-01-20T12:24:48.000+12:00
             */
            NSDateFormatter *formatter = [NSDateFormatter new];
            formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
            
            NSDateFormatter *formatter2 = [NSDateFormatter new];
            formatter2.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter2.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";
            
            blocks[20] = ^(NSString *string) { return [formatter dateFromString:string]; };
            blocks[24] = ^(NSString *string) { return [formatter dateFromString:string]?: [formatter2 dateFromString:string]; };
            blocks[25] = ^(NSString *string) { return [formatter dateFromString:string]; };
            blocks[28] = ^(NSString *string) { return [formatter2 dateFromString:string]; };
            blocks[29] = ^(NSString *string) { return [formatter2 dateFromString:string]; };
        }
        
        {
            /*
             Fri Sep 04 00:12:21 +0800 2015 // Weibo, Twitter
             Fri Sep 04 00:12:21.000 +0800 2015
             */
            NSDateFormatter *formatter = [NSDateFormatter new];
            formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
            
            NSDateFormatter *formatter2 = [NSDateFormatter new];
            formatter2.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter2.dateFormat = @"EEE MMM dd HH:mm:ss.SSS Z yyyy";
            
            blocks[30] = ^(NSString *string) { return [formatter dateFromString:string]; };
            blocks[34] = ^(NSString *string) { return [formatter2 dateFromString:string]; };
        }

    });
    if(!string) return nil;
    if(string.length > kParseNum) return nil;
    XRNSDateParseBlock parse = blocks[string.length];
    if(!parse) return nil;
    return parse(string);
    #undef kParseNum
}


static force_inline Class XRNSBlockClass() {
    static Class cls;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        void (^block)(void) = ^{};
        cls = ((NSObject *)block).class;
        while (class_getSuperclass(cls) != [NSObject class]) {
            cls = class_getSuperclass(cls);
        }
    });
    return cls;
};

static force_inline NSDateFormatter *XRISODateFormatter() {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
    });
    return formatter;
}

/**
 *  将值赋值给属性  核心方法
 *  @param model 需要处理的模型
 *  @param value 需要处理的值
 *  @param meta  属性解析过的结构
 */
static void ModelSetValueForProperty(__unsafe_unretained id model,__unsafe_unretained id value,__unsafe_unretained XRModelPropertyMeta *meta) {
    //1.NSNumber类型处理
    if(meta->_isCNumber) {
        //获取要处理的NSNumber类型值
        NSNumber *num = XRNumberCreateFromID(value);
        //objc_msgSend赋值
        ModelSetNumberToProperty(model, num, meta);
        if(num) [num class];
    } else if(meta->_nsType) {
        if(value == (id)kCFNull) {
            ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, (id)nil);
        } else {
            switch (meta->_nsType) {
                case XREncodingTypeNSString:
                case XREncodingTypeNSMutableString: {
                    //字符串换处理
                    if([value isKindOfClass:[NSString class]]) {
                        if(meta->_nsType == XREncodingTypeNSString) {
                            ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)model, meta->_setter, value);
                        } else {
                            ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)model, meta->_setter, ((NSString *)value).mutableCopy);
                        }
                    }
                    else if ([value isKindOfClass:[NSNumber class]]) {
                        ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)model,
                                                                      meta->_setter,
                                                                      (meta->_nsType == XREncodingTypeNSString) ?
                                                                      ((NSNumber *)value).stringValue :
                                                                      ((NSNumber *)value).stringValue.mutableCopy);
                    }
                    else if([value isKindOfClass:[NSData class]]) {
                        NSMutableString *string = [[NSMutableString alloc] initWithData:value encoding:NSUTF8StringEncoding];
                        ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)model, meta->_setter, string);
                    }
                    else if([value isKindOfClass:[NSURL class]]) {
                        ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)model,
                                                                      meta->_setter,
                                                                      (meta->_nsType == XREncodingTypeNSString) ?
                                                                      ((NSURL *)value).absoluteString:
                                                                      ((NSURL *)value).absoluteString.mutableCopy);
                    }
                    else if([value isKindOfClass:[NSAttributedString class]]) {
                        ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)model,
                                                                      meta->_setter,
                                                                      (meta->_nsType == XREncodingTypeNSString) ?
                                                                      ((NSAttributedString *)value).string :
                                                                      ((NSAttributedString *)value).string.mutableCopy);
                    }
                
                } break;
                
                    //数值类型
                case XREncodingTypeNSValue:
                case XREncodingTypeNSNumber:
                case XREncodingTypeNSDecimalNumber: {
                    if(meta->_nsType == XREncodingTypeNSNumber) {
                        ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)model,meta->_setter,XRNumberCreateFromID(value));
                    } else if(meta->_nsType == XREncodingTypeNSDecimalNumber) {
                        if([value isKindOfClass:[NSDecimalNumber class]]) {
                            ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)model,meta->_setter,value);
                        }else if([value isKindOfClass:[NSNumber class]]) {
                            NSDecimalNumber *decNum = [NSDecimalNumber decimalNumberWithDecimal:[((NSNumber *)value) decimalValue]];
                            ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)model,meta->_setter,decNum);
                        }else if([value isKindOfClass:[NSString class]]) {
                            NSDecimalNumber *decNum = [NSDecimalNumber decimalNumberWithString:value];
                            NSDecimal dec = decNum.decimalValue;
                            if(dec._length == 0 && dec._isNegative) {
                                decNum = nil;
                            }
                            ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)model,meta->_setter,decNum);
                        } else {
                            if([value isKindOfClass:[NSValue class]]) {
                                ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)model,meta->_setter,value);
                            }
                        }
                    }
                } break;
                
                    //二进制数据
                case XREncodingTypeNSData:
                case XREncodingTypeNSMutableData: {
                    if([value isKindOfClass:[NSData class]]) {
                        if(meta->_nsType == XREncodingTypeNSData) {
                            ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)model,meta->_setter,value);
                        } else {
                            NSMutableData *data = ((NSData *)value).mutableCopy;
                            ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)model,meta->_setter,data);
                        }
                    } else if([value isKindOfClass:[NSString class]]) {
                        NSData *data = [(NSString *)value dataUsingEncoding:NSUTF8StringEncoding];
                        if(meta->_nsType == XREncodingTypeNSMutableData) {
                            data = ((NSData *)data).mutableCopy;
                        }
                        ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)model,meta->_setter,data);
                    }
                
                } break;
            
                    //日期数据
                case XREncodingTypeNSDate: {
                    if([value isKindOfClass:[NSDate class]]) {
                        ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)model,meta->_setter,value);
                    } else if([value isKindOfClass:[NSString class]]) {
                        ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)model,meta->_setter,XRNSDateFromString(value));
                    }
                } break;
            
                    //网络地址
                case XREncodingTypeNSURL: {
                    if([value isKindOfClass:[NSURL class]]) {
                        ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)model,meta->_setter,value);
                    } else if([value isKindOfClass:[NSString class]]) {
                        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
                        NSString *str = [value stringByTrimmingCharactersInSet:set];
                        if(str.length == 0) {
                            ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)model,meta->_setter,nil);
                        }else{
                            ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)model,meta->_setter,[[NSURL alloc] initWithString:str]);
                        }
                    }
                } break;
            
                    //数组
                case XREncodingTypeNSArray:
                case XREncodingTypeNSMutableArray: {
                    //数组中的数据为新的类 需要使用递归先进行转换    核心部分
                    if(meta->_genericCls) {
                        //统一处理成数组
                        NSArray *valueArr = nil;
                        if([value isKindOfClass:[NSArray class]]) {
                            valueArr = value;
                        } else if([value isKindOfClass:[NSSet class]]) {
                            valueArr = ((NSSet *)value).allObjects;
                        }
                        if(valueArr) {
                            NSMutableArray *objectArr = [NSMutableArray new];
                            for(id one in valueArr) {
                                //如果数组中存储的是类，则直接添加，递归的出口
                                if([one isKindOfClass:meta->_genericCls]) {
                                    [objectArr addObject:one];
                                }
                                else if([one isKindOfClass:[NSDictionary class]]) {
                                    Class cls = meta->_genericCls;
                                    //如果需要使用用户定义的需要转换的类
                                    if(meta->_hasCustomClassFromDictionary) {
                                        //转换成用户定义的类
                                        cls = [cls modelCustomClassForDictionary:one];
                                        if(!cls) cls = meta->_genericCls;
                                    }
                                    //递归，生成类对象
                                    NSObject *newObj = [cls new];
                                    [newObj xr_modelSetWithDictionary:one];
                                    if(newObj) [objectArr addObject:newObj];
                                }
                            }
                            //赋值
                            ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, objectArr);
                        }
                        //普通的数组 直接赋值
                    } else {
                        if([value isKindOfClass:[NSArray class]]) {
                            if(meta->_nsType == XREncodingTypeNSArray) {
                                ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, value);
                            } else {
                                ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, ((NSArray *)value).mutableCopy);
                            }
                        } else if([value isKindOfClass:[NSSet class]]) {
                            if(meta->_nsType == XREncodingTypeNSSet) {
                                ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, ((NSSet *)value).allObjects);
                            } else {
                                ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, ((NSSet *)value).allObjects.mutableCopy);
                            }
                        }
                    }
                } break;
            
                    //字典
                case XREncodingTypeNSDictionary:
                case XREncodingTypeNSMutableDictionary: {
                    if([value isKindOfClass:[NSDictionary class]]) {
                        //如果字典标识的是一个类，则需要递归抓换
                        if(meta->_genericCls) {
                            NSMutableDictionary *dic = [NSMutableDictionary new];
                            [((NSDictionary *)value) enumerateKeysAndObjectsUsingBlock:^(NSString *key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                                //key 对应一个字典
                                if([obj isKindOfClass:[NSDictionary class]]) {
                                    Class cls = meta->_genericCls;
                                    if(meta->_hasCustomClassFromDictionary) {
                                        cls = [cls modelCustomClassForDictionary:obj];
                                        if(!cls) cls = meta->_genericCls;
                                    }
                                    NSObject *newObj = [cls new];
                                    [newObj xr_modelSetWithDictionary:(id)obj];
                                    if(newObj) dic[key] = newObj;
                                }
                                //maby bug
                            }];
                            ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, dic);
                        } else {
                            if(meta->_nsType == XREncodingTypeNSDictionary) {
                                ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, value);
                            } else {
                                ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, ((NSDictionary *)value).mutableCopy);
                            }
                        }
                    }
                } break;
                
                case XREncodingTypeNSSet:
                case XREncodingTypeNSMutableSet: {
                    NSSet *valueSet = nil;
                    if([value isKindOfClass:[NSArray class]]) {
                        valueSet = [NSMutableSet setWithArray:value];
                    }
                    else if([value isKindOfClass:[NSSet class]]) {
                        valueSet = value;
                    }
                    
                    if(meta->_genericCls) {
                        NSMutableSet *set = [NSMutableSet new];
                        for(id one in valueSet) {
                            if([one isKindOfClass:meta->_genericCls]) {
                                [set addObject:one];
                            }else if([one isKindOfClass:[NSDictionary class]]) {
                                Class cls = meta->_genericCls;
                                if(meta->_hasCustomClassFromDictionary) {
                                    cls = [cls modelCustomClassForDictionary:one];
                                    if(!cls) cls = meta->_genericCls;
                                }
                                NSObject *newOne = [cls new];
                                [newOne xr_modelSetWithDictionary:one];
                                if(newOne) {
                                    [set addObject:newOne];
                                }
                            }
                        }
                        ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, set);
                    } else {
                        if(meta->_nsType == XREncodingTypeNSSet) {
                            ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, valueSet);
                        }else{
                            ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, valueSet.mutableCopy);
                        }
                    }
                } break;
                default: break;
            }
        }
    } else {
        BOOL isNull = (value == (id)kCFNull);
        switch (meta->_type & XREncodingTypeMask) {
            case XREncodingTypeObject: {
                if(isNull) {
                    ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, (id)nil);
                } else if([value isKindOfClass:meta->_cls] || !meta->_cls) {
                    ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, (id)value);
                } else if([value isKindOfClass:[NSDictionary class]]) {
                    NSObject *one = nil;
                    //从get方法中获取对象
                    if(meta->_getter) {
                        one = ((id (*)(id, SEL))(void *)objc_msgSend)((id)model, meta->_getter);
                    }
                    
                    if(one) {
                        //此时并不需要在处理setter方法，应为getter方法已经拿出了对象，直接赋值即可
                        [one xr_modelSetWithDictionary:value];
                    } else {
                        Class cls = meta->_cls;
                        if(meta->_hasCustomClassFromDictionary) {
                            cls = [cls modelCustomClassForDictionary:value];
                            if(!cls) cls = meta->_genericCls;
                        }
                        
                        one = [cls new];
                        [one xr_modelSetWithDictionary:value];
                        ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, (id)one);
                    }
                }
            } break;
            case XREncodingTypeClass: {
                if(isNull) {
                    ((void (*)(id, SEL, Class))(void *) objc_msgSend)((id)model, meta->_setter, (Class)NULL);
                } else {
                    Class cls = nil;
                    if([value isKindOfClass:[NSString class]]) {
                        cls = NSClassFromString(value);
                        if(cls) {
                            ((void (*)(id, SEL, Class))(void *) objc_msgSend)((id)model, meta->_setter, (Class)cls);
                        }
                    } else {
                        cls = object_getClass(value);
                        if(cls) {
                            if(class_isMetaClass(cls)) {
                                ((void (*)(id, SEL, Class))(void *) objc_msgSend)((id)model, meta->_setter, (Class)cls);
                            }
                        }
                    }
                }
            } break;
            case XREncodingTypeSEL: {
                if(isNull) {
                    ((void (*)(id, SEL, SEL))(void *) objc_msgSend)((id)model, meta->_setter, (SEL)NULL);
                } else if ([value isKindOfClass:[NSString class]]) {
                    SEL sel = NSSelectorFromString(value);
                    if(sel) {
                        ((void (*)(id, SEL, SEL))(void *) objc_msgSend)((id)model, meta->_setter, (SEL)sel);
                    }
                }
            } break;
            case XREncodingTypeBlock: {
                if(isNull) {
                    ((void (*)(id, SEL, void (^)()))(void *) objc_msgSend)((id)model, meta->_setter, (void (^)())NULL);
                }else if([value isKindOfClass:XRNSBlockClass()]){
                    ((void (*)(id, SEL, void (^)()))(void *) objc_msgSend)((id)model, meta->_setter, (void (^)())value);
                }
            } break;
            
            case XREncodingTypeStruct: {
                if([value isKindOfClass:[NSValue class]]) {
                    const char *valueType = ((NSValue *)value).objCType;
                    const char *metaType = meta->_info.typeEncoding.UTF8String;
                    if(valueType && metaType && strcmp(valueType, metaType) == 0) {
                        [model setValue:value forKey:meta->_name];
                    }
                }
            } break;
            
            case XREncodingTypePointer:
            case XREncodingTypeCString: {
                if(isNull) {
                    ((void (*)(id, SEL, void *))(void *)objc_msgSend)((id)model, meta->_setter, (void *)NULL);
                }else if([value isKindOfClass:[NSValue class]]) {
                    NSValue *nsValue = value;
                    if(nsValue.objCType && strcmp(nsValue.objCType, "^v") == 0) {
                        ((void (*)(id, SEL, void *))(void *)objc_msgSend)((id)model, meta->_setter, (void *)nsValue.objCType);
                    }
                }
            } break;
                
            default:
                break;
        }
    
    }
}

typedef struct {
    void *modelMeta;
    void *model;
    void *dictionary;
} ModelSetContext;

/**
 *  设置键值对
 *  @param _key   键
 *  @param _value 值
 *  @param _const _context.modelMeta and _context.model
 */
static void ModelSetWithDictionaryFunction(const void *_key,const void *_value, void *_context) {
    ModelSetContext *context = _context;
    __unsafe_unretained XRModelMeta *meta = (__bridge XRModelMeta *)(context->modelMeta);
    __unsafe_unretained XRModelPropertyMeta *propertyMeta = [meta->_mapper objectForKey:(__bridge id)(_key)];
    __unsafe_unretained id model = (__bridge id)(context->model);
    
    while (propertyMeta) {
        if(propertyMeta->_setter) {
            ModelSetValueForProperty(model, (__bridge __unsafe_unretained id)_value, propertyMeta);
        }
        propertyMeta = propertyMeta->_next;
    }
}

static void ModelSetWithPropertyMetaArrayFunction(const void *_propertyMeta, void *_context) {
    ModelSetContext *context = _context;
    __unsafe_unretained NSDictionary *dictionary = (__bridge NSDictionary *)(context->dictionary);
    __unsafe_unretained XRModelPropertyMeta *propertyMeta = (__bridge XRModelPropertyMeta *)(_propertyMeta);
    if(!propertyMeta->_setter) return;
    id value = nil;
    
    if(propertyMeta->_mappedToKeyArray) {
        value = XRValueForMultikeys(dictionary, propertyMeta->_mappedToKeyArray);
    } else if(propertyMeta->_mappedToKeyPath) {
        value = XRValueForKeyPath(dictionary, propertyMeta->_mappedToKeyPath);
    } else {
        value = [dictionary objectForKey:propertyMeta->_mappedToKey];
    }
    
    if(value) {
        __unsafe_unretained id model = (__bridge id)(context->model);
        ModelSetValueForProperty(model, value, propertyMeta);
    }
    
}

/**
 *  根据模型生成JSON对象
 */
static id ModelToJSONObjectRecursive(NSObject *model) {
    if(!model || model == (id)kCFNull) return model;
    if([model isKindOfClass:[NSString class]]) return model;
    if([model isKindOfClass:[NSNumber class]]) return model;
    
    //字典处理
    if([model isKindOfClass:[NSDictionary class]]) {
        if([NSJSONSerialization isValidJSONObject:model]) return model;
        NSMutableDictionary *tmpDic = [NSMutableDictionary new];
        [((NSDictionary *)model) enumerateKeysAndObjectsUsingBlock:^(NSString *key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSString *stringKey = [key isKindOfClass:[NSString class]] ? key : key.description;
            if (!stringKey) return ;
            id jsonObj = ModelToJSONObjectRecursive(obj);
            if (!jsonObj) jsonObj = (id)kCFNull;
            tmpDic[stringKey] = jsonObj;
        }];
        return tmpDic;
    }
    
    //NSSet处理
    if([model isKindOfClass:[NSSet class]]) {
        NSArray *array = ((NSSet *)model).allObjects;
        if([NSJSONSerialization isValidJSONObject:array]) return array;
        NSMutableArray *tmpArray = [NSMutableArray new];
        for(id obj in array) {
            if([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]]) {
                [tmpArray addObject:obj];
            } else {
                id jsonObject = ModelToJSONObjectRecursive(obj);
                if(jsonObject && jsonObject != (id)kCFNull) {
                    [tmpArray addObject:jsonObject];
                }
            }
        }
        return tmpArray;
    }
    
    //NSArray处理
    if([model isKindOfClass:[NSArray class]]) {
        if([NSJSONSerialization isValidJSONObject:model]) return model;
        NSMutableArray *tmpArray = [NSMutableArray new];
        for(id obj in (NSArray *)model) {
            if([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]]) {
                [tmpArray addObject:obj];
            } else {
                id jsonObj = ModelToJSONObjectRecursive(obj);
                if(jsonObj && jsonObj != (id)kCFNull) [tmpArray addObject:jsonObj];
            }
        }
        return tmpArray;
    }
    
    if([model isKindOfClass:[NSURL class]]) return ((NSURL *)model).absoluteString;
    if([model isKindOfClass:[NSAttributedString class]]) return (((NSAttributedString *)model).string);
    if([model isKindOfClass:[NSDate class]]) return [XRISODateFormatter() stringFromDate:(id)model];
    if([model isKindOfClass:[NSData class]]) return nil;
    
    XRModelMeta *modelMeta = [XRModelMeta metaWithClass:[model class]];
    if(!modelMeta || modelMeta->_keyMappedCount == 0) return nil;
    NSMutableDictionary *result = [[NSMutableDictionary alloc] initWithCapacity:64];
    __unsafe_unretained NSMutableDictionary *dic = result;
    [modelMeta->_mapper enumerateKeysAndObjectsUsingBlock:^(NSString *propertyMappedkey,XRModelPropertyMeta *propertyMeta, BOOL * _Nonnull stop) {
        if(!propertyMeta->_getter) return ;
        
        id value = nil;
        if(propertyMeta->_isCNumber) {
            value = ModelCreateNumberFromProperty(model, propertyMeta);
        } else if(propertyMeta -> _nsType) {
            id v = ((id (*)(id, SEL))(void *)objc_msgSend)((id)model,propertyMeta->_getter);
            value = ModelToJSONObjectRecursive(v);
        } else {
            switch (propertyMeta->_type & XREncodingTypeMask) {
                case XREncodingTypeObject: {
                    id v = ((id (*)(id, SEL))(void *)objc_msgSend)((id)model,propertyMeta->_getter);
                    value = ModelToJSONObjectRecursive(v);
                    if(value == (id)kCFNull) value = nil;
                } break;
                case XREncodingTypeClass: {
                    Class v = ((Class (*)(id, SEL))(void *)objc_msgSend)((id)model,propertyMeta->_getter);
                    value = v ? NSStringFromClass(v) : nil;
                } break;
                case XREncodingTypeSEL: {
                    SEL v = ((SEL (*)(id, SEL))(void *)objc_msgSend)((id)model,propertyMeta->_getter);
                    value = v ? NSStringFromSelector(v) : nil;
                } break;
                default: break;
            }
        }
        
        if(!value) return;
        
        if(propertyMeta -> _mappedToKeyPath) {
            NSMutableDictionary *superDic = dic;
            NSMutableDictionary *subDic = nil;
            for(NSUInteger i = 0, max = propertyMeta->_mappedToKeyPath.count; i < max; i++) {
                NSString *key = propertyMeta->_mappedToKeyPath[i];
                if(i + 1 == max) {
                    if(!superDic[key]) {
                        superDic[key] = value;
                    }
                    break;
                }
                
                subDic = superDic[key];
                if(subDic) {
                    if([subDic isKindOfClass:[NSDictionary class]]) {
                        subDic = subDic.mutableCopy;
                        superDic[key] = subDic;
                    } else {
                        break;
                    }
                } else {
                    subDic = [NSMutableDictionary new];
                    superDic[key] = subDic;
                }
                superDic = subDic;
                subDic = nil;
            }
        } else {
            if(!dic[propertyMeta->_mappedToKey]) {
                dic[propertyMeta->_mappedToKey] = value;
            }
        }
    }];
    
    
    if(modelMeta->_hasCustomTransformToDictionary) {
        BOOL suc = [((id<XRModel>)model) modelCustomTransformToDictionary:dic];
        if(!suc) return nil;
    }
    return result;
}


static NSMutableString *ModelDescriptionAddIndent(NSMutableString *desc, NSUInteger ident) {
    for(NSUInteger i = 0, max = desc.length; i < max; i++) {
        unichar c = [desc characterAtIndex:i];
        if(c == '\n') {
            for(NSUInteger j = 0; j < ident; j++) {
                [desc insertString:@"    " atIndex:i + 1];
            }
            i += ident * 4;
            max += ident * 4;
        }
    }
    return desc;
}

static NSString *ModelDescription(NSObject *model) {
    static const int kDescMaxLength = 100;
    if (!model) return @"<nil>";
    if (model == (id)kCFNull) return @"<null>";
    
    if(![model isKindOfClass:[NSObject class]]) return [NSString stringWithFormat:@"%@",model];
    
    XRModelMeta *modelMeta = [XRModelMeta metaWithClass:model.class];
    switch (modelMeta->_nsType) {
        case XREncodingTypeNSString:
        case XREncodingTypeNSMutableString: {
            return [NSString stringWithFormat:@"\"%@\"",model];
        } break;
        
        case XREncodingTypeNSValue:
        case XREncodingTypeNSData:
        case XREncodingTypeNSMutableData: {
            NSString *tmp = model.description;
            if(tmp.length > kDescMaxLength) {
                tmp = [tmp substringToIndex:kDescMaxLength];
                tmp = [tmp stringByAppendingString:@"..."];
            }
            return tmp;
        } break;
            
        case XREncodingTypeNSNumber:
        case XREncodingTypeNSDecimalNumber:
        case XREncodingTypeNSDate:
        case XREncodingTypeNSURL: {
            return [NSString stringWithFormat:@"%@",model];
        } break;
            
        case XREncodingTypeNSSet:
        case XREncodingTypeNSMutableSet: {
            model = ((NSSet *)model).allObjects;
        }
            
        case XREncodingTypeNSArray:
        case XREncodingTypeNSMutableArray: {
            NSArray *array = (id)model;
            NSMutableString *desc = [NSMutableString new];
            if(array.count == 0) {
                return [desc stringByAppendingString:@"[]"];
            } else {
                [desc appendFormat:@"[\n"];
                for(NSUInteger i = 0, max = array.count; i < max; i++) {
                    NSObject *obj = array[i];
                    [desc appendString:@"    "];
                    [desc appendString:ModelDescriptionAddIndent(ModelDescription(obj).mutableCopy, 1)];
                    [desc appendString:(i + 1 == max) ? @"\n" : @";\n"];
                }
                [desc appendString:@"]"];
                return desc;
            }
        } break;
        
        case XREncodingTypeNSDictionary:
        case XREncodingTypeNSMutableDictionary: {
            NSDictionary *dic = (id)model;
            NSMutableString *desc = [NSMutableString new];
            if(dic.count == 0) {
                return [desc stringByAppendingString:@"{}"];
            } else {
                NSArray *keys = dic.allKeys;
                [desc appendFormat:@"{\n"];
                for(NSUInteger i = 0, max = keys.count; i < max; i++) {
                    NSString *key = keys[i];
                    NSObject *value = dic[key];
                    [desc appendString:@"    "];
                    [desc appendFormat:@"%@ = %@",key,ModelDescriptionAddIndent(ModelDescription(value).mutableCopy, 1)];
                    [desc appendString:(i + 1 == max) ? @"\n" : @";\n"];
                }
                [desc appendString:@"}"];
            }
            return desc;
        }
        
        default:{
            NSMutableString *desc = [NSMutableString new];
            [desc appendFormat:@"<%@: %p>",model.class, model];
            
            if(modelMeta->_allPropertyMetas.count == 0) return desc;
            
            NSArray *properties = [modelMeta->_allPropertyMetas sortedArrayUsingComparator:^NSComparisonResult(XRModelPropertyMeta *obj1, XRModelPropertyMeta *obj2) {
                return [obj1->_name compare:obj2->_name];
            }];
            [desc appendFormat:@"{\n"];
            for(NSUInteger i = 0, max = properties.count; i < max; i++) {
                XRModelPropertyMeta *property = properties[i];
                NSString *propertyDesc;
                if(property -> _isCNumber) {
                    NSNumber *num = ModelCreateNumberFromProperty(model, property);
                    propertyDesc = num.stringValue;
                } else {
                    switch (property -> _type & XREncodingTypeMask) {
                        case XREncodingTypeObject: {
                            id v = ((id (*)(id,SEL))(void *) objc_msgSend)((id)model, property->_getter);
                            propertyDesc = ModelDescription(v);
                            if(!propertyDesc) propertyDesc = @"<nil>";
                        } break;
                        case XREncodingTypeClass: {
                            id v = ((id (*)(id, SEL))(void *) objc_msgSend)((id)model, property->_getter);
                            propertyDesc = ((NSObject *)v).description;
                            if (!propertyDesc) propertyDesc = @"<nil>";
                        } break;
                        case XREncodingTypeSEL: {
                            SEL sel = ((SEL (*)(id, SEL))(void *) objc_msgSend)((id)model, property->_getter);
                            if (sel) propertyDesc = NSStringFromSelector(sel);
                            else propertyDesc = @"<NULL>";
                        } break;
                        case XREncodingTypeBlock: {
                            id block = ((id (*)(id, SEL))(void *) objc_msgSend)((id)model, property->_getter);
                            propertyDesc = block ? ((NSObject *)block).description : @"<nil>";
                        } break;
                        case XREncodingTypeCArray:
                        case XREncodingTypeCString:
                        case XREncodingTypePointer: {
                            void *pointer = ((void* (*)(id, SEL))(void *) objc_msgSend)((id)model, property->_getter);
                            propertyDesc = [NSString stringWithFormat:@"%p",pointer];
                        } break;
                        case XREncodingTypeStruct:
                        case XREncodingTypeUnion: {
                            NSValue *value = [model valueForKey:property->_name];
                            propertyDesc = value ? value.description : @"{unknown}";
                        } break;
                        default: propertyDesc = @"<unknown>";
                    }
                }
                
                propertyDesc = ModelDescriptionAddIndent(propertyDesc.mutableCopy, 1);
                [desc appendFormat:@"    %@ = %@",property->_name, propertyDesc];
                [desc appendString:(i + 1 == max) ? @"\n" : @";\n"];
            }
            [desc appendFormat:@"}"];
            return desc;
        } break;
    }
}




@implementation NSObject (XRModel)

/**
 *  将json数据转换成模型
 *  可接受数据类型: NSDictionary、NSString、NSData
 */
+ (instancetype)xr_modelWithJSON:(id)json {
    //1.将数据解析成字典
    NSDictionary *jsonDic = [self xr_dictoryWithJSON:json];
    //2.将字典解析成模型
    return [self xr_modelWithDictionary:jsonDic];
}

/**
 *  将json数据解析成字典
 *  可接受类型：NSDictionary、NSString、NSData
 
 *  nil: 指向一个       (实例)对象           的空指针
 *  Nil: 指向一个           类              的空指针
 *  NULL: 指向  其它类型(基本数据类型、C类型)  的空指针
 *  NSNull: 数组中元素的占位符，数组中的元素不能为nil，但是可以为空即NSNull
 *  kCFNull: NSNull的单例 
    
    typedef const struct CF_BRIDGED_TYPE(NSNull) __CFNull * CFNullRef;
    
    CF_EXPORT
    CFTypeID CFNullGetTypeID(void);
 
    CF_EXPORT
    const CFNullRef kCFNull;
 
    所以: NSNull *null = (id)kCFnull 与 NSNull *null = [NSNull null]
 */
+ (NSDictionary *)xr_dictoryWithJSON:(id)json {
    //1.检查输入合法性
    if(!json || json == (id)kCFNull) return nil;
    //2.jsonDic 存储转换完成后的字典、jsonData 如果输入的json是NSString类，则需要先转换成NSData
    NSDictionary *jsonDic = nil;
    NSData *jsonData = nil;
    //3.如果输入的json是字典，则无需经过转换
    if([json isKindOfClass:[NSDictionary class]]) {
        jsonDic = json;
    }
    else if([json isKindOfClass:[NSString class]]) {
        //4.如果输入的是json字符串，则需要先转换成NSData,在调用系统方法转换成NSDictionary
        jsonData = [(NSString *)json dataUsingEncoding:NSUTF8StringEncoding];
    }
    else if([json isKindOfClass:[NSData class]]) {
        //5.如果输入的是json的二进制，则可以直接存储，用于转换
        jsonData = json;
    }
    if(jsonData) {
        //6.如果json二进制存在的话需要将此二进制转换成NSDictionary
        jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
        //7.检查转换是否成功
        if(![jsonDic isKindOfClass:[NSDictionary class]]) {
            jsonDic = nil;
        }
    }
    return jsonDic;
}


/**
 *  将json字典解析成数据模型
 *  @param jsonDic json数据生成的字典
 */
+ (instancetype)xr_modelWithDictionary:(NSDictionary *)jsonDic {
    //1.检查输入合法性
    if(!jsonDic || jsonDic == (id)kCFNull) return nil;
    if(![jsonDic isKindOfClass:[NSDictionary class]]) return nil;
    
    Class cls = [self class];
    XRModelMeta *modelMeta = [XRModelMeta metaWithClass:cls];
    if(modelMeta->_hasCustomClassFromDictionary) {
        cls = [cls modelCustomClassForDictionary:jsonDic];
    }
    NSObject *obj = [cls new];
    if([obj xr_modelSetWithDictionary:jsonDic]){
        return obj;
    }
    return nil;
}

/**
 *  将字典转换成模型
 */
- (BOOL)xr_modelSetWithDictionary:(NSDictionary *)dic {
    if(!dic || dic == (id)kCFNull) return NO;
    if(![dic isKindOfClass:[NSDictionary class]]) return NO;
    
    XRModelMeta *modelMeta = [XRModelMeta metaWithClass:object_getClass(self)];
    if(modelMeta->_keyMappedCount == 0) return NO;
    
    if(modelMeta->_hasCustomWillTransformFromDictionary) {
        dic = [((id<XRModel>)self) modelCustomWillTransformFromDictionary:dic];
        if(![dic isKindOfClass:[NSDictionary class]]) return NO;
    }
    
    ModelSetContext context = {0};
    context.modelMeta = (__bridge void *)(modelMeta);
    context.model = (__bridge void *)(self);
    context.dictionary = (__bridge void *)(dic);
    
    if(modelMeta->_keyMappedCount >= CFDictionaryGetCount((CFDictionaryRef)dic)) {
        CFDictionaryApplyFunction((CFDictionaryRef)dic, ModelSetWithDictionaryFunction, &context);
        if(modelMeta->_keyPathPropertyMetas) {
            CFArrayApplyFunction((CFArrayRef)modelMeta->_keyPathPropertyMetas, CFRangeMake(0, CFArrayGetCount((CFArrayRef)modelMeta->_keyPathPropertyMetas)), ModelSetWithPropertyMetaArrayFunction, &context);
        }
        if(modelMeta->_multiKeysPropertyMetas) {
            CFArrayApplyFunction((CFArrayRef)modelMeta->_multiKeysPropertyMetas, CFRangeMake(0, CFArrayGetCount((CFArrayRef)modelMeta->_multiKeysPropertyMetas)), ModelSetWithPropertyMetaArrayFunction, &context);
        }
    } else {
        CFArrayApplyFunction((CFArrayRef)modelMeta->_allPropertyMetas, CFRangeMake(0, modelMeta->_keyMappedCount), ModelSetWithPropertyMetaArrayFunction, &context);
    }
    
    if(modelMeta->_hasCustomClassFromDictionary) {
        return [((id<XRModel>)self) modelCustomTransformFromDictionary:dic];
    }
    return YES;
}

- (BOOL)xr_modelSetWithJSON:(id)json {
    NSDictionary *dic = [NSObject xr_dictoryWithJSON:json];
    return [self xr_modelSetWithDictionary:dic];
}

/**
 *  根据模型生成JSON对象
 */
- (nullable id)xr_modelToJSONObject {
    id jsonObject = ModelToJSONObjectRecursive(self);
    if([jsonObject isKindOfClass:[NSArray class]]) return jsonObject;
    if([jsonObject isKindOfClass:[NSDictionary class]]) return jsonObject;
    return nil;
}

/**
 *  模型转换成JSON二进制
 */
- (nullable NSData *)xr_modelToJSONData {
    id obj = [self xr_modelToJSONObject];
    if(!obj) return nil;
    return [NSJSONSerialization dataWithJSONObject:obj options:0 error:NULL];
}

/**
 *  模型转换成JSON字符串
 */
- (nullable NSString *)xr_modelToJSONString {
    NSData *jsonData = [self xr_modelToJSONData];
    if(jsonData.length == 0) return nil;
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

/**
 *  复制一个模型
 */
- (nullable id)xr_modelCopy {
    if(self == (id)kCFNull) return nil;
    XRModelMeta *modelMeta = [XRModelMeta metaWithClass:self.class];
    //NS数据结构，可以直接使用copy方法
    if(modelMeta->_nsType) return [self copy];
    
    NSObject *tmpObj = [self.class new];
    for(XRModelPropertyMeta *propertyMeta in modelMeta->_allPropertyMetas) {
        if(!propertyMeta->_getter || !propertyMeta->_setter) continue;
        if(propertyMeta->_isCNumber) {
            switch (propertyMeta->_type & XREncodingTypeMask) {
                case XREncodingTypeBool: {
                    //取出getter方法
                    bool num = ((bool (*)(id, SEL))(void *) objc_msgSend)((id)self,propertyMeta->_getter);
                    //通过setter方法赋值
                    ((void (*)(id, SEL, bool))(void *) objc_msgSend)((id)tmpObj,propertyMeta->_setter,num);
                } break;
                    
                case XREncodingTypeUInt8:
                case XREncodingTypeInt8:{
                    uint8_t num = ((uint8_t (*)(id, SEL))(void *) objc_msgSend)((id)self,propertyMeta->_getter);
                    ((void (*)(id, SEL, uint8_t))(void *) objc_msgSend)((id)tmpObj,propertyMeta->_setter,num);
                } break;
                    
                case XREncodingTypeInt16:
                case XREncodingTypeUInt16: {
                    uint16_t num = ((uint16_t (*)(id, SEL))(void *) objc_msgSend)((id)self,propertyMeta->_getter);
                    ((void (*)(id, SEL, uint16_t))(void *) objc_msgSend)((id)tmpObj,propertyMeta->_setter,num);
                } break;
                    
                case XREncodingTypeInt32:
                case XREncodingTypeUInt32: {
                    uint32_t num = ((uint32_t (*)(id, SEL))(void *) objc_msgSend)((id)self,propertyMeta->_getter);
                    ((void (*)(id, SEL, uint32_t))(void *) objc_msgSend)((id)tmpObj,propertyMeta->_setter,num);
                } break;
                
                case XREncodingTypeInt64:
                case XREncodingTypeUInt64: {
                    uint64_t num = ((uint64_t (*)(id, SEL))(void *) objc_msgSend)((id)self, propertyMeta->_getter);
                    ((void (*)(id, SEL, uint64_t))(void *) objc_msgSend)((id)tmpObj, propertyMeta->_setter,num);
                } break;
                
                case XREncodingTypeFloat: {
                    float num = ((float (*)(id, SEL))(void *) objc_msgSend)((id)self,propertyMeta->_getter);
                    ((void (*)(id, SEL, float))(void *) objc_msgSend)((id)tmpObj,propertyMeta->_setter,num);
                } break;
                    
                case XREncodingTypeDouble: {
                    double num = ((double (*)(id, SEL))(void *) objc_msgSend)((id)self, propertyMeta->_getter);
                    ((void (*)(id, SEL, float))(void *) objc_msgSend)((id)tmpObj, propertyMeta->_setter, num);
                } break;
                    
                case XREncodingTypeLongDouble: {
                    long double num = ((long double (*)(id, SEL))(void *) objc_msgSend)((id)self,propertyMeta->_getter);
                    ((void (*)(id, SEL, long double))(void *) objc_msgSend)((id)tmpObj, propertyMeta->_setter, num);
                } break;
                default: break;
            }
        } else {
            switch (propertyMeta->_type & XREncodingTypeMask) {
                case XREncodingTypeObject:
                case XREncodingTypeClass:
                case XREncodingTypeBlock: {
                    id value = ((id (*)(id, SEL))(void *) objc_msgSend)((id)self,propertyMeta->_getter);
                    ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)tmpObj, propertyMeta->_setter,value);
                } break;
                
                case XREncodingTypeSEL:
                case XREncodingTypePointer:
                case XREncodingTypeCString: {
                    size_t value = ((size_t (*)(id, SEL))(void *) objc_msgSend)((id)self, propertyMeta->_getter);
                    ((void (*)(id, SEL, size_t))(void *) objc_msgSend)((id)tmpObj, propertyMeta->_setter, value);
                } break;
                    
                case XREncodingTypeStruct:
                case XREncodingTypeUnion: {
                    @try {
                        NSValue *value = [self valueForKey:NSStringFromSelector(propertyMeta->_getter)];
                        if(value) {
                            [tmpObj setValue:value forKey:propertyMeta->_name];
                        }
                    } @catch (NSException *exception) {}
                } break;
                default: break;
            }
            
        }
    }
    return tmpObj;
}

/**
 *  实现NSCodin
 */
- (void)xr_modelEncodeWithCoder:(NSCoder *)aCoder {
    if(!aCoder) return;
    if(self == (id)kCFNull) {
        [((id<NSCoding>)self) encodeWithCoder:aCoder];
        return;
    }
    
    XRModelMeta *modelMeta = [XRModelMeta metaWithClass:self.class];
    if(modelMeta->_nsType) {
        [((id<NSCoding>)self) encodeWithCoder:aCoder];
        return;
    }
    
    for(XRModelPropertyMeta *propertyMeta in modelMeta->_allPropertyMetas) {
        if(!propertyMeta->_getter) return;
        
        if(propertyMeta->_isCNumber) {
            NSNumber *value = ModelCreateNumberFromProperty(self, propertyMeta);
            if(value) [aCoder encodeObject:value forKey:propertyMeta->_name];
        } else {
            switch (propertyMeta->_type & XREncodingTypeMask) {
                case XREncodingTypeObject: {
                    id value = ((id (*)(id, SEL))(void *) objc_msgSend)((id)self,propertyMeta->_getter);
                    if(value && ((propertyMeta->_nsType) || [value respondsToSelector:@selector(encodeWithCoder:)])) {
                        if([value isKindOfClass:[NSValue class]]) {
                            if([value isKindOfClass:[NSNumber class]]) {
                                [aCoder encodeObject:value forKey:propertyMeta->_name];
                            }
                        } else {
                            [aCoder encodeObject:value forKey:propertyMeta->_name];
                        }
                    }
                } break;
                case XREncodingTypeSEL: {
                    SEL value = ((SEL (*)(id, SEL))(void *)objc_msgSend)((id)self,propertyMeta->_getter);
                    if(value) {
                        NSString *str = NSStringFromSelector(value);
                        [aCoder encodeObject:str forKey:propertyMeta->_name];
                    }
                } break;
                case XREncodingTypeStruct:
                case XREncodingTypeUnion: {
                    if(propertyMeta->_isKVCCompatible && propertyMeta->_isStructAvailableForKeyedArchiver) {
                        @try {
                            NSValue *value = [self valueForKey:NSStringFromSelector(propertyMeta->_getter)];
                            [aCoder encodeObject:value forKey:propertyMeta->_name];
                        } @catch (NSException *exception) {}
                    }
                } break;
                    
                default:
                    break;
            }
        }
    }
}


- (id)xr_modelInitWithCoder:(NSCoder *)aDecoder {
    if(!aDecoder) return self;
    if(self == (id)kCFNull) return self;
    XRModelMeta *modelMeta = [XRModelMeta metaWithClass:self.class];
    if(modelMeta->_nsType) return self;
    
    for(XRModelPropertyMeta *propertyMeta in modelMeta->_allPropertyMetas) {
        if(!propertyMeta->_setter) continue;
        
        if(propertyMeta->_isCNumber) {
            NSNumber *value = [aDecoder decodeObjectForKey:propertyMeta->_name];
            if([value isKindOfClass:[NSNumber class]]) {
                ModelSetNumberToProperty(self, value, propertyMeta);
                [value class];
            }
        } else {
            XREncodingType type = propertyMeta->_type & XREncodingTypeMask;
            switch (type) {
                case XREncodingTypeObject:{
                    id value = [aDecoder decodeObjectForKey:propertyMeta->_name];
                    ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)self, propertyMeta->_setter,value);
                } break;
                
                case XREncodingTypeSEL: {
                    NSString *str = [aDecoder decodeObjectForKey:propertyMeta->_name];
                    if(str) {
                        SEL sel = NSSelectorFromString(str);
                        ((void (*)(id, SEL, SEL))(void *) objc_msgSend)((id)self, propertyMeta->_setter,sel);
                    }
                } break;
                
                case XREncodingTypeStruct:
                case XREncodingTypeUnion: {
                    if(propertyMeta->_isKVCCompatible) {
                        @try {
                            NSValue *value = [aDecoder decodeObjectForKey:propertyMeta->_name];
                            if(value) [self setValue:value forKey:propertyMeta->_name];
                        } @catch (NSException *exception) {}
                    }
                } break;
        
                default: break;
            }
        }
    }
    return self;
}

- (NSUInteger)xr_modelHash {
    if(self == (id)kCFNull) return [self hash];
    XRModelMeta *modelMeta = [XRModelMeta metaWithClass:self.class];
    if(modelMeta->_nsType) return [self hash];
    
    NSUInteger value = 0;
    NSUInteger count = 0;
    
    for (XRModelPropertyMeta *propertyMeta in modelMeta->_allPropertyMetas) {
        if(!propertyMeta->_isKVCCompatible) continue;
        
        value ^= [[self valueForKey:NSStringFromSelector(propertyMeta->_getter)] hash];
        count++;
    }
    if(count == 0) value = (long)((__bridge void *)self);
    return value;
}

- (BOOL)xr_modelIsEqual:(id)model {
    if(self == model) return YES;
    if(![model isMemberOfClass:self.class]) return NO;
    
    XRModelMeta *meta = [XRModelMeta metaWithClass:self.class];
    if(meta->_nsType) return [self isEqual:model];
    if([self hash] != [model hash]) return NO;
    
    for(XRModelPropertyMeta *propertyModel in meta->_allPropertyMetas) {
        if (!propertyModel->_isKVCCompatible) continue;
        id this = [self valueForKey:NSStringFromSelector(propertyModel->_getter)];
        id that = [model valueForKey:NSStringFromSelector(propertyModel->_getter)];
        if (this == that) continue;
        if (this == nil || that == nil) return NO;
        if (![this isEqual:that]) return NO;
    }
    return YES;
}


- (NSString *)xr_modelDescription {
    return ModelDescription(self);
}


@end































