//
//  ExamQuestionController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/17.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTExamQuestionController.h"

#import "YWTExamScoreViewController.h"

#import "YWTExamQuestNaviTitleView.h"
#import "YWTExamQuestBottomToolView.h"
#import "YWTTempExamQuestView.h"
#import "YWTExamAnswerRecordCardView.h"
#import "YWTExamQuestSettingView.h"
#import "YWTShowQuestTypeSwitchView.h"

#import "TempDetailQuestionModel.h"
#import "YWTShowSubmitExamView.h"
#import "YWTShowCountDownView.h"
#import "YWTShowVerifyIdentidyErrorView.h"

@interface YWTExamQuestionController ()
<
SZPageControllerDataSource,
SZPageControllerDelegate
>
// 导航栏 title view
@property (nonatomic,strong) YWTExamQuestNaviTitleView *naviTitleView;
// 底部工具view
@property (nonatomic,strong) YWTExamQuestBottomToolView *bottomToolView;
// 答题卡view
@property (nonatomic,strong) YWTExamAnswerRecordCardView *answerCardView;
// 设置 view
@property (nonatomic,strong) YWTExamQuestSettingView *questSettingView;
// 提示提交试卷view
@property (nonatomic,strong) YWTShowSubmitExamView *showSubmitExamView;
// 时间提示框
@property (nonatomic,strong) YWTShowCountDownView *showCountDownView;
// 验证失败view
@property (nonatomic,strong)YWTShowVerifyIdentidyErrorView *showVeriIndeErrorView;
// 提示框
@property (nonatomic,strong) YWTShowServicePromptView *serviceView;
// 题型切换提示框
@property (nonatomic,strong) YWTShowQuestTypeSwitchView *showQuestTypeView;
// 控件
@property (nonatomic, weak) SZPageController *pageController;
// 数据源
@property (nonatomic,strong) NSMutableArray *dataArr;
// 是否显示答题卡  YES 显示 NO 不显示
@property (nonatomic,assign) BOOL showAnswerCard;
// 详情MOdel
@property (nonatomic,strong) TempDetailQuestionModel *detailQuestModel;
// 记录当前数据源的下标
@property (nonatomic,assign) NSInteger currentIndex;
// 记录是否有home 规则 YES 有 NO
@property (nonatomic,assign) BOOL isAlwayMotion;
// 记录是否有考试中随机 规则 YES 有 NO
@property (nonatomic,assign) BOOL isRandomMotion;
// 记录是否有交卷验证 规则 YES 有 NO
@property (nonatomic,assign) BOOL isEndMotion;
// 1启用监控 2不启用监控
@property (nonatomic,strong) NSString *monitorStr;
// 记录按下home次数
@property (nonatomic,assign) NSInteger alwaysNumber;
// 记录考试规则中随机次数数组
@property (nonatomic,strong) NSMutableArray *recordRandomArr;
// 记录人脸验证规则状态
@property (nonatomic,strong) NSString *faceMotionStatu;
// 记录当前题型
@property (nonatomic,strong) NSString *questType;
// 记录当前人脸规则字典
@property (nonatomic,strong) NSDictionary *nowMotionDict;

@end

