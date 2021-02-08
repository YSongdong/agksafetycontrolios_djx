//
//  BasePwdTextFieldView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/8.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTBasePwdTextFieldView.h"

@interface YWTBasePwdTextFieldView ()<UITextFieldDelegate>

@property (nonatomic,strong)  UIImageView *leftImageV;
@end


@implementation YWTBasePwdTextFieldView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createPasswordView];
    }
    return self;
}

-(void) createPasswordView{
    __weak typeof(self) weakSelf = self;
    
    self.leftImageV = [[UIImageView alloc]init];
    [self addSubview:self.leftImageV];
    self.leftImageV.image = [UIImage imageNamed:@"login_ico03"];
    self.leftImageV.contentMode = UIViewContentModeScaleAspectFit;
    [self.leftImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(4));
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.equalTo(@30);
    }];
    
    // 输入框
    self.baseTextField = [[UITextField alloc]init];
    [self addSubview:self.baseTextField];
    self.baseTextField.placeholder = @"";
    self.baseTextField.textColor = [UIColor colorCommonBlackColor];
    self.baseTextField.font = Font(16);
    self.baseTextField.delegate = self;
    self.baseTextField.returnKeyType = UIReturnKeyDone;
    [self.baseTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftImageV.mas_right).offset(KSIphonScreenW(6));
        make.top.bottom.equalTo(weakSelf);
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(75));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    [self.baseTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    //设置颜色和大小
    self.baseTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"" attributes:@{NSForegroundColorAttributeName : [UIColor colorCommonGreyBlackColor],NSFontAttributeName  :[UIFont systemFontOfSize:15]}];
    // 查看按钮
    self.lookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.lookBtn];
    [self.lookBtn setImage:[UIImage imageNamed:@"login_ico_off"] forState:UIControlStateNormal];
    [self.lookBtn setImage:[UIImage imageNamed:@"login_ico_on"] forState:UIControlStateSelected];
    [self.lookBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(5));
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
        make.right.equalTo(weakSelf.lookBtn.mas_left).offset(-KSIphonScreenW(10));
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.equalTo(@28);
    }];
    //隐藏
    self.clearBtn.hidden = YES;
    [self.clearBtn addTarget:self action:@selector(selectClearBtn:) forControlEvents:UIControlEventTouchUpInside];
   
    //发送验证码
    self.sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.sendBtn];
    [self.sendBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [self.sendBtn setTitleColor:[UIColor colorConstantCommonBlueColor] forState:UIControlStateNormal];
    self.sendBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(KSIphonScreenW(70)));
        make.height.equalTo(@(KSIphonScreenH(27)));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(7));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    self.sendBtn.layer.borderWidth = 0.5;
    self.sendBtn.layer.borderColor = [UIColor colorConstantCommonBlueColor].CGColor;
    self.sendBtn.layer.cornerRadius = KSIphonScreenH(27)/2;
    self.sendBtn.layer.masksToBounds = YES;
    [self.sendBtn addTarget:self action:@selector(selectSendBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.sendBtn.hidden = YES;
    
    //线条view
    self.bottomLineView = [[UIView alloc]init];
    [self addSubview:self.bottomLineView];
    self.bottomLineView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf);
        make.height.equalTo(@1);
    }];
    
}
//发送验证码
-(void)selectSendBtn:(UIButton *) sender{
    self.sendCodeBlock();
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

#pragma mark ------- UITextFieldDelegate---------
// 开始编辑
- (void)textFieldDidBeginEditing:(UITextField*)textField{
    if (self.viewStatu == showPasswordView) {
        //显示
        self.clearBtn.hidden = NO;
        
        self.lookBtn.hidden = NO;
    }else{
        //隐藏
        self.clearBtn.hidden = YES;
        
        self.lookBtn.hidden = YES;
    }
    
}
// 结束编辑
-(void)textFieldDidEndEditing:(UITextField *)textField{
    //隐藏
    self.clearBtn.hidden = YES;
    
    self.lookBtn.hidden = YES;
    
}
// 点击完成按钮
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.length == 1 && string.length == 0) {
        return YES;
    }
    return YES;
}

#pragma  mark -----set 方法 -----
-(void)setViewStatu:(showViewStatus)viewStatu{
    _viewStatu = viewStatu;
    if (viewStatu == showPasswordView ) {
        // 显示 查看和清除按钮
        self.lookBtn.hidden = NO;
        self.clearBtn.hidden = NO;
        // 隐藏发送按钮
        self.sendBtn.hidden = YES;
    }else{
        // 隐藏 查看和清除按钮
        self.lookBtn.hidden = YES;
        self.clearBtn.hidden = YES;
        // 显示发送按钮
        self.sendBtn.hidden = NO;
    }
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
-(void)setPlaceTextFont:(UIFont *)placeTextFont{
    _placeTextFont = placeTextFont;
}


@end
