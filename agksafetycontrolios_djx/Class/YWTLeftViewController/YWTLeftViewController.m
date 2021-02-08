//
//  SDLeftViewController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/7.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTLeftViewController.h"
#import "YWTLeftView.h"
#import "YWTMineViewController.h"
#import "YWTSettingViewController.h"
#import "YWTExamCenterRecordController.h"
#import "MyCreditsListController.h"
#import "YWTMineArticleViewController.h"

#import "YWTSectionViewController.h"

#import "YWTPartyMemberAreaListController.h"

@interface YWTLeftViewController ()

@property (nonatomic,strong) YWTLeftView *leftView;


@end

@implementation YWTLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 更新用户信息
    [self updateUserInfo];
}
-(void) setUp{
    [self.customNavBar wr_setBackgroundAlpha:0];
    _leftView = [[YWTLeftView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_leftView];
    __weak typeof(self) weakSelf = self;
    //点击头像
    _leftView.headerBlock = ^{
        // 关闭右侧侧边栏
        [weakSelf closeRightViewController];
        UINavigationController *navCtr= ((AppDelegate*)[UIApplication sharedApplication].delegate).rootTabbarCtrV.selectedViewController;
        YWTMineViewController *mineVC = [[YWTMineViewController alloc]init];
        [navCtr pushViewController:mineVC animated:YES];
    };
    //  点击我的学分
    _leftView.selectMyCrdits = ^{
        // 关闭右侧侧边栏
        [weakSelf closeRightViewController];
        UINavigationController *navCtr= ((AppDelegate*)[UIApplication sharedApplication].delegate).rootTabbarCtrV.selectedViewController;
        MyCreditsListController *myCreditListVC = [[MyCreditsListController alloc]init];
        [navCtr pushViewController:myCreditListVC animated:YES];
    };
    // 点击我的文章
    _leftView.selectMyArticle = ^{
        // 关闭右侧侧边栏
        [weakSelf closeRightViewController];
        UINavigationController *navCtr= ((AppDelegate*)[UIApplication sharedApplication].delegate).rootTabbarCtrV.selectedViewController;
        YWTPartyMemberAreaListController *areaListVC = [[YWTPartyMemberAreaListController alloc]init];
        areaListVC.listType = partyAreaListMineType;
        areaListVC.moduleNameStr = @"";
        [navCtr pushViewController:areaListVC animated:YES];
    };
    // 点击考试成绩
    _leftView.examinationBlock = ^{
        // 关闭右侧侧边栏
        [weakSelf closeRightViewController];
        UINavigationController *navCtr= ((AppDelegate*)[UIApplication sharedApplication].delegate).rootTabbarCtrV.selectedViewController;
        YWTExamCenterRecordController *examRecordVC = [[YWTExamCenterRecordController alloc]init];
        [navCtr pushViewController:examRecordVC animated:YES];
    };
    //点击设置
    _leftView.settingBlock = ^{
        // 关闭右侧侧边栏
        [weakSelf closeRightViewController];
        UINavigationController *navCtr= ((AppDelegate*)[UIApplication sharedApplication].delegate).rootTabbarCtrV.selectedViewController;
        YWTSettingViewController *settingVC = [[YWTSettingViewController alloc]init];
        [navCtr pushViewController:settingVC animated:YES];
    };
}
 // 关闭右侧侧边栏
-(void) closeRightViewController{
    [self.frostedViewController hideMenuViewController];
}
// 更新用户信息
-(void) updateUserInfo{
    [_leftView updateUserInfoData];
}


@end
