//
//  BindIphoneViewController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/9.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTBindIphoneViewController.h"
#import "YWTLoginMaskFloorView.h"
#import "YWTAlterPwdModuleView.h"
#import "YTSubmitButton.h"
#import "YWTAlterLoginPwdVController.h"
@interface YWTBindIphoneViewController ()<YTSubmitButtonDelegate>
// 遮罩层view
@property (nonatomic,strong) YWTLoginMaskFloorView *maskFloorView;
// 手机号码
@property (nonatomic,strong) YWTAlterPwdModuleView *iphoneTextFieldView;
// 验证码
@property (nonatomic,strong) YWTAlterPwdModuleView *codeTextFieldView;
// 确认绑定
@property (nonatomic,strong) UIButton *submitBtn;
// 暂不绑定
@property (nonatomic,strong) UIButton *unSubmitBtn;
// 说明lab
@property (nonatomic,strong) UILabel *showMarkLab;
// 首次显示
@property (nonatomic,strong) UILabel *firstShowLab;
// 记录定时器时间
@property (nonatomic,assign) NSInteger   sendTimer;

@end

@implementation YWTBindIphoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [self setNavi];
    // 创建绑定view
    [self createBindView];
}
// 创建绑定view
-(void)createBindView{
    __weak typeof(self) weakSelf = self;
    self.view.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    //手机号码
    self.iphoneTextFieldView = [[YWTAlterPwdModuleView alloc]init];
    [self.view addSubview:self.iphoneTextFieldView];
    self.iphoneTextFieldView.showViewStatu = showPhoneView;
    self.iphoneTextFieldView.leftTitleStr = @"手机号";
    self.iphoneTextFieldView.placeholderStr = @"请输入绑定手机号码";
    [self.iphoneTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(KSNaviTopHeight+KSIphonScreenH(11));
        make.left.right.equalTo(weakSelf.view);
        make.height.equalTo(@(KSIphonScreenH(60)));
    }];
    self.iphoneTextFieldView.baseTextField.secureTextEntry = NO;
    
    // 验证码
    self.codeTextFieldView = [[YWTAlterPwdModuleView alloc]init];
    [self.view addSubview:self.codeTextFieldView];
    self.codeTextFieldView.showViewStatu = showCodeView;
    self.codeTextFieldView.leftTitleStr = @"验证码";
    self.codeTextFieldView.placeholderStr = @"请输入验证码";
    [self.codeTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.iphoneTextFieldView.mas_bottom);
        make.left.height.right.equalTo(weakSelf.iphoneTextFieldView);
        make.centerX.equalTo(weakSelf.iphoneTextFieldView.mas_centerX);
    }];
    self.codeTextFieldView.baseTextField.secureTextEntry = NO;
    // 发送验证码
    self.codeTextFieldView.sendCodeBlock = ^{
        // 取消第一效应
        [weakSelf.iphoneTextFieldView.baseTextField resignFirstResponder];
        // 手机号码
        if (weakSelf.iphoneTextFieldView.baseTextField.text.length == 0) {
           [weakSelf.view showErrorWithTitle:@"手机号不能为空！" autoCloseTime:0.5];
            return ;
        }
         //发送验证码
        [weakSelf requestIphoneCode];
    };
    
    self.showMarkLab = [[UILabel alloc]init];
    [self.view addSubview:self.showMarkLab];
    self.showMarkLab.numberOfLines = 0;
    self.showMarkLab.textColor = [UIColor colorWithHexString:@"#aaaaaa"];
    [self.showMarkLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).offset(15);
        make.top.equalTo(weakSelf.codeTextFieldView.mas_bottom).offset(15);
        make.right.equalTo(weakSelf.view).offset(-15);
    }];
    //说明
    NSString *markStr = @" 用户绑定手机号码成功后，可支持两项辅助功能：①绑定手机号码+密码登录；②绑定手机号+验证码找回密码。";
    self.showMarkLab.attributedText = [self changeLineSpaceForLabel:markStr WithSpace:3 andRange:NSMakeRange(0, 3) andFont:Font(13) andImage:YES];
    
     //首次显示
    self.firstShowLab  =[[UILabel alloc]init];
    [self.view addSubview:self.firstShowLab];
    self.firstShowLab.numberOfLines = 0;
    self.firstShowLab.textColor = [UIColor colorWithHexString:@"#aaaaaa"];
    [self.firstShowLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.showMarkLab.mas_bottom).offset(14);
        make.left.equalTo(weakSelf.view).offset(15);
        make.right.equalTo(weakSelf.view).offset(-15);
    }];
    NSString *homeStr = @"进入 【个人中心-个人资料】也可对用户手机号码进行绑定和修改";
    self.firstShowLab.attributedText = [self changeLineSpaceForLabel:homeStr WithSpace:3 andRange:NSMakeRange(3, 11) andFont:Font(13)andImage:NO];
    
    //绑定手机按钮
    self.submitBtn = [[UIButton alloc]init];
    [self.view addSubview:self.submitBtn];
    self.submitBtn.titleLabel.font = Font(15);
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstShowLab.mas_bottom).offset(KSIphonScreenH(74));
        make.left.equalTo(weakSelf.view).offset(KSIphonScreenW(25));
        make.right.equalTo(weakSelf.view).offset(-KSIphonScreenW(25));
        make.height.equalTo(@(KSIphonScreenH(44)));
    }];
    self.submitBtn.layer.cornerRadius = KSIphonScreenH(44)/2;
    self.submitBtn.layer.masksToBounds = YES;
    [self.submitBtn addTarget:self action:@selector(selectSubmitBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.submitBtn setTitle:@"确认绑定" forState:UIControlStateNormal];
    [self.submitBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    [self.submitBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorLineCommonBlueColor]] forState:UIControlStateNormal];
    [self.submitBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorClickCommonBlueColor]] forState:UIControlStateHighlighted];
   
    
    // 暂不绑定
    self.unSubmitBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.unSubmitBtn];
    [self.unSubmitBtn setTitle:@"暂不绑定" forState:UIControlStateNormal];
    [self.unSubmitBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    self.unSubmitBtn.titleLabel.font = Font(15);
    [self.unSubmitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.submitBtn.mas_bottom).offset(KSIphonScreenH(15));
        make.left.with.height.equalTo(weakSelf.submitBtn);
        make.centerX.equalTo(weakSelf.submitBtn.mas_centerX);
    }];
    self.unSubmitBtn.layer.cornerRadius = KSIphonScreenH(44)/2;
    self.unSubmitBtn.layer.masksToBounds = YES;
    self.unSubmitBtn.layer.borderWidth = 1;
    self.unSubmitBtn.layer.borderColor = [UIColor colorLineCommonBlueColor].CGColor;
    [self.unSubmitBtn addTarget:self action:@selector(selectUnSubmitBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.viewStatu == showViewNormalStatu || self.viewStatu == showViewAlterBindStatu  ) {
        // 隐藏首次引导
        self.firstShowLab.hidden = YES;
        
        // 隐藏按钮
        self.unSubmitBtn.hidden = YES;
        // 修改约束
        [self.submitBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.showMarkLab.mas_bottom).offset(KSIphonScreenH(74));
            make.left.equalTo(weakSelf.view).offset(KSIphonScreenW(25));
            make.right.equalTo(weakSelf.view).offset(-KSIphonScreenW(25));
            make.height.equalTo(@(KSIphonScreenH(44)));
        }];
    }
}

