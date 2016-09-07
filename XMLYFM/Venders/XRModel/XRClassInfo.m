//
//  XRClassInfo.m
//  XRModel
//
//  Created by East_wu on 16/8/25.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XRClassInfo.h"

/**
 *  C函数，用于根据 typeEncoding 生成 XREncodingType
 */
XREncodingType XREncodingGetType(const char *typeEncoding) {
    //1.类型转换
    char *type = (char *)typeEncoding;
    
    //2.如果不存在，则返回未知类型
    if(!type) return XREncodingTypeUnknown;
    //3.计算类型字符串长度 长度为0 也返回未知类型
    size_t len = strlen(type);
    if(len == 0) return XREncodingTypeUnknown;
    
    //4.顺序遍历type中的每一个字符，判断类型
    XREncodingType qualifier = 0;
    bool prefix = true;
    while (prefix) {
        switch (*type) {
            case 'r': {
                qualifier |= XREncodingTypeQualifierConst;
                type++;
            } break;
            case 'n': {
                qualifier |= XREncodingTypeQualifierIn;
                type++;
            }break;
            case 'N': {
                qualifier |= XREncodingTypeQualifierInout;
                type++;
            }break;
            case 'o': {
                qualifier |= XREncodingTypeQualifierOut;
                type++;
            }break;
            case 'O': {
                qualifier |= XREncodingTypeQualifierBycopy;
                type++;
            }break;
            case 'R': {
                qualifier |= XREncodingTypeQualifierByref;
                type++;
            }break;
            case 'V': {
                qualifier |= XREncodingTypeQualifierOneway;
                type++;
            }break;
            default: {
                prefix = false;
            }break;
        }
    }
    
    
    len = strlen(type);
    if(len == 0) return XREncodingTypeUnknown | qualifier;
    
    switch (*type) {
        case 'v': return XREncodingTypeVoid | qualifier;
        case 'B': return XREncodingTypeBool | qualifier;
        case 'c': return XREncodingTypeInt8 | qualifier;
        case 'C': return XREncodingTypeUInt8 | qualifier;
        case 's': return XREncodingTypeInt16 | qualifier;
        case 'S': return XREncodingTypeUInt16 | qualifier;
        case 'i': return XREncodingTypeInt32 | qualifier;
        case 'I': return XREncodingTypeUInt32 | qualifier;
        case 'l': return XREncodingTypeInt32 | qualifier;
        case 'L': return XREncodingTypeUInt32 | qualifier;
        case 'q': return XREncodingTypeInt64 | qualifier;
        case 'Q': return XREncodingTypeUInt64 | qualifier;
        case 'f': return XREncodingTypeFloat | qualifier;
        case 'd': return XREncodingTypeDouble | qualifier;
        case 'D': return XREncodingTypeLongDouble | qualifier;
        case '#': return XREncodingTypeClass | qualifier;
        case ':': return XREncodingTypeSEL | qualifier;
        case '*': return XREncodingTypeCString | qualifier;
        case '^': return XREncodingTypePointer | qualifier;
        case '[': return XREncodingTypeCArray | qualifier;
        case '(': return XREncodingTypeUnion | qualifier;
        case '{': return XREncodingTypeStruct | qualifier;
        case '@': {
            if(len == 2 && *(type + 1) == '?') {
                return XREncodingTypeBlock | qualifier;
            }else{
                return XREncodingTypeObject | qualifier;
            }
        }
        default: return XREncodingTypeUnknown | qualifier;
    }
}

@implementation XRClassIvarInfo

- (instancetype)initWithIvar:(Ivar)ivar {
    //1.输入检测
    if(!ivar) return nil;
    self = [super init];
    //2.存储原始的ivar
    _ivar = ivar;
    //3.获取ivar的名称
    const char *name = ivar_getName(ivar);
    if(name) {
        //4.如果ivar的名称获取成功，则转换成NSString类型
        _name = [NSString stringWithUTF8String:name];
    }
    //5.获取ivar在类中的偏移量
    _offset = ivar_getOffset(ivar);
    //6.获取属性的类型
    const char *typeEncoding = ivar_getTypeEncoding(ivar);
    if(typeEncoding) {
        //7.生成类型字符串
        _typeEncoding = [NSString stringWithUTF8String:typeEncoding];
        //8.生成类型枚举
        _type = XREncodingGetType(typeEncoding);
    }
    return self;
}

@end

@implementation XRClassMethodInfo

/**
 *  创建方法信息对象
 *  @param method method
 */
