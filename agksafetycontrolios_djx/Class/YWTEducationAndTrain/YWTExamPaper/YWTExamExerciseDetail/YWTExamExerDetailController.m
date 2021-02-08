//
//  ExamExerDetailController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/15.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTExamExerDetailController.h"
#import <WebKit/WebKit.h>

#import "YWTExamPaperExerciseController.h"
#import "YWTExamExerDetaModel.h"
#import "YWTlibayExerciseController.h"
#import "YWTShowServicePromptView.h"

#import "YWTDetaQuestTitleTableViewCell.h"
#define DETAQUESTTITILETABLEIVEW_CELL @"YWTDetaQuestTitleTableViewCell"
#import "YWTDetailQuestInfoTableViewCell.h"
#define DETAILQUESTINFOTBLEVIEW_CELL @"YWTDetailQuestInfoTableViewCell"


@interface YWTExamExerDetailController ()
<
UITableViewDelegate,
UITableViewDataSource,
WKNavigationDelegate
>{
    CGFloat webContentHeight;
}
@property (strong,nonatomic) WKWebView *wkWebView;

@property (strong,nonatomic) UIScrollView *wbScrollView;
// 提示框
@property (nonatomic,strong) YWTShowServicePromptView *showPromptView;
@property (nonatomic,strong) UITableView *detaTableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
// 底部练习按钮
@property (nonatomic,strong) UIButton *bottomExerBtn;
// 数据源
@property (nonatomic,strong) YWTExamExerDetaModel  *detaModel;

@end

@implementation YWTExamExerDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [self setNavi];
    // 创建bottomBtn
    [self createBottomBtn];
    //创建WkWebView
    [self createWKWebView];
    // 创建滚动视图
    [self createTableView];
    // 请求数据接口
    [self requestExamDetailData];
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
#pragma mark --- 创建bottomBtn--------
-(void) createBottomBtn{
    __weak typeof(self) weakSelf = self;
    self.bottomExerBtn = [[UIButton alloc]init];
    [self.view addSubview:self.bottomExerBtn];
    [self.bottomExerBtn setTitle:@"开始测验" forState:UIControlStateNormal];
    [self.bottomExerBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    [self.bottomExerBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorLineCommonBlueColor]] forState:UIControlStateNormal];
    [self.bottomExerBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorClickCommonBlueColor]] forState:UIControlStateHighlighted];
    self.bottomExerBtn.titleLabel.font  = Font(17);
    [self.bottomExerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view).offset(-KSTabbarH);
        make.height.equalTo(@(KSIphonScreenH(50)));
    }];
    [self.bottomExerBtn addTarget:self action:@selector(selectExamBtn:) forControlEvents:UIControlEventTouchUpInside];
    if ([self.statuStr isEqualToString:@"2"]) {
        [self.bottomExerBtn setTitle:@"开始测验" forState:UIControlStateNormal];
        [self.bottomExerBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorLineCommonBlueColor]] forState:UIControlStateNormal];
    }else{
        [self.bottomExerBtn setTitle:@"继续测验" forState:UIControlStateNormal];
        [self.bottomExerBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorContinueBtnIsSelectColor:NO]] forState:UIControlStateNormal];
    }
}
#pragma mark --- 创建滚动视图 --------
-(void) createTableView{
    self.view.backgroundColor = [UIColor colorTextWhiteColor];
    self.detaTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH-KSIphonScreenH(50))];
    [self.view insertSubview:self.detaTableView atIndex:0];
   
    self.detaTableView.delegate = self;
    self.detaTableView.dataSource = self;
    self.detaTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.detaTableView.tableFooterView = self.wkWebView;
    
    [self.detaTableView registerClass:[YWTDetaQuestTitleTableViewCell class] forCellReuseIdentifier:DETAQUESTTITILETABLEIVEW_CELL];
    [self.detaTableView registerClass:[YWTDetailQuestInfoTableViewCell class] forCellReuseIdentifier:DETAILQUESTINFOTBLEVIEW_CELL];
    
    if (@available(iOS 11.0, *)) {
        self.detaTableView.estimatedRowHeight = 0;
        self.detaTableView.estimatedSectionFooterHeight = 0;
        self.detaTableView.estimatedSectionHeaderHeight = 0 ;
        self.detaTableView.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        YWTDetaQuestTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DETAQUESTTITILETABLEIVEW_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detaModel = self.dataArr[indexPath.row];
        return cell;
    }else{
        YWTDetailQuestInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DETAILQUESTINFOTBLEVIEW_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detaModel = self.dataArr[indexPath.row];
        __weak typeof(self) weakSelf = self;
        // 点击跳转到题库练习
        cell.pushLibayExer = ^(NSString *titleStr) {
            YWTlibayExerciseController *libayExerVC = [[YWTlibayExerciseController alloc]init];
            libayExerVC.titleStr = titleStr;
            [weakSelf.navigationController pushViewController:libayExerVC animated:YES];
        };
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   YWTExamExerDetaModel *model = self.dataArr[indexPath.row];
    if (indexPath.row == 0) {
        
        return [YWTDetaQuestTitleTableViewCell getLabelHeightWithDict:model];
    }else{
        return [YWTDetailQuestInfoTableViewCell getLabelHeightWithDict:model];
    }
}
#pragma mark - WKNavigationDelegate -------
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //这个方法也可以计算出webView滚动视图滚动的高度
    [webView evaluateJavaScript:@"document.body.scrollWidth"completionHandler:^(id _Nullable result,NSError * _Nullable error){
       

        [webView evaluateJavaScript:@"document.body.scrollHeight"completionHandler:^(id _Nullable result,NSError * _Nullable error){
            CGFloat newHeight = [result floatValue];
            
            [self resetWebViewFrameWithHeight:newHeight];

            if (newHeight < CGRectGetHeight(self.view.frame)) {
                //如果webView此时还不是满屏，就需要监听webView的变化  添加监听来动态监听内容视图的滚动区域大小
                [self.wbScrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
            }
        }];
    }];
}
// 网页由于某些原因加载失败
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    // 隐藏加载提示框
    [self.wbScrollView removeObserver:self forKeyPath:@"contentSize"];
}
// 加载失败
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    // 隐藏加载提示框
    [self.wbScrollView removeObserver:self forKeyPath:@"contentSize"];
}
// 网页加载内容进程终止
-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    // 隐藏加载提示框
    [self.wbScrollView removeObserver:self forKeyPath:@"contentSize"];
}
-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}

