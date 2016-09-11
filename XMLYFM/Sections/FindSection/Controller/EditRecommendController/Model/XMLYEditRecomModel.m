//
//  XMLYEditRecomModel.m
//  XMLYFM
//
//  Created by East_wu on 16/9/11.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYEditRecomModel.h"

@implementation XMLYEditRecomItemModel

@end

@implementation XMLYEditRecomModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list":[XMLYEditRecomItemModel class]};
}



@end
