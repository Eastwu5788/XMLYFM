//
//  XMLYFindCellStyleFee.m
//  XMLYFM
//
//  Created by East_wu on 16/8/11.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYFindCellStyleFee.h"
#import "UIImageView+YYWebImage.h"

@interface XMLYFindCellStyleFee ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *moreButton;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageViewLeft;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageViewMiddle;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageViewRight;

@property (weak, nonatomic) IBOutlet UILabel *contentLeft;

@property (weak, nonatomic) IBOutlet UILabel *contentMiddel;

@property (weak, nonatomic) IBOutlet UILabel *contentRight;

@property (weak, nonatomic) IBOutlet UILabel *subContentLeft;

@property (weak, nonatomic) IBOutlet UILabel *subContentMiddle;

@property (weak, nonatomic) IBOutlet UILabel *subContentRight;

@end

@implementation XMLYFindCellStyleFee


- (void)setRecommendModel:(XMLYFindEditorRecommendAlbumModel *)recommendModel {
    _recommendModel = recommendModel;
    
    self.titleLabel.text = _recommendModel.title;
    
    [self setSubDetailsWithDetailArr:_recommendModel.list];
}

- (void)setCityColumn:(XMLYCityColumnModel *)cityColumn {
    _cityColumn = cityColumn;
    
    self.titleLabel.text = _cityColumn.title;
    
    [self setSubDetailsWithDetailArr:_cityColumn.list];
}

- (void)setHotRecommedItemModel:(XMLYHotRecommendItemModel *)hotRecommedItemModel {
    _hotRecommedItemModel = hotRecommedItemModel;
    
    self.titleLabel.text = _hotRecommedItemModel.title;
    
    [self setSubDetailsWithDetailArr:_hotRecommedItemModel.list];
}


- (void)setSubDetailsWithDetailArr:(NSMutableArray<XMLYFindEditorRecommendDetailModel *> *)array {
    for(NSInteger index = 0; index < array.count; index ++) {
        XMLYFindEditorRecommendDetailModel *model = [array objectAtIndex:index];
        NSURL *url = [NSURL URLWithString:model.coverMiddle];
        if(index == 0) {
            [self.iconImageViewLeft yy_setImageWithURL:url options:YYWebImageOptionSetImageWithFadeAnimation];
            self.contentLeft.text = model.intro;
            self.subContentLeft.text = model.title;
        }else if(index == 1) {
            [self.iconImageViewMiddle yy_setImageWithURL:url options:YYWebImageOptionSetImageWithFadeAnimation];
            self.contentMiddel.text = model.intro;
            self.subContentMiddle.text = model.title;
        }else if(index == 2) {
            [self.iconImageViewRight yy_setImageWithURL:url options:YYWebImageOptionSetImageWithFadeAnimation];
            self.contentRight.text = model.intro;
            self.subContentRight.text = model.title;
        }
    }
}

- (IBAction)showMoreButtonClick:(id)sender {
    if([self.delegate respondsToSelector:@selector(findCellStyleFeeCellDidMoreClick:)]) {
        [self.delegate findCellStyleFeeCellDidMoreClick:self];
    }
}

+ (XMLYFindBaseCell *)findCell:(UITableView *)tableView {
    return [self findCellStyleFee:tableView];
}


+ (instancetype)findCellStyleFee:(UITableView *)tableView {
    NSString *identifer = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:identifer bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifer];
    return [tableView dequeueReusableCellWithIdentifier:identifer];
}


@end


