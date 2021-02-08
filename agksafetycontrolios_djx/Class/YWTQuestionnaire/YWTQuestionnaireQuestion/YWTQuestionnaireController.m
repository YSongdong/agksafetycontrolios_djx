//
//  YWTQuestionnaireController.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/17.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTQuestionnaireController.h"

#import "YWTQuestResultController.h"

#import "YWTTempExamQuestView.h"
#import "YWTQuestBottomToolView.h"
#import "YWTShowSubmitExamView.h"

@interface YWTQuestionnaireController ()
<
SZPageControllerDataSource,
SZPageControllerDelegate,
YWTQuestBottomToolViewDelegate
>
// 提示提交试卷view
@property (nonatomic,strong) YWTShowSubmitExamView *showSubmitExamView;
// 工具view
@property (nonatomic,strong) YWTQuestBottomToolView *bottomToolView;
// 控件
@property (nonatomic, weak) SZPageController *pageController;
// 数据源
@property (nonatomic,strong) NSMutableArray *dataArr;
// 记录当前题型
@property (nonatomic,strong) NSString *questType;
// 记录当前数据源的下标
@property (nonatomic,assign) NSInteger currentIndex;
@end

@implementation YWTQuestionnaireController

- (void)viewDidLoad {
    [super viewDidLoad];
    // App不息屏
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    self.questType = @"";
    // 设置导航栏
    [self setNavi];
    // 创建考试控件
    [self createPageConteroller];
    // 工具view
    [self createBottomToolView];
    // 请求题
    [self requestGeneratePaper];
}
#pragma mark ---- SZPageControllerDataSource ---------
- (NSInteger)numberOfPagesInPageController:(SZPageController *)pageController {
    return self.dataArr.count;
}
- (UIView *)pageController:(SZPageController *)pageController viewForIndex:(NSInteger)index {
    YWTTempExamQuestView *questView = [[YWTTempExamQuestView alloc] init];
    QuestionListModel *model = self.dataArr[index];
    questView.nowQuestNumberStr = [NSString stringWithFormat:@"%ld",(long)index];
    questView.questMode = tempExamQuestAnswerMode ;
    //    // 题型切换提示框
    //    [self createQuestTypeView:model];
    //  答题类型
    if ([model.typeId isEqualToString:@"1"]) {
        // 单选
        questView.questType = tempExamQuestSingleSelectType;
        // 记录题类型
        self.questType = @"1";
    }else if ([model.typeId isEqualToString:@"2"]){
        // 多选
        questView.questType = tempExamQuestMultipleSelectType;
        // 记录题类型
        self.questType = @"2";
    }else if ([model.typeId isEqualToString:@"3"]){
        // 判断
        questView.questType = tempExamQuestJudgmentType;
        // 记录题类型
        self.questType = @"3";
    }else if ([model.typeId isEqualToString:@"5"]){
        // 填空'
        questView.questType = tempExamQuestFillingType;
        // 记录题类型
        self.questType = @"5";
    }else if ([model.typeId isEqualToString:@"6"] || [model.typeId isEqualToString:@"4"]){
        //主观'
        questView.questType = tempExamQuestThemeType;
        // 记录题类型
        self.questType = @"6";
    }
    // 数据源
    questView.tempQuestModel =  model;
    
    if (self.dataArr.count-1 == index) {
        [self.bottomToolView.nextQuestBtn setTitle:@" 提交" forState:UIControlStateNormal];
        [self.bottomToolView.nextQuestBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
        [self.bottomToolView.nextQuestBtn setTitleColor:[[UIColor colorLineCommonBlueColor]colorWithAlphaComponent:0.8] forState:UIControlStateHighlighted];
        [self.bottomToolView.nextQuestBtn setImage:[UIImage imageNamed:@"suggetion_quest_submitNormal"] forState:UIControlStateNormal];
        [self.bottomToolView.nextQuestBtn setImage:[UIImage imageNamed:@"suggetion_quest_submitSelect"] forState:UIControlStateHighlighted];
    }else{
        [self.bottomToolView.nextQuestBtn setTitle:@" 下一题" forState:UIControlStateNormal];
        [self.bottomToolView.nextQuestBtn setTitleColor:[UIColor colorCommonBlackColor] forState:UIControlStateNormal];
        [self.bottomToolView.nextQuestBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateHighlighted];
        [self.bottomToolView.nextQuestBtn setImage:[UIImage imageNamed:@"sjlx_tab_ico_04"] forState:UIControlStateNormal];
        [self.bottomToolView.nextQuestBtn setImage:[UIImage imageNamed:@"tab_exam_right_sel_2"] forState:UIControlStateHighlighted];
    }
    return questView;
}

#pragma mark --- SZPageControllerDelegate -----
//  当前显示的View
- (void)pageController:(SZPageController *)pageController currentView:(UIView *)currentView currentIndex:(NSInteger)currentIndex {
    self.currentIndex = currentIndex;
}
- (void)pageControllerSwitchToLastDisabled:(SZPageController *)pageController {
    [self.view showErrorWithTitle:@"当前已是第一题" autoCloseTime:0.5];
}
- (void)pageControllerSwitchToNextDisabled:(SZPageController *)pageController {
    [self.view showErrorWithTitle:@"当前已是最后一题" autoCloseTime:0.5];
}
#pragma mark ---创建底部工具View--------
-(void) createBottomToolView{
    [self.view addSubview:self.bottomToolView];
    self.bottomToolView.delegate = self;
}
/* -------- YWTQuestBottomToolViewDelegate -------*/
// 上一题
-(void) selectBottomLastQuest{
    [self.pageController switchToLastAnimated:YES];
    if (self.currentIndex == 0) {
        [self.view showErrorWithTitle:@"当前已是第一题" autoCloseTime:0.5];
    }
}
// 下一题
-(void) selectBottomNextQuest{
    if (self.dataArr.count == self.currentIndex+1) {
        self.showSubmitExamView = [[YWTShowSubmitExamView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH)];
        [self.view addSubview:self.showSubmitExamView];
        WS(weakSelf);
        self.showSubmitExamView.submitExamBlock = ^{
            // 立即交卷
            [weakSelf requestSubmitPaperAnswer];
        };
    }else{
        [self.pageController switchToNextAnimated:YES];
    }
}
#pragma mark ---创建考试控件--------
-(void)createPageConteroller{
    SZPageController *pageVC = [[SZPageController alloc] init];
    pageVC.dataSource = self;
    pageVC.delegate = self;
    pageVC.switchTapEnabled = NO;
    pageVC.circleSwitchEnabled = NO;
    pageVC.contentModeController = NO;
    [self.view insertSubview:pageVC.view atIndex:0];
    [self addChildViewController:pageVC];
    self.pageController = pageVC;
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    self.customNavBar.title = @"问卷调查";
    
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    __weak typeof(self) weakSelf = self;
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}
#pragma mark --- 懒加载 --------
-(YWTQuestBottomToolView *)bottomToolView{
    if (!_bottomToolView) {
        _bottomToolView = [[YWTQuestBottomToolView alloc]initWithFrame:CGRectMake(0, KScreenH-KSTabbarH-KSIphonScreenH(50), KScreenW, KSIphonScreenH(50))];
    }
    return _bottomToolView;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(void)setPaperId:(NSString *)paperId{
    _paperId = paperId;
}
-(NSArray *) newAssemblyNSArry:(NSArray *)showdataArr{
    NSMutableArray *dataSource  = [NSMutableArray array];
    // 1单选
    NSMutableArray *singleArr = [NSMutableArray array];
    // 2多选
    NSMutableArray *moreArr = [NSMutableArray array];
    // 3判断
    NSMutableArray *judgeArr = [NSMutableArray array];
    // 4：问答题
    NSMutableArray *essayQuestionArr = [NSMutableArray array];
    // 5填空题
    NSMutableArray *gapFillingArr = [NSMutableArray array];
    // 6主观题
    NSMutableArray *subjectivityArr = [NSMutableArray array];
    for (NSDictionary *dict in showdataArr) {
        NSString *typeIdStr = [NSString stringWithFormat:@"%@",dict[@"typeId"]];
        if ([typeIdStr isEqualToString:@"1"]) {
            [singleArr addObject:dict];
        }else if ([typeIdStr isEqualToString:@"2"]){
            [moreArr addObject:dict];
        }else if ([typeIdStr isEqualToString:@"3"]){
            [judgeArr addObject:dict];
        }else if ([typeIdStr isEqualToString:@"4"]){
            [essayQuestionArr addObject:dict];
        }else if ([typeIdStr isEqualToString:@"5"]){
            [gapFillingArr addObject:dict];
        }else if ([typeIdStr isEqualToString:@"6"]){
            [subjectivityArr addObject:dict];
        }
    }
    if (singleArr.count > 0) {
        [dataSource addObjectsFromArray:singleArr];
    }
    if (moreArr.count > 0) {
        [dataSource addObjectsFromArray:moreArr];
    }
    if (judgeArr.count > 0) {
        [dataSource addObjectsFromArray:judgeArr];
    }
    if (essayQuestionArr.count > 0) {
        [dataSource addObjectsFromArray:essayQuestionArr];
    }
    if (gapFillingArr.count > 0) {
        [dataSource addObjectsFromArray:gapFillingArr];
    }
    if (subjectivityArr.count > 0) {
        [dataSource addObjectsFromArray:subjectivityArr];
    }
    return dataSource;
}
-(void)setTaskIdStr:(NSString *)taskIdStr{
    _taskIdStr = taskIdStr;
}
#pragma mark ---- 数据相关 ----
-(void) requestGeneratePaper{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"userId"] = [YWTUserInfo obtainWithUserId];
    param[@"paperId"] = self.paperId;
    //获取本地软件的版本号
    NSString *localVersion =  [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    param[@"appVersion"] = localVersion;
    // 手机系统版本
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    // 手机型号
    NSString *phoeModel = [YWTTools deviceModelName];
    NSString *systemVersionStr = [NSString stringWithFormat:@"%@-%@",phoeModel,phoneVersion];
    param[@"systemVersion"] = systemVersionStr;
    param[@"terminal"] = [NSNumber numberWithInteger:1];
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTSERICEAPIGENERATEPAPER_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if (![showdata isKindOfClass:[NSDictionary class]]) {
            return;
        }
        // 添加到本地存储数据
        NSArray *dataSourceArr = [self newAssemblyNSArry:showdata[@"data"]];
        [[DataBaseManager sharedManager]saveQusetAlls:dataSourceArr];
        
        if (dataSourceArr.count == 0) {
            [self.view showErrorWithTitle:@"系统错误返回重新进入!" autoCloseTime:2];
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        for (NSDictionary *dict in dataSourceArr ) {
            QuestionListModel *model = [QuestionListModel yy_modelWithDictionary:dict];
            [self.dataArr addObject:model];
        }
        [self.pageController reloadData];
    }];
}
// 问卷调查完全提交
-(void) requestSubmitPaperAnswer{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"paperid"] = self.paperId;
    param[@"token"] = [YWTTools getNewToken];
    //获取本地软件的版本号
    NSString *localVersion =  [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    param[@"appVersion"] = localVersion;
    // 手机系统版本
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    // 手机型号
    NSString *phoeModel = [YWTTools deviceModelName];
    NSString *systemVersionStr = [NSString stringWithFormat:@"%@-%@",phoeModel,phoneVersion];
    param[@"systemVersion"] = systemVersionStr;
    param[@"terminal"] = [NSNumber numberWithInteger:1];
    NSArray *answerArr = [[DataBaseManager sharedManager]selectAllApps];
    NSMutableArray *userAnswerArr = [NSMutableArray array];
    for (NSDictionary *dict in answerArr) {
        NSMutableDictionary *userDict = [NSMutableDictionary dictionary];
        userDict[@"id"] = dict[@"questId"];
        userDict[@"answer"] = dict[@"userAnswer"];
        [userAnswerArr addObject:userDict];
    }
    // 任务id
    param[@"taskid"] = self.taskIdStr;
    // 转换成json数组的字符串
    NSString *answerJsonStr = [YWTTools convertToJsonData:userAnswerArr];
    param[@"answer"] = answerJsonStr;
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTSERICEAPISUBIMTPAPERANSWER_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if ([showdata isKindOfClass:[NSDictionary class]]) {
            NSString *idStr = [NSString stringWithFormat:@"%@",showdata[@"id"]];
            // 删除数据
            [[DataBaseManager sharedManager]deleteAll];
            
            YWTQuestResultController *resultVC = [[YWTQuestResultController alloc]init];
            resultVC.idStr = idStr;
            [self.navigationController pushViewController:resultVC animated:YES];
        }
        
    }];
}

@end
