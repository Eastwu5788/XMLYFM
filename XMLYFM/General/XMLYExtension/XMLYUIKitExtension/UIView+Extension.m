//
//  UIView+Extension.m
//  XMLYFM
//
//  Created by East_wu on 16/8/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)removeAllSubViews {
    for(UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}



@end
