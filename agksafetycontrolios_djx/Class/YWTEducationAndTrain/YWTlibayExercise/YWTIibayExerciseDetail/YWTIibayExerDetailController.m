//
//  IibayExerDetailController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/2/14.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTIibayExerDetailController.h"

#import <WebKit/WebKit.h>
#import "YWTLibayExerBottomToolView.h"
#import "YWTLibayExerDetaModel.h"
#import "YWTSpecialTrainingController.h"
#import "WKWebViewOrJSText.h"
#import "YWTLibayExerStartLearnPromptView.h"
#import "YWTLibayExerPromptView.h"
#import "YWTShowVerifyIdentidyErrorView.h"

#import "YWTIibayExerDetaIfonCell.h"
#define IIBAYEXERDETAIFON_CELL @"YWTIibayExerDetaIfonCell"

@interface YWTIibayExerDetailController ()
<
UITableViewDelegate,
UITableViewDataSource,
WKNavigationDelegate,
UIScrollViewDelegate
>{
  CGFloat webContentHeight;
}
// 底部工具view
@property (nonatomic,strong)YWTLibayExerBottomToolView *bottomToolView;
@property (nonatomic,strong) YWTLibayExerStartLearnPromptView *startLearnPromptView;
// 清空题库提示框
@property (nonatomic,strong) YWTLibayExerPromptView *libayExerPromptView;
// 验证失败view
@property (nonatomic,strong)YWTShowVerifyIdentidyErrorView *showVeriIndeErrorView;
// 提示框
@property (nonatomic,strong) YWTShowServicePromptView *showPromptView;

@property (nonatomic,strong) UITableView *detaTableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (strong,nonatomic) WKWebView *wkWebView;
@property (strong,nonatomic) UIScrollView *wbScrollView;

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

@implementation YWTIibayExerDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [self setNavi];
    //创建WkWebView
    [self createWKWebView];
    // 创建底部工具view
    [self createBottomView];
    // 创建TableView
    [self createTableView];
    // 请求数据接口
    [self requestQuestLibayIfons];
}
#pragma mark --- 创建TableView--------
-(void) createTableView{
    self.view.backgroundColor = [UIColor colorTextWhiteColor];
    
    self.detaTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH-KSIphonScreenH(65))];
    [self.view insertSubview:self.detaTableView atIndex:0];
    
    self.detaTableView.delegate = self;
    self.detaTableView.dataSource = self;
    self.detaTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.detaTableView.tableFooterView = self.wkWebView;
    
    if (@available(iOS 11.0, *)) {
        self.detaTableView.estimatedRowHeight = 0;
        self.detaTableView.estimatedSectionFooterHeight = 0;
        self.detaTableView.estimatedSectionHeaderHeight = 0 ;
        self.detaTableView.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.detaTableView registerClass:[YWTIibayExerDetaIfonCell class] forCellReuseIdentifier:IIBAYEXERDETAIFON_CELL];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWTIibayExerDetaIfonCell * cell = [tableView dequeueReusableCellWithIdentifier:IIBAYEXERDETAIFON_CELL forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    YWTLibayExerDetaModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWTLibayExerDetaModel *model = self.dataArr[indexPath.row];
    return [YWTIibayExerDetaIfonCell getDetaInfoHeight:model];
//  return KSIphonScreenH(340);
}
#pragma mark --- 创建WkWebView--------
-(void) createWKWebView{
    self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectZero];
    self.wkWebView.backgroundColor = [UIColor colorTextWhiteColor];
    self.wkWebView.navigationDelegate = self;
    
    self.wbScrollView = self.wkWebView.scrollView;
    self.wbScrollView.bounces = NO;
    self.wbScrollView.scrollEnabled = NO;
}
#pragma mark - WKNavigationDelegate -------
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //这个方法也可以计算出webView滚动视图滚动的高度
    [webView evaluateJavaScript:@"document.body.scrollWidth"completionHandler:^(id _Nullable result,NSError * _Nullable error){
        
//        CGFloat ratio =  CGRectGetWidth(self.wkWebView.frame) /[result floatValue];
        
        [webView evaluateJavaScript:@"document.body.scrollHeight"completionHandler:^(id _Nullable result,NSError * _Nullable error){
//            NSLog(@"scrollHeight高度：%.2f",[result floatValue]);
//            NSLog(@"scrollHeight计算高度：%.2f",[result floatValue]*ratio);
            CGFloat newHeight = [result floatValue];
            
            [self resetWebViewFrameWithHeight:newHeight];
            
            if (newHeight < CGRectGetHeight(self.view.frame)) {
                //如果webView此时还不是满屏，就需要监听webView的变化  添加监听来动态监听内容视图的滚动区域大小
                [self.wbScrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
            }
        }];
    }];
}
#pragma mark  ----- KVO回调 -------
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    //更具内容的高重置webView视图的高度
    CGFloat newHeight = self.wbScrollView.contentSize.height;
