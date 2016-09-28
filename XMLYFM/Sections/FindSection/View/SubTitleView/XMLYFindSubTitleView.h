//
//  XMLYFindSubTitleView.h
//  XMLYFM
//
//  Created by East_wu on 16/8/9.
//  Copyright © 2016年 East_wu. All rights reserved.
//  这个控件日后可以加以利用



#import <UIKit/UIKit.h>

@class XMLYFindSubTitleView;

@protocol  XMLYFindSubTitleViewDelegate <NSObject>

/**
 *  当前选中第index个标题的代理毁掉
 */
- (void)findSubTitleViewDidSelected:(XMLYFindSubTitleView *)titleView atIndex:(NSInteger)index title:(NSString *)title;

@end

@interface XMLYFindSubTitleView : UIView

/**
 *  字标题视图的数据源
 */
@property (nonatomic, strong) NSMutableArray<NSString *> *titleArray;

@property (nonatomic, weak) __weak id<XMLYFindSubTitleViewDelegate> delegate;


/**
 指定跳转位置

 @param index 传递位置的索引
 */
- (void)trans2ShowAtIndex:(NSInteger)index;

@end
