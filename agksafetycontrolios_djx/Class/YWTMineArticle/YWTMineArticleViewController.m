//
//  MineArticleViewController.m
//  PartyBuildingStar
//
//  Created by 世界之窗 on 2019/8/28.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import "YWTMineArticleViewController.h"

#import "YWTShowNoSourceView.h"

@interface YWTMineArticleViewController ()
// 空白页
@property (nonatomic,strong) YWTShowNoSourceView *showNoSoucreView;
@end

@implementation YWTMineArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorTextWhiteColor];
    // 设置导航栏
    [self setNavi];
    // 添加空白页
    [self.view addSubview:self.showNoSoucreView];
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    self.customNavBar.title = @"我的文章";
    
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    __weak typeof(self) weakSelf = self;
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}
-(YWTShowNoSourceView *)showNoSoucreView{
    if (!_showNoSoucreView) {
        _showNoSoucreView = [[YWTShowNoSourceView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KScreenH-KSTabbarH-KSNaviTopHeight)];
        _showNoSoucreView.showMarkLab.text = @"暂无数据";
    }
    return _showNoSoucreView;
}


@end
