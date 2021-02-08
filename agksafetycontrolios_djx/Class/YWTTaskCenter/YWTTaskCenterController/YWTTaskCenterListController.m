//
//  TaskCenterListController.m
//  PartyBuildingStar
//
//  Created by mac on 2019/4/16.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import "YWTTaskCenterListController.h"

#import "YWTExamPaperListSiftView.h"
#import "YWTTaskCenterListHeaderView.h"
#import "YWTLockTaskStatuPromptView.h"
#import "YWTShowNoSourceView.h"

#import "TaskCenterListModel.h"

#import "YWTTaskCenterDetailController.h"
#import "MyCreditsListController.h"

#import "YWTTaskCenterUnStartedCell.h"
#define TASKCENTERUNSTARTED_CELL @"YWTTaskCenterUnStartedCell"
#import "YWTTaskCenterCompleteCell.h"
#define TASKCENTERCOMPLETE_CELL @"YWTTaskCenterCompleteCell"

@interface YWTTaskCenterListController ()
<
ExamPaperListSiftViewDelegate,
UITableViewDelegate,
UITableViewDataSource
>
// 筛选view
@property (nonatomic,strong) YWTExamPaperListSiftView *listSiftView;
// header
@property (nonatomic,strong) YWTTaskCenterListHeaderView *listHeaderView;
// 锁定任务view
@property (nonatomic,strong) YWTLockTaskStatuPromptView *lockTaskStatuView;
// 空白页
@property (nonatomic,strong) YWTShowNoSourceView *showNoSoucreView;

@property (nonatomic,strong) UITableView *listTableView;

@property (nonatomic,strong) NSMutableArray *dataArr;
// 页数
@property (nonatomic,assign) NSInteger page;
// 筛选条
@property (nonatomic,strong) NSString *tagIdStr;
// 任务状态
@property (nonatomic,strong) NSString *taskStatusStr;
// 是否重新创建筛选view
@property (nonatomic,assign) BOOL isShowCreateListSiftView;
@end

