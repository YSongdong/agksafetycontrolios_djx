//
//  LoginView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/8.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTLoginView.h"

#import "YWTLoginBaseTextFieldView.h"
#import "YWTBasePwdTextFieldView.h"
#import "YWTLoginMaskFloorView.h"
#import "YWTLoginModel.h"

@interface YWTLoginView () <UITextFieldDelegate>
//公司代码view
@property (nonatomic,strong) YWTLoginBaseTextFieldView *companyTextFieldView;
//用户名
@property (nonatomic,strong) YWTLoginBaseTextFieldView *userNameTextFieldView;
// 密码view
@property (nonatomic,strong) YWTBasePwdTextFieldView *pwdTextFieldView;
// 提交按钮
@property (nonatomic,strong) UIButton *submitBtn;

// 遮罩层view
@property (nonatomic,strong) YWTLoginMaskFloorView *maskFloorView;

@end


@implementation YWTLoginView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createLoginView];
    }
    return self;
}
// 创建View
-(void) createLoginView{
    __weak typeof(self) weakSelf = self;
    weakSelf.backgroundColor = [UIColor colorTextWhiteColor];
    
    UIImageView *headerImageV = [[UIImageView alloc]init];
    [self addSubview:headerImageV];
    headerImageV.image = [UIImage imageNamed:@"login_bg"];
    [headerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(weakSelf);
    }];
    
    // 公司代码
    self.companyTextFieldView = [[YWTLoginBaseTextFieldView alloc]init];
    [self addSubview:self.companyTextFieldView];
    self.companyTextFieldView.textFieldStatu = baseTextFieldShowClearStatu;
    self.companyTextFieldView.placeholderStr = @"请输入公司代码";
    self.companyTextFieldView.leftNormalImageStr = @"login_ico01";
    self.companyTextFieldView.leftHeihtImageStr = @"login_sel_ico01";
    [self.companyTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerImageV.mas_bottom).offset(KSIphonScreenH(15));
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(25));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(25));
        make.height.equalTo(@(KSIphonScreenH(60)));
    }];
    
    // 取出以前的数组
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Success"]) {
        self.companyTextFieldView.baseTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"Success"][@"platformCode"] ;
        self.companyTextFieldView.leftImageV.image = [UIImage imageNamed:@"login_sel_ico01"];
    }
    
    // 用户名
    self.userNameTextFieldView = [[YWTLoginBaseTextFieldView alloc]init];
    [self addSubview:self.userNameTextFieldView];
    self.userNameTextFieldView.textFieldStatu = baseTextFieldShowClearStatu;
    self.userNameTextFieldView.placeholderStr = @"请输入员工编号/绑定手机";
    self.userNameTextFieldView.leftNormalImageStr = @"login_ico02";
    self.userNameTextFieldView.leftHeihtImageStr = @"login_sel_ico02";
    [self.userNameTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.companyTextFieldView.mas_bottom);
        make.left.equalTo(weakSelf.companyTextFieldView);
        make.width.height.equalTo(weakSelf.companyTextFieldView);
    }];
    // 取出以前的数组
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Success"]) {
        self.userNameTextFieldView.baseTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"Success"][@"sn"] ;
        self.userNameTextFieldView.leftImageV.image = [UIImage imageNamed:@"login_sel_ico02"];
    }
    
    // 密码view
    self.pwdTextFieldView = [[YWTBasePwdTextFieldView alloc]init];
    [self addSubview:self.pwdTextFieldView];
    self.pwdTextFieldView.placeholderStr = @"请输入员工登录密码";
    self.pwdTextFieldView.leftNormalImageStr = @"login_ico03";
    self.pwdTextFieldView.leftHeihtImageStr = @"login_sel_ico03";
    self.pwdTextFieldView.baseTextField.delegate = self;
    [self.pwdTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.userNameTextFieldView.mas_bottom);
        make.left.equalTo(weakSelf.userNameTextFieldView);
        make.width.height.equalTo(weakSelf.userNameTextFieldView);
    }];
    self.pwdTextFieldView.baseTextField.secureTextEntry = YES;
    
    self.submitBtn = [[UIButton alloc]init];
    [self addSubview:self.submitBtn];
    [self.submitBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.submitBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.submitBtn.titleLabel.font = Font(16);
    [self.submitBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorLineCommonBlueColor]] forState:UIControlStateNormal];
    [self.submitBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorClickCommonBlueColor]] forState:UIControlStateHighlighted];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.pwdTextFieldView.mas_bottom).offset(KSIphonScreenH(38));
        make.left.equalTo(weakSelf.pwdTextFieldView);
        make.width.equalTo(weakSelf.pwdTextFieldView);
        make.height.equalTo(@(KSIphonScreenH(44)));
    }];
    self.submitBtn.layer.cornerRadius =KSIphonScreenH(44)/2;
    self.submitBtn.layer.masksToBounds = YES;
    [self.submitBtn addTarget:self action:@selector(selectSubmitBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    // 忘记密码
    UIButton *forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:forgetPwdBtn];
    [forgetPwdBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetPwdBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    forgetPwdBtn.titleLabel.font = Font(14);
    [forgetPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.submitBtn.mas_bottom).offset(KSIphonScreenH(15));
        make.left.equalTo(weakSelf.submitBtn.mas_left);
    }];
    [forgetPwdBtn addTarget:self action:@selector(selectPwdBtn:) forControlEvents:UIControlEventTouchUpInside];
}
-(void) selectSubmitBtn:(UIButton *) sender{
    [self.companyTextFieldView.baseTextField resignFirstResponder];
    [self.userNameTextFieldView.baseTextField resignFirstResponder];
    [self.pwdTextFieldView.baseTextField resignFirstResponder];
    // 公司代码
    if (self.companyTextFieldView.baseTextField.text.length == 0) {
        [self showErrorWithTitle:@"公司代码不能为空!" autoCloseTime:0.5];
        return ;
    }
    // 员工编号和手机号码
    if (self.userNameTextFieldView.baseTextField.text.length == 0) {
        [self showErrorWithTitle:@"员工编号或手机号码不能为空!" autoCloseTime:0.5];
        return ;
    }
    // 登录密码
    if (self.pwdTextFieldView.baseTextField.text.length == 0) {
       [self showErrorWithTitle:@"登录密码不能为空!" autoCloseTime:0.5];
        return ;
    }
    if (self.pwdTextFieldView.baseTextField.text.length < 6) {
        [self showErrorWithTitle:@"登录密码至少不少于6位!" autoCloseTime:0.5];
        return ;
    }
    // 创建遮罩层view
    [[UIApplication sharedApplication].keyWindow addSubview:self.maskFloorView];
    
    // 请求登录
    [self requestLoginData];
}
// 点击密码找回
-(void) selectPwdBtn:(UIButton *) sender{
    self.pwdRetieveBlock();
}
#pragma mark -------pwdTextFieldView      UITextFieldDelegate---------
// 开始编辑
- (void)textFieldDidBeginEditing:(UITextField*)textField{
    if (self.pwdTextFieldView.viewStatu == showPasswordView) {
        //显示
        self.pwdTextFieldView.clearBtn.hidden = NO;
        
        self.pwdTextFieldView.lookBtn.hidden = NO;
    }else{
        //隐藏
        self.pwdTextFieldView.clearBtn.hidden = YES;
        
        self.pwdTextFieldView.lookBtn.hidden = YES;
    }
   
    CGRect viewFrame =self.frame;
    viewFrame.origin.y -= KSIphonScreenH(80);
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = viewFrame;
    }];
}
// 结束编辑
-(void)textFieldDidEndEditing:(UITextField *)textField{
    //隐藏
    self.pwdTextFieldView.clearBtn.hidden = YES;
    
    self.pwdTextFieldView.lookBtn.hidden = YES;
    
    CGRect viewFrame =self.frame;
    viewFrame.origin.y +=KSIphonScreenH(80);
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = viewFrame;
    }];
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

