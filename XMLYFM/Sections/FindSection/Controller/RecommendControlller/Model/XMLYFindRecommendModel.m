//
//  XMLYFindRecommendModel.m
//  XMLYFM
//
//  Created by East_wu on 16/8/10.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYFindRecommendModel.h"

@implementation XMLYFindRecommendModel

@end

@implementation XMLYFindEditorRecommendAlbumModel

@end

@implementation XMLYSpecialColumnModel

@end

@implementation XMLYSpecialColumnDetailModel

@end

@implementation XMLYFindFocusImagesModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list":[XMLYFindFocusImageDetailModel class]};
}

@end

@implementation XMLYFindFocusImageDetailModel

@end

@implementation XMLYFindEditorRecommendDetailModel

@end