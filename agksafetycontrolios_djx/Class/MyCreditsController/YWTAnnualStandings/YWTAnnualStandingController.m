//
//  YWTAnnualStandingController.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/20.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTAnnualStandingController.h"

#import "YWTAnnualStandingHeaderView.h"
#import "YWTAnnualBottomView.h"
#import "YWTAnnualStandingCell.h"
#define YWTANNUALSTANDING_CELL @"YWTAnnualStandingCell"

@interface YWTAnnualStandingController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic,strong) UIImageView *bgImageV;

@property (nonatomic,strong) YWTAnnualStandingHeaderView *headerView;

@property (nonatomic,strong) YWTAnnualBottomView *bottomView;

@property (nonatomic,strong) UITableView *myTableView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,assign) NSInteger page;

@end

@implementation YWTAnnualStandingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    // 设置导航栏
    [self setNavi];
    //添加背景图片
    [self.view insertSubview:self.bgImageV atIndex:0];
    
    [self.view addSubview:self.bottomView];
    
    [self.view addSubview:self.headerView];
    
    [self.view addSubview:self.myTableView];
    // 请求数据
    [self requestTaskLeaderBoard];
}
#pragma mark --- UITableViewDataSource--------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWTAnnualStandingCell *cell = [tableView dequeueReusableCellWithIdentifier:YWTANNUALSTANDING_CELL forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dict = self.dataArr[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KSIphonScreenH(63);
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:0];
    
    self.customNavBar.title = @"年度积分榜";
    
    __weak typeof(self) weakSelf = self;
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}
-(UIImageView *)bgImageV{
    if (!_bgImageV) {
        _bgImageV = [[UIImageView alloc]initWithFrame:self.view.bounds];
        _bgImageV.image = [UIImage imageNamed:@"annualStanding_bg"];
    }
    return _bgImageV;
}
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(KSIphonScreenW(12), KSNaviTopHeight+KSIphonScreenH(184), KScreenW-KSIphonScreenW(24), KScreenH-KSNaviTopHeight-KSIphonScreenH(184)-KSTabbarH-KSIphonScreenH(50))];
        _myTableView.backgroundColor = [UIColor colorTextWhiteColor];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
        [_myTableView registerClass:[YWTAnnualStandingCell class] forCellReuseIdentifier:YWTANNUALSTANDING_CELL];
        WS(weakSelf);
        [_myTableView bindGlobalStyleForHeadRefreshHandler:^{
            weakSelf.page =1 ;
            [weakSelf requestTaskLeaderBoard];
        }];
        [_myTableView bindGlobalStyleForFootRefreshHandler:^{
            weakSelf.page ++ ;
            [weakSelf requestTaskLeaderBoard];
        }];
    }
    return _myTableView;
}
-(YWTAnnualBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[YWTAnnualBottomView alloc]initWithFrame:CGRectMake(0, KScreenH-KSTabbarH-KSIphonScreenH(50), KScreenW, KSIphonScreenH(50))];
    }
    return _bottomView;
}
-(YWTAnnualStandingHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[YWTAnnualStandingHeaderView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KSIphonScreenH(184))];
    }
    return _headerView;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

#pragma mark ------  数据相关 --------
-(void) requestTaskLeaderBoard{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] =  [YWTTools getNewToken];
    param[@"page"] =  [NSNumber numberWithInteger:self.page];
    param[@"pageSize"] =  [NSNumber numberWithInteger:20];
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPSERVICEAPIMYTASKANNUALLEADERBOARD_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        [self.myTableView.footRefreshControl endRefreshing];
        [self.myTableView.headRefreshControl endRefreshing];
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if ([showdata isKindOfClass:[NSDictionary class]]) {
            if (self.page == 1) {
                [self.dataArr removeAllObjects];
            }
            // 排行榜
            [self.dataArr addObjectsFromArray:showdata[@"leaderboardList"]];
            // 当前用户数据源
            NSDictionary *userDict = showdata[@"currentUser"];
            self.bottomView.dict = userDict;
            // 前三数据源
            NSArray *topArr = showdata[@"topthree"];
            self.headerView.nowArr = topArr;
            // 刷新UI
            [self.myTableView reloadData];
        }
    }];
}



@end
