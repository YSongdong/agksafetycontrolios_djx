//
//  LoginBaseTextFieldView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/8.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    baseTextFieldNormalStatu = 0 , // 正常状态
    baseTextFieldShowClearStatu,   // 只显示清除按钮状态
    baseTextFieldPhoneStatu,     // 手机
}baseTextFieldStatu;

@interface YWTLoginBaseTextFieldView : UIView
// 类型
@property (nonatomic,assign)baseTextFieldStatu  textFieldStatu;
//查看按钮
@property (nonatomic,strong) UIButton *lookBtn;
// 左边UIimageV
@property (nonatomic,strong)  UIImageView *leftImageV;
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


@end

NS_ASSUME_NONNULL_END