//    NSLog(@"kvo算出的高度啊：%.f",newHeight);
    [self resetWebViewFrameWithHeight:newHeight];
}

-(void)resetWebViewFrameWithHeight:(CGFloat)height{
    //如果是新高度，那就重置
    if (height != webContentHeight) {
        [self.wkWebView setFrame:CGRectMake(0, 0, KScreenW, height)];
        [self.detaTableView reloadData];
        webContentHeight = height;
    }
}
#pragma mark ---- 创建底部工具view -------
-(void) createBottomView{
    __weak typeof(self) weakSelf = self;
    self.bottomToolView = [[YWTLibayExerBottomToolView alloc]initWithFrame:CGRectMake(0, KScreenH-KSTabbarH-KSIphonScreenH(55), KScreenW, KSIphonScreenH(55))];
    [self.view addSubview:self.bottomToolView];
     // 1为继续练习 2为开始练习 3为再次练习
    if ([weakSelf.sequentPracStatus isEqualToString:@"1"]) {
        [self.bottomToolView.samilLearnBtn setTitle:@"继续学习" forState:UIControlStateNormal];
        [self.bottomToolView.samilLearnBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorContinueBtnIsSelectColor:NO]] forState:UIControlStateNormal];
        [self.bottomToolView.samilLearnBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorContinueBtnIsSelectColor:YES]] forState:UIControlStateHighlighted];
    }else if ([self.sequentPracStatus isEqualToString:@"2"]){
        [self.bottomToolView.samilLearnBtn setTitle:@"开始学习" forState:UIControlStateNormal];
        [self.bottomToolView.samilLearnBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
        [self.bottomToolView.samilLearnBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorLineCommonBlueColor]] forState:UIControlStateNormal];
    }else if ([self.sequentPracStatus isEqualToString:@"3"]){
        [self.bottomToolView.samilLearnBtn setTitle:@"再次学习" forState:UIControlStateNormal];
        [self.bottomToolView.samilLearnBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorWithHexString:@"#f49894"]] forState:UIControlStateNormal];
        [self.bottomToolView.samilLearnBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorWithHexString:@"#f49894"alpha:0.8]] forState:UIControlStateSelected];
    }
    // 错题巩固
    self.bottomToolView.errorQuestBlock = ^{
        // 判断是否开启人脸
        if ([YWTTools getWithFaceMonitorStr:[NSString stringWithFormat:@"%@",weakSelf.nowDataDict[@"monitor"]]]) {
            weakSelf.monitorRulesArr = nil;
            weakSelf.monitorRulesArr = (NSArray*)weakSelf.nowDataDict[@"monitorRules"];
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
                [weakSelf pushSequentPracViewDict];
            }
        }else{
            // 跳转到 错题巩固
            weakSelf.pushLibaryType = @"1";
            [weakSelf pushSequentPracViewDict];
        }
    };
    // 我的收藏
    self.bottomToolView.mineCollecBlock = ^{
        // 判断是否开启人脸
        if ([YWTTools getWithFaceMonitorStr:[NSString stringWithFormat:@"%@",weakSelf.nowDataDict[@"monitor"]]]) {
            weakSelf.monitorRulesArr = nil;
            weakSelf.monitorRulesArr = (NSArray*)weakSelf.nowDataDict[@"monitorRules"];
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
                weakSelf.pushLibaryType = @"2";
                [weakSelf pushSequentPracViewDict];
            }
        }else{
            // 跳转到 错题巩固
            weakSelf.pushLibaryType = @"2";
            [weakSelf pushSequentPracViewDict];
        }
    };
    // 开始练习
    self.bottomToolView.beginLearnBlock = ^{
        if ([weakSelf.sequentPracStatus  isEqualToString:@"3"]) {
            [weakSelf createClearUserLibaryDict];
        }else{
             [weakSelf createBeginLearnPromptView];
        }
    };
}
#pragma mark --- 创建清空做题记录 --------
-(void) createClearUserLibaryDict{
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.libayExerPromptView];
    NSString *contentStr = [NSString stringWithFormat:@"您已完整学习该题库，正确%@题，错误%@题，您是否需要清空做题再次练习?",self.succeedStr,self.errorStr];
    self.libayExerPromptView.showContentLab.attributedText = [self getAttrbuteContentStr:contentStr andAlterTotalStr:self.succeedStr answerStr:self.errorStr];
    
    // 直接进入
    self.libayExerPromptView.enterExam = ^{
        [weakSelf.libayExerPromptView removeFromSuperview];
        [weakSelf createBeginLearnPromptView];
    };
    // 清空重做
    self.libayExerPromptView.againExer = ^{
        [weakSelf.libayExerPromptView removeFromSuperview];
        [weakSelf requestClearUserQuestDict];
    };
}
#pragma mark --- 创建开始学习弹框 --------
-(void) createBeginLearnPromptView{
    __weak typeof(self) weakSelf = self;
    [weakSelf.view addSubview:weakSelf.startLearnPromptView];
    
    // 顺序练习
    weakSelf.startLearnPromptView.selectSequenPrac = ^{
        [weakSelf.startLearnPromptView removeFromSuperview];
        // 判断是否开启人脸
        if ([YWTTools getWithFaceMonitorStr:[NSString stringWithFormat:@"%@",weakSelf.nowDataDict[@"monitor"]]]) {
            weakSelf.monitorRulesArr = nil;
            weakSelf.monitorRulesArr = (NSArray*)weakSelf.nowDataDict[@"monitorRules"];
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
                weakSelf.pushLibaryType = @"3";
                [weakSelf pushSequentPracViewDict];
            }
        }else{
            // 跳转到 错题巩固
            weakSelf.pushLibaryType = @"3";
            [weakSelf pushSequentPracViewDict];
        }
    };
    
    // 专项练习
    weakSelf.startLearnPromptView.selectSpecialPrac = ^{
        [weakSelf.startLearnPromptView removeFromSuperview];
        YWTSpecialTrainingController *specTrainVC = [[YWTSpecialTrainingController alloc]init];
        specTrainVC.libaryIdStr = weakSelf.libaryIdStr;
        specTrainVC.dataDict = weakSelf.nowDataDict;
        [weakSelf.navigationController pushViewController:specTrainVC animated:YES];
    };
}
#pragma mark --- 跳转到顺序练习 --------
// weakSelf.pushLibaryType  1 错题练习 2 我的收藏 3 顺序练习
-(void) pushSequentPracViewDict{
    __weak typeof(self) weakSelf = self;
    WKWebViewOrJSText *wkWebVC = [[WKWebViewOrJSText alloc]init];
    if ([weakSelf.pushLibaryType isEqualToString:@"1"]) {
        wkWebVC.titleType = showLibaryTitleErrorQuestType;
    }else if ([weakSelf.pushLibaryType isEqualToString:@"2"]){
        wkWebVC.titleType = showLibaryTitleMineCollecType;
    }else if ([weakSelf.pushLibaryType isEqualToString:@"3"]){
        wkWebVC.titleType = showLibaryTitleSequentPracType;
        wkWebVC.sequentPracStatus = weakSelf.sequentPracStatus;
    }
    wkWebVC.libaryIdStr = weakSelf.libaryIdStr;
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
#pragma mark ---- <UIScrollViewDelegate>----
//只要滚动了就会触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y > 130) {
        [UIView animateWithDuration:0.25 animations:^{
            [self.customNavBar wr_setBackgroundAlpha:1];
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            [self.customNavBar wr_setBackgroundAlpha:0];
        }];
    }
}
-(void)dealloc{
    // 移除KVO
    [self.wbScrollView removeObserver:self forKeyPath:@"contentSize"];
}
// UILabel 富文本
/*
 nameStr : 传入的文字
 colorStr   : 要想修改的文字
 */
