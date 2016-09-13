//
//  XMLYAlbumIntroDetailModel.m
//  XMLYFM
//
//  Created by East_wu on 16/9/13.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYAlbumDetailModel.h"
#import "NSString+Extension.h"

@implementation XMLYAlbumIntroModel

- (void)calculateIntrolCellFrame {
    
    //1.计算标题frame
    CGFloat titX = 10;
    CGFloat titY = 0;
    CGFloat titW = kScreenWidth - 20;
    CGFloat titH = 45;
    self.titleLabelFrame = CGRectMake(titX, titY, titW, titH);
    
    //2.计算内容frame
    CGSize size = CGSizeMake(kScreenWidth - 20, CGFLOAT_MAX);
    size = [self.intro sizeForFont:[UIFont systemFontOfSize:15] size:size mode:NSLineBreakByWordWrapping];
    CGFloat intX = 10;
    CGFloat intY = CGRectGetMaxY(self.titleLabelFrame);
    CGFloat intW = titW;
    CGFloat intH = size.height + 1;
    self.introlLabelFrame = CGRectMake(intX, intY, intW, intH);
    
    //3.查看更多按钮
    CGFloat morX = 0;
    CGFloat morY = CGRectGetMaxY(self.introlLabelFrame) + 2;
    CGFloat morW = kScreenWidth;
    CGFloat morH = 44.0f;
    self.showMoreButtonFrame = CGRectMake(morX, morY, morW, morH);
    
    //4.分割view
    CGFloat sepX = 0;
    CGFloat sepY = CGRectGetMaxY(self.showMoreButtonFrame);
    CGFloat sepW = morW;
    CGFloat sepH = 10;
    self.sepViewFrame = CGRectMake(sepX, sepY, sepW, sepH);
    
    //cell高度
    self.cellHeight = CGRectGetMaxY(self.sepViewFrame);
}

@end


@implementation XMLYAlbumEditUserModel

- (void)calculateEditUserCellFrame {
    CGSize size = CGSizeMake(200, 21);
    size = [self.nickname sizeForFont:[UIFont systemFontOfSize:15.0f] size:size mode:NSLineBreakByWordWrapping];
    self.nicknameWidth = size.width;
    
    size = CGSizeMake(kScreenWidth - 51, CGFLOAT_MAX);
    size = [self.personalSignature sizeForFont:[UIFont systemFontOfSize:14.0f] size:size mode:NSLineBreakByWordWrapping];
    self.introlHeight = size.height;
    
    self.cellHeight = size.height + 155;
}

@end


@implementation XMLYAlbumRecsItemModel

- (void)calculateRecsItemModelFrame {
    //1.封面背景
    CGFloat cbgX = 5;
    CGFloat cbgY = 5;
    CGFloat cbgW = 72;
    CGFloat cbgH = 72;
    self.bgImageViewFrame = CGRectMake(cbgX, cbgY, cbgW, cbgH);
    
    //2.封面
    CGFloat covX = 12;
    CGFloat covY = 12;
    CGFloat covW = 58;
    CGFloat covH = 58;
    self.coverImageViewFrame = CGRectMake(covX, covY, covW, covH);
    
    //3.标题
    CGFloat titX = CGRectGetMaxX(self.bgImageViewFrame) + 5;
    CGFloat titW = kScreenWidth - 40 - titX;
    CGFloat titY = covY;
    CGSize size = CGSizeMake(titW, CGFLOAT_MAX);
    CGFloat titH = [self.title sizeForFont:[UIFont systemFontOfSize:15] size:size mode:NSLineBreakByWordWrapping].height + 1;
    self.titleLabelFrame = CGRectMake(titX, titY, titW, titH);
    
    //4.简介
    CGFloat intX = titX;
    CGFloat intY = CGRectGetMaxY(self.titleLabelFrame) + 10;
    CGFloat intW = titW;
    CGFloat intH = [self.intro sizeForFont:[UIFont systemFontOfSize:12] size:size mode:NSLineBreakByWordWrapping].height + 1;
    self.introLabelFrame = CGRectMake(intX, intY, intW, intH);
    
    //5.播放量
    CGFloat plbX = titX;
    CGFloat plbY = CGRectGetMaxY(self.introLabelFrame) + 10;
    CGFloat plbW = 70;
    CGFloat plbH = 10;
    self.playButtonFrame = CGRectMake(plbX, plbY, plbW, plbH);
    
    //6.专辑数量
    CGFloat albX = CGRectGetMaxX(self.playButtonFrame) + 5;
    CGFloat albY = plbY;
    CGFloat albW = plbW;
    CGFloat albH = plbH;
    self.albumButtonFrame = CGRectMake(albX, albY, albW, albH);
    
    //7.高度
    self.cellHeight = CGRectGetMaxY(self.albumButtonFrame) + 5;
    
    //8.箭头
    CGFloat arwW = 10;
    CGFloat arwH = 18;
    CGFloat arwX = kScreenWidth - 15 - arwW;
    CGFloat arwY = self.cellHeight / 2.0 - 9.0;
    self.arrowImageViewFrame = CGRectMake(arwX, arwY, arwW, arwH);

}

@end


@implementation XMLYAlbumRecsModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list":[XMLYAlbumRecsItemModel class]};
}

- (void)calculateRecsFrame {
    //标题
    CGFloat titX = 10;
    CGFloat titY = 0;
    CGFloat titW = kScreenWidth - 20;
    CGFloat titH = 45;
    self.titleLabelFrame = CGRectMake(titX, titY, titW, titH);
    
    //子视图的frame
    self.subItemFrameArray = [NSMutableArray new];
    CGFloat preY = CGRectGetMaxY(self.titleLabelFrame);
    for(XMLYAlbumRecsItemModel *model in self.list) {
        [model calculateRecsItemModelFrame];
        CGFloat itmX = 0;
        CGFloat itmY = preY;
        CGFloat itmW = kScreenWidth;
        CGFloat itmH = model.cellHeight;
        [self.subItemFrameArray addObject:NSStringFromCGRect(CGRectMake(itmX, itmY, itmW, itmH))];
        preY = itmY + itmH;
    }
    
    //子视图
    CGFloat morX = 0;
    CGFloat morY = preY + 10;
    CGFloat morW = kScreenWidth;
    CGFloat morH = 45.0f;
    self.showMoreButtonFrame = CGRectMake(morX, morY, morW, morH);
    
    self.cellHeight = morY + morH;
}

@end


@implementation XMLYAlbumDetailModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"detail":[XMLYAlbumIntroModel class],
             @"user":[XMLYAlbumEditUserModel class],
             @"recs":[XMLYAlbumRecsModel class]
             };
}

- (void)calculateFrameForCells {
    [self.detail calculateIntrolCellFrame];
    [self.user calculateEditUserCellFrame];
    [self.recs calculateRecsFrame];
}

@end
