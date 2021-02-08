//
//  AlterPwdModuleView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/9.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum{
    showPasswordView = 0, // 不发送验证码
    showCodeView,         // 显示验证码
    showPhoneView,        // 显示phone
}showViewStatus;

@interface YWTAlterPwdModuleView : UIView

// 发送按钮
@property (nonatomic,strong) UIButton *sendBtn;
//查看按钮
@property (nonatomic,strong) UIButton *lookBtn;
// 状态
@property (nonatomic,assign) showViewStatus showViewStatu;

//左边文字
@property (nonatomic,strong) NSString *leftTitleStr;
//textfield
@property (nonatomic,strong) UITextField *baseTextField;
// textField 提示str
@property (nonatomic,strong) NSString *placeholderStr;
//textField 提示颜色
@property (nonatomic,strong) UIColor *placeColor;
// textField 提示 字体大小
@property (strong,nonatomic)UIFont *placeTextFont;
// 底部线条View 颜色
@property (nonatomic,strong) UIView *bottomLineView;

#pragma  mark ------点击方法 ---------
// 发送验证码
@property (nonatomic,copy) void(^sendCodeBlock)(void);

@end

NS_ASSUME_NONNULL_END
