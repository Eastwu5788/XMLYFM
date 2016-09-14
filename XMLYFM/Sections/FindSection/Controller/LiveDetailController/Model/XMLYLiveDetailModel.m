//
//  XMLYLiveDetailModel.m
//  XMLYFM
//
//  Created by East_wu on 16/9/14.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYLiveDetailModel.h"


@implementation XMLYLivePlayUrl

@end

@implementation XMLYLiveDetailActivity

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"playUrl":[XMLYLivePlayUrl class]};
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"desc":@"description"};
}

@end

@implementation XMLYAnchorInfo

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"desc":@"description"};
}

@end

@implementation XMLYActivitySchedules

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"playUrl":[XMLYLivePlayUrl class]};
}



@end

@implementation XMLYLiveDetailModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"activityDetail":[XMLYLiveDetailActivity class],
             @"anchorInfo":[XMLYAnchorInfo class],
             @"activitySchedules":[XMLYActivitySchedules class]};
}

@end
