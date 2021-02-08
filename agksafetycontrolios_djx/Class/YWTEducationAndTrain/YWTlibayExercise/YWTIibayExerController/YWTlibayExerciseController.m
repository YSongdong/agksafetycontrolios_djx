//
//  libayExerciseController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/26.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTlibayExerciseController.h"

#import "YWTIibayExerDetailController.h"
#import "YWTSpecialTrainingController.h"

#import "WKWebViewOrJSText.h"

#import "YWTShowNoSourceView.h"
#import "YWTExamPaperListSiftView.h"
#import "YWTBaseHeaderSearchView.h"
#import "YWTLibayExerPromptView.h"
#import "YWTShowUnNetWorkStatuView.h"
#import "YWTLibayExerStartLearnPromptView.h"
#import "YWTShowVerifyIdentidyErrorView.h"
#import "YWTShowServicePromptView.h"

#import "YWTlibayExerciseListTableViewCell.h"
#define LIBAYEXERCISELISTTABLEVIEW_CELL  @"YWTlibayExerciseListTableViewCell"


@interface YWTlibayExerciseController ()
<
UITableViewDelegate,
UITableViewDataSource,
ExamPaperListSiftViewDelegate
>
// 头部搜索view
@property (nonatomic,strong) YWTBaseHeaderSearchView  *headerSearchView;
// 空白页
@property (nonatomic,strong) YWTShowNoSourceView *showNoSoucreView;
// 筛选view
@property (nonatomic,strong) YWTExamPaperListSiftView *listSiftView;
// 清空题库提示框
@property (nonatomic,strong) YWTLibayExerPromptView *libayExerPromptView;
// 没有网络view
@property (nonatomic,strong) YWTShowUnNetWorkStatuView  *showNetWorkStatuView;

@property (nonatomic,strong) YWTLibayExerStartLearnPromptView *startLearnPromptView;
// 验证失败view
@property (nonatomic,strong)YWTShowVerifyIdentidyErrorView *showVeriIndeErrorView;
// 提示框
@property (nonatomic,strong) YWTShowServicePromptView *showPromptView;

@property (nonatomic,strong) UITableView *listTableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
// 页数
@property (nonatomic,assign) NSInteger page;
//  筛选条
@property (nonatomic,strong) NSString *tagIdStr;
// 记录题库当前数据源
@property (nonatomic,strong) NSDictionary *nowDataDict;
// 记录跳转题库类型 1 错题练习 2 我的收藏 3 顺序练习
@property (nonatomic,strong) NSString *pushLibaryType;
// 人脸规则数组
@property (nonatomic,strong) NSArray *monitorRulesArr;
// 记录当前人脸规则的数据源
@property (nonatomic,strong) NSDictionary *nowVeriDict;
// 是否强制人脸 1强制 2非强制
@property (nonatomic,strong) NSString *forceStr;
// 记录规则验证失败次数
@property (nonatomic,strong) NSString *veriNumberStr;
// 记录验证失败次数
@property (nonatomic,assign) NSInteger veriErrorNumber;
@end

