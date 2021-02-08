//
//  TaskCenterDetailController.m
//  PartyBuildingStar
//
//  Created by mac on 2019/4/19.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import "YWTTaskCenterDetailController.h"

#import "YWTTaskCenterDetailHeaderView.h"
#import "YWTTaskMarkPromptView.h"
#import "YWTlibayExerciseController.h"
#import "YWTExamPaperListController.h"
#import "YWTExamPaperExerciseController.h"
#import "YWTBaseShowListController.h"
#import "YWTAttendanceChenkController.h"
#import "YWTBaseTableViewController.h"
#import "YWTMyStudiesController.h"
#import "YWTPartyMemberAreaListController.h"
#import "YWTQuestionnaireListController.h"
#import "YWTSubmitSuggestionController.h"

#import "YWTTaskCenterDetailTableCell.h"
#define TASKCENTERDETAILTABLE_CELL @"YWTTaskCenterDetailTableCell"

@interface YWTTaskCenterDetailController ()
<
UITableViewDelegate,
UITableViewDataSource
>
// 任务说明更多view
@property (nonatomic,strong) YWTTaskMarkPromptView *taskMarkPrompteView;

@property (nonatomic,strong) UITableView *detaTableView;

@property (nonatomic,strong) NSMutableArray *dataArr;
// 总数据源
@property (nonatomic,strong) NSMutableDictionary *dataDict;
@end

