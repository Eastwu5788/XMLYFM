//
//  XMLYRadioSectionHeaderView.h
//  XMLYFM
//
//  Created by East_wu on 16/9/7.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, XMLYRadioSectionHeaderViewStyle) {
    XMLYRadioSectionHeaderViewStyleLocal   = 0, //本地
    XMLYRadioSectionHeaderViewStyleTop     = 1, //排行榜
    XMLYRadioSectionHeaderViewStyleHistory = 2, //历史记录
};

@interface XMLYRadioSectionHeaderView : UIView

/**
 *  初始化方法
 *  @param section  当前view所在的section
 *  @param location 当前用户所处的位置信息
 */
+ (instancetype)radioSectionHeaderViewWithSection:(XMLYRadioSectionHeaderViewStyle)style location:(nullable NSString *)location;
- (instancetype)initRadioSectionHeaderViewWithSection:(XMLYRadioSectionHeaderViewStyle)style location:(nullable NSString *)location;

- (nullable instancetype)init UNAVAILABLE_ATTRIBUTE;
- (nullable instancetype)new UNAVAILABLE_ATTRIBUTE;

@end

NS_ASSUME_NONNULL_END