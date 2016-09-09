//
//  XMLYSubScribeNavView.m
//  XMLYFM
//
//  Created by East_wu on 16/8/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYSubScribeNavView.h"
#import "Masonry.h"

#define kTitleColorNormal [UIColor colorWithRed:0.40f green:0.40f blue:0.41f alpha:1.00f]
#define kTitleColorSelect [UIColor colorWithRed:0.86f green:0.39f blue:0.30f alpha:1.00f]

@interface XMLYSubScribeNavView ()

/**
 *  小滑块
 */
@property (nonatomic, weak) UIView   *sliderView;


@property (nonatomic, strong) NSArray *titles;

@end

@implementation XMLYSubScribeNavView

+ (instancetype)subScribeNavViewWithTitles:(NSArray *)titles {
    XMLYSubScribeNavView *view = [[XMLYSubScribeNavView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    view.titles = titles;
    return view;
}



- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    [self configSubView];
    [self sliderView];
}


- (void)configSubView {
    if(self.titles.count == 0) return;
    
    CGFloat width = kScreenWidth / self.titles.count;
    
    for(NSInteger i = 0, max = self.titles.count; i < max; i++) {
        NSString *title = self.titles[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * width, 0, width, 44);
        [btn setTitleColor:kTitleColorNormal forState:UIControlStateNormal];
        [btn setTitleColor:kTitleColorSelect forState:UIControlStateSelected];
        [btn setTitleColor:kTitleColorSelect forState:UIControlStateHighlighted | UIControlStateSelected];
        [btn setTitle:title forState:UIControlStateNormal];
        if(i == 0) btn.selected = YES;
        [btn addTarget:self action:@selector(subButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100 + i;
        [self addSubview:btn];
    }
}

- (void)transToControllerAtIndex:(NSInteger)index {
    UIButton *btn = (UIButton *)[self viewWithTag:index + 100];
    btn.selected = YES;
    [self unSelectedAllButtonExcept:btn];
    [self slideViewAnimation:btn];
}

/**
 *  点击事件处理
 */
- (void)subButtonSelected:(UIButton *)btn {
    btn.selected = YES;
    [self unSelectedAllButtonExcept:btn];
    [self slideViewAnimation:btn];
    if(self.subScribeNavViewDidSubClick) {
        self.subScribeNavViewDidSubClick(self,btn.tag - 100);
    }
}

//小滑块的动画
- (void)slideViewAnimation:(UIButton *)btn {
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.sliderView.frame;
        frame.origin.x = btn.frame.origin.x + 2;
        self.sliderView.frame = frame;
    }];
}

//将除了当前按钮之外的所有按钮置为非选中状态
- (void)unSelectedAllButtonExcept:(UIButton *)btn {
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj isKindOfClass:[UIButton class]] && btn != obj) {
            ((UIButton *)obj).selected = NO;
        }
    }];
}


#pragma mark - Getter

/**
 *  加载下方的滑块
 */
- (UIView *)sliderView {
    if(!_sliderView) {
        CGFloat width = kScreenWidth / self.titles.count;
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(2, self.frame.size.height - 2.0f, width - 4, 2);
        view.backgroundColor = kTitleColorSelect;
        [self addSubview:view];
        _sliderView = view;
    }
    return _sliderView;
}

@end
