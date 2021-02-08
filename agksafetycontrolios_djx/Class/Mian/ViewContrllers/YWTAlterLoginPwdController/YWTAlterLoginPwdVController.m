//
//  AlterLoginPwdVController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/9.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTAlterLoginPwdVController.h"

#import "YWTAlterPwdModuleView.h"
#import "YTSubmitButton.h"
#import "YWTLoginMaskFloorView.h"
#import "YWTLoginViewController.h"
@interface YWTAlterLoginPwdVController () <YTSubmitButtonDelegate,REFrostedViewControllerDelegate>
// 旧密码
@property (nonatomic,strong) YWTAlterPwdModuleView *oldPwdView;
// 新密码
@property (nonatomic,strong) YWTAlterPwdModuleView *newsPwdView;
// 确认密码
@property (nonatomic,strong) YWTAlterPwdModuleView *confiremPwdTextFView;
// 确认修改按钮
@property (nonatomic,strong) UIButton *submitAlterBtn;
// 首次显示
@property (nonatomic,strong) UILabel *firstShowLab;
// 暂不绑定
@property (nonatomic,strong) UIButton *unSubmitBtn;
// 遮罩层view
@property (nonatomic,strong) YWTLoginMaskFloorView *maskFloorView;
@end

@implementation YWTAlterLoginPwdVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [self setNavi];
    // 创建修改VIew
    [self createAlterPwdView];
}
// 创建修改VIew
-(void) createAlterPwdView{
    __weak typeof(self) weakSelf = self;
    self.view.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    // 旧密码
    self.oldPwdView = [[YWTAlterPwdModuleView alloc]init];
    [self.view addSubview:self.oldPwdView];
    self.oldPwdView.leftTitleStr = @"旧密码";
    self.oldPwdView.placeholderStr = @"请输入旧密码";
    [self.oldPwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(KSNaviTopHeight+KSIphonScreenH(11));
        make.left.right.equalTo(weakSelf.view);
        make.height.equalTo(@(KSIphonScreenH(60)));
    }];
    
    // 新密码
    self.newsPwdView = [[YWTAlterPwdModuleView alloc]init];
    [self.view addSubview:self.newsPwdView];
    self.newsPwdView.leftTitleStr = @"新密码";
    self.newsPwdView.placeholderStr = @"请输入新密码";
    [self.newsPwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.oldPwdView.mas_bottom);
        make.left.height.right.equalTo(weakSelf.oldPwdView);
        make.centerX.equalTo(weakSelf.oldPwdView.mas_centerX);
    }];
    
    // 确认密码
    self.confiremPwdTextFView = [[YWTAlterPwdModuleView alloc]init];
    [self.view addSubview:self.confiremPwdTextFView];
    self.confiremPwdTextFView.leftTitleStr = @"确认密码";
    self.confiremPwdTextFView.placeholderStr = @"请输入确认密码";
    [self.confiremPwdTextFView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.newsPwdView.mas_bottom);
        make.left.height.right.equalTo(weakSelf.newsPwdView);
        make.centerX.equalTo(weakSelf.newsPwdView.mas_centerX);
    }];
    
    //首次显示
    NSString *homeStr = @"进入 【个人中心-个人资料】也可对用户登录密码进行修改";
    NSMutableAttributedString *attrHomeStr = [[NSMutableAttributedString alloc] initWithString:homeStr];
    [attrHomeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0f]
                        range:[homeStr rangeOfString:homeStr]];
    //添加颜色
    [attrHomeStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorLineCommonBlueColor]
                        range:NSMakeRange(3, 11)];
    self.firstShowLab  =[[UILabel alloc]init];
    [self.view addSubview:self.firstShowLab];
    self.firstShowLab.numberOfLines = 0;
    self.firstShowLab.textColor = [UIColor colorWithHexString:@"#aaaaaa"];
    [self.firstShowLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.confiremPwdTextFView.mas_bottom).offset(KSIphonScreenH(14));
        make.left.equalTo(weakSelf.view).offset(KSIphonScreenW(15));
        make.right.equalTo(weakSelf.view).offset(-KSIphonScreenW(15));
    }];
    self.firstShowLab.attributedText = attrHomeStr;

    // 确认修改
    self.submitAlterBtn = [[UIButton alloc]init];
    [self.view addSubview:self.submitAlterBtn];
    [self.submitAlterBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    self.submitAlterBtn.titleLabel.font = Font(14);
    [self.submitAlterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.confiremPwdTextFView.mas_bottom).offset(KSIphonScreenH(100));
        make.left.equalTo(weakSelf.view).offset(KSIphonScreenW(25));
        make.right.equalTo(weakSelf.view).offset(-KSIphonScreenW(25));
        make.height.equalTo(@(KSIphonScreenH(44)));
    }];
    self.submitAlterBtn.layer.cornerRadius = KSIphonScreenH(44)/2;
    self.submitAlterBtn.layer.masksToBounds = YES;
    [self.submitAlterBtn addTarget:self action:@selector(selectSubmitAlterBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.submitAlterBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    [self.submitAlterBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorLineCommonBlueColor]] forState:UIControlStateNormal];
    [self.submitAlterBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorClickCommonBlueColor]] forState:UIControlStateHighlighted];
   
    // 暂不绑定
    self.unSubmitBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.unSubmitBtn];
    [self.unSubmitBtn setTitle:@"进入首页" forState:UIControlStateNormal];
    [self.unSubmitBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    self.unSubmitBtn.titleLabel.font = Font(14);
    self.unSubmitBtn.backgroundColor = [UIColor colorViewWhiteColor];
    [self.unSubmitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.submitAlterBtn.mas_bottom).offset(KSIphonScreenH(15));
        make.left.with.height.equalTo(weakSelf.submitAlterBtn);
        make.centerX.equalTo(weakSelf.submitAlterBtn.mas_centerX);
    }];
    self.unSubmitBtn.layer.cornerRadius = KSIphonScreenH(44)/2;
    self.unSubmitBtn.layer.masksToBounds = YES;
    self.unSubmitBtn.layer.borderWidth = 1;
    self.unSubmitBtn.layer.borderColor = [UIColor colorLineCommonBlueColor].CGColor;
    [self.unSubmitBtn addTarget:self action:@selector(selectUnSubmitBtn:) forControlEvents:UIControlEventTouchUpInside];
   
    if (self.pwdViewStatu == showPwdViewNormalStatu) {
        // 隐藏
        self.firstShowLab.hidden = YES;
        self.unSubmitBtn.hidden = YES;
    }
}
// 点击登录按钮
- (void)selectSubmitAlterBtn:(UIButton *) sender {
    // 旧密码
    if (self.oldPwdView.baseTextField.text.length == 0) {
        [self.view showErrorWithTitle:@"旧密码不能为空!" autoCloseTime:0.5];
        return ;
    }
   
    // 新密码
    if (self.newsPwdView.baseTextField.text.length == 0)  {
       [self.view showErrorWithTitle:@"新密码不能为空!" autoCloseTime:0.5];
        return ;
    }
    
    // 确认密码
    if (self.confiremPwdTextFView.baseTextField.text.length == 0 ) {
        [self.view showErrorWithTitle:@"确认密码不能为空!" autoCloseTime:0.5];
        return ;
    }
    
    // 新密码和确认密码不一样
    if (![self.newsPwdView.baseTextField.text isEqualToString:self.confiremPwdTextFView.baseTextField.text]) {
        [self.view showErrorWithTitle:@"两次新密码不一致!" autoCloseTime:1];
        return ;
    }
    
    // 创建遮罩层view
    [[UIApplication sharedApplication].keyWindow addSubview:self.maskFloorView];
    
    // 请求接口
    [self requestAlterLoginPwd];
}
// 进入首页
-(void)selectUnSubmitBtn:(UIButton *) sender{
    //否则直接进入应用
    SDRootNavigationController *leftVC = [[SDRootNavigationController alloc]initWithRootViewController:[YWTLeftViewController new]];
    SDRootNavigationController *rootVC = [[SDRootNavigationController alloc]initWithRootViewController:[YWTHomeViewController new]];
    UITabBarController *tarBarCtr=[[UITabBarController alloc]init];
    [tarBarCtr setViewControllers:[NSArray arrayWithObjects:rootVC, nil]];
    //侧边栏
    REFrostedViewController *rostedViewController = [[REFrostedViewController alloc] initWithContentViewController:tarBarCtr menuViewController:leftVC];
    rostedViewController.direction = REFrostedViewControllerDirectionLeft;
    rostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleDark;
    rostedViewController.liveBlur = YES;
    rostedViewController.limitMenuViewSize = YES;
    rostedViewController.backgroundFadeAmount=0.5;
    rostedViewController.delegate = self;
    rostedViewController.menuViewSize=CGSizeMake(leftSideMeunWidth, KScreenH);
    
    AppDelegate *appdel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appdel.rootTabbarCtrV = tarBarCtr;
    appdel.window.rootViewController =rostedViewController;
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
#pragma mark -----系统回调--------
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.pwdViewStatu == showPwdViewFristHomeStatu) {
        if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.pwdViewStatu == showPwdViewFristHomeStatu) {
        if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
    }
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    self.customNavBar.title = @"修改登录密码";
    
    __weak typeof(self) weakSelf = self;
    if (_pwdViewStatu != showPwdViewFristHomeStatu) {
        [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
        self.customNavBar.onClickLeftButton = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
}
// 跳转到那个页面
-(void)pushViewController{
    //否则直接进入应用
    SDRootNavigationController *leftVC = [[SDRootNavigationController alloc]initWithRootViewController:[YWTLeftViewController new]];
    SDRootNavigationController *rootVC = [[SDRootNavigationController alloc]initWithRootViewController:[YWTHomeViewController new]];
    UITabBarController *tarBarCtr=[[UITabBarController alloc]init];
    [tarBarCtr setViewControllers:[NSArray arrayWithObjects:rootVC, nil]];
    //侧边栏
    REFrostedViewController *rostedViewController = [[REFrostedViewController alloc] initWithContentViewController:tarBarCtr menuViewController:leftVC];
    rostedViewController.direction = REFrostedViewControllerDirectionLeft;
    rostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleDark;
    rostedViewController.liveBlur = YES;
    rostedViewController.limitMenuViewSize = YES;
    rostedViewController.backgroundFadeAmount=0.5;
    rostedViewController.delegate = self;
    rostedViewController.menuViewSize=CGSizeMake(leftSideMeunWidth, KScreenH);
    
    AppDelegate *appdel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appdel.rootTabbarCtrV = tarBarCtr;
    appdel.window.rootViewController =rostedViewController;
}
#pragma mark ----懒加载 -----
-(YWTLoginMaskFloorView *)maskFloorView{
    if (!_maskFloorView) {
        _maskFloorView = [[YWTLoginMaskFloorView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    }
    return _maskFloorView;
}
#pragma mark ---set 方法 -----
-(void)setPwdViewStatu:(showPwdViewStatu)pwdViewStatu{
    _pwdViewStatu = pwdViewStatu;
}
#pragma mark ------修改登录密码------
-(void)requestAlterLoginPwd{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] = [YWTUserInfo obtainWithUserId];
    param[@"token"] = [YWTTools getNewToken];
    param[@"oldPassword"] = self.oldPwdView.baseTextField.text;
    param[@"newPassword"] = self.newsPwdView.baseTextField.text;
    param[@"rePassword"] = self.confiremPwdTextFView.baseTextField.text;
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPALTERPASSWORD_URL params:param withModel:nil waitView:nil complateHandle:^(id showdata, NSString *error) {
        //移除遮罩层view
        [self.maskFloorView removeFromSuperview];
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:1];
            return ;
        }
        // 删除用户信息
        [YWTUserInfo delUserInfo];
        NSLog(@"-----%@---",[YWTTools getNewToken]);
        //退出的时候删除别名
        [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            if (iResCode == 0) {
                NSLog(@"删除别名成功");
            }
        } seq:1];
        // 提示
        [self.view showRightWithTitle:@"修改成功" autoCloseTime:0.5];
        // 跳转 登录页
        AppDelegate *appdel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        SDRootNavigationController *loginVC = [[SDRootNavigationController alloc]initWithRootViewController:[[YWTLoginViewController alloc]init]];
        appdel.window.rootViewController = loginVC;
    }];
}



@end
