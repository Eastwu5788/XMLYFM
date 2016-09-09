//
//  XMLYFindAnchorModel.m
//  XMLYFM
//
//  Created by East_wu on 16/9/8.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYFindAnchorModel.h"

@implementation XMLYAnchorCellModel

@end

@implementation XMLYAnchorSectionModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list":[XMLYAnchorCellModel class]};
}

@end

@implementation XMLYFindAnchorModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"famous":[XMLYAnchorSectionModel class],
             @"normal":[XMLYAnchorSectionModel class],
             @"dataSource":[XMLYAnchorSectionModel class]};
}

- (void)createDataSource {
    self.dataSource = [[NSMutableArray alloc] init];
    for(NSInteger i = 0,max = self.famous.count; i < max; i++){
        XMLYAnchorSectionModel *secionModel = self.famous[i];
        if(secionModel.list.count) {
            [self.dataSource addObject:secionModel];
        }
    }
    
    for(NSInteger i = 0,max = self.normal.count; i < max; i++) {
        XMLYAnchorSectionModel *sectionModel = self.normal[i];
        if(sectionModel.list.count) {
            [self.dataSource addObject:sectionModel];
        }
    }
}

@end