@implementation YWTlibayExerciseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    // 默认 跳转题库类型
    self.pushLibaryType = @"3";
    // 设置导航栏
    [self setNavi];
    //创建搜索view
    [self createSearchView];
    // 创建Tableview
    [self createTableView];
    // 注册网络通知
    [self registeredNetworkTifi];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 请求
    [self requestQuestLibaryListData];
}
#pragma mark --- 创建Tableview --------
-(void)createTableView {
    __weak typeof(self) weakSelf = self;
    self.view.backgroundColor = [UIColor colorTextWhiteColor];
    // 添加搜索view
    [self.view addSubview:self.headerSearchView];
    if (![self.titleStr isEqualToString:@""]) {
        self.headerSearchView.searchTextField.text = self.titleStr;
        [UIView animateWithDuration:0.25 animations:^{
            // 更新约束
            [weakSelf.headerSearchView.searchImageV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.headerSearchView.bgView).offset(KSIphonScreenW(10));
            }];
        }];
    }
    self.headerSearchView.searchBlock = ^(NSString * _Nonnull search) {
        weakSelf.resourceIdStr = @"";
        weakSelf.tagIdStr = @"";
        weakSelf.titleStr = search;
        weakSelf.page = 1;
        [weakSelf requestQuestLibaryListData];
    };
    
    self.listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight+KSIphonScreenH(60), KScreenW, KScreenH-KSNaviTopHeight-KSTabbarH-KSIphonScreenH(60))];
    [self.view addSubview:self.listTableView];
    self.listTableView.dataSource = self;
    self.listTableView.delegate = self;
    self.listTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.listTableView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    
    // 添加空白页
    [self.listTableView addSubview:self.showNoSoucreView];
    
    [self.listTableView registerClass:[YWTlibayExerciseListTableViewCell class] forCellReuseIdentifier:LIBAYEXERCISELISTTABLEVIEW_CELL];
    
    if (@available(iOS 11.0, *)) {
        self.listTableView.estimatedRowHeight = 0;
        self.listTableView.estimatedSectionFooterHeight = 0;
        self.listTableView.estimatedSectionHeaderHeight = 0 ;
        self.listTableView.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    // 刷新
    [self.listTableView bindGlobalStyleForHeadRefreshHandler:^{
        weakSelf.page = 1;
        [weakSelf requestQuestLibaryListData];
    }];
    
    [self.listTableView bindGlobalStyleForFootRefreshHandler:^{
        weakSelf.page ++;
        [weakSelf requestQuestLibaryListData];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWTlibayExerciseListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LIBAYEXERCISELISTTABLEVIEW_CELL forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dict = self.dataArr[indexPath.row];
    cell.dict = dict;
    __weak typeof(self) weakSelf = self;
    // 错题巩固
    cell.errorQuestBlock = ^{
        // 判断是否开启人脸
        if ([YWTTools getWithFaceMonitorStr:[NSString stringWithFormat:@"%@",dict[@"monitor"]]]) {
            weakSelf.monitorRulesArr = nil;
            weakSelf.monitorRulesArr = (NSArray*)dict[@"monitorRules"];
            // 记录题库当前数据源
            weakSelf.nowDataDict = nil;
            weakSelf.nowDataDict = dict;
            
            // 判断是否找到人脸规则
            if ([weakSelf getByMonitorNameHaveFoundMonitorDict:@"start"]) {
                // 通过规则 调用人脸识别
                NSDictionary *faceDict = [weakSelf createFaveVerificationStr:@"start"];
                weakSelf.nowVeriDict = nil;
                weakSelf.nowVeriDict = faceDict;
                // 是否强制人脸 1强制 2非强制
                weakSelf.forceStr = [NSString stringWithFormat:@"%@",faceDict[@"force"]];
                // 记录验证失败次数
                weakSelf.veriNumberStr = [NSString stringWithFormat:@"%@",faceDict[@"number"]];
                // 开始人脸认证
                [weakSelf passRulesConductFaceVeri:faceDict];
            }else{
                // 跳转到 错题巩固
                weakSelf.pushLibaryType = @"1";
                [weakSelf pushSequentPracViewDict:dict andTaskFace:YES];
            }
        }else{
            // 跳转到 错题巩固
            weakSelf.pushLibaryType = @"1";
            [weakSelf pushSequentPracViewDict:dict andTaskFace:NO];
        }
    };
    // 我的收藏
    cell.mineCollecBlock = ^{
        // 判断是否开启人脸
        if ([YWTTools getWithFaceMonitorStr:[NSString stringWithFormat:@"%@",dict[@"monitor"]]]) {
            weakSelf.monitorRulesArr = nil;
            weakSelf.monitorRulesArr = (NSArray*)dict[@"monitorRules"];
            // 记录题库当前数据源
            weakSelf.nowDataDict = nil;
            weakSelf.nowDataDict = dict;
            // 判断是否找到人脸规则
            if ([weakSelf getByMonitorNameHaveFoundMonitorDict:@"start"]) {
                // 通过规则 调用人脸识别
                NSDictionary *faceDict = [weakSelf createFaveVerificationStr:@"start"];
                weakSelf.nowVeriDict = nil;
                weakSelf.nowVeriDict = faceDict;
                // 是否强制人脸 1强制 2非强制
                weakSelf.forceStr = [NSString stringWithFormat:@"%@",faceDict[@"force"]];
                // 记录验证失败次数
                weakSelf.veriNumberStr = [NSString stringWithFormat:@"%@",faceDict[@"number"]];
                // 开始人脸认证
                [weakSelf passRulesConductFaceVeri:faceDict];
            }else{
                // 跳转到 我的收藏
                weakSelf.pushLibaryType = @"2";
                [weakSelf pushSequentPracViewDict:dict andTaskFace:YES];
            }
        }else{
            // 跳转到 我的收藏
            weakSelf.pushLibaryType = @"2";
            [weakSelf pushSequentPracViewDict:dict andTaskFace:NO];
        }
    };
    // 开始学习
    cell.beginLearnBlock = ^{
        // 3为再次练习
        NSString *statusStr = [NSString stringWithFormat:@"%@",dict[@"status"]];
        if ([statusStr isEqualToString:@"3"]) {
            [weakSelf createClearUserLibaryDict:dict];
        }else{
            // 创建开始学习弹框
            [weakSelf createBeginLearnPromptView:dict];
        }
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KSIphonScreenH(190);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YWTIibayExerDetailController *detaVC = [[YWTIibayExerDetailController alloc]init];
    NSDictionary *dict = self.dataArr[indexPath.row];
    detaVC.libaryIdStr = [NSString stringWithFormat:@"%@",dict[@"libaryId"]];
    detaVC.sequentPracStatus = [NSString stringWithFormat:@"%@",dict[@"status"]];
    detaVC.errorStr = [NSString stringWithFormat:@"%@",dict[@"error"]];
    detaVC.succeedStr = [NSString stringWithFormat:@"%@",dict[@"succeed"]];
    detaVC.doNumStr = [NSString stringWithFormat:@"%@",dict[@"doNum"]];
    detaVC.percentStr = [NSString stringWithFormat:@"%@",dict[@"percent"]];
    [self.navigationController pushViewController:detaVC animated:YES];
}
#pragma mark --- 创建开始学习弹框 --------
-(void) createBeginLearnPromptView:(NSDictionary *) dict{
    __weak typeof(self) weakSelf = self;
    [weakSelf.view addSubview:weakSelf.startLearnPromptView];
    
    // 顺序练习
    weakSelf.startLearnPromptView.selectSequenPrac = ^{
        [weakSelf.startLearnPromptView removeFromSuperview];
        // 判断是否开启人脸
        if ([YWTTools getWithFaceMonitorStr:[NSString stringWithFormat:@"%@",dict[@"monitor"]]]) {
            weakSelf.monitorRulesArr = nil;
            weakSelf.monitorRulesArr = (NSArray*)dict[@"monitorRules"];
            // 记录题库当前数据源
            weakSelf.nowDataDict = nil;
            weakSelf.nowDataDict = dict;
            
            // 判断是否找到人脸规则
            if ([weakSelf getByMonitorNameHaveFoundMonitorDict:@"start"]) {
                // 通过规则 调用人脸识别
                NSDictionary *faceDict = [weakSelf createFaveVerificationStr:@"start"];
                weakSelf.nowVeriDict = nil;
                weakSelf.nowVeriDict = faceDict;
                // 是否强制人脸 1强制 2非强制
                weakSelf.forceStr = [NSString stringWithFormat:@"%@",faceDict[@"force"]];
                // 记录验证失败次数
                weakSelf.veriNumberStr = [NSString stringWithFormat:@"%@",faceDict[@"number"]];
                // 开始人脸认证
                [weakSelf passRulesConductFaceVeri:faceDict];
            }else{
                // 跳转到 顺序练习
                weakSelf.pushLibaryType = @"3";
                [weakSelf pushSequentPracViewDict:dict andTaskFace:YES];
            }
        }else{
            // 跳转到 顺序练习
            weakSelf.pushLibaryType = @"3";
            [weakSelf pushSequentPracViewDict:dict andTaskFace:NO];
        }
    };
    
    // 专项练习
    weakSelf.startLearnPromptView.selectSpecialPrac = ^{
        [weakSelf.startLearnPromptView removeFromSuperview];
        YWTSpecialTrainingController *specTrainVC = [[YWTSpecialTrainingController alloc]init];
        specTrainVC.libaryIdStr = [NSString stringWithFormat:@"%@",dict[@"libaryId"]];
        specTrainVC.dataDict = dict;
        [weakSelf.navigationController pushViewController:specTrainVC animated:YES];
    };
}
#pragma mark --- 创建搜索view --------
-(void) createSearchView{
    [self.view addSubview:self.headerSearchView];
    __weak typeof(self) weakSelf = self;
    self.headerSearchView.searchBlock = ^(NSString * _Nonnull search) {
        weakSelf.titleStr = search;
        weakSelf.page = 1;
        [weakSelf requestQuestLibaryListData];
    };
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
                [weakSelf requestQuestLibaryListData];
                // 移除
                [weakSelf.showNetWorkStatuView removeFromSuperview];
            }
        };
    }
}
#pragma mark --- 创建清空做题记录 --------
-(void) createClearUserLibaryDict:(NSDictionary*)dict{
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.libayExerPromptView];
    NSString *succeedStr = [NSString stringWithFormat:@"%@",dict[@"succeed"]];
    NSString *errorStr = [NSString stringWithFormat:@"%@",dict[@"error"]];
    NSString *contentStr = [NSString stringWithFormat:@"您已完整学习该题库，正确 %@ 题，错误 %@ 题，您是否需要清空做题再次练习?",succeedStr,errorStr];
    self.libayExerPromptView.showContentLab.attributedText = [self getAttrbuteContentStr:contentStr andAlterTotalStr:succeedStr answerStr:errorStr];
    
    // 直接进入
    self.libayExerPromptView.enterExam = ^{
        [weakSelf.libayExerPromptView removeFromSuperview];
        [weakSelf createBeginLearnPromptView:dict];
    };
    // 清空重做
    self.libayExerPromptView.againExer = ^{
        [weakSelf.libayExerPromptView removeFromSuperview];
        [weakSelf requestClearUserQuestDict:dict];
    };
}
#pragma mark --- 跳转到顺序练习 --------
/*
 weakSelf.pushLibaryType  1 错题练习 2 我的收藏 3 顺序练习
 TaskFace  开启任务  YES 是  NO 不是
 */
