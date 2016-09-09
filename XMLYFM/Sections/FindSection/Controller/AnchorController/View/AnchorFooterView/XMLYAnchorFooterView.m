//
//  XMLYAnchorFooterView.m
//  XMLYFM
//
//  Created by East_wu on 16/9/8.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYAnchorFooterView.h"

@implementation XMLYAnchorFooterView

+ (instancetype)anchorFooterView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = NSStringFromClass([self class]);
    [collectionView registerClass:[self class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier];
    XMLYAnchorFooterView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier forIndexPath:indexPath];
    footer.backgroundColor = Hex(0xf0f0f0);
    return footer;
}

@end