- (instancetype)initWithMethod:(Method)method {
    //1.输入检查
    if(!method) return nil;
    self = [super init];
    //2.存储原始method
    _method = method;
    //3.根据method获取SEL 然后根据SEL获取方法名称
    _sel = method_getName(method);
    //4.获取方法实现的指针
    _imp = method_getImplementation(method);
    //5.根据方法的选择器获取方法的名称
    const char *name = sel_getName(_sel);
    if(name) {
        //6.将方法名称转换成NSString类型
        _name = [NSString stringWithUTF8String:name];
    }
    
    //7.根据方法获取方法的类型
    const char *typeEncoding = method_getTypeEncoding(method);
    if(typeEncoding) {
        _typeEncoding = [NSString stringWithUTF8String:typeEncoding];
    }
    
    //8.获取方法的返回值类型 注意使用free()函数释放
    char *returnTypeEncoding = method_copyReturnType(method);
    if(returnTypeEncoding) {
        _returnTypeEncoding = [NSString stringWithUTF8String:returnTypeEncoding];
        free(returnTypeEncoding);
    }
    
    //9.获取方法的参数个数
    unsigned int argumentCount = method_getNumberOfArguments(method);
    if(argumentCount > 0) {
        NSMutableArray *argumentTypes = [NSMutableArray new];
        //10.依次获取方法中的每一个参数
        for(unsigned int i = 0; i < argumentCount; i++) {
            //11.获取第i个参数类型
            char *argumentType = method_copyArgumentType(method, i);
            //12.如果参数类型存在，则转换成NSStirng类型
            NSString *type = argumentType ? [NSString stringWithUTF8String:argumentType] : nil;
            //13.存储到数组中
            [argumentTypes addObject:type ? type : @""];
            if(argumentType) {
                free(argumentType);  //注意不能忘了释放
            }
        }
        //存储
        _argumentTypeEncodings = argumentTypes;
    }
    return self;
}

@end

@implementation XRClassPropertyInfo


- (instancetype)initWithProperty:(objc_property_t)property {
    //1.输入检测
    if(!property) return nil;
    self = [super init];
    //2.存储原始输入
    _property = property;
    //3.获取属性名称
    const char *name = property_getName(property);
    if(name) {
        _name = [NSString stringWithUTF8String:name];
    }
    
    //4.获取
    XREncodingType type = 0;
    unsigned int attrCount;
    //5.获取改属性的属性列表
    objc_property_attribute_t *attrs = property_copyAttributeList(property, &attrCount);
    for(unsigned int i = 0; i < attrCount; i++) {
        switch (attrs[i].name[0]) {
            case 'T': { //类型编码
                if(attrs[i].value) {
                    //获取属性类型
                    _typeEncoding = [NSString stringWithUTF8String:attrs[i].value];
                    type = XREncodingGetType(attrs[i].value);
                    
                    //类型存在
                    if((type & XREncodingTypeMask) == XREncodingTypeObject && _typeEncoding.length) {
                        //NSScanner 用于扫描字符串中指定的字符
                        NSScanner *scanner = [NSScanner scannerWithString:_typeEncoding];
                        if(![scanner scanString:@"@\"" intoString:NULL]) continue;
                        
                        NSString *clsName = nil;
                        //扫描出改属性是一个类
                        if([scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\"<"] intoString:&clsName]) {
                            if(clsName.length) {
                                _cls = objc_getClass(clsName.UTF8String);
                            }
                        }
                        
                        //扫描出属性中所有的协议
                        NSMutableArray *protocols = nil;
                        while ([scanner scanString:@"<" intoString:NULL]) {
                            NSString *protocol = nil;
                            if([scanner scanString:@">" intoString:&protocol]) {
                                if(protocol.length) {
                                    if(!protocols) protocols = [NSMutableArray new];
                                    [protocols addObject:protocol];
                                }
                            }
                            [scanner scanString:@"<" intoString:NULL];
                        }
                        _protocols = protocols;
                    }
                }
            }break;
            case 'V': { //实例变量
                if(attrs[i].value) {
                    _ivarName = [NSString stringWithUTF8String:attrs[i].value];
                }
            }break;
            case 'R': {
                type |= XREncodingTypePropertyReadonly; //只读属性
            }break;
            case 'C': {
                type |= XREncodingTypePropertyCopy;  //copy属性
            }break;
            case '&': {
                type |= XREncodingTypePropertyRetain; //retain属性
            }break;
            case 'N': {
                type |= XREncodingTypePropertyNonatomic; //nonatomic属性
            }break;
            case 'D': {
                type |= XREncodingTypePropertyDynamic;  //dynamic属性
            }break;
            case 'W': {
                type |= XREncodingTypePropertyWeak;    //weak属性
            }break;
            case 'G': {
                type |= XREncodingTypePropertyCustomGetter;
                if(attrs[i].value) {
                    //获取setter方法的 SEL
                    _getter = NSSelectorFromString([NSString stringWithUTF8String:attrs[i].value]);
                }
            }break;
            case 'S': {
                type |= XREncodingTypePropertyCustomSetter;
                if(attrs[i].value) {
                    _setter = NSSelectorFromString([NSString stringWithUTF8String:attrs[i].value]);
                }
            }break;
            default:break;
        }
    }
    if(attrs) {
        free(attrs);
        attrs = NULL;
    }
    //存储解析出来的类型
    _type = type;
    
    //如果没有自定义的getter方法或者setter方法，则使用默认的getter和setter方法
    if(_name.length) {
        if(!_getter) {
            _getter = NSSelectorFromString(_name);
        }
        if(!_setter) {
            _setter = NSSelectorFromString([NSString stringWithFormat:@"set%@%@:",[_name substringToIndex:1].uppercaseString,[_name substringFromIndex:1]]);
        }
    }
    return self;
}