-(NSMutableAttributedString *) getAttrbuteContentStr:(NSString *)contentStr andAlterTotalStr:(NSString *)succesStr answerStr:(NSString *)errorStr{
    NSMutableAttributedString  *attributStr = [[NSMutableAttributedString alloc]initWithString:contentStr];
    NSRange range = NSMakeRange(12, succesStr.length);
    if (range.location != NSNotFound) {
        // 设置颜色
        [attributStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#00c356"] range:range];
        // 设置字体
        [attributStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:range];
    }
    
    NSRange answerRange = NSMakeRange(12+4+succesStr.length, errorStr.length);
    if (answerRange.location != NSNotFound) {
        // 设置颜色
        [attributStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff3030"] range:answerRange];
        // 设置字体
        [attributStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:answerRange];
    }
    return attributStr;
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:0];
    
    self.customNavBar.title = @"题库详细信息";
    
    __weak typeof(self) weakSelf = self;
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}
#pragma mark ---懒加载 --------
-(YWTLibayExerStartLearnPromptView *)startLearnPromptView{
    if (!_startLearnPromptView) {
        _startLearnPromptView = [[YWTLibayExerStartLearnPromptView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH)];
    }
    return _startLearnPromptView;
}
-(YWTShowServicePromptView *)showPromptView{
    if (!_showPromptView) {
        _showPromptView = [[YWTShowServicePromptView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH)];
    }
    return _showPromptView;
}
-(YWTLibayExerPromptView *)libayExerPromptView{
    if (!_libayExerPromptView) {
        _libayExerPromptView = [[YWTLibayExerPromptView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH)];
    }
    return _libayExerPromptView;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(void)setLibaryIdStr:(NSString *)libaryIdStr{
    _libaryIdStr = libaryIdStr;
}
-(void)setSequentPracStatus:(NSString *)sequentPracStatus{
    _sequentPracStatus = sequentPracStatus;
}
-(void)setSucceedStr:(NSString *)succeedStr{
    _succeedStr = succeedStr;
}
-(void)setErrorStr:(NSString *)errorStr{
    _errorStr = errorStr;
}
-(void)setDoNumStr:(NSString *)doNumStr{
    _doNumStr = doNumStr;
}
-(void)setPercentStr:(NSString *)percentStr{
    _percentStr = percentStr;
}
-(void)setNowDataDict:(NSDictionary *)nowDataDict{
    _nowDataDict = nowDataDict;
}
#pragma mark --- 题库详情 --------
-(void) requestQuestLibayIfons{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"libaryId"] =self.libaryIdStr;
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPQUSTLIBARYQUESTIONINFOS_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
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
        if (![showdata isKindOfClass:[NSDictionary class]]) {
            [self.view showErrorWithTitle:@"返回格式错误!" autoCloseTime:1];
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        // 字典转模型
        YWTLibayExerDetaModel *model = [YWTLibayExerDetaModel yy_modelWithDictionary:showdata];
        model.doNum = self.doNumStr;
        model.percentStr = self.percentStr;
        // 添加数据源
        [self.dataArr addObject:model];
        
        // 加载本地html
        NSString *urlStr = model.descr;
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
        [self.wkWebView loadRequest:request];
        // 刷新UI
        [self.detaTableView reloadData];
    }]; 
}
#pragma mark ---  清空题库练习的做题记录----------
-(void) requestClearUserQuestDict{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"libaryId"] =self.libaryIdStr;
    param[@"token"] = [YWTTools getNewToken];
    param[@"typeOf"] = @"1";
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPQUSTLISCLEARUSERQUESTLIBAY_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        [self createBeginLearnPromptView];
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
                    [self pushSequentPracViewDict];
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
                    [self pushSequentPracViewDict];
                }
            }else{
                //记录验证失败次数
                self.veriErrorNumber += 1;
                if (self.veriErrorNumber >= [self.veriNumberStr integerValue]) {
                    [self.showVeriIndeErrorView removeFromSuperview];
                    // 是否开始验证
                    if ([ruleStr isEqualToString:@"start"]) {
                        // 跳转到文件详情页面  （hl5）
                        [self pushSequentPracViewDict];
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
