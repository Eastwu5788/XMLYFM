//
//  XMLYDownTaskModel.m
//  XMLYFM
//
//  Created by East_wu on 16/9/19.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYDownTaskModel.h"
#import "NSString+Extension.h"

@implementation XMLYDownTaskModel

- (NSString *)destinationLocaoPath {
    if(!_destinationLocaoPath) {
        _destinationLocaoPath = self.trackModel.destinationLocaoPath;
    }
    return _destinationLocaoPath;
}

@end
