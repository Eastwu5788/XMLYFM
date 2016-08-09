//
//  XMLYSubFindController.m
//  XMLYFM
//
//  Created by East_wu on 16/8/9.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYSubFindController.h"
#import "XMLYRecommendView.h"

@interface XMLYSubFindController ()

@property (nonatomic, weak) XMLYRecommendView *recommendView;


@end

@implementation XMLYSubFindController

+ (instancetype)subFindControllerWithTitle:(NSString *)title {
    XMLYSubFindController *con = [[XMLYSubFindController alloc] init];
    con.subFindType = [self typeFromTitle:title];
    return con;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.subFindType == XMLYSubFindTypeRecommend) {
        [self recommendView];
    }else if(self.subFindType == XMLYSubFindTypeCategory) {
        self.view.backgroundColor = [UIColor greenColor];
    }else if(self.subFindType == XMLYSubFindTypeRadio) {
        self.view.backgroundColor = [UIColor orangeColor];
    }else if(self.subFindType == XMLYSubFindTypeRank) {
        self.view.backgroundColor = [UIColor yellowColor];
    }else{
        self.view.backgroundColor = [UIColor whiteColor];
    }
}

#pragma mark - private

- (XMLYRecommendView *)recommendView {
    if(!_recommendView) {
        XMLYRecommendView *view = [[XMLYRecommendView alloc] init];
        [self.view addSubview:view];
        _recommendView = view;
    }
    return _recommendView;
}



+ (XMLYSubFindType)typeFromTitle:(NSString *)title {
    if([title isEqualToString:@"推荐"]) {
        return XMLYSubFindTypeRecommend;
    }else if([title isEqualToString:@"分类"]) {
        return XMLYSubFindTypeCategory;
    }else if([title isEqualToString:@"广播"]) {
        return XMLYSubFindTypeRadio;
    }else if([title isEqualToString:@"榜单"]) {
        return XMLYSubFindTypeRank;
    }else if([title isEqualToString:@"主播"]) {
        return XMLYSubFindTypeAnchor;
    }else{
        return XMLYSubFindTypeUnknown;;
    }
}



@end
