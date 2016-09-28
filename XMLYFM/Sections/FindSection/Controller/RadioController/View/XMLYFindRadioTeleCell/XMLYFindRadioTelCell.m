//
//  XMLYFindRadioTelCell.m
//  XMLYFM
//
//  Created by East_wu on 16/9/7.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYFindRadioTelCell.h"
#import "XMLYHeaderIconView.h"
#import "UIView+Extension.h"


@interface XMLYFindTelView : UIView

@property (nonatomic, strong) NSArray *iconArray;
@property (nonatomic, strong) NSArray *titleArray;


- (instancetype)initWithFrame:(CGRect)frame;

@end

@implementation XMLYFindTelView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self configSubViews];
    return self;
}

- (void)configSubViews {
    CGFloat width = kScreenWidth / 4.0f;
    for(NSInteger i = 0, max = self.iconArray.count; i < max; i++) {
        XMLYHeaderIconView *view = [XMLYHeaderIconView headerIconView];
        view.frame = CGRectMake(i * width, 0, width, self.frame.size.height);
        [view configWithTitle:self.titleArray[i] localImageName:self.iconArray[i]];
        [self addSubview:view];
    }
}

#pragma mark - Getter

- (NSArray *)iconArray {
    if(!_iconArray) {
        _iconArray = @[@"icon_radio_local",@"icon_radio_country",@"icon_radio_province",@"icon_radio_internet"];
    }
    return _iconArray;
}

- (NSArray *)titleArray {
    if(!_titleArray) {
        _titleArray = @[@"本地台",@"国家台",@"省市台",@"网络台"];
    }
    return _titleArray;
}

@end



@interface XMLYFindRadioTelCell ()

@property (nonatomic, weak) XMLYFindTelView *telView;

@end

@implementation XMLYFindRadioTelCell

//新闻台，国家台
- (void)setModel:(XMLYFindRadioModel *)model {
    _model = model;
    
    NSInteger max = _model.style == XMLYFindRadioTelCellStyleHidden ? 8 : 16;
    
    [self removeAllResufulButton];
    
    CGFloat width = (kScreenWidth - 24.5) / 4.0f;
    for(NSInteger i = 0; i < max; i++) {
        NSInteger col = i % 4; //列
        NSInteger cow = i / 4; //行
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10 + (width + 1.5) * col, 100 + 46 * cow, width, 45);
        btn.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
        if(i == max - 1) {
            NSString *imgName = _model.style == XMLYFindRadioTelCellStyleHidden ? @"icon_radio_show" : @"icon_radio_hide";
            [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(showMoreOrHiddenButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            if(i >= _model.categories.count) break;
            XMLYFindRadioCategoryItem *item = _model.categories[i];
            [btn setTitle:item.name forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRed:0.18f green:0.18f blue:0.18f alpha:1.00f] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
        }
        [self addSubview:btn];
    }
}

- (void)showMoreOrHiddenButtonClick:(UIButton *)btn {
    if(self.showMoreOrHiddenBlock) {
        self.showMoreOrHiddenBlock(self);
    }
}

- (void)removeAllResufulButton {
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj isKindOfClass:[UIButton class]]) {
            [obj removeFromSuperview];
        }
    }];
}


- (void)configSubViews {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self telView];
}

+ (instancetype)findRadioTelCell:(UITableView *)tableView {
    NSString *identifier = NSStringFromClass(self);
    [tableView registerClass:[self class] forCellReuseIdentifier:identifier];
    XMLYFindRadioTelCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    [cell configSubViews];
    return cell;
}

#pragma mark - Getter
- (XMLYFindTelView *)telView {
    if(!_telView) {
        XMLYFindTelView *tel = [[XMLYFindTelView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        [self addSubview:tel];
        _telView = tel;
    }
    return _telView;
}

@end