// 点击确认绑定按钮
- (void)selectSubmitBtn:(UIButton *) sender {
    // 取消第一效应
    [self.view endEditing:YES];
    // 手机号码
    if (self.iphoneTextFieldView.baseTextField.text.length == 0) {
        [self showErrorWithTitle:@"手机号不能为空！" autoCloseTime:0.5];
        return ;
    }
    
    // 验证码
    if (self.codeTextFieldView.baseTextField.text.length == 0) {
       [self showErrorWithTitle:@"手机号不能为空！" autoCloseTime:0.5];
        return ;
    }
    // 创建遮罩层view
    [[UIApplication sharedApplication].keyWindow addSubview:self.maskFloorView];

    // 请求接口
    [self requestBindIphoeData];
}
// 暂不绑定
-(void)selectUnSubmitBtn:(UIButton *) sender{
    YWTAlterLoginPwdVController *alterPwdVC = [[YWTAlterLoginPwdVController alloc]init];
    alterPwdVC.pwdViewStatu = showPwdViewFristHomeStatu;
    [self.navigationController pushViewController:alterPwdVC animated:YES];
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
#pragma mark -----系统回调--------
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.viewStatu == showViewFristHomeStatu) {
        if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.viewStatu == showViewFristHomeStatu) {
        if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
// *  改变行间距
- (NSMutableAttributedString *)changeLineSpaceForLabel:(NSString *)labelText WithSpace:(float)space andRange:(NSRange)range andFont:(UIFont *) font  andImage:(BOOL)isImage{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    if (isImage) {
        //添加图片
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        attach.image = [UIImage imageNamed:@"photo_mark"];
        attach.bounds = CGRectMake(-5, -1.5, 13, 13);
        NSAttributedString *attributeStr2 = [NSAttributedString attributedStringWithAttachment:attach];
        [attributedString insertAttributedString:attributeStr2 atIndex:0];
    }else{
        //添加颜色
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorLineCommonBlueColor]
                                 range:range];
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    [attributedString addAttribute:NSFontAttributeName value:Font(13) range:NSMakeRange(0, [labelText length])];
    return  attributedString;
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    self.customNavBar.title = @"绑定手机号码";
    
    __weak typeof(self) weakSelf = self;
    if (_viewStatu != showViewFristHomeStatu) {
        [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
        self.customNavBar.onClickLeftButton = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
}
#pragma mark ----懒加载 -----
-(YWTLoginMaskFloorView *)maskFloorView{
    if (!_maskFloorView) {
        _maskFloorView = [[YWTLoginMaskFloorView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    }
    return _maskFloorView;
}
#pragma mark ---set 方法 -----
-(void)setViewStatu:(showViewStatu)viewStatu{
    _viewStatu = viewStatu;
}
#pragma mark ------发送验证码-------
-(void) requestIphoneCode{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] = [YWTUserInfo obtainWithUserId];
    param[@"token"] = [YWTTools getNewToken];
    param[@"type"] = @"binding";
    param[@"mobile"] = self.iphoneTextFieldView.baseTextField.text;
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool]postRequstWith:HTTP_ATTAPPSendCode_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if ([showdata isKindOfClass:[NSDictionary class]]) {
            [self.view showRightWithTitle:@"发送成功" autoCloseTime:1];
             self->_sendTimer = 60;
            [[ZTGCDTimerManager sharedInstance] scheduleGCDTimerWithName:@"sendTimer" interval:1 queue:dispatch_get_main_queue() repeats:YES option:CancelPreviousTimerAction action:^{
                
                [weakSelf sendCodeTimer];
            }];
        }
    }];
}
#pragma mark ------绑定手机号码-------
-(void) requestBindIphoeData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] = [YWTUserInfo obtainWithUserId];
    param[@"token"] = [YWTTools getNewToken];
    param[@"code"] = self.codeTextFieldView.baseTextField.text;
    param[@"mobile"] = self.iphoneTextFieldView.baseTextField.text;
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool]postRequstWith:HTTP_ATTAPPBINDINGPHONE_URL params:param withModel:nil waitView:nil complateHandle:^(id showdata, NSString *error) {
        //移除遮罩层view
        [self.maskFloorView removeFromSuperview];
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:1];
            return ;
        }
        if ([showdata isKindOfClass:[NSDictionary class]]) {
            // 修改用户信息
            [YWTUserInfo alterIsBindPhone:showdata];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (weakSelf.viewStatu == showViewFristHomeStatu) {
                    // 跳转到下一个页面
                    YWTAlterLoginPwdVController *alterPwdVC = [[YWTAlterLoginPwdVController alloc]init];
                    alterPwdVC.pwdViewStatu = showPwdViewFristHomeStatu;
                    [weakSelf.navigationController pushViewController:alterPwdVC animated:YES];
                }else if (weakSelf.viewStatu == showViewAlterBindStatu) {
                    [weakSelf.navigationController popToViewController:[weakSelf.navigationController.viewControllers objectAtIndex:1] animated:YES];
                }else{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
            });
        }
    }];
}



@end
