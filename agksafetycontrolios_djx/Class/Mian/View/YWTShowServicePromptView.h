//
//  ShowServicePromptView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/16.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTShowServicePromptView : UIView

@property (nonatomic,strong)  UILabel *showContentLab;
//  知道按钮
@property (nonatomic,strong) UIButton *tureBtn;
// 点击确定按钮
@property (nonatomic,copy) void(^selectTureBtn)(void);

@end

NS_ASSUME_NONNULL_END
