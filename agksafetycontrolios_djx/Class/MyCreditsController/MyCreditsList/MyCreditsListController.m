//
//  MyCreditsListController.m
//  PartyBuildingStar
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import "MyCreditsListController.h"

#import "MyCreditsScoreView.h"
#import "MyCreditdRecordingView.h"

#import "CreditChartListController.h"

@interface MyCreditsListController ()
// 得分
@property (nonatomic,strong) MyCreditsScoreView *scoreView;
// 记录view
@property (nonatomic,strong) MyCreditdRecordingView  *recordingView;

@end

@implementation MyCreditsListController

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
    self.scoreView = [[MyCreditsScoreView alloc]init];
    [self.view addSubview:self.scoreView];
    [self.scoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(KSNaviTopHeight);
        make.right.left.equalTo(weakSelf.view);
        make.height.equalTo(@(KSIphonScreenH(120)));
    }];

    self.recordingView = [[MyCreditdRecordingView alloc]init];
    [self.view addSubview:self.recordingView];
    [self.recordingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.scoreView.mas_bottom);
        make.right.left.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view).offset(-KSTabbarH);
    }];
    self.recordingView.myCreditsSetCount = ^(NSString * _Nonnull dataSetCountStr) {
        weakSelf.scoreView.showScoreLab.text = dataSetCountStr;
    };
    
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    self.customNavBar.title = @"我的学分";
   
    __weak typeof(self) weakSelf = self;
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    //排行榜
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@""]];
    [self.customNavBar.rightButton  setTitle:@"排行榜" forState:UIControlStateNormal];
    [self.customNavBar.rightButton setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.customNavBar.rightButton.titleLabel.font = Font(16);
    self.customNavBar.rightButton.frame = CGRectMake(KScreenW - 80, KSStatusHeight, 70 , 44);
    [self.customNavBar setOnClickRightButton:^{
        CreditChartListController *chartListVC = [[CreditChartListController alloc]init];
        [weakSelf.navigationController pushViewController:chartListVC animated:YES];
    }];
}

@end
