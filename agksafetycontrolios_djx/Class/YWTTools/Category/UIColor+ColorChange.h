//
//  UIColor+ColorChange.h
//  PlayDemo
//
//  Created by tiao on 2018/1/12.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ColorChange)

//文字白色
+ (UIColor *) colorTextWhiteColor;
//View背景白色
+ (UIColor *) colorViewBackGrounpWhiteColor;
//ViewBackF9F9背景白色
+ (UIColor *) colorViewBackF9F9GrounpWhiteColor;
//文字常用黑色
+ (UIColor *) colorCommonBlackColor;
//文字错误红色
+ (UIColor *) colorCommonRedColor;
//文字常用灰黑色
+ (UIColor *) colorCommonGreyBlackColor;
//文字常用65灰黑色
+ (UIColor *) colorCommon65GreyBlackColor;
//文字常用AAAA灰黑色
+ (UIColor *) colorCommonAAAAGreyBlackColor;
//文字常用灰色
+ (UIColor *) colorCommonGreyColor;
// 文字常用橙色
+ (UIColor *) colorTextCommonOrangeColor;
//文字常用蓝色
+ (UIColor *) colorTextCommonBlueColor;
//ViewF0f0背景白色
+ (UIColor *) colorViewF0F0BackGrounpWhiteColor;
//view常用背景灰色
+ (UIColor *) colorCommonBackGroumdGreyColor;
// view背景白色
+ (UIColor *) colorViewWhiteColor;
//头像描边颜色
+ (UIColor *) colorHeaderImageVDBDBColor;
//线条E3E3灰色
+ (UIColor *) colorLineE3E3CommonGreyBlackColor;
//线条常用灰色
+ (UIColor *) colorLineCommonE9E9E9GreyBlackColor;
//线条常用灰色
+ (UIColor *) colorLineCommonGreyBlackColor;
//线条常用蓝色
+ (UIColor *) colorConstantCommonBlueColor;
// 十六进制颜色
+ (UIColor *) colorWithHexString: (NSString *)color;
// 十六进制颜色 自定义alphe
+ (UIColor *) colorWithHexString: (NSString *)color alpha:(CGFloat) alpha;
/*      主颜色         */
//主体颜色 蓝色
+ (UIColor *) colorLineCommonBlueColor;
/*      主颜色点击效果的颜色         */
+ (UIColor *) colorClickCommonBlueColor;
// 继续按钮
+ (UIColor *) colorContinueBtnIsSelectColor:(BOOL)isSelect;

//  党员互动区 用户名橙色
+ (UIColor *) colorPatryNickNameColor;

// 黑暗主颜色
+ (UIColor *) colorConstantStyleDarkColor;
// 适配黑暗模式的颜色
+ (UIColor *) colorStyleLeDarkWithConstantColor:(UIColor*)ConstantColor normalCorlor:(UIColor*)normalColor;

@end
