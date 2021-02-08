//
//  AnnexLookOverJSController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/27.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTAnnexLookOverJSController.h"
#import <WebKit/WebKit.h>
#import "YWTShowUnNetWorkStatuView.h"
#import "YWTShowVerifyIdentidyErrorView.h"

@interface YWTAnnexLookOverJSController () <WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
@property (nonatomic,strong) WKWebView *wkWebView;
// 没有网络view
@property (nonatomic,strong) YWTShowUnNetWorkStatuView *showNetWorkStatuView;
// 验证失败view
@property (nonatomic,strong)YWTShowVerifyIdentidyErrorView *showVeriIndeErrorView;
// 记录 进入页面得时间【时间戳】
@property (nonatomic,assign) NSInteger startTimer;
// 记录当前人脸规则的数据源
@property (nonatomic,strong) NSDictionary *nowVeriDict;
// 只能使用一次
@property (nonatomic ,assign) BOOL isOne;
@end

@implementation YWTAnnexLookOverJSController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 默认
    self.isOne = YES;
    //  设置导航栏.
    [self setNavi];
    //
    [self createWKWebView];
    // 注册网络通知
    [self registeredNetworkTifi];
    
    // 记录 进入页面得时间【时间戳】
    self.startTimer = [YWTTools getNowTimestamp];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    // 清除缓存
    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    //// Date from
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    //// Execute
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        // Done
    }];
}
#pragma mark - 创建WKWebView ------
-(void) createWKWebView{
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    // 设置偏好设置
    config.preferences = [[WKPreferences alloc] init];
    // 默认为0
    config.preferences.minimumFontSize = 10;
    // 默认认为YES
    config.preferences.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示不能自动通过窗口打开
    config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    // web内容处理池
    config.processPool = [[WKProcessPool alloc] init];
    // 通过JS与webview内容交互
    config.userContentController = [[WKUserContentController alloc] init];
    // 注入JS对象名称AppModel，当JS通过AppModel来调用时，
    // 我们可以在WKScriptMessageHandler代理中接收到
    [config.userContentController addScriptMessageHandler:self name:@"CallAppToWebViewer"];
    [config.userContentController addScriptMessageHandler:self name:@"CallWebToAppTokenInvalid"];
    [config.userContentController addScriptMessageHandler:self name:@"CallWebToAppShowErrorLayout"];
    self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KScreenH-KSNaviTopHeight-KSTabbarH) configuration:config];
    
//    NSURL *url = [NSURL URLWithString:@"http://192.168.3.201:2580/#/viewer"];
    NSURL *url = [NSURL URLWithString:@"http://webapp.agk.cqlanhui.com/#/viewer"];
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:url]];
    self.wkWebView.navigationDelegate = self;
    self.wkWebView.UIDelegate = self;
    self.wkWebView.scrollView.bounces = NO;
    [self.view addSubview:self.wkWebView];
}
#pragma mark - WKScriptMessageHandler ------
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    // token 失效
    if ([message.name isEqualToString:@"CallWebToAppTokenInvalid"]) {
        [self showPromptView];
    }
    // 错误提示
    if ([message.name isEqualToString:@"CallWebToAppShowErrorLayout"]) {
        NSDictionary *dict =message.body;
        NSString *msg = [NSString stringWithFormat:@"%@",dict[@"message"]];
        NSString *reloadBtnStr = [NSString stringWithFormat:@"%@",dict[@"reloadBtn"]];
        if ([msg isEqualToString:@""]) {
            [self createShowNetWorkStatuStr:@"1" andContentStr:@"" andReloadBtn:reloadBtnStr];
        }else{
            [self createShowNetWorkStatuStr:@"2" andContentStr:msg andReloadBtn:reloadBtnStr];
        }
    }
}
-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    //如果是跳转一个新页面
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}
#pragma mark ----- WKNavigationDelegate  -------
// 开始加载wkweb
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
   
}
// 加载完成  传值
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    // 请求数据
    [self requestLibayExerData];
    
}
// 网页由于某些原因加载失败
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
   
    [self createShowNetWorkStatuStr:@"1" andContentStr:@"" andReloadBtn:@"1"];
}
// 加载失败
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
   
    [self createShowNetWorkStatuStr:@"1" andContentStr:@"" andReloadBtn:@"1"];
}
// 网页加载内容进程终止
-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
   
    [self createShowNetWorkStatuStr:@"1" andContentStr:@"" andReloadBtn:@"1"];
}
#pragma mark -----提示框 -------
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"alert" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
    completionHandler();
}
//显示
-(void) showPromptView{
    AppDelegate *appdel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //删除
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"登录已过期,请重新登录!" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //退出的时候删除别名
        [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            if (iResCode == 0) {
                NSLog(@"删除别名成功");
            }
        } seq:1];
        //删除本地用户信息
        [YWTUserInfo delUserInfo];
        
        SDRootNavigationController *loginVC = [[SDRootNavigationController alloc]initWithRootViewController:[YWTLoginViewController new]];
        appdel.window.rootViewController = loginVC;
    }]];
    [appdel.window.rootViewController presentViewController:alertController animated:YES completion:nil];
}
#pragma mark --- 注册网络通知 --------
-(void) registeredNetworkTifi{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unNetwork:) name:@"NetWorkStatu" object:nil];
}
// 获取网络状态
-(void)unNetwork:(NSNotification *)tifi{
    NSDictionary *dict = tifi.userInfo;
    if ([dict[@"netwrok"] isEqualToString:@"NO"]) {
        [self createShowNetWorkStatuStr:@"1" andContentStr:@"" andReloadBtn:@"1"];
    }
}

