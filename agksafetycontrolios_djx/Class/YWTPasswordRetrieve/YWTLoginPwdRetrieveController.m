//
//  LoginPwdRetrieveController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/9.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTLoginPwdRetrieveController.h"

#import "YWTPwdRetrieveView.h"

@interface YWTLoginPwdRetrieveController ()

@property (nonatomic,strong) YWTPwdRetrieveView *pwdRetrieveView;

@end

@implementation YWTLoginPwdRetrieveController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [self setNavi];
    // 创建 view
    [self createPwdView];

}
-(void) createPwdView{
    self.pwdRetrieveView = [[YWTPwdRetrieveView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KScreenH-KSNaviTopHeight)];
    [self.view addSubview:self.pwdRetrieveView];
    __weak typeof(self) weakSelf = self;
    self.pwdRetrieveView.backBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    self.customNavBar.title = @"密码找回";
    
    __weak typeof(self) weakSelf = self;
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}


@end
