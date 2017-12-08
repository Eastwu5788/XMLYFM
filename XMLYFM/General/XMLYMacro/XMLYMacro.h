//
//  XMLYMacro.h
//  XMLYFM
//
//  Created by East_wu on 16/8/8.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 *  系统相关宏定义
 */
#define kScreenWidth   CGRectGetWidth([[UIScreen mainScreen] bounds])  //获取屏幕宽度
#define kScreenHeight  CGRectGetHeight([[UIScreen mainScreen] bounds]) //获取屏幕高度

/**
 *  颜色处理
 */
#define Hex(rgbValue) ([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]) 

/***  普通字体 */
#define kFont(size) [UIFont systemFontOfSize:size]
/***  粗体 */
#define kBoldFont(size) [UIFont boldSystemFontOfSize:size]
/***  线条高度 */
#define kLineHeight (1 / [UIScreen mainScreen].scale)
/***  快速创建图片 */
#define kIMAGE(name)  [UIImage imageNamed:name]

// 系统UI相关
#define kTopBarHeight (iPhoneX ? 88.0f : 64.0f)
#define kTabBarHeight (iPhoneX ? 83.0f : 49.0f)

/*** 判断当前设备类型 */
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneX [UIScreen mainScreen].bounds.size.width == 375.0f && [UIScreen mainScreen].bounds.size.height == 812.0f

#define iOS11 @available(iOS 11.0, *)

// 字符串相关
#define kEmptyStr @""
#define kValidStr(str) [LDUtils validString:str]
#define kIntegerStr(i) [NSString stringWithFormat:@"%ld", i]
#define kIntStr(i) [NSString stringWithFormat:@"%d", i]

// Log打印相关
#define NEED_LOG  1
#if NEED_LOG
#define Log(xx, ...)         NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define Log(xx, ...)         nil
#endif

#define force_inline __inline__ __attribute__((always_inline))

static NSString *const kSectionFooter = @"UICollectionElementKindSectionFooter";
static NSString *const kSectionHeader = @"UICollectionElementKindSectionHeader";


@interface XMLYMacro : NSObject
@end
