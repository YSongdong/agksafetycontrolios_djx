//
//  ShowVerifyIdentidyErrorView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/23.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTShowVerifyIdentidyErrorView : UIView

-(instancetype)initWithFrame:(CGRect)frame andType:(NSString *)typeStr;

// 点击其他区域取消view  YES 不能 NO 能
@property (nonatomic,assign) BOOL isColseBigBgView;
// 再次验证
@property (nonatomic,strong) UIButton *againVerifyBtn;
// 直接进入
@property (nonatomic,strong) UIButton *enterDirectlyBtn;

@property (nonatomic,copy) void(^againBtnBlock)(void);

@property (nonatomic,copy) void(^enterBtnBlcok)(void);



@end

NS_ASSUME_NONNULL_END
