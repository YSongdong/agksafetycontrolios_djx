//
//  PwdRetrieveView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/9.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTPwdRetrieveView.h"

#import "YWTLoginBaseTextFieldView.h"
#import "YWTBasePwdTextFieldView.h"
#import "YWTLoginMaskFloorView.h"

@interface YWTPwdRetrieveView ()
// 手机号
@property (nonatomic,strong) YWTLoginBaseTextFieldView *iphoeTextFieldView;
//验证码
@property (nonatomic,strong) YWTBasePwdTextFieldView *codeTextFieldView;
//平台码
@property (nonatomic,strong) YWTLoginBaseTextFieldView *platformCodeTextFieldView;
// 新密码
@property (nonatomic,strong) YWTLoginBaseTextFieldView *newsPwdTextFieldView;
// 确认密码
@property (nonatomic,strong) YWTLoginBaseTextFieldView *confiremPwdTextFView;
// 提交按钮
@property (nonatomic,strong) UIButton *submitBtn;
// 遮罩层view
@property (nonatomic,strong) YWTLoginMaskFloorView *maskFloorView;
// 记录定时器时间
@property (nonatomic,assign) NSInteger   sendTimer;
// 记录用户的UserId
@property (nonatomic,strong) NSString *userIdStr;

@end

@implementation YWTPwdRetrieveView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createPwdRetrieveView];
    }
    return self;
}
-(void) createPwdRetrieveView{
    __weak typeof(self) weakSelf = self;
    
    self.backgroundColor = [UIColor colorTextWhiteColor];
    
    // 手机号
    self.iphoeTextFieldView = [[YWTLoginBaseTextFieldView alloc]init];
    [self addSubview:self.iphoeTextFieldView];
    self.iphoeTextFieldView.placeholderStr = @"请输入绑定手机号码";
    self.iphoeTextFieldView.leftNormalImageStr = @"mazh_ico_nor_sj";
    self.iphoeTextFieldView.leftHeihtImageStr = @"mazh_ico_sel_sj";
    self.iphoeTextFieldView.textFieldStatu = baseTextFieldPhoneStatu;
    [self.iphoeTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(KSIphonScreenH(15));
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(20));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(20));
        make.height.equalTo(@(KSIphonScreenH(60)));
    }];
    
    // 验证码view
    self.codeTextFieldView = [[YWTBasePwdTextFieldView alloc]init];
    [self addSubview:self.codeTextFieldView];
    self.codeTextFieldView.placeholderStr = @"请输入验证码";
    self.codeTextFieldView.leftNormalImageStr = @"mazh_ico_nor_yzm";
    self.codeTextFieldView.leftHeihtImageStr = @"mazh_ico_sel_yzm";
    self.codeTextFieldView.viewStatu = showCodeView;
    [self.codeTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.iphoeTextFieldView.mas_bottom);
        make.left.equalTo(weakSelf.iphoeTextFieldView);
        make.width.height.equalTo(weakSelf.iphoeTextFieldView);
    }];
    
    // 发送验证码
    self.codeTextFieldView.sendCodeBlock = ^{
        // 手机号码
        if (weakSelf.iphoeTextFieldView.baseTextField.text.length == 0) {
            [weakSelf showErrorWithTitle:@"手机号不能为空!" autoCloseTime:0.5];
            return ;
        }
        // 请求接口
        [weakSelf requestIphoneCode];
    };
    
    // 平台码
    self.platformCodeTextFieldView = [[YWTLoginBaseTextFieldView alloc]init];
    [self addSubview:self.platformCodeTextFieldView];
    self.platformCodeTextFieldView.placeholderStr = @"请输入平台码";
    self.platformCodeTextFieldView.leftNormalImageStr = @"login_ico01";
    self.platformCodeTextFieldView.leftHeihtImageStr = @"login_sel_ico01";
    self.platformCodeTextFieldView.textFieldStatu = baseTextFieldShowClearStatu;
    [self.platformCodeTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.codeTextFieldView.mas_bottom);
        make.left.equalTo(weakSelf.codeTextFieldView);
        make.width.height.equalTo(weakSelf.codeTextFieldView);
    }];
    
    // 新密码
    self.newsPwdTextFieldView = [[YWTLoginBaseTextFieldView alloc]init];
    [self addSubview:self.newsPwdTextFieldView];
    self.newsPwdTextFieldView.textFieldStatu = baseTextFieldNormalStatu;
    self.newsPwdTextFieldView.placeholderStr = @"请输入新密码";
    self.newsPwdTextFieldView.leftNormalImageStr = @"login_ico03";
    self.newsPwdTextFieldView.leftHeihtImageStr = @"login_sel_ico03";
    [self.newsPwdTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.platformCodeTextFieldView.mas_bottom);
        make.left.equalTo(weakSelf.platformCodeTextFieldView.mas_left);
        make.height.width.equalTo(weakSelf.platformCodeTextFieldView);
        make.centerX.equalTo(weakSelf.platformCodeTextFieldView.mas_centerX);
    }];
    self.newsPwdTextFieldView.baseTextField.secureTextEntry = YES;
    
    // 确认密码
    self.confiremPwdTextFView = [[YWTLoginBaseTextFieldView alloc]init];
    [self addSubview:self.confiremPwdTextFView];
    self.confiremPwdTextFView.textFieldStatu = baseTextFieldNormalStatu;
    self.confiremPwdTextFView.placeholderStr = @"请输入确认密码";
    self.confiremPwdTextFView.leftNormalImageStr = @"login_ico03";
    self.confiremPwdTextFView.leftHeihtImageStr = @"login_sel_ico03";
    [self.confiremPwdTextFView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.newsPwdTextFieldView.mas_bottom);
        make.left.equalTo(weakSelf.newsPwdTextFieldView.mas_left);
        make.height.width.equalTo(weakSelf.newsPwdTextFieldView);
        make.centerX.equalTo(weakSelf.newsPwdTextFieldView.mas_centerX);
    }];
    self.confiremPwdTextFView.baseTextField.secureTextEntry = YES;
    
    // 确认
    self.submitBtn = [[UIButton alloc]init];
    [self addSubview:self.submitBtn];
    [self.submitBtn setTitle:@"确认" forState:UIControlStateNormal];
    [self.submitBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    [self.submitBtn setTitleColor:[UIColor colorWithHexString:@"#e0e0e0"] forState:UIControlStateHighlighted];
    self.submitBtn.titleLabel.font = Font(16);
    [self.submitBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorLineCommonBlueColor]] forState:UIControlStateNormal];
    [self.submitBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorClickCommonBlueColor]] forState:UIControlStateHighlighted];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.confiremPwdTextFView.mas_bottom).offset(KSIphonScreenH(70));
        make.left.equalTo(weakSelf.confiremPwdTextFView);
        make.width.equalTo(weakSelf.confiremPwdTextFView);
        make.height.equalTo(@(KSIphonScreenH(44)));
    }];
    self.submitBtn.layer.cornerRadius =KSIphonScreenH(44)/2;
    self.submitBtn.layer.masksToBounds = YES;
    [self.submitBtn addTarget:self action:@selector(selectSubmitBtn:) forControlEvents:UIControlEventTouchUpInside];
}
// 点击登录按钮
- (void)selectSubmitBtn:(UIButton *) sender {
    // 手机号码
    if (self.iphoeTextFieldView.baseTextField.text.length == 0) {
        [self showErrorWithTitle:@"手机号不能为空!" autoCloseTime:0.5];
        return ;
    }
    // 验证码
    if (self.codeTextFieldView.baseTextField.text.length == 0) {
        [self showErrorWithTitle:@"验证码不能为空!" autoCloseTime:0.5];
        return ;
    }
    // 平台码
    if (self.platformCodeTextFieldView.baseTextField.text.length == 0) {
        [self showErrorWithTitle:@"平台码不能为空!" autoCloseTime:0.5];
        return ;
    }

    // 新密码
    if (self.newsPwdTextFieldView.baseTextField.text.length == 0) {
        [self showErrorWithTitle:@"新密码不能为空!" autoCloseTime:0.5];
        return ;
    }
    // 确认密码
    if (self.confiremPwdTextFView.baseTextField.text.length == 0) {
        [self showErrorWithTitle:@"确认密码不能为空!" autoCloseTime:0.5];
        return ;
    }
    // 创建遮罩层view
    [[UIApplication sharedApplication].keyWindow addSubview:self.maskFloorView];
    
    // 请求密码找回接口
    [self requestRepPwdData];
}