-(void) pushSequentPracViewDict:(NSDictionary *)dict andTaskFace:(BOOL)isFace{
     __weak typeof(self) weakSelf = self;
    WKWebViewOrJSText *wkWebVC = [[WKWebViewOrJSText alloc]init];
    if ([weakSelf.pushLibaryType isEqualToString:@"1"]) {
        wkWebVC.titleType = showLibaryTitleErrorQuestType;
    }else if ([weakSelf.pushLibaryType isEqualToString:@"2"]){
         wkWebVC.titleType = showLibaryTitleMineCollecType;
    }else if ([weakSelf.pushLibaryType isEqualToString:@"3"]){
         wkWebVC.titleType = showLibaryTitleSequentPracType;
         wkWebVC.sequentPracStatus = [NSString stringWithFormat:@"%@",dict[@"status"]];
    }
    // YES 是  NO 不是
    if (isFace) {
        wkWebVC.taskIdStr = [NSString stringWithFormat:@"%@",dict[@"taskid"]];
        wkWebVC.monitorRulesArr = (NSArray *)dict[@"monitorRules"];
    }else{
        wkWebVC.taskIdStr = @"";
    }
    //题库ID
    wkWebVC.libaryIdStr = [NSString stringWithFormat:@"%@",dict[@"libaryId"]];
    
    [weakSelf.navigationController pushViewController:wkWebVC animated:YES];
}
#pragma mark --- 关于开启任务人脸识别模块--------
// 通过规则名称 判断是否能找到规则源  YES 能 NO  不能
-(BOOL) getByMonitorNameHaveFoundMonitorDict:(NSString *)nameStr{
    BOOL  isFound = NO;
    // 赋值
    self.monitorRules = self.monitorRulesArr;
    // 找到对应的规则数据源
    NSDictionary *dict = [self createFaveVerificationStr:nameStr];
    if (dict.count != 0) {
        isFound = YES;
    }
    return isFound;
}
// 人脸采集成功回调方法
-(void)returnFaceSuccessImage:(NSDictionary *)dict{
    // 调人脸对比接口
    [self requestMonitorFaceRecogintion:dict[@"faceSuccess"] andRuleStr:dict[@"rule"]];
}
// 超时
-(void)codeTimeOut{
   
}
// 关闭
-(void)closeViewControll{
   
}
#pragma mark --- 创建验证失败的view --------
-(void) createShowVeriIndeErrorViewAndType:(NSString *)typeStr{
    __weak typeof(self) weakSelf = self;
    self.showVeriIndeErrorView = [[YWTShowVerifyIdentidyErrorView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH) andType:typeStr];
    [self.view addSubview:self.showVeriIndeErrorView];
    // 点击其他区域不能取消view
    self.showVeriIndeErrorView.isColseBigBgView = NO;
    
    // 再次验证
    self.showVeriIndeErrorView.againBtnBlock = ^{
        [weakSelf.showVeriIndeErrorView removeFromSuperview];
        // 重新调起人脸
        [weakSelf passRulesConductFaceVeri:weakSelf.nowVeriDict];
    };
    // 直接进入考试
    self.showVeriIndeErrorView.enterBtnBlcok = ^{
        [weakSelf.showVeriIndeErrorView removeFromSuperview];
    };
}

