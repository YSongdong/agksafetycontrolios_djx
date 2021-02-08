//
//  ExamCenterListController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/22.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTExamCenterListController.h"

#import "YWTExamCenterRecordController.h"
#import "YWTExamPaperExerciseController.h"
#import "YWTExamPaperListController.h"
#import "YWTlibayExerciseController.h"

#import "YWTExamCenterListHeaderView.h"
#import "YWTExamCenterSpaceView.h"
#import "ExamCenterListModel.h"
#import "ExamCenterRoomListModel.h"
#import "YWTShowUnNetWorkStatuView.h"

#import "YWTExamCeterListTableViewCell.h"
#define EXAMCETERLISTTABLEVIEW_CELL @"YWTExamCeterListTableViewCell"
#import "YWTExamRoomListCell.h"
#define EXAMROOMLISTCELL  @"YWTExamRoomListCell"

@interface YWTExamCenterListController ()
<
UITableViewDelegate,
UITableViewDataSource
>
// 头部视图
@property (nonatomic,strong) YWTExamCenterListHeaderView *listHeaderView;
// 空白视图
@property (nonatomic,strong) YWTExamCenterSpaceView *examCenterSpaceView;
// 没有网络view
@property (nonatomic,strong) YWTShowUnNetWorkStatuView *showNetWorkStatuView;
@property (nonatomic,strong) UITableView *listTableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
// 页数
@property (nonatomic,assign) NSInteger page;

@end