#pragma mark ----发送验证码处理方法 -----
-(void)sendCodeTimer{
    _sendTimer -= 1;
    if (_sendTimer < 0) {
        [[ZTGCDTimerManager sharedInstance] cancelTimerWithName:@"sendTimer"];
        [self.codeTextFieldView.sendBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        return ;
    }else{
        NSString *titleStr = [NSString stringWithFormat:@"%ldS",(long)_sendTimer];
        [self.codeTextFieldView.sendBtn setTitle:titleStr forState:UIControlStateNormal];
    }
}
#pragma mark ----懒加载 -----
-(YWTLoginMaskFloorView *)maskFloorView{
    if (!_maskFloorView) {
        _maskFloorView = [[YWTLoginMaskFloorView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    }
    return _maskFloorView;
}
#pragma mark ------发送验证码-------
-(void) requestIphoneCode{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"type"] = @"repassword";
    param[@"mobile"] = self.iphoeTextFieldView.baseTextField.text;
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool]postRequstWith:HTTP_ATTAPPSendCode_URL params:param withModel:nil waitView:self complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if ([showdata isKindOfClass:[NSDictionary class]]) {
            [self showRightWithTitle:@"发送成功" autoCloseTime:1];
            // 记录用户userId
            self.userIdStr = [NSString stringWithFormat:@"%@",showdata[@"userId"]];
            
            self->_sendTimer = 60;
            [[ZTGCDTimerManager sharedInstance] scheduleGCDTimerWithName:@"sendTimer" interval:1 queue:dispatch_get_main_queue() repeats:YES option:CancelPreviousTimerAction action:^{
                
                [weakSelf sendCodeTimer];
            }];
        }
    }];
}
#pragma mark ------密码找回-------
-(void) requestRepPwdData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] = self.userIdStr;
    param[@"code"] = self.codeTextFieldView.baseTextField.text;
    param[@"mobile"] = self.iphoeTextFieldView.baseTextField.text;
    param[@"platformCode"] = self.platformCodeTextFieldView.baseTextField.text;
    param[@"newPassword"] = self.newsPwdTextFieldView.baseTextField.text;
    param[@"rePassword"] = self.confiremPwdTextFView.baseTextField.text;
    [[KRMainNetTool sharedKRMainNetTool]postRequstWith:HTTP_ATTAPPPASSWORDRECOVERY_URL params:param withModel:nil waitView:nil complateHandle:^(id showdata, NSString *error) {
        //移除遮罩层view
        [self.maskFloorView removeFromSuperview];
        if (error) {
            [self showErrorWithTitle:error autoCloseTime:1];
            return ;
        }
        // 跳转
        self.backBlock();
    }];
}




@end