@implementation YWTTaskCenterListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor colorViewBackGrounpWhiteColor];
    self.page = 1;
    self.taskStatusStr = @"1";
    self.isShowCreateListSiftView = YES;
    // 设置导航栏
    [self setNavi];
    // 添加TableView
    [self.view insertSubview:self.listTableView atIndex:0];
    // 启动倒计时管理
    [kCountDownManager start];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.page = 1;
    // 请求人员信息
    [self requestTaskUserDetails];
    // 任务列表
    [self requestServiceApiTaskList];
}
//当前视图在即将被移除
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    // 移除锁定弹框视图
    [self.lockTaskStatuView removeFromSuperview];
}
#pragma mark --- UITableViewDataSource --------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TaskCenterListModel *model = self.dataArr[indexPath.row];
    if ([model.status isEqualToString:@"6"]) {
        // 6未开始
        YWTTaskCenterUnStartedCell *cell = [tableView dequeueReusableCellWithIdentifier:TASKCENTERUNSTARTED_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = model;
        return cell;
    }else{
        YWTTaskCenterCompleteCell *cell = [tableView dequeueReusableCellWithIdentifier:TASKCENTERCOMPLETE_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = model;
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TaskCenterListModel *model = self.dataArr[indexPath.row];
    if ([model.status isEqualToString:@"6"]) {
        // 未开始
        return [YWTTaskCenterUnStartedCell getWithCompleteCellHeight:model];
    }else{
        return [YWTTaskCenterCompleteCell getWithCompleteCellHeight:model];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TaskCenterListModel *model = self.dataArr[indexPath.row];
    if ([model.relatedtask isEqualToString:@"1"]) {
        [self.view addSubview:self.lockTaskStatuView];
        // 任务名称
        self.lockTaskStatuView.taskNameLab.text = model.title;
        // 任务要求
        NSAttributedString *attrStr = [[NSAttributedString alloc]initWithData:[model.relatedtaskName dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:[UIFont boldSystemFontOfSize:13] } documentAttributes:nil error:nil];
        self.lockTaskStatuView.taskRequirLab.attributedText = attrStr;
    
        __weak typeof(self) weakSelf = self;
        // 点前置任务详情
        self.lockTaskStatuView.selectTaskRequir = ^{
            YWTTaskCenterDetailController *detailVC = [[YWTTaskCenterDetailController alloc]init];
            // 1进行中2已完成3未完成4暂时完成5作废6未开始【4基本不会返回】
            if ([model.status isEqualToString:@"1"]) {
                detailVC.taskStatu = showTaskCenterDetailTaskingStatu;
            }else if ([model.status isEqualToString:@"2"]){
                detailVC.taskStatu = showTaskCenterDetailTaskCompleteStatu;
            }else if ([model.status isEqualToString:@"3"]){
                detailVC.taskStatu = showTaskCenterDetailTaskUndoneStatu;
            }else if ([model.status isEqualToString:@"5"]){
                detailVC.taskStatu = showTaskCenterDetailTaskOutDateStatu;
            }else if ([model.status isEqualToString:@"6"]){
                detailVC.taskStatu = showTaskCenterDetailTaskUnbeginStatu;
            }
            detailVC.taskvarIdStr = model.relatedtaskid;
            [weakSelf.navigationController pushViewController:detailVC animated:YES];
        };
        // 点击本任务查看详情
        self.lockTaskStatuView.selectLookDetail = ^{
            YWTTaskCenterDetailController *detailVC = [[YWTTaskCenterDetailController alloc]init];
            // 1进行中2已完成3未完成4暂时完成5作废6未开始【4基本不会返回】
            if ([model.status isEqualToString:@"1"]) {
                detailVC.taskStatu = showTaskCenterDetailTaskingStatu;
            }else if ([model.status isEqualToString:@"2"]){
                detailVC.taskStatu = showTaskCenterDetailTaskCompleteStatu;
            }else if ([model.status isEqualToString:@"3"]){
                detailVC.taskStatu = showTaskCenterDetailTaskUndoneStatu;
            }else if ([model.status isEqualToString:@"5"]){
                detailVC.taskStatu = showTaskCenterDetailTaskOutDateStatu;
            }else if ([model.status isEqualToString:@"6"]){
                detailVC.taskStatu = showTaskCenterDetailTaskUnbeginStatu;
            }
            detailVC.taskvarIdStr = model.taskvarid;
            [weakSelf.navigationController pushViewController:detailVC animated:YES];
        };
    }else{
        YWTTaskCenterDetailController *detailVC = [[YWTTaskCenterDetailController alloc]init];
        // 1进行中2已完成3未完成4暂时完成5作废6未开始【4基本不会返回】
        if ([model.status isEqualToString:@"1"]) {
            detailVC.taskStatu = showTaskCenterDetailTaskingStatu;
        }else if ([model.status isEqualToString:@"2"]){
            detailVC.taskStatu = showTaskCenterDetailTaskCompleteStatu;
        }else if ([model.status isEqualToString:@"3"]){
            detailVC.taskStatu = showTaskCenterDetailTaskUndoneStatu;
        }else if ([model.status isEqualToString:@"5"]){
            detailVC.taskStatu = showTaskCenterDetailTaskOutDateStatu;
        }else if ([model.status isEqualToString:@"6"]){
            detailVC.taskStatu = showTaskCenterDetailTaskUnbeginStatu;
        }
        detailVC.taskvarIdStr = model.taskvarid;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:0];
    
    self.customNavBar.title = self.moduleNameStr;
    
    __weak typeof(self) weakSelf = self;
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    self.customNavBar.onClickLeftButton = ^{
        // 返回到首页
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageChangeName:@"nav_ico_sift"]];
    __block  bool isCreateListSiftView = YES;
    self.customNavBar.onClickRightButton = ^{
        if (weakSelf.isShowCreateListSiftView) {
            isCreateListSiftView = YES;
        }
        if (isCreateListSiftView) {
            [weakSelf.view addSubview:weakSelf.listSiftView];
            weakSelf.listSiftView.siftType = showListSiftTaskCenterType;
            weakSelf.listSiftView.delegate = weakSelf;
            weakSelf.isShowCreateListSiftView = NO;
            isCreateListSiftView = NO;
        }else{
            [weakSelf clickSiftBtn];
        }
    };
}
// 点击筛选按钮
-(void)clickSiftBtn{
    __weak typeof(self) weakSelf= self;
    weakSelf.customNavBar.rightButton.selected = !weakSelf.customNavBar.rightButton.selected;
    if (weakSelf.customNavBar.rightButton.selected) {
        weakSelf.listSiftView.hidden = YES;
    }else{
        weakSelf.listSiftView.hidden = NO;
    }
}
#pragma mark --- 条件筛选--------
-(void) selectSubmitBtnTagIdStr:(NSString *)tagIdStr{
    // 点击筛选按钮
    [self clickSiftBtn];
    // 判断是否要显示筛选红点
    if ([tagIdStr isEqualToString:@""]) {
        [self.customNavBar.rightButton setImage:[UIImage imageChangeName:@"nav_ico_sift"] forState:UIControlStateNormal];
    }else{
        NSArray *arr = [tagIdStr componentsSeparatedByString:@","];
        BOOL isSelectSift = NO;
        for (NSString *tagStr in arr) {
            if (![tagStr isEqualToString:@"0"]) {
                isSelectSift = YES;
            }
        }
        if (isSelectSift) {
            [self.customNavBar.rightButton setImage:[UIImage imageChangeName:@"nav_ico_sift_select"] forState:UIControlStateNormal];
        }else{
            [self.customNavBar.rightButton setImage:[UIImage imageChangeName:@"nav_ico_sift"] forState:UIControlStateNormal];
        }
    }
    self.tagIdStr = tagIdStr;
    self.titleStr = @"";
    self.page = 1;
    [self requestServiceApiTaskList];
}
#pragma mark ---- <UIScrollViewDelegate>----
//只要滚动了就会触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y > KSIphonScreenH(130)) {
        [UIView animateWithDuration:0.25 animations:^{
            [self.customNavBar wr_setBackgroundAlpha:1];
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            [self.customNavBar wr_setBackgroundAlpha:0];
        }];
    }
}
#pragma mark -----系统回调----
-(void)dealloc{
    // 考场倒计时
    // 清空时间差
    [kCountDownManager removeAllSource];
    // 废除定时器
    [kCountDownManager invalidate];
}
#pragma mark ------ 刷新数据------
- (void)reloadData {
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 考场倒计时
        // 调用reload
        [kCountDownManager reload];
        // 刷新
        [weakSelf.listTableView reloadData];
    });
}
#pragma mark ---  get 方法 ---- 
-(YWTExamPaperListSiftView *)listSiftView{
    if (!_listSiftView) {
        _listSiftView = [[YWTExamPaperListSiftView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KScreenH-KSNaviTopHeight)];
    }
    return _listSiftView;
}
-(YWTTaskCenterListHeaderView *)listHeaderView{
    if (!_listHeaderView) {
        _listHeaderView = [[YWTTaskCenterListHeaderView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KSIphonScreenH(250))];
        __weak typeof(self) weakSelf = self;
    
        // 搜索
        _listHeaderView.selectSearch = ^(NSString * _Nonnull searchStr) {
            weakSelf.tagIdStr = @"";
            weakSelf.titleStr = searchStr;
            weakSelf.page = 1;
            [weakSelf requestServiceApiTaskList];
        };
        // 搜索进行中任务状态
        _listHeaderView.selectTasking = ^{
            weakSelf.taskStatusStr = @"1";
            weakSelf.page = 1;
            [weakSelf requestServiceApiTaskList];
        };
        // 搜索全部任务状态
        _listHeaderView.selectAllTask = ^{
            weakSelf.taskStatusStr = @"0";
            weakSelf.page = 1;
            weakSelf.tagIdStr = @"";
            [weakSelf requestServiceApiTaskList];
        };
        // 我的学分
        _listHeaderView.selectMyStudies = ^{
            MyCreditsListController *myCrditsVC = [[MyCreditsListController alloc]init];
            [weakSelf.navigationController pushViewController:myCrditsVC animated:YES];
        };
    }
    return _listHeaderView;
}
-(UITableView *)listTableView{
    if (!_listTableView) {
        _listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH)];
        _listTableView.dataSource = self;
        _listTableView.delegate = self;
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableView.tableHeaderView = self.listHeaderView;
        _listTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _listTableView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
        _listTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [_listTableView registerClass:[YWTTaskCenterUnStartedCell class] forCellReuseIdentifier:TASKCENTERUNSTARTED_CELL];
        [_listTableView registerClass:[YWTTaskCenterCompleteCell class] forCellReuseIdentifier:TASKCENTERCOMPLETE_CELL];
        // 添加空白页
        [_listTableView addSubview:self.showNoSoucreView];
        
        if (@available(iOS 11.0, *)) {
            _listTableView.estimatedRowHeight = 0;
            _listTableView.estimatedSectionFooterHeight = 0;
            _listTableView.estimatedSectionHeaderHeight = 0 ;
            _listTableView.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        // 刷新
        __weak typeof(self) weakSelf = self;
        [_listTableView bindGlobalStyleForHeadRefreshHandler:^{
            weakSelf.page = 1;
            [weakSelf requestServiceApiTaskList];
            // 请求人员信息
            [weakSelf requestTaskUserDetails];
        }];

        [_listTableView bindGlobalStyleForFootRefreshHandler:^{
            weakSelf.page ++;
            [weakSelf requestServiceApiTaskList];

        }];
    }
    return _listTableView;
}
-(YWTLockTaskStatuPromptView *)lockTaskStatuView{
    if (!_lockTaskStatuView) {
        _lockTaskStatuView = [[YWTLockTaskStatuPromptView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH)];
    }
    return _lockTaskStatuView;
}
-(YWTShowNoSourceView *)showNoSoucreView{
    if (!_showNoSoucreView) {
        _showNoSoucreView = [[YWTShowNoSourceView alloc]initWithFrame:CGRectMake(0, KSIphonScreenH(245), KScreenW, KScreenH-KSTabbarH-KSIphonScreenH(245))];
        _showNoSoucreView.showMarkLab.text = @"暂无任务";
    }
    return _showNoSoucreView;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(void)setModuleNameStr:(NSString *)moduleNameStr{
    _moduleNameStr = moduleNameStr;
}
-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
}
#pragma mark -- 数据处理 ------
// 请求人员信息
-(void) requestTaskUserDetails{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPSERVICEAPIMYTASKUSERDETAILS_URL params:param withModel:nil waitView:nil complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if ([showdata isKindOfClass:[NSDictionary class]]) {
            //  更新用户信息
            [self.listHeaderView updateUserDataInfo:showdata];
        }
    }];
}
// 任务列表
-(void) requestServiceApiTaskList{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"page"] = [NSNumber numberWithInteger:self.page];
    param[@"tagId"] = self.tagIdStr;
    param[@"title"] = self.titleStr;
    param[@"taskStatus"] = self.taskStatusStr;
    [[KRMainNetTool sharedKRMainNetTool]postRequstWith:HTTP_ATTAPPSERVICEAPIMYTASKLIST_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        [self.listTableView.headRefreshControl endRefreshing];
        [self.listTableView.footRefreshControl endRefreshing];
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if ([showdata isKindOfClass:[NSArray class]]) {
            if (self.page == 1) {
                [self.dataArr removeAllObjects];
            }
            NSArray *arr = (NSArray *) showdata;
            if (arr.count == 0) {
                // 判断是否显示空白页
                if (self.dataArr.count > 0) {
                    self.showNoSoucreView.hidden = YES;
                }else{
                    self.showNoSoucreView.hidden = NO;
                }
                // 刷新数据源
                [self reloadData];
                return;
            }
            for (NSDictionary *dict in arr) {
                TaskCenterListModel *model = [TaskCenterListModel yy_modelWithDictionary:dict];
                [self.dataArr addObject:model];
            }
            // 判断是否显示空白页
            if (self.dataArr.count > 0) {
                self.showNoSoucreView.hidden = YES;
            }else{
                self.showNoSoucreView.hidden = NO;
            }
            // 刷新数据源
            [self reloadData];
        }
    }];
}




@end