@implementation YWTTaskCenterDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [self setNavi];
    [self.view insertSubview:self.detaTableView atIndex:0];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestTaskChildListData];
}
#pragma mark --- UITableViewDataSource--------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.dataArr[section];
    return arr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWTTaskCenterDetailTableCell *cell = [tableView dequeueReusableCellWithIdentifier:TASKCENTERDETAILTABLE_CELL forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // 1是可以做 2是不可做任务
    cell.canDoStr = [NSString stringWithFormat:@"%@",self.dataDict[@"canDo"]];\
    cell.indexPath = indexPath;
    NSArray *arr = self.dataArr[indexPath.section];
    NSDictionary *dict = arr[indexPath.row];
    cell.dict = dict;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr = self.dataArr[indexPath.section];
    NSDictionary *dict = arr[indexPath.row];
    return [YWTTaskCenterDetailTableCell getWithDetailHeightCellDict:dict];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    YWTTaskCenterDetailHeaderView *headerView = [[YWTTaskCenterDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 300)];
    // 点击更多按钮
    __weak typeof(self) weakSelf = self;
    headerView.dict = [self.dataDict copy];
    // 点击更多按钮
    headerView.selectMarkMany = ^{
        [weakSelf.view addSubview:weakSelf.taskMarkPrompteView];
        NSString *descriptionStr = [NSString stringWithFormat:@"%@",weakSelf.dataDict[@"description"]];
        NSAttributedString *attrStr = [[NSAttributedString alloc]initWithData:[descriptionStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:[UIFont boldSystemFontOfSize:12]} documentAttributes:nil error:nil];
        weakSelf.taskMarkPrompteView.taskMarkTextView.attributedText = attrStr;
    };
    // 点前置任务
    headerView.selectPariTap = ^{
         // 前置任务id
        weakSelf.taskvarIdStr = [NSString stringWithFormat:@"%@",weakSelf.dataDict[@"relatedtaskid"]];
        // 重新请求
        [weakSelf requestTaskChildListData];
    };
    
    return  headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [YWTTaskCenterDetailHeaderView getWithTaskDetailHeaderHeight:self.dataDict];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr = self.dataArr[indexPath.section];
    NSDictionary *dict = arr[indexPath.row];
    //1是可以做 2是不可做任务
    NSString *canDoStr = [NSString stringWithFormat:@"%@",self.dataDict[@"canDo"]];
    if ([canDoStr isEqualToString:@"2"]) {
        return;
    }
    // 1可做 2不可做
    NSString *carryOutStr = [NSString stringWithFormat:@"%@",dict[@"carryOut"]];
    if ([carryOutStr isEqualToString:@"2"]) {
        return ;
    }
    // 任务需要跳得模块名称
    NSString *modeNameStr = [NSString stringWithFormat:@"%@",dict[@"modeName"]];
    // 搜索条件
    NSString *resourceNameStr = [NSString stringWithFormat:@"%@",dict[@"resourceName"]];
    if ([modeNameStr isEqualToString:@"libayExercise"]) {
        // 题库练习
        YWTlibayExerciseController *libayExerVC = [[YWTlibayExerciseController alloc]init];
        libayExerVC.titleStr = resourceNameStr;
        // app模块名【可能为空】
        libayExerVC.moduleNameStr = @"题库练习";
        libayExerVC.resourceIdStr = [NSString stringWithFormat:@"%@",dict[@"resourceId"]];
        [self.navigationController pushViewController:libayExerVC animated:YES];
    }else if ([modeNameStr isEqualToString:@"examPaper"]){
        // 模拟考试
        YWTExamPaperListController *examPaperVC = [[YWTExamPaperListController alloc]init];
        examPaperVC.titleStr =resourceNameStr;
        examPaperVC.resourceIdStr = [NSString stringWithFormat:@"%@",dict[@"resourceId"]];
        examPaperVC.taskIdStr = [NSString stringWithFormat:@"%@",dict[@"taskid"]];
        [self.navigationController pushViewController:examPaperVC animated:YES];
    }else if ([modeNameStr isEqualToString:@"examCenter"]){
        // 正式考试
        YWTExamPaperExerciseController *examPaperExerVC = [[YWTExamPaperExerciseController alloc]init];
        [self.navigationController pushViewController:examPaperExerVC animated:YES];
        
    }else if ([modeNameStr isEqualToString:@"myStudies"]){
        // 我的学习
        YWTMyStudiesController *myStudiesVC = [[YWTMyStudiesController alloc]init];
        myStudiesVC.moduleNameStr = @"我的学习";
        myStudiesVC.titleStr =resourceNameStr;
        myStudiesVC.resourceIdStr = [NSString stringWithFormat:@"%@",dict[@"resourceId"]];
        myStudiesVC.taskIdStr = [NSString stringWithFormat:@"%@",dict[@"taskid"]];
        [self.navigationController pushViewController:myStudiesVC animated:YES];
    }else if ([modeNameStr isEqualToString:@"riskDisplay"] ){
        // 风险展示  曝光台
        YWTBaseShowListController *showListVC = [[YWTBaseShowListController alloc]init];
        showListVC.listType = showControllerRiskListType;
        [self.navigationController pushViewController:showListVC animated:YES];
    }else if ([modeNameStr isEqualToString:@"exposureStation"]){
        // 曝光台
        YWTBaseShowListController *showListVC = [[YWTBaseShowListController alloc]init];
        showListVC.listType = showControllerExposureListType;
        [self.navigationController pushViewController:showListVC animated:YES];
        
    }else if ([modeNameStr isEqualToString:@"securityCheck"]){
        // 安全检查
        YWTBaseTableViewController *baseVC = [[YWTBaseTableViewController alloc]init];
        baseVC.veiwBaseType =  showViewControllerSafetyType;
        baseVC.scoureType =  showBaseAddSoucreType;
        baseVC.taskIdStr = [NSString stringWithFormat:@"%@",dict[@"taskid"]];
        // app模块名【可能为空】
        baseVC.moduleNameStr = [NSString stringWithFormat:@"%@",dict[@"appName"]];
        [self.navigationController pushViewController:baseVC animated:YES];
    }else if ([modeNameStr isEqualToString:@"classRecord"] ){
        // 班会记录
        YWTBaseTableViewController *baseVC = [[YWTBaseTableViewController alloc]init];
        baseVC.veiwBaseType =  showViewControllerMeetingType;
        baseVC.scoureType =  showBaseAddSoucreType;
        baseVC.taskIdStr = [NSString stringWithFormat:@"%@",dict[@"taskid"]];
        // app模块名【可能为空】
        baseVC.moduleNameStr = [NSString stringWithFormat:@"%@",dict[@"appName"]];
        [self.navigationController pushViewController:baseVC animated:YES];
    }else if ([modeNameStr isEqualToString:@"technicalDisclosure"] ){
        // 技术交底
        YWTBaseTableViewController *baseVC = [[YWTBaseTableViewController alloc]init];
        baseVC.veiwBaseType =  showViewControllerTechnoloType;
        baseVC.scoureType =  showBaseAddSoucreType;
        // app模块名【可能为空】
        baseVC.moduleNameStr = [NSString stringWithFormat:@"%@",dict[@"appName"]];
        baseVC.taskIdStr = [NSString stringWithFormat:@"%@",dict[@"taskid"]];
        [self.navigationController pushViewController:baseVC animated:YES];
    }else if ([modeNameStr isEqualToString:@"violationHan"]){
        // 违章处理
        YWTBaseTableViewController *baseVC = [[YWTBaseTableViewController alloc]init];
        baseVC.veiwBaseType =  showViewControllerViolationType;
        baseVC.scoureType =  showBaseAddSoucreType;
        baseVC.taskIdStr = [NSString stringWithFormat:@"%@",dict[@"taskid"]];
        // app模块名【可能为空】
        baseVC.moduleNameStr = [NSString stringWithFormat:@"%@",dict[@"appName"]];
        [self.navigationController pushViewController:baseVC animated:YES];
    }else if ([modeNameStr isEqualToString:@"attendanceAtte"]){
        // 考勤签到
        YWTAttendanceChenkController *attendanceVC = [[YWTAttendanceChenkController alloc]init];
        // app模块名【可能为空】
        attendanceVC.moduleNameStr = [NSString stringWithFormat:@"%@",dict[@"appName"]];
        attendanceVC.taskIdStr = [NSString stringWithFormat:@"%@",dict[@"taskid"]];
        [self.navigationController pushViewController:attendanceVC animated:YES];
    }else if ([modeNameStr isEqualToString:@"activityarea"]){
           // 党员g活动区
           YWTPartyMemberAreaListController *areaListVC = [[YWTPartyMemberAreaListController alloc]init];
           // app模块名【可能为空】
           areaListVC.moduleNameStr = [NSString stringWithFormat:@"%@",dict[@"appName"]];
           areaListVC.listType = partyAreaListOtherType;
           areaListVC.taskIdStr = [NSString stringWithFormat:@"%@",dict[@"taskid"]];
           [self.navigationController pushViewController:areaListVC animated:YES];
    }else if ([modeNameStr isEqualToString:@"questionnaire"]){
           // 问卷调查
           YWTQuestionnaireListController *questListVC = [[YWTQuestionnaireListController alloc]init];
           questListVC.taskIdStr = [NSString stringWithFormat:@"%@",dict[@"taskid"]];
           [self.navigationController pushViewController:questListVC animated:YES];
    }else if ([modeNameStr isEqualToString:@"suggestionbox"]){
           // 意见箱
           YWTSubmitSuggestionController *submitSuggestinVC = [[YWTSubmitSuggestionController alloc]init];
            submitSuggestinVC.taskIdStr = [NSString stringWithFormat:@"%@",dict[@"taskid"]];
           [self.navigationController pushViewController:submitSuggestinVC animated:YES];
    }else{
        [self.view showErrorWithTitle:@"找不到模块!" autoCloseTime:0.5];
    }
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
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:0];
    
    self.customNavBar.title = @"任务详情";
    
    __weak typeof(self) weakSelf = self;
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}
#pragma mark --- get 方法 --------
-(UITableView *)detaTableView{
    if (!_detaTableView) {
        _detaTableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH) style:UITableViewStyleGrouped];
        _detaTableView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
        _detaTableView.delegate = self;
        _detaTableView.dataSource = self;
        _detaTableView.bounces = NO;
        _detaTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
        _detaTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        [_detaTableView registerClass:[YWTTaskCenterDetailTableCell class] forCellReuseIdentifier:TASKCENTERDETAILTABLE_CELL];
        if (@available(iOS 11.0, *)) {
            _detaTableView.estimatedRowHeight = 0;
            _detaTableView.estimatedSectionFooterHeight = 0;
            _detaTableView.estimatedSectionHeaderHeight = 0 ;
            _detaTableView.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _detaTableView;
}
-(YWTTaskMarkPromptView *)taskMarkPrompteView{
    if (!_taskMarkPrompteView) {
        _taskMarkPrompteView = [[YWTTaskMarkPromptView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH)];
    }
    return _taskMarkPrompteView;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(NSMutableDictionary *)dataDict{
    if (!_dataDict) {
        _dataDict = [NSMutableDictionary dictionary];
    }
    return _dataDict;
}
-(void)setTaskvarIdStr:(NSString *)taskvarIdStr{
    _taskvarIdStr = taskvarIdStr;
}
#pragma mark   子任务列表 ----
-(void) requestTaskChildListData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"taskvarid"] = self.taskvarIdStr;
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPSERVICEAPIMYTASKTASKCHILDLIST_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if ([showdata isKindOfClass:[NSDictionary class]]) {
            NSString *codeStr = [NSString stringWithFormat:@"%@",showdata[@"code"]];
            if ([codeStr isEqualToString:@"2"]) {
                [self.view showErrorWithTitle:@"无法查看该任务，请联系管理员!" autoCloseTime:1];
                return;
            }
            // 移除数据源
            [self.dataDict removeAllObjects];
            [self.dataArr removeAllObjects];
            
            // 总赋值
            [self.dataDict addEntriesFromDictionary:showdata];
            //
            NSArray *arr =(NSArray *) showdata[@"child"];
            [self.dataArr addObject:arr];
            
            [self.detaTableView reloadData];
        }
    }];
}





@end
