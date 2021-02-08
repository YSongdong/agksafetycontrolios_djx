//
//  YSLProgressHUD.h
//  TestDemo
//
//  Created by creazylee on 2018/8/27.
//  Copyright © 2018年 creazylee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSLProgressHUD : UIView

+ (void)showErrorWithMessage:(NSString *)msg;
+ (void)showWarningWithMessage:(NSString *)msg;
+ (void)showSuccessWithMessage:(NSString *)msg;

@end
