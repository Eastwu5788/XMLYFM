//
//  XMLYBasePlayController.h
//  XMLYFM
//
//  Created by East_wu on 16/9/11.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XMLYBaseController.h"

@interface XMLYBasePlayView : UIView

@property (nonatomic, weak) UIButton    *playButton;
@property (nonatomic, weak) UIImageView *bgImageView;



@end

@interface XMLYBasePlayController : XMLYBaseController

@property (nonatomic, weak) XMLYBasePlayView *playView;

@end