@end

@implementation XRClassInfo {
    BOOL _needUpdate;
}

/**
 *  获得一个类的类信息 
 *  先从缓存中查找，如果没找到则重新创建，并加以缓存
 *  在出错的情况下有可能会返回nil
 */
+ (nullable instancetype)classInfoWithClass:(Class)cls {
    //1.检查输入
    if(!cls) return nil;
    //2.类缓存
    static CFMutableDictionaryRef classCache;
    //3.类中元素缓存
    static CFMutableDictionaryRef metaCache;
    //4.资源锁
    static dispatch_semaphore_t   lock;
    //5.创建单例
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        classCache = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        metaCache = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        lock = dispatch_semaphore_create(1);
    });
    //6.加锁并取出缓存的类信息
    dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
    XRClassInfo *info = CFDictionaryGetValue(classCache, (__bridge const void *)(cls));
    //7.如果取出的类信息需要更细，则更新类信息
    if(info && info->_needUpdate) {
        [info _update];
    }
    dispatch_semaphore_signal(lock);
    //8.如果没有缓存的类信息，则需要重新创建，并缓存
    if(!info) {
        //9.根据类，创建新的类信息
        info = [[XRClassInfo alloc] initWithClass:cls];
        if(info) {
            dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
            CFDictionarySetValue(classCache, (__bridge const void *)(cls), (__bridge const void *)(info));
            dispatch_semaphore_signal(lock);
        }
    }
    return info;
}

/**
 *  根据类名称生成类的信息
 *  @param className 类名称
 */
+ (nullable instancetype)classInfoWithClassName:(NSString *)className {
    Class cls = NSClassFromString(className);
    return [self classInfoWithClass:cls];
}

/**
 *  创建类的信息类
 *  @param cls 需要处理的类
 *  @return 处理过的信息类对象
 */
- (nullable instancetype)initWithClass:(Class)cls {
    //1.输入检测
    if(!cls) return nil;
    self = [super init];
    //2.存储原始类
    _cls = cls;
    //3.存储相应的父类
    _superCls = class_getSuperclass(cls);
    //4.判断当前类对象是否是元类
    _isMeta = class_isMetaClass(cls);
    //5.如果不是元类，则获取该类的原类对象
    if(!_isMeta) {
        _metaCls = objc_getMetaClass(class_getName(cls));
    }
    //6.获取类名称
    _name = NSStringFromClass(cls);
    //7.更新类的信息
    [self _update];
    //8.递归获取父类的类信息 self.class 是为了能调用类方法
    _superClassInfo = [self.class classInfoWithClass:_superCls];
    return self;
}

- (void)setNeedUpdate {
    _needUpdate = YES;
}

- (BOOL)needUpdate {
    return _needUpdate;
}

- (void)_update {
    //置空变量信息字典
    _ivarInfos = nil;
    //置空方法字典
    _methodInfos = nil;
    //质控属性方法字典
    _propertyInfos = nil;


    Class cls = self.cls;
    
    //1.处理Method
    unsigned int methodCount = 0;
    Method *methods = class_copyMethodList(cls, &methodCount);
    if(methods) {
        NSMutableDictionary *methodInfos = [NSMutableDictionary new];
        _methodInfos = methodInfos;
        for(unsigned int i = 0; i < methodCount; i++) {
            XRClassMethodInfo *info = [[XRClassMethodInfo alloc] initWithMethod:methods[i]];
            if(info.name) {
                methodInfos[info.name] = info;
            }
        }
        free(methods);
    }
    
    //2.处理Property
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(cls, &propertyCount);
    if(properties) {
        NSMutableDictionary *propertyInfos = [NSMutableDictionary new];
        _propertyInfos = propertyInfos;
        for(unsigned int i = 0; i < propertyCount; i++) {
            XRClassPropertyInfo *info = [[XRClassPropertyInfo alloc] initWithProperty:properties[i]];
            if(info.name) {
                propertyInfos[info.name] = info;
            }
        }
        free(properties);
    }
    
    //3.处理ivars
    unsigned int ivarCount = 0;
    Ivar *ivars = class_copyIvarList(cls, &ivarCount);
    if(ivars) {
        NSMutableDictionary *ivarInfo = [NSMutableDictionary new];
        _ivarInfos = ivarInfo;
        for(unsigned int i = 0; i < ivarCount; i++) {
            XRClassIvarInfo *info = [[XRClassIvarInfo alloc] initWithIvar:ivars[i]];
            if(info.name) {
                ivarInfo[info.name] = info;
            }
        }
        free(ivars);
    }
    
    //4.防止处理不成功
    if (!_ivarInfos) {
        _ivarInfos = @{};
    }
    if (!_methodInfos) {
        _methodInfos = @{};
    }
    if (!_propertyInfos) {
        _propertyInfos = @{};
    }
    
    _needUpdate = NO;
}




@end















