//
//  XMLYAnchorFlowLayout.m
//  XMLYFM
//
//  Created by East_wu on 16/9/8.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYAnchorFlowLayout.h"

@implementation XMLYAnchorFlowLayout

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray* attributes = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    for(NSInteger i = 1,max = attributes.count; i < max; i++) {
        UICollectionViewLayoutAttributes *currentLayoutAttributes = attributes[i];
        UICollectionViewLayoutAttributes *prevLayoutAttributes = attributes[i - 1];
        NSInteger maximumSpacing = 0;
        NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
        if(origin + maximumSpacing + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width) {
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = origin + maximumSpacing;
            currentLayoutAttributes.frame = frame;
        }
    }
    return attributes;
}

@end
