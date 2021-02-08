//
//  ShowUnNetWorkStateView.h
//  AgkSafetyControl
//
//  Created by tiao on 2019/2/15.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTShowUnNetWorkStatuView : UIView
//
@property (nonatomic,strong) UIImageView *bgImageV;
// 重试按钮
@property (nonatomic,strong) UIButton *retryBtn;
// 点击重试按钮
@property (nonatomic,copy) void(^selectRetryBlock)(void);
// 内容lab;
@property (nonatomic,strong)  UILabel *titleLab;
@end

NS_ASSUME_NONNULL_END
