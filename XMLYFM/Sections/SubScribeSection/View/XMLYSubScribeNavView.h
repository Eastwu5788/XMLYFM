//
//  XMLYSubScribeNavView.h
//  XMLYFM
//
//  Created by East_wu on 16/8/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMLYSubScribeNavView : UIView
/**
 *  选中subButton的block
 */
@property (nonatomic, copy) void(^subScribeNavViewDidSubClick)(XMLYSubScribeNavView *view,NSInteger index);

/**
 *  订阅听控制器上方的导航栏
 */
+ (instancetype)subScribeNavViewWithTitles:(NSArray *)titles;

- (void)transToControllerAtIndex:(NSInteger)index;

@end
