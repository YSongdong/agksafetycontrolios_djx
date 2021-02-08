//
//  AlterBindIphoneController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/9.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTAlterBindIphoneController.h"

#import "YWTBasePwdTextFieldView.h"
#import "YTSubmitButton.h"
#import "YWTLoginMaskFloorView.h"
#import "YWTBindIphoneViewController.h"

@interface YWTAlterBindIphoneController () <YTSubmitButtonDelegate>
// 验证码view
@property (nonatomic,strong) YWTBasePwdTextFieldView *codeTextFieldView;
// 提交按钮
@property (nonatomic,strong) UIButton *submitBtn;
// 遮罩层view
@property (nonatomic,strong) YWTLoginMaskFloorView *maskFloorView;
// 记录定时器时间
@property (nonatomic,assign) NSInteger   sendTimer;
@end

@implementation YWTAlterBindIphoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [self setNavi];
    //
    [self createAlterBindView];
    
}
-(void) createAlterBindView{
    self.view.backgroundColor = [UIColor colorViewBackF9F9GrounpWhiteColor];
    
    __weak typeof(self) weakSelf = self;
    UIImageView *nomalImageV = [[UIImageView alloc]init];
    [self.view addSubview:nomalImageV];
    nomalImageV.image = [UIImage imageChangeName:@"grzx_pic_sj"];
    [nomalImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(KSNaviTopHeight+27);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
    }];
    
    UILabel *showNameLab  =[[UILabel alloc]init];
    [self.view addSubview:showNameLab];
    showNameLab.text = @"真实姓名";
    showNameLab.font = Font(15);
    showNameLab.textColor = [UIColor colorCommonGreyBlackColor];
    [showNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nomalImageV.mas_bottom).offset(22);
        make.left.equalTo(weakSelf.view).offset(94);
    }];
    
    UILabel *nameLab = [[UILabel alloc]init];
    [self.view addSubview:nameLab];
    nameLab.textColor = [UIColor colorCommonBlackColor];
    nameLab.text = [YWTUserInfo obtainWithRealName];
    nameLab.font = Font(15);
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(showNameLab.mas_right).offset(33);
        make.centerY.equalTo(showNameLab.mas_centerY);
    }];
    
    UILabel *showPhoneLab = [[UILabel alloc]init];
    [self.view addSubview:showPhoneLab];
    showPhoneLab.textColor =[UIColor colorCommonGreyBlackColor];
    showPhoneLab.font = Font(15);
    showPhoneLab.text = @"已绑定手机";
    [showPhoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(showNameLab.mas_bottom).offset(10);
        make.left.equalTo(showNameLab.mas_left);
    }];
    
    UILabel *phoneLab = [[UILabel alloc]init];
    [self.view addSubview:phoneLab];
    phoneLab.textColor = [UIColor colorCommonBlackColor];
    phoneLab.text = [YWTUserInfo obtainWithMobile];
    phoneLab.font = Font(15);
    [phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(showPhoneLab.mas_right).offset(16);
        make.centerY.equalTo(showPhoneLab.mas_centerY);
    }];
    
    // 验证码view
    self.codeTextFieldView = [[YWTBasePwdTextFieldView alloc]init];
    [self.view addSubview:self.codeTextFieldView];
    self.codeTextFieldView.placeholderStr = @"请输入验证码";
    self.codeTextFieldView.leftNormalImageStr = @"mazh_ico_nor_yzm";
    self.codeTextFieldView.leftHeihtImageStr = @"mazh_ico_sel_yzm";
    self.codeTextFieldView.viewStatu = showCodeView;
    [self.codeTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneLab.mas_bottom).offset(KSIphonScreenH(20));
        make.left.equalTo(weakSelf.view).offset(KSIphonScreenW(25));
        make.right.equalTo(weakSelf.view).offset(-KSIphonScreenW(25));
        make.height.equalTo(@(KSIphonScreenH(44)));
    }];
    // 发送验证码
    self.codeTextFieldView.sendCodeBlock = ^{
        //发送验证码
        [weakSelf requestIphoneCode];
    };

    // 提交按钮
    self.submitBtn = [[UIButton alloc]init];
    [self.view addSubview:self.submitBtn];
    self.submitBtn.titleLabel.font = Font(14);
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.codeTextFieldView.mas_bottom).offset(KSIphonScreenH(70));
        make.left.equalTo(weakSelf.codeTextFieldView);
        make.width.height.equalTo(weakSelf.codeTextFieldView);
    }];
    self.submitBtn.layer.cornerRadius = KSIphonScreenH(44)/2;
    self.submitBtn.layer.masksToBounds = YES;
    [self.submitBtn addTarget:self action:@selector(selectSubmitBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.submitBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.submitBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    [self.submitBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorLineCommonBlueColor]] forState:UIControlStateNormal];
    [self.submitBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorClickCommonBlueColor]] forState:UIControlStateSelected];
    
}
// 点击登录按钮
- (void)selectSubmitBtn:(UIButton *) sender {
    // 验证码
    if (self.codeTextFieldView.baseTextField.text.length == 0) {
        [self.view showErrorWithTitle:@"验证码不能为空!" autoCloseTime:0.5];
        return ;
    }
    // 创建遮罩层view
    [[UIApplication sharedApplication].keyWindow addSubview:self.maskFloorView];
    // 解绑手机号码
    [self   requestBindIphoeData];
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
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    self.customNavBar.title = @"修改绑定手机号码";
    
    __weak typeof(self) weakSelf = self;
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}
#pragma mark ----懒加载 -----
-(YWTLoginMaskFloorView *)maskFloorView{
    if (!_maskFloorView) {
        _maskFloorView = [[YWTLoginMaskFloorView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    }
    return _maskFloorView;
}
#pragma mark ---set 方法 -----
-(void)setBindStatu:(showAlterBindStatu)bindStatu{
    _bindStatu = bindStatu;
}
#pragma mark ------发送验证码-------
-(void) requestIphoneCode{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] = [YWTUserInfo obtainWithUserId];
    param[@"token"] = [YWTTools getNewToken];
    param[@"type"] = @"Untie";
    param[@"mobile"] = [YWTUserInfo obtainWithMobile];
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool]postRequstWith:HTTP_ATTAPPSendCode_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:1];
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
#pragma mark ------解绑手机号码-------
-(void) requestBindIphoeData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] = [YWTUserInfo obtainWithUserId];
    param[@"token"] = [YWTTools getNewToken];
    param[@"code"] = self.codeTextFieldView.baseTextField.text;
    param[@"mobile"] = [YWTUserInfo obtainWithMobile];
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool]postRequstWith:HTTP_ATTAPPPHONEUNTIE_URL params:param withModel:nil waitView:nil complateHandle:^(id showdata, NSString *error) {
        //移除遮罩层view
        [self.maskFloorView removeFromSuperview];
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:1];
            return ;
        }
        if ([showdata isKindOfClass:[NSDictionary class]]) {
            // 跳转
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 下一个界面
                YWTBindIphoneViewController *bindPhoneVC =[[YWTBindIphoneViewController alloc]init];
                bindPhoneVC.viewStatu = showViewAlterBindStatu;
                [weakSelf.navigationController pushViewController:bindPhoneVC animated:YES];
            });
        }
        
    }];
}



@end
