//
//  ShowCountDownView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/21.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTShowCountDownView : UIView

@property (nonatomic,strong) UILabel *contentLab;

@property (nonatomic,strong) UIButton *countDownBtn;
// 是否关闭定时器 YES 是 NO 不是
@property (nonatomic,assign) BOOL  isOffTime;

@end

NS_ASSUME_NONNULL_END
