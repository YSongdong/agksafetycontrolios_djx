//
//  UIColor+ColorChange.m
//  PlayDemo
//
//  Created by tiao on 2018/1/12.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "UIColor+ColorChange.h"

@implementation UIColor (ColorChange)

//文字白色
+ (UIColor *) colorTextWhiteColor{
    return [UIColor colorWithHexString:@"#ffffff"];
}
//View背景白色
+ (UIColor *) colorViewBackGrounpWhiteColor{
    return [UIColor colorWithHexString:@"#f2f2f2"];
}
//ViewF0f0背景白色
+ (UIColor *) colorViewF0F0BackGrounpWhiteColor{
    return [UIColor colorWithHexString:@"#f0f0f0"];
}
//ViewBackF9F9背景白色
+ (UIColor *) colorViewBackF9F9GrounpWhiteColor{
    return [UIColor colorWithHexString:@"#f9f9f9"];
}

//文字常用黑色
+ (UIColor *) colorCommonBlackColor{
     return [UIColor colorWithHexString:@"#282828"];
}
//文字错误红色
+ (UIColor *) colorCommonRedColor{
     return [UIColor colorWithHexString:@"#ff3030"];
}

//文字常用灰黑色
+ (UIColor *) colorCommonGreyBlackColor{
   return [UIColor colorWithHexString:@"#989898"];
}
//文字常用65灰黑色
+ (UIColor *) colorCommon65GreyBlackColor{
    return [UIColor colorWithHexString:@"#656565"];
}
//文字常用AAAA灰黑色
+ (UIColor *) colorCommonAAAAGreyBlackColor{
    return [UIColor colorWithHexString:@"#aaaaaa"];
}
//文字常用灰色
+ (UIColor *) colorCommonGreyColor{
    return [UIColor colorWithHexString:@"#f5f5f5"];
}
// 文字常用橙色
+ (UIColor *) colorTextCommonOrangeColor{
    return [UIColor colorWithHexString:@"#ffb046"];
}
//文字常用蓝色
+ (UIColor *) colorTextCommonBlueColor{
     return [UIColor colorWithHexString:@"#3dbafd"];
}
//view常用背景灰色
+ (UIColor *) colorCommonBackGroumdGreyColor{
    return [UIColor colorWithHexString:@"#f9f9f9"];
}
// view背景白色
+ (UIColor *) colorViewWhiteColor{
    return [UIColor colorWithHexString:@"#f1f1f1"];
}
//头像描边颜色
+ (UIColor *) colorHeaderImageVDBDBColor{
    return [UIColor colorWithHexString:@"#dbdbdb"];
}
//线条E3E3灰色
+ (UIColor *) colorLineE3E3CommonGreyBlackColor{
    return [UIColor colorWithHexString:@"#e3e3e3"];
}
//线条常用灰色
+ (UIColor *) colorLineCommonGreyBlackColor{
    return [UIColor colorWithHexString:@"#e0e0e0"];
}
//线条常用灰色
+ (UIColor *) colorLineCommonE9E9E9GreyBlackColor{
    return [UIColor colorWithHexString:@"#e9e9e9"];
}

//线条常用蓝色
+ (UIColor *) colorConstantCommonBlueColor{
    return [UIColor colorWithHexString:@"#4285f5"];
}

//主体颜色 红色
+ (UIColor *) colorLineCommonBlueColor{
    return [UIColor colorWithHexString:@"#e93129"];
}
/*      主颜色点击效果的颜色         */
+ (UIColor *) colorClickCommonBlueColor{
    return [UIColor colorWithHexString:@"#e93129" alpha:0.8];
}
// 继续按钮
+ (UIColor *) colorContinueBtnIsSelectColor:(BOOL)isSelect{
    if (isSelect) {
        return [UIColor colorWithHexString:@"#f06e69" alpha:0.8];
    }else{
        return [UIColor colorWithHexString:@"#f06e69"];
    }
}

//  党员互动区 用户名橙色
+ (UIColor *) colorPatryNickNameColor{
    return [UIColor colorWithHexString:@"#fa8605"];
}

#pragma mark ----- 黑暗模式 --------
// 黑暗主颜色
+ (UIColor *) colorConstantStyleDarkColor{
    return [UIColor colorWithHexString:@"#151e2f"];
}
// 适配黑暗模式的颜色
+ (UIColor *) colorStyleLeDarkWithConstantColor:(UIColor*)ConstantColor normalCorlor:(UIColor*)normalColor{
    if (@available(iOS 13.0, *)) {
         return  [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if ([traitCollection userInterfaceStyle] == UIUserInterfaceStyleDark) {
                return ConstantColor;
            }else{
                return normalColor;
            }
        }];
    }else{
        return normalColor;
    }
}

+ (UIColor *) colorWithHexString: (NSString *)color{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+ (UIColor *) colorWithHexString: (NSString *)color alpha:(CGFloat) alpha
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}

@end