#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    self.customNavBar.title = self.moduleNameStr;
    
    __weak typeof(self) weakSelf = self;
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageChangeName:@"nav_ico_sift"]];
     __block  bool isCreateListSiftView = YES;
    self.customNavBar.onClickRightButton = ^{
        if (isCreateListSiftView) {
            [weakSelf.view addSubview:weakSelf.listSiftView];
            weakSelf.listSiftView.siftType = showListSiftLabayExerType;
            weakSelf.listSiftView.delegate = weakSelf;
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
    self.resourceIdStr = @"";
    self.tagIdStr = tagIdStr;
    self.titleStr = @"";
    self.page = 1;
    [self requestQuestLibaryListData];
}
// UILabel 富文本
/*
 nameStr : 传入的文字
 colorStr   : 要想修改的文字
 */
-(NSMutableAttributedString *) getAttrbuteContentStr:(NSString *)contentStr andAlterTotalStr:(NSString *)succesStr answerStr:(NSString *)errorStr{
    NSMutableAttributedString  *attributStr = [[NSMutableAttributedString alloc]initWithString:contentStr];
    NSRange range = NSMakeRange(13, succesStr.length);
    if (range.location != NSNotFound) {
        // 设置颜色
        [attributStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#00c356"] range:range];
        // 设置字体
        [attributStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:range];
    }
    
    NSRange answerRange = NSMakeRange(13+6+succesStr.length, errorStr.length);
    if (answerRange.location != NSNotFound) {
        // 设置颜色
        [attributStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff3030"] range:answerRange];
        // 设置字体
        [attributStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:answerRange];
    }
    return attributStr;
}
#pragma mark --- get 方法 --------
-(YWTBaseHeaderSearchView *)headerSearchView{
    if (!_headerSearchView) {
        _headerSearchView = [[YWTBaseHeaderSearchView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KSIphonScreenH(60))];
    }
    return _headerSearchView;
}
-(YWTShowNoSourceView *)showNoSoucreView{
    if (!_showNoSoucreView) {
        _showNoSoucreView = [[YWTShowNoSourceView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSNaviTopHeight-KSIphonScreenH(60)-KSTabbarH)];
    }
    return _showNoSoucreView;
}
-(YWTShowServicePromptView *)showPromptView{
    if (!_showPromptView) {
        _showPromptView = [[YWTShowServicePromptView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH)];
    }
    return _showPromptView;
}
-(YWTExamPaperListSiftView *)listSiftView{
    if (!_listSiftView) {
        _listSiftView = [[YWTExamPaperListSiftView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KScreenH-KSNaviTopHeight)];
    }
    return _listSiftView;
}
-(YWTLibayExerPromptView *)libayExerPromptView{
    if (!_libayExerPromptView) {
        _libayExerPromptView = [[YWTLibayExerPromptView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH)];
    }
    return _libayExerPromptView;
}
-(YWTShowUnNetWorkStatuView *)showNetWorkStatuView{
    if (!_showNetWorkStatuView) {
        _showNetWorkStatuView = [[YWTShowUnNetWorkStatuView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight+KSIphonScreenH(60), KScreenW, KScreenH-KSNaviTopHeight-KSIphonScreenH(60)-KSTabbarH)];
    }
    return _showNetWorkStatuView;
}
-(YWTLibayExerStartLearnPromptView *)startLearnPromptView{
    if (!_startLearnPromptView) {
        _startLearnPromptView = [[YWTLibayExerStartLearnPromptView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH)];
    }
    return _startLearnPromptView;
}
-(void)setModuleNameStr:(NSString *)moduleNameStr{
    _moduleNameStr = moduleNameStr;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(NSDictionary *)nowVeriDict{
    if (!_nowVeriDict) {
        _nowVeriDict = [NSDictionary dictionary];
    }
    return _nowVeriDict;
}
-(NSDictionary *)nowDataDict{
    if (!_nowDataDict) {
        _nowDataDict = [NSDictionary dictionary];
    }
    return _nowDataDict;
}
-(NSArray *)monitorRulesArr{
    if (!_monitorRulesArr) {
        _monitorRulesArr = [NSArray array];
    }
    return _monitorRulesArr;
}
-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
}
-(void)setResourceIdStr:(NSString *)resourceIdStr{
    _resourceIdStr = resourceIdStr;
}
#pragma mark ----请求题库列表--------
-(void) requestQuestLibaryListData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"page"] = [NSNumber numberWithInteger:self.page];
    param[@"pageSize"] =  @"10";
    param[@"libaryid"] = self.resourceIdStr;
    param[@"title"] = self.titleStr;
    param[@"tagId"] = self.tagIdStr;
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPQUSTLIBARYQUESTIONLIST_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        
        [self.listTableView.headRefreshControl endRefreshing];
        [self.listTableView.footRefreshControl endRefreshing];
    
        if (error) {
            if ([error containsString:@"examinprogress"]) {
                NSArray *propmtArr = [error componentsSeparatedByString:@"|"];
                [self.view addSubview:self.showPromptView];
                self.showPromptView.showContentLab.text = [propmtArr lastObject];
                [self.showPromptView.tureBtn setTitleColor:[UIColor colorCommonBlackColor] forState:UIControlStateNormal];
                WS(weakSelf);
                self.showPromptView.selectTureBtn = ^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                };
            }else{
                 [self.view showErrorWithTitle:error autoCloseTime:1];
            }
            return ;
        }
        if ([showdata isKindOfClass:[NSArray class]]) {
            if (self.page ==1) {
                [self.dataArr removeAllObjects];
            }
            [self.dataArr addObjectsFromArray:showdata];
            if (self.dataArr.count > 0) {
                self.showNoSoucreView.hidden = YES;
            }else{
                self.showNoSoucreView.hidden = NO;
            }
            [self.listTableView reloadData];
        }
    }];
}
#pragma mark ---  清空题库练习的做题记录----------
-(void) requestClearUserQuestDict:(NSDictionary *)dict{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"libaryId"] =[NSString stringWithFormat:@"%@",dict[@"libaryId"]];
    param[@"token"] = [YWTTools getNewToken];
    param[@"typeOf"] = @"1";
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPQUSTLISCLEARUSERQUESTLIBAY_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        [self createBeginLearnPromptView:dict];
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
    param[@"examId"] = @"0";
    param[@"examRoomId"] = @"0";
    param[@"type"] = @"2";
    param[@"source"] = @"3";
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
    param[@"taskId"] = self.nowDataDict[@"taskid"];
    
    [[KRMainNetTool sharedKRMainNetTool] upLoadPhotoUrl:HTTP_ATTAPPMOITORAPIFACERECOGINTION_URL params:param photo:faceImage waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if (![showdata isKindOfClass:[NSDictionary class]]) {
            return;
        }
        // 1强制 2非强制
        if ([self.forceStr isEqualToString:@"1"]) {
            NSString *succStr = [NSString stringWithFormat:@"%@",showdata[@"succ"]];
            if ([succStr isEqualToString:@"1"]) {
                // 是否开始验证
                if ([ruleStr isEqualToString:@"start"]) {
                    // 跳转到文件详情页面  （hl5）
                    [self pushSequentPracViewDict:self.nowDataDict andTaskFace:YES];
                }
            }else{
                // 创建失败view
                [self createShowVeriIndeErrorViewAndType:@"1"];
            }
        }else{
            NSString *succStr = [NSString stringWithFormat:@"%@",showdata[@"succ"]];
            if ([succStr isEqualToString:@"1"]) {
                // 是否开始验证
                if ([ruleStr isEqualToString:@"start"]) {
                    // 跳转到文件详情页面  （hl5）
                    [self pushSequentPracViewDict:self.nowDataDict andTaskFace:YES];
                }
            }else{
                //记录验证失败次数
                self.veriErrorNumber += 1;
                if (self.veriErrorNumber >= [self.veriNumberStr integerValue]) {
                    [self.showVeriIndeErrorView removeFromSuperview];
                    // 是否开始验证
                    if ([ruleStr isEqualToString:@"start"]) {
                        // 跳转到文件详情页面  （hl5）
                        [self pushSequentPracViewDict:self.nowDataDict andTaskFace:YES];
                    }
                }else{
                    // 创建失败view
                    [self createShowVeriIndeErrorViewAndType:@"1"];
                }
            }
        }
    }];
}




@end
