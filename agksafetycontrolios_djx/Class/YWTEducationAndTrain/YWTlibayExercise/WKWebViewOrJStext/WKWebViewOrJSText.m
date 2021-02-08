//
//  WKWebViewOrJSText.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/22.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "WKWebViewOrJSText.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "YWTShowUnNetWorkStatuView.h"
#import "YWTShowVerifyIdentidyErrorView.h"

#import "WkWebViewNaviTitleView.h"

@interface WKWebViewOrJSText ()<WKUIDelegate,WKScriptMessageHandler,WKNavigationDelegate>

@property (nonatomic,strong) WKWebView *wkWebView;
// 没有网络view
@property (nonatomic,strong) YWTShowUnNetWorkStatuView *showNetWorkStatuView;

@property (nonatomic,strong) WkWebViewNaviTitleView *naviTitleView;
// 加载提示框
@property (nonatomic,strong)  MBProgressHUD *HUD;
// 接收js 传过来的  定义 1 收藏 2是未收藏
@property (nonatomic,strong) NSString *collectStr;
// 验证失败view
@property (nonatomic,strong)YWTShowVerifyIdentidyErrorView *showVeriIndeErrorView;
// 记录 进入页面得时间【时间戳】
@property (nonatomic,assign) NSInteger startTimer;
// 记录当前人脸规则的数据源
@property (nonatomic,strong) NSDictionary *nowVeriDict;
// 只能使用一次
@property (nonatomic ,assign) BOOL isOne;

@end

@implementation WKWebViewOrJSText

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorTextWhiteColor];
    self.isOne = YES;
    // 设置导航栏
    [self setNavi];
    //
    [self createWKWebView];
    // 注册网络通知
    [self registeredNetworkTifi];
}
//-(void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    // 清除缓存
//    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
//    //// Date from
//    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
//    //// Execute
//    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
//        // Done
//    }];
//}
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
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    // web内容处理池
    config.processPool = [[WKProcessPool alloc] init];
    // 通过JS与webview内容交互
    config.userContentController = [[WKUserContentController alloc] init];
    // 注入JS对象名称AppModel，当JS通过AppModel来调用时，
    // 我们可以在WKScriptMessageHandler代理中接收到
    [config.userContentController addScriptMessageHandler:self name:@"CallAppToWebInit"];
    [config.userContentController addScriptMessageHandler:self name:@"CallWebToAppSetFavorite"];
    [config.userContentController addScriptMessageHandler:self name:@"CallAppToWebSetFavorite"];
    [config.userContentController addScriptMessageHandler:self name:@"CallWebToAppTokenInvalid"];
    [config.userContentController addScriptMessageHandler:self name:@"CallWebToAppShowErrorLayout"];
    [config.userContentController addScriptMessageHandler:self name:@"CallAppToWebSetViewMode"];
    [config.userContentController addScriptMessageHandler:self name:@"CallWebToAppSetViewMode"];
    [config.userContentController addScriptMessageHandler:self name:@"CallWebToAppShowBoxView"];
    self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KScreenH-KSNaviTopHeight-KSTabbarH) configuration:config];
   
