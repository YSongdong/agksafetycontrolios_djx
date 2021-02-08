//
//  BasePwdTextFieldView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/8.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum{
    showPasswordView = 0, // 显示密码
    showCodeView,         // 显示验证码
}showViewStatus;


@interface YWTBasePwdTextFieldView : UIView
// 构造函数
-(instancetype)initWithFrame:(CGRect)frame ;

@property (nonatomic,assign) showViewStatus viewStatu;

//清除按钮
@property (nonatomic,strong) UIButton *clearBtn;
//查看按钮
@property (nonatomic,strong) UIButton *lookBtn;
// 发送按钮
@property (nonatomic,strong) UIButton *sendBtn;
// 左边默认 image
@property (nonatomic,strong) NSString *leftNormalImageStr;
//左边高度image
@property (nonatomic,strong) NSString *leftHeihtImageStr;
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