// 请求数据
-(void) requestLibayExerData{
    /*
     *token：
     * appType: 手机端类型
     * fileId:  文件id
     * chapterId： 章节id【专项练习使用】
     * typeid:typeid=2代表学习中心过来 其他代表普通 文件
     * page:当前页数
     */
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] =[YWTTools getNewToken];
    param[@"appType"] = @"IOS";
    param[@"fileId"] =self.mIdStr;
    param[@"typeid"] = self.fileType;
    NSString *str = [self getWithJsParamDict:param];
    NSString *jsStr = [NSString stringWithFormat:@"CallAppToWebViewer(%@)",str];
    [self.wkWebView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"response: %@ error: %@", result, error);
       
    }];
}
// 转换给js 的参数
-(NSString *) getWithJsParamDict:(NSDictionary *)dict{
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:nil];
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return str;
}
#pragma mark --- 创建遮挡页图层 --------
// statuStr  1 默认没有网络  2 错误提示
-(void)createShowNetWorkStatuStr:(NSString *)statuStr andContentStr:(NSString *) contentStr andReloadBtn:(NSString *)reloadBtnStr{
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.showNetWorkStatuView];
    if ([statuStr isEqualToString:@"2"]) {
        self.showNetWorkStatuView.titleLab.text = contentStr;
        self.showNetWorkStatuView.bgImageV.image = [UIImage imageNamed:@"zwkt_pic"];
    }
    if ([reloadBtnStr isEqualToString:@"2"]) {
        self.showNetWorkStatuView.retryBtn.hidden = YES;
    }
    self.showNetWorkStatuView.selectRetryBlock = ^{
        NSString *networkStr = [YWTTools getNetworkTypeByReachability];
        if (![networkStr isEqualToString:@"NONE"]) {
            // 重新请求数据
            [weakSelf requestLibayExerData];
            // 移除
            [weakSelf.showNetWorkStatuView removeFromSuperview];
        }
    };
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    self.customNavBar.title = self.fileNameStr;
    
    __weak typeof(self) weakSelf = self;
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    self.customNavBar.onClickLeftButton = ^{
        
        if (![weakSelf getByMonitorNameHaveFoundMonitorDict:@"end"]) {
            // 学习时间上报
            [weakSelf.navigationController popViewControllerAnimated:YES];
            return ;
        }
        // 通过规则 调用人脸识别
        NSDictionary *faceDict = [weakSelf createFaveVerificationStr:@"end"];
        weakSelf.nowVeriDict = nil;
        weakSelf.nowVeriDict = faceDict;
        // 开始人脸认证
        [weakSelf passRulesConductFaceVeri:faceDict];
    };
}
#pragma mark --- 关于开启任务人脸识别模块 --------
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
    [self createShowVeriIndeErrorViewAndType:@"1"];
}
// 关闭
-(void)closeViewControll{
    [self createShowVeriIndeErrorViewAndType:@"1"];
}
#pragma mark --- 创建验证失败的view --------
//  1  没有直接进入按钮 非1 有
-(void) createShowVeriIndeErrorViewAndType:(NSString *)typeStr{
    __weak typeof(self) weakSelf = self;
    self.showVeriIndeErrorView = [[YWTShowVerifyIdentidyErrorView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH) andType:typeStr];
    [self.view addSubview:self.showVeriIndeErrorView];
    // 点击其他区域不能取消view
    self.showVeriIndeErrorView.isColseBigBgView = YES;
    
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
#pragma mark --- 系统回调 左滑返回拦截--------
- (void)willMoveToParentViewController:(UIViewController*)parent{
    [super willMoveToParentViewController:parent];
    __weak typeof(self) weakSelf = self;
    if (!parent) {
        
        if ([weakSelf.taskIdStr isEqualToString:@""]) {
            return;
        }
        // 只能使用一次
        if (!self.isOne) {
            return;
        }
        // 通过人脸规则 没有找到对应的人脸规则
        if (![weakSelf getByMonitorNameHaveFoundMonitorDict:@"end"]) {
            // 上报学习时间
            [self requestFileLeaRecordData];
            return;
        }
        // 通过规则 调用人脸识别
        NSDictionary *faceDict = [weakSelf createFaveVerificationStr:@"end"];
        weakSelf.nowVeriDict = nil;
        weakSelf.nowVeriDict = faceDict;
        // 开始人脸认证
        [weakSelf passRulesConductFaceVeri:faceDict];
    }
}
- (void)didMoveToParentViewController:(UIViewController*)parent{
    [super didMoveToParentViewController:parent];
}
//-(void)dealloc{
//    self.wkWebView.UIDelegate = nil;
//    self.wkWebView = nil;
//}
#pragma mark -----   get 方法   ------
-(void)setMIdStr:(NSString *)mIdStr{
    _mIdStr = mIdStr;
}
-(void)setFileNameStr:(NSString *)fileNameStr{
    _fileNameStr = fileNameStr;
}
-(void)setTaskIdStr:(NSString *)taskIdStr{
    _taskIdStr = taskIdStr;
}

-(void)setMonitorRulesArr:(NSArray *)monitorRulesArr{
    _monitorRulesArr = monitorRulesArr;
}
-(void)setFileType:(NSString *)fileType{
    _fileType = fileType;
}
-(NSDictionary *)nowVeriDict{
    if (!_nowVeriDict) {
        _nowVeriDict = [NSDictionary dictionary];
    }
    return _nowVeriDict;
}
#pragma mark -----   人脸识别对比  ------
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
    param[@"taskId"] = self.nowVeriDict[@"taskid"];
    
    [[KRMainNetTool sharedKRMainNetTool] upLoadPhotoUrl:HTTP_ATTAPPMOITORAPIFACERECOGINTION_URL params:param photo:faceImage waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            // 只能使用一次
            self.isOne =  YES;
            
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if (![showdata isKindOfClass:[NSDictionary class]]) {
            return;
        }
        //判断是否是 结束
        if ([ruleStr isEqualToString:@"end"]) {
            // 只能使用一次
            self.isOne =  NO;
            // 学习时间上报
            [self requestFileLeaRecordData];
        }
    }];
}
#pragma mark ------ 学习时间上报  ----
-(void) requestFileLeaRecordData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"taskid"] = self.taskIdStr;
    param[@"fileName"] = self.fileNameStr;
    param[@"id"] = self.mIdStr;
    param[@"startTime"] = [NSNumber numberWithInteger:self.startTimer];
    NSString *startTimeStr = [YWTTools timestampSwitchTime:self.startTimer andFormatter:@"YYYY-MM-dd HH:mm:s"];
    NSString *endTimeStr = [YWTTools timestampSwitchTime:[YWTTools getNowTimestamp] andFormatter:@"YYYY-MM-dd HH:mm:s"];
    NSTimeInterval  interval = [YWTTools pleaseInsertStarTime:startTimeStr andInsertEndTime:endTimeStr andFormatter:@"YYYY-MM-dd HH:mm:s"];
    param[@"taskTotalTime"] = [NSNumber numberWithInteger:interval];
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPFILEMANAGEMENTLEARECORD_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        // 返回上一页
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

@end
