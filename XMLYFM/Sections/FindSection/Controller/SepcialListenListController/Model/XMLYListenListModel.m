//
//  XMLYListenListModel.m
//  XMLYFM
//
//  Created by East_wu on 16/9/12.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYListenListModel.h"

@implementation XMLYListenItemModel


+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id":@"cid"};
}

@end

@implementation XMLYListenListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list":[XMLYListenItemModel class]};
}

- (NSMutableArray *)list {
    if(!_list) {
        _list = [[NSMutableArray alloc] init];
    }
    return _list;
}



@end