//    NSURL *url = [NSURL URLWithString:@"http://192.168.3.201:2580"];
    NSURL *url = [NSURL URLWithString:@"http://webapp.djx.cqlanhui.com"];
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:url]];
    self.wkWebView.navigationDelegate = self;
    self.wkWebView.UIDelegate = self;
    self.wkWebView.scrollView.bounces = NO;
    [self.view addSubview:self.wkWebView];
}
#pragma mark - WKScriptMessageHandler ------
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    // 1 收藏 2是未收藏
    if ([message.name isEqualToString:@"CallWebToAppSetFavorite"]) {
        self.collectStr = [NSString stringWithFormat:@"%@",message.body];
        if ([self.collectStr isEqualToString:@"1"]) {
             self.customNavBar.rightButton.selected = YES;
        }else{
            self.customNavBar.rightButton.selected = NO;
        }
    }
    // token 失效
    if ([message.name isEqualToString:@"CallWebToAppTokenInvalid"]) {
        [self showPromptView];
    }
   
    //1需要弹提示框 2不需要
    if ([message.name isEqualToString:@"CallWebToAppShowBoxView"]) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
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
    // 标题接收函数  1:答题模式 2：背题模式
    if ([message.name isEqualToString:@"CallWebToAppSetViewMode"]) {
        NSString *msg = [NSString stringWithFormat:@"%@",message.body];
        [self.naviTitleView alterSelectBtnMode:msg];
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
    __weak typeof(self)  weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.HUD = [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
        weakSelf.HUD.bezelView.color =[UIColor colorWithWhite:0 alpha:0.7];
        weakSelf.HUD.contentColor = [UIColor colorWithWhite:1 alpha:1];
    });
}
// 加载完成  传值
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    // 隐藏加载提示框
    __weak typeof(self)  weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.HUD hideAnimated:YES];
    });
    // 请求数据
    [self requestLibayExerData];
    
    // 导航标题方法
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"type"] = @"1";
    [self getWithJsPassValue:param];
}
// 网页由于某些原因加载失败
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    // 隐藏加载提示框
    __weak typeof(self)  weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.HUD hideAnimated:YES];
    });
    [self createShowNetWorkStatuStr:@"1" andContentStr:@"" andReloadBtn:@"1"];
}
// 加载失败
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    // 隐藏加载提示框
    __weak typeof(self)  weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.HUD hideAnimated:YES];
    });
    [self createShowNetWorkStatuStr:@"1" andContentStr:@"" andReloadBtn:@"1"];
}
// 网页加载内容进程终止
-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    // 隐藏加载提示框
    __weak typeof(self)  weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.HUD hideAnimated:YES];
    });
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
// 请求数据
-(void) requestLibayExerData{
    /*
     *libaryId：题库id
     * typeOf: 1：顺序练习 2：专项练习 3 :错题练习 * 4: 收藏
     * status: 是否继续练习 1:继续  2：开始
     * chapterId： 章节id【专项练习使用】
     * typeId:试题类型【专项练习使用】 1：单选题 2：多选题 3：判断题 4：问答题 5：填空题 6:主观题
     * page:当前页数
     */
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] =[YWTTools getNewToken];
    param[@"page"] = @"0";
    param[@"appType"] = @"IOS";
    // 题库ID
    param[@"libaryId"] = self.libaryIdStr;
    if (self.titleType == showLibaryTitleSequentPracType) {
        // 顺序练习
        // 章节id
        param[@"chapterId"] = @"0";
        // 试题类型
        param[@"typeId"] = @"0";
        // 练习类型
        param[@"typeOf"] = @"1";
        // 是否继续练习
        param[@"status"] = [NSString stringWithFormat:@"%@",self.sequentPracStatus];
    }else if (self.titleType == showLibaryTitleSpecialTrainType){
        // 专项训练
        // 练习类型
        param[@"typeOf"] = @"2";
        // 是否继续练习
        param[@"status"] = @"0";
        // 章节id
        param[@"chapterId"] =self.chapterIdStr;
        // 试题类型
        param[@"typeId"] = self.typeIdStr;
    }else if (self.titleType == showLibaryTitleErrorQuestType){
        // 错题巩固
        // 练习类型
        param[@"typeOf"] = @"3";
        // 是否继续练习
        param[@"status"] = @"0";
        // 章节id
        param[@"chapterId"] = @"0";
        // 试题类型
        param[@"typeId"] = @"0";
    }else if (self.titleType == showLibaryTitleMineCollecType){
        // 我的收藏
        // 练习类型
        param[@"typeOf"] = @"4";
        // 是否继续练习
        param[@"status"] = @"0";
        // 章节id
        param[@"chapterId"] = @"0";
        // 试题类型
        param[@"typeId"] = @"0";
    }
    NSString *str = [self getWithJsParamDict:param];
    NSString *jsStr = [NSString stringWithFormat:@"CallAppToWebInit(%@)",str];
    __weak typeof(self) weakSelf = self;
    [self.wkWebView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//        NSLog(@"response: %@ error: %@", result, error);
        // 记录 进入页面得时间【时间戳】
        weakSelf.startTimer = [YWTTools getNowTimestamp];
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
        [self createShowNetWorkStatuStr:@"1" andContentStr:@"" andReloadBtn:@"1"];
    }
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
    
    __weak typeof(self) weakSelf = self;
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    self.customNavBar.onClickLeftButton = ^{
        if (![weakSelf.taskIdStr isEqualToString:@""]) {
            if ([weakSelf getByMonitorNameHaveFoundMonitorDict:@"end"]) {
                // 通过规则 调用人脸识别
                NSDictionary *faceDict = [weakSelf createFaveVerificationStr:@"end"];
                weakSelf.nowVeriDict = nil;
                weakSelf.nowVeriDict = faceDict;
                // 开始人脸认证
                [weakSelf passRulesConductFaceVeri:faceDict];
            }else{
               [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        }else{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    };
    
    // 标题
    [self.customNavBar addSubview:self.naviTitleView];
    self.naviTitleView.selectBtnBlock = ^(NSInteger btnTag) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        switch (btnTag) {
            case 1:{
                param[@"type"] = @"1";
                [weakSelf getWithJsPassValue:param];
                break;
            }
            case 2:{
                param[@"type"] = @"2";
                [weakSelf getWithJsPassValue:param];
                break;
            }
            default:
                break;
        }
    };
    
    //收藏
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@""]];
    [self.customNavBar.rightButton setImage:[UIImage imageNamed:@"nav_ico_nor_sc"] forState:UIControlStateNormal];
    [self.customNavBar.rightButton setImage:[UIImage imageNamed:@"nav_ico_sel_sc"] forState:UIControlStateSelected];
    self.customNavBar.onClickRightButton = ^{
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"id"] = @"";
        if ([weakSelf.collectStr isEqualToString:@"1"]) {
            param[@"type"] = @"2";
        }else{
             param[@"type"] = @"1";
        }
        NSString *jsCallWebSetFavoriteStr = [weakSelf getWithJsParamDict:param];
        NSString *jsStr = [NSString stringWithFormat:@"CallAppToWebSetFavorite(%@)",jsCallWebSetFavoriteStr];
        [weakSelf.wkWebView evaluateJavaScript:jsStr completionHandler:^(id _Nullable resp, NSError * _Nullable error) {
            NSLog(@"error = %@ , response = %@",error, resp);
        }];
    };
    if (self.titleType ==  showLibaryTitleSequentPracType) {
    
    }else if (self.titleType == showLibaryTitleSpecialTrainType){
      
    }else if (self.titleType == showLibaryTitleErrorQuestType){
        
    }else if (self.titleType == showLibaryTitleMineCollecType){
        self.customNavBar.rightButton.hidden = YES;
    }
}
//  标题点击方法 传值给JS
-(void) getWithJsPassValue:(NSDictionary*)dict{
    __weak typeof(self) weakSelf = self;
    NSString *str = [weakSelf getWithJsParamDict:dict];
    NSString *jsStr = [NSString stringWithFormat:@"CallAppToWebSetViewMode(%@)",str];
    [weakSelf.wkWebView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"response: %@ error: %@", result, error);
    }];
}
// 转换给js 的参数
-(NSString *) getWithJsParamDict:(NSDictionary *)dict{
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:nil];
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return str;
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
        // 只能使用一次
        if (!self.isOne) {
            return;
        }
        if (![weakSelf.taskIdStr isEqualToString:@""]) {
            if ([weakSelf getByMonitorNameHaveFoundMonitorDict:@"end"]) {
                // 通过规则 调用人脸识别
                NSDictionary *faceDict = [weakSelf createFaveVerificationStr:@"end"];
                weakSelf.nowVeriDict = nil;
                weakSelf.nowVeriDict = faceDict;
                // 开始人脸认证
                [weakSelf passRulesConductFaceVeri:faceDict];
            }
        }
    }
}
- (void)didMoveToParentViewController:(UIViewController*)parent{
    [super didMoveToParentViewController:parent];
}