#pragma mark ----懒加载 -----
-(YWTLoginMaskFloorView *)maskFloorView{
    if (!_maskFloorView) {
        _maskFloorView = [[YWTLoginMaskFloorView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    }
    return _maskFloorView;
}
#pragma mark ----数据相关 -----
// 登录
-(void)requestLoginData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"platformCode"] = self.companyTextFieldView.baseTextField.text;
    param[@"sn"] = self.userNameTextFieldView.baseTextField.text;
    param[@"password"] = self.pwdTextFieldView.baseTextField.text;
    param[@"mobileModel"] = [YWTTools deviceModelName];
    param[@"appType"] = @"1";
    //获取本地软件的版本号
    NSString *localVersion =  [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    param[@"appVersion"] =localVersion;
    
    [[KRMainNetTool sharedKRMainNetTool]postRequstWith:HTTP_ATTAPPLOGIN_URL params:param withModel:nil waitView:self complateHandle:^(id showdata, NSString *error) {
        //移除遮罩层view
        [self.maskFloorView removeFromSuperview];
        if (error) {
            [self showErrorWithTitle:error autoCloseTime:1];
            return ;
        }
        // 别名
        NSString *aliasesStr = [NSString stringWithFormat:@"%@",showdata[@"aliases"]];
        // 注册别名
        [JPUSHService setAlias:aliasesStr completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            if (iResCode == 0) {
                NSLog(@"添加别名成功");
            }
        } seq:1];
       
        // 字典转模型
        YWTLoginModel *model = [YWTLoginModel yy_modelWithJSON:showdata];
        // 模型转字典
        NSDictionary *userInfo = [model yy_modelToJSONObject];
       
        // 保存用户登录成功后的 公司代码和用户
        NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
        NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
        infoDict[@"platformCode"] = self.companyTextFieldView.baseTextField.text;
        infoDict[@"sn"] = self.userNameTextFieldView.baseTextField.text;
        [userD setObject:infoDict forKey:@"Success"];
        //3.强制让数据立刻保存
        [userD synchronize];
        //删除用户信息
        [YWTUserInfo delUserInfo];
        // 保存用户信息
        [YWTUserInfo saveUserData:userInfo];
        // 登录成功 跳转
        self.successBlock();
    }];
}




@end
