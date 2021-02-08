//
//  SDLoginViewController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/7.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTLoginViewController.h"
#import "YWTLoginView.h"
#import "YWTLoginSettingController.h"
#import "YWTLoginPwdRetrieveController.h"
#import "YWTPhotoCollectionController.h"
#import "YWTBindIphoneViewController.h"
#import "YWTAlterLoginPwdVController.h"

@interface YWTLoginViewController ()<REFrostedViewControllerDelegate>

@property (nonatomic,strong) YWTLoginView *loginView;

@end

@implementation YWTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self setNavi];
    //创建视图
    [self createLoginView];
    //注册通知
    [self registerNotifi];
}
#pragma mark --- 创建视图 --------
-(void) createLoginView{
 
    _loginView = [[YWTLoginView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    [self.view insertSubview:_loginView atIndex:0];
    __weak typeof(self) weakSelf = self;
    // 忘记密码
    _loginView.pwdRetieveBlock = ^{
        YWTLoginPwdRetrieveController *pwdRetVC = [[YWTLoginPwdRetrieveController alloc]init];
        [weakSelf.navigationController  pushViewController:pwdRetVC animated:YES];
    };
    // 登录成功
    _loginView.successBlock = ^{
        [weakSelf pushViewController];
    };
}
// 跳转到那个页面
-(void)pushViewController{
    __weak  typeof(self) weakSelf = self;
    
    //判断是否是第一次登录  0  是 非0 不是
    NSString *loginCountStr = [NSString stringWithFormat:@"%@",[YWTUserInfo obtainWithLoginCount]];
    if ([loginCountStr isEqualToString:@"0"]) {
        // 判断人脸认证
        NSString *vFaceStr = [NSString stringWithFormat:@"%@",[YWTUserInfo obtainWithVFace]];
        if (![vFaceStr isEqualToString:@"1"]) {
            YWTPhotoCollectionController *photoVC = [[YWTPhotoCollectionController alloc]init];
            photoVC.isFristHome = YES;
            // 未上传
            photoVC.photoStatu = photoStatuNotUploaded;
            [weakSelf.navigationController pushViewController:photoVC animated:YES];
            return ;
        }

        // 判断是否绑定手机
        NSString *vMobileStr = [NSString stringWithFormat:@"%@",[YWTUserInfo obtainWithVMobile]];
        if ([vMobileStr isEqualToString:@"2"]) {
            YWTBindIphoneViewController *bindVC = [[YWTBindIphoneViewController alloc]init];
            bindVC.viewStatu = showViewFristHomeStatu;
            [weakSelf.navigationController pushViewController:bindVC animated:YES];
            return ;
        }
        //修改登录密码
        YWTAlterLoginPwdVController *alterPwdVC = [[YWTAlterLoginPwdVController alloc]init];
        alterPwdVC.pwdViewStatu = showPwdViewFristHomeStatu;
        [weakSelf.navigationController pushViewController:alterPwdVC animated:YES];
    }else {
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
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
//注册通知
-(void) registerNotifi{
    //注册通知
    //程序从前台退到后台
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification  object:nil];
}
#pragma mark  ----- 通知事件-------
//app从前台退到后台
-(void) applicationDidEnterBackground
{
   [self.view endEditing:YES];
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:0];
    
    //设置
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"login_ico_sz"]];
    __weak typeof(self) weakSelf = self;
    self.customNavBar.onClickRightButton = ^{
        YWTLoginSettingController *loginSettingVC = [[YWTLoginSettingController alloc]init];
        [weakSelf.navigationController pushViewController:loginSettingVC animated:YES];
    };
}


@end
