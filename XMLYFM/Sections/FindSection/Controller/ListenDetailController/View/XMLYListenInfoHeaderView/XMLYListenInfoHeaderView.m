//
//  XMLYListenInfoHeaderView.m
//  XMLYFM
//
//  Created by East_wu on 16/9/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYListenInfoHeaderView.h"

@interface XMLYListenInfoHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation XMLYListenInfoHeaderView

- (void)setInfoModel:(XMLYListenDetailEditInfo *)infoModel {
    _infoModel = infoModel;
    
    self.titleLabel.text = _infoModel.title;
}


+ (instancetype)listenInfoHeaderView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [collectionView registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier];
    XMLYListenInfoHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier forIndexPath:indexPath];
    return header;
}

@end