@implementation YWTExamQuestionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // App不息屏
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    // 设置导航栏
    [self setNavi];
    self.showAnswerCard = NO;
    self.alwaysNumber = 0;
    self.faceMotionStatu = @"";
    self.isAlwayMotion = NO;
    self.isRandomMotion = NO;
    self.isEndMotion =  NO;
    self.questType = @"";
    // 创建底部工具View
    [self createBottomToolView];
    // 创建考试控件
    [self createPageConteroller];
    //  判断有没有规则
    [self createFaceVierMonitor];
    // 请求试卷题
    [self requestQuestData];
    //app从后台推到前台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterBackgound)name:UIApplicationDidEnterBackgroundNotification object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterFore) name:UIApplicationWillEnterForegroundNotification object:[UIApplication sharedApplication]];
    // 服务器发起强制交卷
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(serviceSubimtExamPaper:)name:@"ServiceSubmitExamPaper" object:nil];
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
#pragma mark ---- SZPageControllerDataSource ---------
- (NSInteger)numberOfPagesInPageController:(SZPageController *)pageController {
    return self.dataArr.count;
}
- (UIView *)pageController:(SZPageController *)pageController viewForIndex:(NSInteger)index {
    YWTTempExamQuestView *questView = [[YWTTempExamQuestView alloc] init];
    QuestionListModel *model = self.dataArr[index];
    questView.nowQuestNumberStr = [NSString stringWithFormat:@"%ld",(long)index];
    // 答题模式
    if (self.controllerQuestMode == controllerExamQuestAnswerMode) {
        questView.questMode = tempExamQuestAnswerMode ;
    }else{
        questView.questMode = tempExamQuestDetailMode ;
    }
    // 题型切换提示框
    [self createQuestTypeView:model];
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
    
    // 判断是否有人脸规则
    if (self.isRandomMotion) {
        if ([self.recordRandomArr containsObject:[NSNumber numberWithInteger:index]]) {
            [self passRulesConductFaceVeri:[self createFaveVerificationStr:@"random"]];
            self.faceMotionStatu = @"random";
            // 从随机次数中移除识别过的随机数
            [self.recordRandomArr removeObject:[NSNumber numberWithInteger:index]];
        }
    }
    return questView;
}
#pragma mark --- SZPageControllerDelegate -----
//  当前显示的View
- (void)pageController:(SZPageController *)pageController currentView:(UIView *)currentView currentIndex:(NSInteger)currentIndex {
    //请求提交答案
    [self requestPaperRecordData];
    self.currentIndex = currentIndex;
}
- (void)pageControllerSwitchToLastDisabled:(SZPageController *)pageController {
    [self.view showErrorWithTitle:@"当前已是第一题" autoCloseTime:0.5];
}
- (void)pageControllerSwitchToNextDisabled:(SZPageController *)pageController {
    [self.view showErrorWithTitle:@"当前已是最后一题" autoCloseTime:0.5];
}
#pragma mark ---创建题型切换提示框-------
-(void) createQuestTypeView:(QuestionListModel *)questModel{
    // 第一次，直接返回
    if ([self.questType isEqualToString:@""]) {
        return;
    }
    if (![self.questType isEqualToString:questModel.typeId]) {
        [self.view addSubview:self.showQuestTypeView];
        NSString *contentStr;
        if ([questModel.typeId isEqualToString:@"1"]) {
            contentStr = @"单选题";
        }else if ([questModel.typeId isEqualToString:@"2"]){
            contentStr = @"多选题";
        }else if ([questModel.typeId isEqualToString:@"3"]){
            contentStr = @"判断题";
        }else if ([questModel.typeId isEqualToString:@"5"]){
            contentStr = @"填空题";
        }else if ([questModel.typeId isEqualToString:@"6"]){
            contentStr = @"主观题";
        }
        self.showQuestTypeView.showContentLab.text = [NSString stringWithFormat:@"您已进入%@!",contentStr];
      
        __weak typeof(self) weakSelf = self;
        // 移除视图
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.showQuestTypeView removeFromSuperview];
        });
    }
}
#pragma mark ---创建底部工具View--------
-(void) createBottomToolView{
    [self.view addSubview:self.bottomToolView];
    __weak typeof(self) weakSelf = self;
    // 上一题
    self.bottomToolView.lastQuestBlock = ^{
        [weakSelf.pageController switchToLastAnimated:YES];
        if (weakSelf.currentIndex == 0) {
            [weakSelf.view showErrorWithTitle:@"当前已是第一题" autoCloseTime:0.5];
        }
    };
    // 答题卡
    self.bottomToolView.answerCardBlock = ^{
        weakSelf.answerCardView = [[YWTExamAnswerRecordCardView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH)];
        [weakSelf.view addSubview:weakSelf.answerCardView];
        // 获取当前题id
        QuestionListModel *model = weakSelf.dataArr[weakSelf.currentIndex];
        weakSelf.answerCardView.questId = model.Id;
        //赋值
        weakSelf.answerCardView.sourceArr = weakSelf.dataArr.copy;
        
        __weak typeof(weakSelf) strongSelf = weakSelf;
        // 选中题方法
        weakSelf.answerCardView.selectQuetionBlock = ^(NSString * _Nonnull questId) {
            // 刷新到当前题
            [strongSelf getByQuestionId:questId];
            // 关闭答题卡view
            [strongSelf.answerCardView removeFromSuperview];
        };
    };
    // 设置
    self.bottomToolView.settingBlcok = ^{
        weakSelf.questSettingView = [[YWTExamQuestSettingView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH)];
        [weakSelf.view addSubview:weakSelf.questSettingView];
        weakSelf.questSettingView.refreshViewBlock = ^{
            //1、 移除视图
            [weakSelf.questSettingView removeFromSuperview];
            //2、 刷新视图
            YWTTempExamQuestView *questView =(YWTTempExamQuestView *) weakSelf.pageController.currentView;
            [questView refreshUI];
        };
    };
    // 下一题
    self.bottomToolView.nextQuestBlock = ^{
        [weakSelf.pageController switchToNextAnimated:YES];
        if (weakSelf.dataArr.count == weakSelf.currentIndex+1) {
            [weakSelf.view showErrorWithTitle:@"当前已是最后一题" autoCloseTime:0.5];
        }
        //请求提交答案
        [weakSelf requestPaperRecordData];
    };
}
#pragma mark ---通过questId 跳转到题--------
-(void) getByQuestionId:(NSString *)questId{
    __weak typeof(self) weakSelf = self;
    for (int i = 0 ; i< self.dataArr.count; i++) {
        QuestionListModel *model = self.dataArr[i];
        if ([questId isEqualToString:model.Id]) {
            [weakSelf.pageController  switchToIndex:i animated:YES];
            return;
        }
    }
}
#pragma mark --- ------设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    __weak typeof(self) weakSelf = self;
    // 添加titleView
    [self.customNavBar addSubview:self.naviTitleView];
    // 立即交卷
    self.naviTitleView.immedSubmitBlock = ^{
        weakSelf.showSubmitExamView = [[YWTShowSubmitExamView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH)];
        [weakSelf.view addSubview:weakSelf.showSubmitExamView];
        __weak typeof(weakSelf) strongSelf = weakSelf;
        weakSelf.showSubmitExamView.submitExamBlock = ^{
            // 判断是否有人脸规则
            if (strongSelf.isEndMotion) {
                [strongSelf passRulesConductFaceVeri:[strongSelf createFaveVerificationStr:@"end"]];
                strongSelf.faceMotionStatu = @"end";
            }else{
                // 立即交卷
                [strongSelf requestPaperAnswer];
            }
        };
    };
    // 弹3分钟提示框
    self.naviTitleView.bulletBoxBlock = ^{
        [weakSelf.view addSubview:weakSelf.showCountDownView];
        if (weakSelf.controllerExamType == controllerMockExamType ) {
            weakSelf.showCountDownView.contentLab.text = @"练习时间只剩最后3分钟了";
        }else{
            weakSelf.showCountDownView.contentLab.text = @"考试时间只剩最后3分钟了";
        }
    };
    // 到时间立即交卷
    self.naviTitleView.timeToBlock = ^{
        [weakSelf.view addSubview:weakSelf.showCountDownView];
        if (weakSelf.controllerExamType == controllerMockExamType ) {
            weakSelf.showCountDownView.contentLab.text = @"练习时间只剩最后3秒自动交卷";
            weakSelf.showCountDownView.countDownBtn.hidden = YES;
        }else{
            weakSelf.showCountDownView.contentLab.text = @"考试时间只剩最后3秒自动交卷";
            weakSelf.showCountDownView.countDownBtn.hidden = YES;
        }
        // 3秒自动交卷
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf requestPaperAnswer];
        });
    };
}
// 人脸采集成功回调方法
-(void)returnFaceSuccessImage:(NSDictionary *)dict{
    self.nowMotionDict = nil;
    self.nowMotionDict = dict;
    // 请求剩余时间
    [self requestPaperGetRemaTime];
    // 调人脸对比接口
    [self requestMonitorFaceRecogintion:dict[@"faceSuccess"] andRuleStr:dict[@"rule"]];
}
-(void)codeTimeOut{
    // 请求剩余时间
    [self requestPaperGetRemaTime];
    // 创建人脸失败view
    [self createShowVeriIndeErrorViewAndType:@"1"];
}
-(void)closeViewControll{
    // 请求剩余时间
    [self requestPaperGetRemaTime];
    // 创建人脸失败view
    [self createShowVeriIndeErrorViewAndType:@"1"];
}
// 判断有没有规则
-(void)createFaceVierMonitor{
    if (self.monitorRulesArr.count == 0) {
        return;
    }
    for (NSDictionary *dict in self.monitorRulesArr) {
        // 获取检测规则key
        NSString *ruleKeyStr = [NSString stringWithFormat:@"%@",dict[@"rule"]];
        // 检测使用home退出
        if ([ruleKeyStr isEqualToString:@"always"]) {
            self.isAlwayMotion = YES;
        }
        if ([ruleKeyStr  isEqualToString:@"random"]) {
            self.isRandomMotion = YES;
        }
        if ([ruleKeyStr  isEqualToString:@"end"]) {
            self.isEndMotion = YES;
        }
    }
    self.monitorRules = self.monitorRulesArr;
}
#pragma mark --- 创建验证失败的view --------
-(void) createShowVeriIndeErrorViewAndType:(NSString *)typeStr{
    __weak typeof(self) weakSelf = self;
    self.showVeriIndeErrorView = [[YWTShowVerifyIdentidyErrorView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH) andType:typeStr];
    [self.view addSubview:self.showVeriIndeErrorView];
    
    NSString *ruleStr = [NSString stringWithFormat:@"%@",weakSelf.nowMotionDict[@"rule"]];
    //如果是 考试中随机  不能取消
    if ([ruleStr isEqualToString:@"random"]) {
        // 点击蒙版可取消
        self.showVeriIndeErrorView.isColseBigBgView = YES;
    }
    
    // 再次验证
    self.showVeriIndeErrorView.againBtnBlock = ^{
        [weakSelf.showVeriIndeErrorView removeFromSuperview];
        [weakSelf passRulesConductFaceVeri:[weakSelf createFaveVerificationStr:weakSelf.faceMotionStatu]];
    };
    // 直接进入考试
    self.showVeriIndeErrorView.enterBtnBlcok = ^{
        [weakSelf.showVeriIndeErrorView removeFromSuperview];
        [weakSelf passRulesConductFaceVeri:[weakSelf createFaveVerificationStr:weakSelf.faceMotionStatu]];
    };
}
#pragma mark ----通知 ------------
//app从前台推到后台
-(void)enterBackgound{
    self.alwaysNumber += 1;
    if (self.isAlwayMotion) {
        NSDictionary *alwaysDict = [self createFaveVerificationStr:@"always"];
        if (self.alwaysNumber >= [alwaysDict[@"number"]integerValue]) {
            // 发起违规请求 上报给后台
            [self requestMonitorServiceFaceRecogRuleStr:@"always"];
        }
    }
}
// 进入前台
-(void)enterFore{
    // 获取剩余秒数
    [self requestPaperGetRemaTime];
    if (!self.isAlwayMotion) {
        return;
    }
    // 判断是否是在当前页面
    UIViewController *vc = [self.navigationController.viewControllers lastObject];
    if (![vc isKindOfClass:[YWTExamQuestionController class]]) {
        return;
    }
    NSDictionary *alwaysDict = [self createFaveVerificationStr:@"always"];
    if (self.alwaysNumber < [alwaysDict[@"number"]integerValue]) {
        return ;
    }
    self.serviceView.showContentLab.text = @"系统监测到您当前存在违规操作！";
    [[UIApplication sharedApplication].keyWindow addSubview:self.serviceView];
    __weak typeof(self) weakSelf = self;
    // 确定
    self.serviceView.selectTureBtn = ^{
        // 移除 视图
        [weakSelf.serviceView removeFromSuperview];
    };
    
}
// 服务器发起强制交卷
-(void)serviceSubimtExamPaper:(NSNotification *) titf{
    NSDictionary *dict = titf.userInfo;
    // 消息类型
    NSString *instructionStr = dict[@"instruction"];
    if ([instructionStr isEqualToString:@"exams"]){
        // 强制交卷
        NSString *contentsStr = dict[@"contents"];
        NSString *colorStr = dict[@"color"];
        NSAttributedString *attrStr = [[NSAttributedString alloc]initWithData:[contentsStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:[UIFont boldSystemFontOfSize:14],NSForegroundColorAttributeName:[UIColor colorWithHexString:colorStr] } documentAttributes:nil error:nil];
        self.serviceView.showContentLab.attributedText = attrStr;
        [[UIApplication sharedApplication].keyWindow addSubview:self.serviceView];
        __weak typeof(self) weakSelf = self;
        // 确定
        self.serviceView.selectTureBtn = ^{
            // 立即交卷
            [weakSelf requestPaperAnswer];
            // 移除 视图
            [weakSelf.serviceView removeFromSuperview];
        };
    }
}
#pragma mark -----系统回调--------
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 移除定时器
    [self.naviTitleView removeTimer];
    // 清除记录home次数
    self.alwaysNumber = 0;
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}
#pragma mark --- 懒加载 --------
-(YWTExamQuestNaviTitleView *)naviTitleView{
    if (!_naviTitleView) {
        _naviTitleView = [[YWTExamQuestNaviTitleView alloc]initWithFrame:CGRectMake(KScreenW/2-KSIphonScreenW(175)/2, KSStatusHeight+(22-KSIphonScreenH(30)/2), KSIphonScreenW(175), KSIphonScreenH(30))];
    }
    return _naviTitleView;
}
-(YWTExamQuestBottomToolView *)bottomToolView{
    if (!_bottomToolView) {
        _bottomToolView = [[YWTExamQuestBottomToolView alloc]initWithFrame:CGRectMake(0, KScreenH-KSIphonScreenH(50)-KSTabbarH, KScreenW, KSIphonScreenH(50))];
    }
    return _bottomToolView;
}
-(YWTShowCountDownView *)showCountDownView{
    if (!_showCountDownView) {
        _showCountDownView = [[YWTShowCountDownView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH)];
    }
    return _showCountDownView;
}
-(YWTShowServicePromptView *)serviceView{
    if (!_serviceView) {
        _serviceView = [[YWTShowServicePromptView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH)];
    }
   return  _serviceView;
}
-(YWTShowQuestTypeSwitchView *)showQuestTypeView{
    if (!_showQuestTypeView) {
        _showQuestTypeView = [[YWTShowQuestTypeSwitchView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KSIphonScreenH(33))];
    }
    return _showQuestTypeView;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(NSMutableArray *)recordRandomArr{
    if (!_recordRandomArr) {
        _recordRandomArr = [NSMutableArray array];
    }
    return _recordRandomArr;
}
-(TempDetailQuestionModel *)detailQuestModel{
    if (!_detailQuestModel) {
        _detailQuestModel = [[TempDetailQuestionModel alloc]init];
    }
    return _detailQuestModel;
}
-(NSDictionary *)nowMotionDict{
    if (!_nowMotionDict) {
        _nowMotionDict = [NSDictionary dictionary];
    }
    return _nowMotionDict;
}
-(void)setControllerQuestMode:(controllerExamQuestMode)controllerQuestMode{
    _controllerQuestMode = controllerQuestMode;
}
-(void)setMonitorRulesArr:(NSArray *)monitorRulesArr{
    _monitorRulesArr = monitorRulesArr;
}
-(void)setTaskidStr:(NSString *)taskidStr{
    _taskidStr = taskidStr;
}
-(void)setExamIdStr:(NSString *)examIdStr{
    _examIdStr = examIdStr;
}
-(void)setExamRoomIdStr:(NSString *)examRoomIdStr{
    _examRoomIdStr = examRoomIdStr;
}
-(void)setExamBatchIdStr:(NSString *)examBatchIdStr{
    _examBatchIdStr = examBatchIdStr;
}
-(void)setDescriptionStr:(NSString *)descriptionStr{
    _descriptionStr = descriptionStr;
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
#pragma mark --- 做题中提交答案--------
-(void) requestPaperRecordData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"examRoomId"] = self.examRoomIdStr;
    //当前题
    QuestionListModel *model = self.dataArr[self.currentIndex];
    // 找出当前题的答案
    NSString *userAnswerStr = [[DataBaseManager sharedManager]getObtainUserSelectAnswer:model.Id];
    NSMutableArray *userAnswerArr = [NSMutableArray array];
    NSMutableDictionary *answerDict = [NSMutableDictionary dictionary];
    answerDict[@"id"] = model.Id;
    answerDict[@"answer"] = userAnswerStr;
    [userAnswerArr addObject:answerDict];
    // 转换成json数组的字符串
    NSString *answerJsonStr = [YWTTools convertToJsonData:userAnswerArr];
    param[@"answer"] = answerJsonStr;
    if (self.controllerExamType == controllerMockExamType ) {
        param[@"type"] = @"2";
    }else{
        param[@"type"] = @"1";
    }
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPPPAPERRECORD_URL params:param withModel:nil waitView:nil complateHandle:^(id showdata, NSString *error) {
        if (error) {
            return ;
        }
    }];
}
#pragma mark ---- 立即交卷 ----------
-(void) requestPaperAnswer{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"examRoomId"] = self.examRoomIdStr;
    param[@"userId"] = [YWTUserInfo obtainWithUserId];
    param[@"platformCode"] = [YWTUserInfo obtainWithLoginPlatformCode];
    param[@"token"] = [YWTTools getNewToken];
    param[@"terminal"] =  @"1";
    param[@"description"] = self.descriptionStr;
    if (self.controllerExamType == controllerMockExamType ) {
        param[@"type"] = @"2";
        param[@"taskid"] = self.taskidStr;
    }else{
        param[@"type"] = @"1";
    }
    NSArray *answerArr = [[DataBaseManager sharedManager]selectAllApps];
    NSMutableArray *userAnswerArr = [NSMutableArray array];
    for (NSDictionary *dict in answerArr) {
        NSMutableDictionary *userDict = [NSMutableDictionary dictionary];
        userDict[@"id"] = dict[@"questId"];
        userDict[@"answer"] = dict[@"userAnswer"];
        [userAnswerArr addObject:userDict];
    }
    // 转换成json数组的字符串
    NSString *answerJsonStr = [YWTTools convertToJsonData:userAnswerArr];
    param[@"answer"] = answerJsonStr;
   
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPPAPERSUBMITANSWER_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            if ([error containsString:@"请勿重复提交试卷"]) {
                YWTShowServicePromptView *showServiceView = [[YWTShowServicePromptView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH)];
                [[UIApplication sharedApplication].keyWindow addSubview:showServiceView];
                showServiceView.showContentLab.text = error;
                [showServiceView.tureBtn setTitle:@"回到首页" forState:UIControlStateNormal];
                __weak typeof(self) weakSelf = self;
                __weak typeof(showServiceView) weakShowServiceView = showServiceView;
                showServiceView.selectTureBtn = ^{
                    [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                    [weakShowServiceView removeFromSuperview];
                };
            }else{
                [self.view showErrorWithTitle:error autoCloseTime:0.5];
            }
            return ;
        }
        if (![showdata isKindOfClass:[NSDictionary class]]) {
            [self.view showErrorWithTitle:@"返回数据格式错误" autoCloseTime:1];
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        // 移除定时器
        [self.naviTitleView removeTimer];
        // 跳转到成绩页面
        YWTExamScoreViewController *examScoreVC = [[YWTExamScoreViewController alloc]init];
        examScoreVC.idStr = [NSString stringWithFormat:@"%@",showdata[@"id"]];
        examScoreVC.examRoomIdStr = self.examRoomIdStr;
        if (self.controllerExamType == controllerMockExamType ) {
            examScoreVC.scoreType =showExamScoreExerType;
            examScoreVC.taskIdStr = self.taskidStr;
        }else{
            examScoreVC.scoreType =showExamScoreExamPaperType;
        }
        [self.navigationController pushViewController:examScoreVC animated:YES];
    }];
}
#pragma mark --- 获取剩余秒数-------
-(void) requestPaperGetRemaTime{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"examRoomId"] = self.examRoomIdStr;
    param[@"userId"] = [YWTUserInfo obtainWithUserId];
    param[@"token"] = [YWTTools getNewToken];
    param[@"platformCode"] = [YWTUserInfo obtainWithLoginPlatformCode];
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPPAPERGETREMATIME_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            return ;
        }
        if (![showdata isKindOfClass:[NSDictionary class]]) {
            [self.view showErrorWithTitle:@"返回数据格式错误" autoCloseTime:1];
            return;
        }
        double time = [showdata[@"time"]doubleValue];
        if (time < 0) {
            // 立即交卷
            [self requestPaperAnswer];
        }else{
            // 更新定时器
            self.naviTitleView.totalInterval = time;
        }
    }];
}
#pragma mark --- 请求答题--------
-(void) requestQuestData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] =  [YWTTools getNewToken];
    param[@"userId"] =  [YWTUserInfo obtainWithUserId];
    param[@"platformCode"] = [YWTUserInfo obtainWithLoginPlatformCode];
    param[@"examId"] = self.examIdStr;
    param[@"examRoomId"] = self.examRoomIdStr;
    param[@"examBatchId"] = self.examBatchIdStr;
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
    param[@"description"] = self.descriptionStr;
    //考试类型
    if (self.controllerExamType == controllerMockExamType ) {
        param[@"type"] = @"2";
    }else{
        param[@"type"] = @"1";
    }
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPPAPERGENERATEPAPER_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:1];
            [self.navigationController popViewControllerAnimated:YES];
            return ;
        }
        if (![showdata isKindOfClass:[NSDictionary class]]) {
            [self.view showErrorWithTitle:@"返回数据格式错误" autoCloseTime:1];
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        // 答题模式
        if (self.controllerQuestMode == controllerExamQuestAnswerMode) {
            // 添加到本地存储数据
            NSArray *dataSourceArr = [self newAssemblyNSArry:showdata[@"data"]];
            [[DataBaseManager sharedManager]saveQusetAlls:dataSourceArr];
            
            double time = [showdata[@"time"]doubleValue];
            if (time > 1) {
                // 更新定时器
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.naviTitleView.totalInterval = [showdata[@"time"]doubleValue];
                });
            }else{
                // 强制交卷
                [self requestPaperAnswer];
                return;
            }
            if (dataSourceArr.count == 0) {
               [self.view showErrorWithTitle:@"系统错误返回重新进入!" autoCloseTime:2];
               [self.navigationController popViewControllerAnimated:YES];
                return;
            }
            for (NSDictionary *dict in dataSourceArr ) {
                QuestionListModel *model = [QuestionListModel yy_modelWithDictionary:dict];
                [self.dataArr addObject:model];
            }
            // 判断有没有开启考试中人脸
            if (self.isRandomMotion) {
                // 获取规则字典
                NSDictionary *dict = [self createFaveVerificationStr:@"random"];
                for (int i=0; i< [dict[@"number"] integerValue]; i++) {
                    [self.recordRandomArr addObject:[NSNumber numberWithInteger:arc4random()%self.dataArr.count]];
                }
            }
            [self.pageController reloadData];
            // 通过questId 跳转到题-
            [self getByQuestionId:[NSString stringWithFormat:@"%@",showdata[@"doId"]]];
            
        }else{
            NSArray * listArr = (NSArray *)showdata[@"questionList"];
            for (NSDictionary *dict in listArr ) {
                QuestionListModel *model = [QuestionListModel yy_modelWithDictionary:dict];
                [self.dataArr addObject:model];
            }
            [self.pageController reloadData];
        }
    }];
}
/**
 人脸识别对比
 @param faceImage 传入人脸获取图片
 @param ruleStr 人脸规则 的位置  【start开始前 random考试中随机 end交卷验证
 */
