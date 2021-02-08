//
//  LoginBaseTextFieldView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/8.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTLoginBaseTextFieldView.h"

@interface YWTLoginBaseTextFieldView ()<UITextFieldDelegate>
//清除按钮
@property (nonatomic,strong) UIButton *clearBtn;



@end

@implementation YWTLoginBaseTextFieldView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createBaseTF];
    }
    return self;
}
-(void) createBaseTF{
    __weak typeof(self) weakSelf = self;
    
    self.leftImageV = [[UIImageView alloc]init];
    [self addSubview:self.leftImageV];
    self.leftImageV.image = [UIImage imageNamed:@"login_ico01"];
    self.leftImageV.contentMode = UIViewContentModeScaleAspectFit;
    [self.leftImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(4));
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.equalTo(@30);
    }];
    
    // 查看按钮
    self.lookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.lookBtn];
    [self.lookBtn setImage:[UIImage imageNamed:@"login_ico_off"] forState:UIControlStateNormal];
    [self.lookBtn setImage:[UIImage imageNamed:@"login_ico_on"] forState:UIControlStateSelected];
    [self.lookBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(7));
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.equalTo(@28);
    }];
    //隐藏
    self.lookBtn.hidden = YES;
    [self.lookBtn addTarget:self action:@selector(selectLookBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    // 清除按钮
    self.clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.clearBtn];
    [self.clearBtn setImage:[UIImage imageNamed:@"login_ico_delete"] forState:UIControlStateNormal];
    [self.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.lookBtn.mas_left).offset(-KSIphonScreenW(5));
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.equalTo(@28);
    }];
    //隐藏
    self.clearBtn.hidden = YES;
    [self.clearBtn addTarget:self action:@selector(selectClearBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    // 输入框
    self.baseTextField = [[UITextField alloc]init];
    [self addSubview:self.baseTextField];
    self.baseTextField.placeholder = @"";
    self.baseTextField.textColor = [UIColor colorCommonBlackColor];
    self.baseTextField.font = Font(16);
    self.baseTextField.delegate = self;
    self.baseTextField.returnKeyType = UIReturnKeyDone;
    //设置颜色和大小
    self.baseTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"" attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15],NSForegroundColorAttributeName : [UIColor colorCommonGreyBlackColor]}];
    
    [self.baseTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftImageV.mas_right).offset(KSIphonScreenW(6));
        make.top.bottom.equalTo(weakSelf);
        make.right.equalTo(weakSelf.clearBtn.mas_left);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    [self.baseTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    
    
    //线条view
    self.bottomLineView = [[UIView alloc]init];
    [self addSubview:self.bottomLineView];
    self.bottomLineView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf);
        make.height.equalTo(@1);
    }];
}
// 点击完成按钮
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)selectLookBtn:(UIButton *) sender{
    sender.selected =! sender.selected;
    if (sender.selected) {
        self.baseTextField.secureTextEntry = NO;
    }else{
        self.baseTextField.secureTextEntry = YES;
    }
}
//点击清除按钮
-(void) selectClearBtn:(UIButton *) sender{
    self.baseTextField.text = @"";
    //默认左边的图
    self.leftImageV.image = [UIImage imageNamed:self.leftNormalImageStr];
    // 线条颜色
    self.bottomLineView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
}
//监听键盘输入
- (void)textFieldChanged:(UITextField*)textField{
    //默认颜色
    self.baseTextField.textColor = [UIColor colorCommonBlackColor];
    // 默认线条颜色
    self.bottomLineView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];

    if (textField.text.length > 0) {
         self.leftImageV.image = [UIImage imageNamed:self.leftHeihtImageStr];
    }else{
        self.leftImageV.image = [UIImage imageNamed:self.leftNormalImageStr];
    }
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.length == 1 && string.length == 0) {
        return YES;
    }
    if (self.textFieldStatu == baseTextFieldPhoneStatu) {
        if (self.textFieldStatu == baseTextFieldPhoneStatu) {
            return textField.text.length < 11;
        }
    }
    return YES;
}

// 开始编辑
- (void)textFieldDidBeginEditing:(UITextField*)textField{
    //显示
    self.clearBtn.hidden = NO;
    // 查看按钮
    if (self.textFieldStatu == baseTextFieldPhoneStatu || self.textFieldStatu == baseTextFieldShowClearStatu) {
        self.lookBtn.hidden = YES;
    }else{
        self.lookBtn.hidden = NO;
    }
}
// 结束编辑
-(void)textFieldDidEndEditing:(UITextField *)textField{
    //隐藏
    self.clearBtn.hidden = YES;
    
    self.lookBtn.hidden = YES;
}

-(void)setLeftNormalImageStr:(NSString *)leftNormalImageStr{
    _leftNormalImageStr = leftNormalImageStr;
     self.leftImageV.image = [UIImage imageNamed:leftNormalImageStr];
}
-(void)setLeftHeihtImageStr:(NSString *)leftHeihtImageStr{
    _leftHeihtImageStr = leftHeihtImageStr;
}
-(void)setPlaceholderStr:(NSString *)placeholderStr{
    self.baseTextField.placeholder = placeholderStr;
}
-(void)setPlaceColor:(UIColor *)placeColor{
    _placeColor = placeColor;
}
-(void)setTextFieldStatu:(baseTextFieldStatu)textFieldStatu{
    _textFieldStatu = textFieldStatu;
    __weak typeof(self) weakSelf = self;
    if (textFieldStatu == baseTextFieldPhoneStatu) {
        self.lookBtn.hidden = YES;
        [self.clearBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf).offset(-KSIphonScreenW(7));
            make.centerY.equalTo(weakSelf.mas_centerY);
            make.width.equalTo(@28);
        }];
    }else if (textFieldStatu == baseTextFieldShowClearStatu){
        self.lookBtn.hidden = YES;
        [self.clearBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf).offset(-KSIphonScreenW(7));
            make.centerY.equalTo(weakSelf.mas_centerY);
            make.width.equalTo(@28);
        }];
    }
}
-(void)setPlaceTextFont:(UIFont *)placeTextFont{
    _placeTextFont = placeTextFont;
}


@end
