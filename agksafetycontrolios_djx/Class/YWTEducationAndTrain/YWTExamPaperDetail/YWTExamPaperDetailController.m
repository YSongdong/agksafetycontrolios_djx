//
//  ExamPaperDetailController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/2/13.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTExamPaperDetailController.h"

#import "YWTExamQuestBottomToolView.h"
#import "YWTTempExamQuestView.h"
#import "YWTExamAnswerRecordCardView.h"
#import "YWTExamQuestSettingView.h"

#import "TempDetailQuestionModel.h"

@interface YWTExamPaperDetailController ()
<
SZPageControllerDataSource,
SZPageControllerDelegate
>
// 底部工具view
@property (nonatomic,strong) YWTExamQuestBottomToolView *bottomToolView;
// 答题卡view
@property (nonatomic,strong) YWTExamAnswerRecordCardView *answerCardView;
// 设置 view
@property (nonatomic,strong) YWTExamQuestSettingView *questSettingView;
// 控件
@property (nonatomic, weak) SZPageController *pageController;
// 数据源
@property (nonatomic,strong) NSMutableArray *dataArr;
// 记录当前数据源的下标
@property (nonatomic,assign) NSInteger currentIndex;

@property (nonatomic,strong) TempDetailQuestionModel *detailModel;

@end

@implementation YWTExamPaperDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [self setNavi];
    [self createBottomToolView];
    [self createPageConteroller];
    [self requestQuestData];
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
    questView.questMode = tempExamQuestDetailMode ;
    //  答题类型
    if ([model.typeId isEqualToString:@"1"]) {
        // 单选
        questView.questType = tempExamQuestSingleSelectType;
    }else if ([model.typeId isEqualToString:@"2"]){
        // 多选
        questView.questType = tempExamQuestMultipleSelectType;
    }else if ([model.typeId isEqualToString:@"3"]){
        // 判断
        questView.questType = tempExamQuestJudgmentType;
    }else if ([model.typeId isEqualToString:@"5"]){
        // 填空'
        questView.questType = tempExamQuestFillingType;
    }else if ([model.typeId isEqualToString:@"6"] || [model.typeId isEqualToString:@"4"]){
        //主观'
        questView.questType = tempExamQuestThemeType;
    }
    // 数据源
    questView.tempQuestModel =  model;
    questView.tempDataModel = self.detailModel;
    return questView;
}
#pragma mark --- SZPageControllerDelegate -----
//  当前显示的View
- (void)pageController:(SZPageController *)pageController currentView:(UIView *)currentView currentIndex:(NSInteger)currentIndex {
    self.currentIndex = currentIndex;
}
- (void)pageControllerSwitchToLastDisabled:(SZPageController *)pageController {
    [self.view showErrorWithTitle:@"已经是第一题了!" autoCloseTime:0.5];
}
- (void)pageControllerSwitchToNextDisabled:(SZPageController *)pageController {
    [self.view showErrorWithTitle:@"已经是最后一题了!" autoCloseTime:0.5];
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
        // 模式
        weakSelf.answerCardView.answerCardMode = showAnswerCardDetailMode;
        // 获取当前题id
        QuestionListModel *model = weakSelf.dataArr[weakSelf.currentIndex];
        weakSelf.answerCardView.questId = model.Id;
        //赋值
        weakSelf.answerCardView.detaSourceArr = weakSelf.detailModel.sheet;
        
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
        if (weakSelf.dataArr.count == weakSelf.currentIndex+1) {
            [weakSelf.view showErrorWithTitle:@"当前已是最后一题" autoCloseTime:0.5];
        }
        [weakSelf.pageController switchToNextAnimated:YES];
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
    
    self.customNavBar.title = @"模拟测验详情";
    // 左边按钮
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    __weak typeof(self) weakSelf = self;
    self.customNavBar.onClickLeftButton = ^{
        // 删除请求下来的本地试题
        [[DataBaseManager sharedManager]deleteAll];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}
#pragma mark --- 懒加载 --------

-(YWTExamQuestBottomToolView *)bottomToolView{
    if (!_bottomToolView) {
        _bottomToolView = [[YWTExamQuestBottomToolView alloc]initWithFrame:CGRectMake(0, KScreenH-KSIphonScreenH(50)-KSTabbarH, KScreenW, KSIphonScreenH(50))];
    }
    return _bottomToolView;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(TempDetailQuestionModel *)detailModel{
    if (!_detailModel) {
        _detailModel = [[TempDetailQuestionModel alloc]init];
    }
    return _detailModel;
}
-(void)setExamRecordIdStr:(NSString *)examRecordIdStr{
    _examRecordIdStr = examRecordIdStr;
}
-(void)setSpeciJumpQuestNumberStr:(NSString *)speciJumpQuestNumberStr{
    _speciJumpQuestNumberStr = speciJumpQuestNumberStr;
}
#pragma mark --- 请求答题--------
-(void) requestQuestData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] =  [YWTTools getNewToken];
    param[@"id"] = self.examRecordIdStr;
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPQUESTIONEXAMRECORD_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
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
        // 添加到本地存储数据
        [[DataBaseManager sharedManager]saveQusetAlls:showdata[@"questionList"]];
        
        NSArray * listArr = (NSArray *)showdata[@"questionList"];
        for (NSDictionary *dict in listArr ) {
            QuestionListModel *model = [QuestionListModel yy_modelWithDictionary:dict];
            [self.dataArr addObject:model];
        }
        self.detailModel = [TempDetailQuestionModel yy_modelWithDictionary:showdata];
        [self.pageController reloadData];
        //是否要跳转到指定题
        if (self.speciJumpQuestNumberStr != nil || ![self.speciJumpQuestNumberStr isEqualToString:@""]) {
            [self getByQuestionId:self.speciJumpQuestNumberStr];
        }
    }];
}

@end
