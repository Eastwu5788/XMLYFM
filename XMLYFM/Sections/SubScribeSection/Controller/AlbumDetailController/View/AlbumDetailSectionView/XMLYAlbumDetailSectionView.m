//
//  XMLYAlbumDetailSectionView.m
//  XMLYFM
//
//  Created by East_wu on 16/9/13.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYAlbumDetailSectionView.h"


@interface XMLYAlbumDetailSectionView ()

@property (nonatomic, weak) UIButton    *detailButton;   //详情按钮
@property (nonatomic, weak) UIButton    *listButton;     //节目列表按钮
@property (nonatomic, weak) UIView      *circleView;     //圆点
@property (nonatomic, weak) UIView      *sepView;

@end


@implementation XMLYAlbumDetailSectionView

+ (instancetype)albumDetailSectionView {
    return [[self alloc] initAlbumDetailSectionView];
}

- (instancetype)initAlbumDetailSectionView {
    self = [super init];
    self.backgroundColor = [UIColor whiteColor];
    [self detailButton];
    [self listButton];
    [self circleView];
    [self sepView];
    return self;
}

- (void)setStyle:(XMLYAlbumDetailStyle)style {
    _style = style;
    if(_style == XMLYAlbumDetailStyleDetail) {
        self.detailButton.selected = YES;
        self.listButton.selected = NO;
    }else{
        self.detailButton.selected = NO;
        self.listButton.selected = YES;
    }
}

- (void)setAlbumModel:(XMLYAlbumModel *)albumModel {
    _albumModel = albumModel;
    
    [self.listButton setTitle:[NSString stringWithFormat:@"节目(%ld)",_albumModel.tracks] forState:UIControlStateNormal];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.width / 2.0f;
    
    self.detailButton.frame = CGRectMake(0, 0, width, self.height - 1);
    
    self.listButton.frame = CGRectMake(width, 0, width, self.height - 1);

    self.circleView.size = CGSizeMake(6, 6);
    self.circleView.bottom = self.height - 7;
    
    if(self.style == XMLYAlbumDetailStyleDetail) {
        self.circleView.centerX = self.detailButton.centerX;
    } else {
        self.circleView.centerX = self.listButton.centerX;
    }
    
    self.sepView.frame = CGRectMake(0, self.height - 0.5f, self.width, 0.5f);
}

- (void)clickButton:(UIButton *)btn {
    if(btn.tag == 100) {
        self.style = XMLYAlbumDetailStyleDetail;
    }else{
        self.style = XMLYAlbumDetailStyleList;
    }
    self.circleView.centerX = btn.centerX;
    if(self.sectionButtonClicBlock) {
        self.sectionButtonClicBlock(self,self.style);
    }
}

#pragma mark - getter

- (UIView *)sepView {
    if(!_sepView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = Hex(0xECEDEE);
        [self addSubview:view];
        _sepView = view;
    }
    return _sepView;
}

//红色小圆点
- (UIView *)circleView {
    if(!_circleView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = Hex(0xF86442);
        view.layer.cornerRadius = 3.0f;
        [self addSubview:view];
        _circleView = view;
    }
    return _circleView;
}

//节目列表
- (UIButton *)listButton {
    if(!_listButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"节目(373)" forState:UIControlStateNormal];
        [btn setTitleColor:Hex(0x636465) forState:UIControlStateNormal];
        [btn setTitleColor:Hex(0xF86442) forState:UIControlStateSelected];
        btn.tag = 101;
        [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _listButton = btn;
    }
    return _listButton;
}

//详情按钮
- (UIButton *)detailButton {
    if(!_detailButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"详情" forState:UIControlStateNormal];
        [btn setTitleColor:Hex(0x636465) forState:UIControlStateNormal];
        [btn setTitleColor:Hex(0xF86442) forState:UIControlStateSelected];
        btn.tag = 100;
        [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _detailButton = btn;
    }
    return _detailButton;
}

@end
