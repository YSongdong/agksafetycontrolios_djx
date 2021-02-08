//
//  CreditChartListController.m
//  PartyBuildingStar
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import "CreditChartListController.h"

#import "CreditChartListHeaderView.h"
#import "CreditChartRankingView.h"

#import "YWTAnnualStandingController.h"

@interface CreditChartListController ()
// 头部view
@property (nonatomic,strong) CreditChartListHeaderView *listHeaderView;
// 排名view
@property (nonatomic,strong) CreditChartRankingView *rankingView;

@end

@implementation CreditChartListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [self setNavi];
    // 创建UI
    [self createUI];
}
#pragma mark --- 创建UI --------
-(void) createUI{
    self.view.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    __weak typeof(self) weakSelf = self;
    self.listHeaderView = [[CreditChartListHeaderView alloc]init];
    [self.view addSubview:self.listHeaderView];
    [self.listHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(KSNaviTopHeight);
        make.left.right.equalTo(weakSelf.view);
        make.height.equalTo(@(KSIphonScreenH(150)));
    }];
    
    // 排名view
    self.rankingView = [[CreditChartRankingView alloc]init];
    [self.view addSubview:self.rankingView];
    [self.rankingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(KSIphonScreenH(KSNaviTopHeight+KSIphonScreenH(118)));
        make.right.equalTo(weakSelf.view).offset(-KSIphonScreenW(12));
        make.left.equalTo(weakSelf.view).offset(KSIphonScreenW(12));
        make.bottom.equalTo(weakSelf.view).offset(-(KSTabbarH+KSIphonScreenH(12)));
    }];
    self.rankingView.currentUser = ^(NSDictionary * _Nonnull userDict) {
        // 更新u用户信息
        [weakSelf.listHeaderView updateUserInfoDict:userDict];
    };
}

#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    self.customNavBar.title = @"学分排行榜";
    
    __weak typeof(self) weakSelf = self;
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    //检查记录
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@""]];
    [self.customNavBar.rightButton  setTitle:@"年度积分榜" forState:UIControlStateNormal];
    [self.customNavBar.rightButton setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.customNavBar.rightButton.titleLabel.font = Font(16);
    self.customNavBar.rightButton.frame = CGRectMake(KScreenW - 100, KSStatusHeight, 90 , 44);
    [self.customNavBar setOnClickRightButton:^{
        YWTAnnualStandingController *annualVC = [[YWTAnnualStandingController alloc]init];
        [weakSelf.navigationController pushViewController:annualVC animated:YES];
    }];
    
}



@end
