//
//  XMLYAlbumContentCell.m
//  XMLYFM
//
//  Created by East_wu on 16/9/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYAlbumContentCell.h"
#import "XMLYAlbumDetailView.h"

@interface XMLYAlbumContentCell ()

@property(nonatomic, weak) XMLYAlbumDetailView *detailView;

@end

@implementation XMLYAlbumContentCell

- (void)showAlbumDetailView {
    [self detailView];
}

- (XMLYAlbumDetailView *)detailView {
    if(!_detailView) {
        XMLYAlbumDetailView *view = [XMLYAlbumDetailView albumDetailViewWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 40)];
        [self addSubview:view];
        _detailView = view;
    }
    return _detailView;
}

@end
