//
//  DetailBottomToolView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/4/10.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTDetailBottomToolView : UIView

@property (nonatomic,strong) UIButton *beginLearnBtn ;

@property (nonatomic,copy) void(^selectLearnBtn)(void);


@end

NS_ASSUME_NONNULL_END
