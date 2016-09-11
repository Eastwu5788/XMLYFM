//
//  XMLYLiveListModel.m
//  XMLYFM
//
//  Created by East_wu on 16/9/11.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYLiveListModel.h"

@implementation XMLYLiveListItemModel



@end

@implementation XMLYLiveListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data":[XMLYLiveListItemModel class]};
}

@end