@implementation YWTExamCenterListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page  = 1;
    // 设置导航栏
    [self setNavi];
    // 创建TableView
    [self createTableView];
    // 考场倒计时
    if (self.viewControStatu == showViewControllerExamRoomListStatu) {
        // 启动倒计时管理
        [kCountDownManager start];
    }
    // 注册网络通知
    [self registeredNetworkTifi];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 请求数据
    self.page  = 1;
    [self requestExamDataLIst];
}
#pragma mark --- 创建TableView --------
-(void)createTableView{
    self.view.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    self.listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KScreenH-KSNaviTopHeight-KSTabbarH)];
    [self.view addSubview:self.listTableView];
    self.listTableView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.listTableView.tableHeaderView =  self.listHeaderView;
    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.listTableView addSubview:self.examCenterSpaceView];
    
    [self.listTableView registerClass:[YWTExamCeterListTableViewCell class] forCellReuseIdentifier:EXAMCETERLISTTABLEVIEW_CELL];
    [self.listTableView registerClass:[YWTExamRoomListCell class] forCellReuseIdentifier:EXAMROOMLISTCELL];
    if (@available(iOS 11.0, *)) {
        self.listTableView.estimatedRowHeight = 0;
        self.listTableView.estimatedSectionFooterHeight = 0;
        self.listTableView.estimatedSectionHeaderHeight = 0 ;
        self.listTableView.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    __weak typeof(self) weakSelf = self;
    // 刷新
    [self.listTableView bindGlobalStyleForHeadRefreshHandler:^{
        weakSelf.page = 1;
        [weakSelf requestExamDataLIst];
    }];
    
    [self.listTableView bindGlobalStyleForFootRefreshHandler:^{
        weakSelf.page ++;
        [weakSelf requestExamDataLIst];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self)weakSelf = self;
    if (self.viewControStatu == showViewControllerExamCenterListStatu) {
        YWTExamCeterListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EXAMCETERLISTTABLEVIEW_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ExamCenterListModel *model = self.dataArr[indexPath.row];
        cell.model =model;
        return cell;
    }else if (self.viewControStatu == showViewControllerExamRoomListStatu){
        YWTExamRoomListCell *cell = [tableView dequeueReusableCellWithIdentifier:EXAMROOMLISTCELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ExamCenterRoomListModel *model = self.dataArr[indexPath.row];
        cell.model =model;
        cell.countDownZero = ^(ExamCenterRoomListModel *model) {
            [weakSelf.dataArr replaceObjectAtIndex:indexPath.row withObject:model];
        };
        return cell;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.viewControStatu == showViewControllerExamCenterListStatu) {
        ExamCenterListModel *model = self.dataArr[indexPath.row];
        return [YWTExamCeterListTableViewCell getWithExamCenterListCellHeight:model];
    }else{
        ExamCenterRoomListModel *model = self.dataArr[indexPath.row];
        return [YWTExamRoomListCell getWithExamRoomCellHeight:model];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.viewControStatu == showViewControllerExamCenterListStatu) {
        ExamCenterListModel *model = self.dataArr[indexPath.row];
        // 1考试进行中 2考试未开始 3考试次数已用完
        if ([model.status  isEqualToString:@"3"]) {
//            [self.view showErrorWithTitle:@"考试次数已用完!" autoCloseTime:0.5];
        }else {
            YWTExamCenterListController *examRoomVC = [[YWTExamCenterListController alloc]init];
            examRoomVC.viewControStatu = showViewControllerExamRoomListStatu;
            examRoomVC.examIdStr = model.examId;
            [self.navigationController pushViewController:examRoomVC animated:YES];
        }
    }else{
        ExamCenterRoomListModel *model = self.dataArr[indexPath.row];
        // 1考试进行中 2考试未开始 3 考试次数已用完
        if ([model.status isEqualToString:@"3"]) {
//            [self.view showErrorWithTitle:@"考试次数已用完！" autoCloseTime:0.5];
        }else if ([model.status isEqualToString:@"2"]){
            [self.view showErrorWithTitle:@"考试未开始" autoCloseTime:0.5];
        }else{
           [self requestExamNumberData:model];
        }
    }
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    if (self.viewControStatu == showViewControllerExamCenterListStatu ) {
        self.customNavBar.title = self.titleStr;
    }else{
        self.customNavBar.title = @"考场中心";
    }
   
    __weak typeof(self) weakSelf = self;
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    //保存设置
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@""]];
    [self.customNavBar.rightButton  setTitle:@"考试成绩" forState:UIControlStateNormal];
    [self.customNavBar.rightButton setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.customNavBar.rightButton.titleLabel.font = Font(16);
    self.customNavBar.rightButton.frame = CGRectMake(KScreenW - 80, KSStatusHeight, 70 , 44);
    [self.customNavBar setOnClickRightButton:^{
        YWTExamCenterRecordController *examRecordVC = [[YWTExamCenterRecordController alloc]init];
        [weakSelf.navigationController pushViewController:examRecordVC animated:YES];
    }];
}
#pragma mark --- 注册网络通知 --------
-(void) registeredNetworkTifi{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unNetwork:) name:@"NetWorkStatu" object:nil];
}
// 获取网络状态
-(void)unNetwork:(NSNotification *)tifi{
    NSDictionary *dict = tifi.userInfo;
    if ([dict[@"netwrok"] isEqualToString:@"NO"]) {
        [self.view addSubview:self.showNetWorkStatuView];
        __weak typeof(self) weakSelf = self;
        self.showNetWorkStatuView.selectRetryBlock = ^{
            NSString *networkStr = [YWTTools getNetworkTypeByReachability];
            if (![networkStr isEqualToString:@"NONE"]) {
                // 重新请求数据
                [weakSelf requestExamDataLIst];
                // 移除
                [weakSelf.showNetWorkStatuView removeFromSuperview];
            }
        };
    }
}
#pragma mark -----系统回调----
-(void)dealloc{
    // 考场倒计时
    if (self.viewControStatu == showViewControllerExamRoomListStatu) {
        // 清空时间差
        [kCountDownManager removeAllSource];
        // 废除定时器
        [kCountDownManager invalidate];
    }
}
#pragma mark ------ 刷新数据------
- (void)reloadData {
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 考场倒计时
        if (self.viewControStatu == showViewControllerExamRoomListStatu) {
            // 调用reload
            [kCountDownManager reload];
        }
        // 刷新
        [weakSelf.listTableView reloadData];
    });
}
#pragma mark --- 懒加载 --------
-(YWTExamCenterListHeaderView *)listHeaderView{
    if (!_listHeaderView) {
        _listHeaderView = [[YWTExamCenterListHeaderView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KSIphonScreenH(140))];
    }
    return _listHeaderView;
}
-(YWTExamCenterSpaceView *)examCenterSpaceView{
    if (!_examCenterSpaceView) {
        _examCenterSpaceView = [[YWTExamCenterSpaceView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSNaviTopHeight-KSTabbarH)];
    }
    return _examCenterSpaceView;
}
-(YWTShowUnNetWorkStatuView *)showNetWorkStatuView{
    if (!_showNetWorkStatuView) {
        _showNetWorkStatuView = [[YWTShowUnNetWorkStatuView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KScreenH-KSNaviTopHeight-KSTabbarH)];
    }
    return _showNetWorkStatuView;
}
-(void)setViewControStatu:(showViewControllerStatu)viewControStatu{
    _viewControStatu = viewControStatu;
}
-(void)setExamIdStr:(NSString *)examIdStr{
    _examIdStr = examIdStr;
}
-(void)setTitleStr:(NSString *)titleStr{
    _titleStr=titleStr;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return  _dataArr;
}
#pragma mark  ----请求正式考试列表--------
-(void) requestExamDataLIst{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"page"] = [NSNumber numberWithInteger:self.page];
    param[@"pageSize"] = @"10";
    NSString *url;
    if (self.viewControStatu == showViewControllerExamRoomListStatu) {
        param[@"examId"] = self.examIdStr;
        url = HTTP_ATTAPPEXAMROOMLIST_URL;
    }else{
        url = HTTP_ATTAPPEXAMPAPEREXAMLIST_URL;
    }
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:url params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        
        [self.listTableView.headRefreshControl endRefreshing];
        [self.listTableView.footRefreshControl endRefreshing];
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:1];
            return ;
        }
        if (![showdata isKindOfClass:[NSArray class]]) {
            [self.view showErrorWithTitle:@"返回数据格式错误" autoCloseTime:1];
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        if (self.page == 1) {
            [self.dataArr removeAllObjects];
        }
        
        if (self.viewControStatu == showViewControllerExamCenterListStatu) {
            for (NSDictionary *dict in showdata) {
                ExamCenterListModel *model = [ExamCenterListModel yy_modelWithDictionary:dict];
                [self.dataArr addObject:model];
            }
        }else if (self.viewControStatu == showViewControllerExamRoomListStatu) {
            for (NSDictionary *dict in showdata) {
                ExamCenterRoomListModel *model = [ExamCenterRoomListModel yy_modelWithDictionary:dict];
                [self.dataArr addObject:model];
            }
        }
        if (self.dataArr.count > 0) {
            self.examCenterSpaceView.hidden = YES;
        }else{
            self.examCenterSpaceView.hidden = NO;
        }
        // 判断是不是只有一场考试
        if (self.viewControStatu == showViewControllerExamCenterListStatu) {
            if (self.dataArr.count == 1) {
                NSDictionary *dict = self.dataArr[0];
                ExamCenterListModel *model = [ExamCenterListModel yy_modelWithDictionary:dict];
                if ([model.status isEqualToString:@"1"]) {
                    self.examIdStr = model.examId;
                    self.viewControStatu =showViewControllerExamRoomListStatu;
                    self.customNavBar.title = @"考场中心";
                    // 请求考场列表信息
                    [self requestExamDataLIst];
                    // 终止
                    return;
                }
            }
        }
        // 刷新数据源
        [self reloadData];
    }];
}

#pragma mark ------ 检查是否具有考试权限 -------
-(void) requestExamNumberData:(ExamCenterRoomListModel *)model{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"examId"] = self.examIdStr;
    param[@"examRoomId"] = model.examRoomId;
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPEXAMPAPEREXAMNUMBER_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:1];
            return ;
        }
        if (![showdata isKindOfClass:[NSDictionary class]]) {
            return;
        }
        NSString *canEnterStr = [NSString stringWithFormat:@"%@",showdata[@"canEnter"]];
        if ([canEnterStr isEqualToString:@"2"]) {
            [self.view showErrorWithTitle:@"考试次数已用完！" autoCloseTime:1];
            return;
        }
        YWTExamPaperExerciseController *examRoomVC = [[YWTExamPaperExerciseController alloc]init];
        examRoomVC.examType = showTableViewExamCenterType;
        examRoomVC.paperIdStr = model.paperId;
        examRoomVC.examIdStr = model.examId;
        examRoomVC.examRoomIdStr = model.examRoomId;
        examRoomVC.examBatchIdStr = model.examBatchId;
        [self.navigationController pushViewController:examRoomVC animated:YES];
    }];
}

@end