#pragma mark  ----- KVO回调 -------
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    //更具内容的高重置webView视图的高度
    CGFloat newHeight = self.wbScrollView.contentSize.height;
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
#pragma mark ----开始练习-------
-(void)selectExamBtn:(UIButton *) sender{
    YWTExamPaperExerciseController *exerciseVC = [[YWTExamPaperExerciseController alloc]init];
    exerciseVC.examType = showTableViewExamPaperType;
    exerciseVC.paperIdStr = self.paperIdStr;
    exerciseVC.examIdStr =  self.paperIdStr;
    exerciseVC.examRoomIdStr =  self.examRoomIdStr;
    exerciseVC.examBatchIdStr = @"1";
    exerciseVC.taskIdStr = self.taskIdStr;
    [self.navigationController pushViewController:exerciseVC animated:YES];
}
#pragma mark ---- 懒加载 -------
-(YWTShowServicePromptView *)showPromptView{
    if (!_showPromptView) {
        _showPromptView = [[YWTShowServicePromptView alloc]initWithFrame:CGRectMake(0,0, KScreenW, KScreenH-KSTabbarH)];
    }
    return _showPromptView;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(YWTExamExerDetaModel *)detaModel{
    if (!_detaModel) {
        _detaModel = [[YWTExamExerDetaModel alloc]init];
    }
    return _detaModel;
}
-(void)setExamIdStr:(NSString *)examIdStr{
    _examIdStr = examIdStr;
}
-(void)setExamRoomIdStr:(NSString *)examRoomIdStr{
    _examRoomIdStr = examRoomIdStr;
}
-(void)setStatuStr:(NSString *)statuStr{
    _statuStr = statuStr;
}
-(void)setPaperIdStr:(NSString *)paperIdStr{
    _paperIdStr = paperIdStr;
}
-(void)setMonitorRulesArr:(NSArray *)monitorRulesArr{
    _monitorRulesArr = monitorRulesArr;
}
-(void)setTaskIdStr:(NSString *)taskIdStr{
    _taskIdStr = taskIdStr;
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:0];
    
    self.customNavBar.title = @"测验详细信息";
    
    __weak typeof(self) weakSelf = self;
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}
#pragma mark -----请详情信息-------
-(void) requestExamDetailData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"paperId"] =  self.paperIdStr;
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPQUESTIONEXAMDETAILS_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
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
            [self.view showErrorWithTitle:@"返回数据格式错误" autoCloseTime:1];
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        // 数据转模型
        self.detaModel = [YWTExamExerDetaModel yy_modelWithDictionary:showdata];
        // 添加数据源
        [self.dataArr addObject:self.detaModel];
        [self.dataArr addObject:self.detaModel];
        
        // 加载本地html
        NSString *urlStr = self.detaModel.desc;
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
        [self.wkWebView loadRequest:request];
        
        [self.detaTableView reloadData];
    }];
}





@end