-(void) requestMonitorFaceRecogintion:(UIImage *)faceImage andRuleStr:(NSString *)ruleStr{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] = [YWTUserInfo obtainWithUserId];
    param[@"token"] = [YWTTools getNewToken];
    param[@"platformCode"] = [YWTUserInfo obtainWithLoginPlatformCode];
    param[@"examId"] = self.examIdStr;
    param[@"examRoomId"] = self.examRoomIdStr;
    if (self.controllerExamType == controllerMockExamType) {
        param[@"source"] = @"2";
        param[@"type"] = @"2";
    }else{
        param[@"source"] = @"1";
        param[@"type"] = @"1";
    }
    param[@"rule"] = ruleStr;
    
    param[@"terminal"] = [NSNumber numberWithInteger:1];
    //获取本地软件的版本号
    NSString *localVersion =  [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    param[@"appVersion"] = localVersion;
    // 手机系统版本
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    // 手机型号
    NSString *phoeModel = [YWTTools deviceModelName];
    NSString *systemVersionStr = [NSString stringWithFormat:@"%@-%@",phoeModel,phoneVersion];
    param[@"systemVersion"] = systemVersionStr;
    // 任务id
    param[@"taskId"] = self.taskidStr;
    
    [[KRMainNetTool sharedKRMainNetTool] upLoadPhotoUrl:HTTP_ATTAPPMOITORAPIFACERECOGINTION_URL params:param photo:faceImage waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if (![showdata isKindOfClass:[NSDictionary class]]) {
            return;
        }
        // 如果是交卷验证的  验证成功后交卷
        if ([ruleStr isEqualToString:@"end"]) {
            [self requestPaperAnswer];
        }
    }];
}
#pragma mark   ------- 违规操作上传------
-(void) requestMonitorServiceFaceRecogRuleStr:(NSString *)ruleStr{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] = [YWTUserInfo obtainWithUserId];
    param[@"token"] = [YWTTools getNewToken];
    param[@"platformCode"] = [YWTUserInfo obtainWithLoginPlatformCode];
    param[@"examId"] = self.examIdStr;
    param[@"examRoomId"] = self.examRoomIdStr;
    param[@"type"] = @"1";
    param[@"outNum"] = [NSNumber numberWithInteger:self.alwaysNumber];
    param[@"do"]= @"2";
    param[@"isViolation"] = @"2";
    if (self.controllerExamType == controllerMockExamType) {
        param[@"source"] = @"2";
    }else{
        param[@"source"] = @"1";
    }
    param[@"rule"] = ruleStr;
    
    param[@"terminal"] = [NSNumber numberWithInteger:1];
    //获取本地软件的版本号
    NSString *localVersion =  [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    param[@"appVersion"] = localVersion;
    // 手机系统版本
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    // 手机型号
    NSString *phoeModel = [YWTTools deviceModelName];
    NSString *systemVersionStr = [NSString stringWithFormat:@"%@-%@",phoeModel,phoneVersion];
    param[@"systemVersion"] = systemVersionStr;
    // 任务id
    param[@"taskId"] = self.taskidStr;
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPMONITORSEVICEAPIFACERECOGNITIOn_URL params:param withModel:nil waitView:nil complateHandle:^(id showdata, NSString *error) {
        if (error) {
            return ;
        }
    }];
}








@end