#pragma mark --- 懒加载--------
-(YWTShowUnNetWorkStatuView *)showNetWorkStatuView{
    if (!_showNetWorkStatuView) {
        _showNetWorkStatuView = [[YWTShowUnNetWorkStatuView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KScreenH-KSNaviTopHeight-KSTabbarH)];
    }
    return _showNetWorkStatuView;
}
-(WkWebViewNaviTitleView *)naviTitleView{
    if (!_naviTitleView) {
        _naviTitleView = [[WkWebViewNaviTitleView alloc]initWithFrame:CGRectMake((KScreenW-15-KSIphonScreenW(166))/2, KSStatusHeight+(22-KSIphonScreenH(30)/2), KSIphonScreenW(166), KSIphonScreenH(30))];
    }
    return _naviTitleView;
}
-(NSDictionary *)nowVeriDict{
    if (!_nowVeriDict) {
        _nowVeriDict = [NSDictionary dictionary];
    }
    return _nowVeriDict;
}
-(void)setTitleType:(showLibaryTitleType)titleType{
    _titleType = titleType;
}
-(void)setLibaryIdStr:(NSString *)libaryIdStr{
    _libaryIdStr = libaryIdStr;
}
-(void)setSequentPracStatus:(NSString *)sequentPracStatus{
    _sequentPracStatus = sequentPracStatus;
}
-(void)setChapterIdStr:(NSString *)chapterIdStr{
    _chapterIdStr = chapterIdStr;
}
-(void)setTypeIdStr:(NSString *)typeIdStr{
    _typeIdStr = typeIdStr;
}
-(void)setMonitorRulesArr:(NSArray *)monitorRulesArr{
    _monitorRulesArr =  monitorRulesArr;
}
-(void)setTaskIdStr:(NSString *)taskIdStr{
    _taskIdStr = taskIdStr;
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
    param[@"taskId"] = self.taskIdStr;
    
    [[KRMainNetTool sharedKRMainNetTool] upLoadPhotoUrl:HTTP_ATTAPPMOITORAPIFACERECOGINTION_URL params:param photo:faceImage waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            // 只能使用一次
            self.isOne =  YES;
            // 失败view
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if (![showdata isKindOfClass:[NSDictionary class]]) {
            return;
        }
        // 只能使用一次
        self.isOne =  NO;
        // 返回上一页
        [self.navigationController popViewControllerAnimated:YES];
    }];
}


@end
