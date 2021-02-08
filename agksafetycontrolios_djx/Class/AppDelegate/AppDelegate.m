//
//  AppDelegate.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/8/30.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "AppDelegate.h"

#import "YWTHomeViewController.h"
#import "YWTLoginViewController.h"
#import "YWTLeftViewController.h"
#import "YWTBootLoaderController.h"

// 跳转模块类名
#import "YWTTaskCenterListController.h"
#import "YWTlibayExerciseController.h"
#import "YWTExamPaperListController.h"
#import "YWTExamCenterListController.h"
#import "YWTMyStudiesController.h"
#import "YWTBaseTableViewController.h"
#import "YWTAttendanceChenkController.h"

#import "YWTTaskCenterReultPromptView.h"

#import <CoreLocation/CLLocationManager.h>

@interface AppDelegate () <BMKLocationAuthDelegate,JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //百度云 人脸采集
    NSString* licensePath = [[NSBundle mainBundle] pathForResource:FACE_LICENSE_NAME ofType:FACE_LICENSE_SUFFIX];
    [[FaceSDKManager sharedInstance] setLicenseID:FACE_LICENSE_ID andLocalLicenceFile:licensePath];
    
    //腾讯Bugly收集器
    [Bugly startWithAppId:@"67700e4677"];
    
    // 百度地图
    BMKMapManager *mapManager = [[BMKMapManager alloc]init];
    BOOL  ret= [mapManager start:@"gp98XXBFfQLyCOyUDsSxousUHDElHKzh" generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    // 百度定位
    [[BMKLocationAuth sharedInstance] checkPermisionWithKey:@"gp98XXBFfQLyCOyUDsSxousUHDElHKzh" authDelegate:self];
    
    //极光推送
    [self registerJPUHSerVice:launchOptions];
    //自定义消息
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    
    //默认刷新样式
    [[KafkaRefreshDefaults standardRefreshDefaults] setHeadDefaultStyle:KafkaRefreshStyleReplicatorDot];
    [[KafkaRefreshDefaults standardRefreshDefaults] setFootDefaultStyle:KafkaRefreshStyleReplicatorDot];
    [[KafkaRefreshDefaults standardRefreshDefaults] setThemeColor:[UIColor colorConstantCommonBlueColor]];
    
    //注册通知，异步加载，判断网络连接情况
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [reachability startNotifier];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    NSUserDefaults *useDef = [NSUserDefaults standardUserDefaults];
    // 使用 NSUserDefaults 读取用户数据
    if (![useDef boolForKey:@"notFirst"]) {
        YWTBootLoaderController *bootVC = [[YWTBootLoaderController alloc]init];
        _window.rootViewController = bootVC;
    }else{
        //程序入口
        [self startRootView];
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
    //清除角标
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService setBadge:0];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//程序入口
-(void) startRootView{
    if ([YWTUserInfo passLoginData]) {
        SDRootNavigationController *leftVC = [[SDRootNavigationController alloc]initWithRootViewController:[YWTLeftViewController new]];
        SDRootNavigationController *rootVC = [[SDRootNavigationController alloc]initWithRootViewController:[YWTHomeViewController new]];
        UITabBarController *tarBarCtr=[[UITabBarController alloc]init];
        [tarBarCtr setViewControllers:[NSArray arrayWithObjects:rootVC, nil]];
        self.rootTabbarCtrV = tarBarCtr;
        //侧边栏
        REFrostedViewController *rostedViewController = [[REFrostedViewController alloc] initWithContentViewController:tarBarCtr menuViewController:leftVC];
        rostedViewController.direction = REFrostedViewControllerDirectionLeft;
        rostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleDark;
        rostedViewController.liveBlur = YES;
        rostedViewController.limitMenuViewSize = YES;
        rostedViewController.backgroundFadeAmount=0.5;
        rostedViewController.delegate = self;
        rostedViewController.menuViewSize=CGSizeMake(leftSideMeunWidth, KScreenH);
        
        self.window.rootViewController=rostedViewController;
        
    }else{
        SDRootNavigationController *loginVC = [[SDRootNavigationController alloc]initWithRootViewController:[YWTLoginViewController new]];
        self.window.rootViewController=loginVC;
    }
}
/**
 *此函数通过判断联网方式，通知给用户
 */
- (void)reachabilityChanged:(NSNotification *)notification
{
    Reachability *curReachability = [notification object];
    NSParameterAssert([curReachability isKindOfClass:[Reachability class]]);
    NetworkStatus curStatus = [curReachability currentReachabilityStatus];
    
    if(curStatus == NotReachable) {
        //没有网
        NSDictionary *dic = @{@"netwrok":@"NO"};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NetWorkStatu" object:nil userInfo:dic];
    }else  if(curStatus == ReachableViaWiFi) {
        //WIFI
        NSDictionary *dic = @{@"netwrok":@"WIFI"};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NetWorkStatu" object:nil userInfo:dic];
    }else if(curStatus == ReachableViaWWAN) {
        NSDictionary *dic = @{@"netwrok":@"GPRS"};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NetWorkStatu" object:nil userInfo:dic];
    }
}
/// 取消通知
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}
/**
 *@brief 返回授权验证错误
 *@param iError 错误号 : 为0时验证通过，具体参加BMKLocationAuthErrorCode
 */
- (void)onCheckPermissionState:(BMKLocationAuthErrorCode)iError{
    NSLog(@"--iError-----%ld----",(long)iError);
    
}
#pragma mark ---- 判断用户手机授权定位服务 ------
-(void) createLocationAuthorizationServer{
    BOOL enable = [CLLocationManager locationServicesEnabled];
    NSInteger state = [CLLocationManager authorizationStatus];
    if (!enable || 2 > state) {
        if (8 <= [[UIDevice currentDevice].systemVersion floatValue]) {
            NSLog(@"系统位置权限授权弹窗");
            // 系统位置权限授权弹窗
            CLLocationManager  *locationManager = [[CLLocationManager alloc] init];
            [locationManager requestAlwaysAuthorization];
            [locationManager requestWhenInUseAuthorization];
        }
    }
}
#pragma mark------ 远程通知 ------
//注册极光推送通知
-(void)registerJPUHSerVice:(NSDictionary *)launchOptions {
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound |UIUserNotificationTypeAlert)  categories:nil];
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    //注册  0e900577d450f5b96603be7d   7c73b76abb1ef04b7d11942a
    [JPUSHService setupWithOption:launchOptions appKey:@"57630a02afbfaeadb5764375"
                          channel:@"Publish channel"
                 apsForProduction:1
            advertisingIdentifier:nil];
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
#pragma mark ------自定义通知消息--------
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary *dict = notification.userInfo;
    // 消息类型
    NSDictionary *extrasDict = dict[@"extras"];
    NSString *instructionStr = extrasDict[@"instruction"];
    if ([instructionStr isEqualToString:@"logout"]) {
        // 退出登录
        NSString *contentsStr = extrasDict[@"contents"];
        [self showPromptView:contentsStr andType:@"1"];
    }else if ([instructionStr isEqualToString:@"exams"]){
        // 提交试卷
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"color"] = extrasDict[@"color"];
        param[@"contents"] = extrasDict[@"contents"];
        param[@"endTime"] = extrasDict[@"endTime"];
        param[@"instruction"] = extrasDict[@"instruction"];
        param[@"title"] = extrasDict[@"title"];
        // ServiceSubmitExamPaper
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ServiceSubmitExamPaper" object:nil userInfo:param];
    }else if ([instructionStr isEqualToString:@"remind"]){
        // 弹窗提示类消息
        NSString *contentsStr = extrasDict[@"contents"];
        [self showPromptView:contentsStr andType:@"2"];
    }else if ([instructionStr isEqualToString:@"instr"]){
        // 人脸审核
        NSString *contentsStr = extrasDict[@"contents"];
        // 修改头像审核状态
        [YWTUserInfo alterUserHeaderFaceChenkStatu:contentsStr];
    }else if ([instructionStr isEqualToString:@"taskType"]){
        // 任务消息弹框
        [self showTaskTypePromtView:extrasDict];
    }
}
#pragma mark- JPUSHRegisterDelegate---
// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification API_AVAILABLE(ios(10.0)){
    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //从通知界面直接进入应用
    }else{
        //从通知设置界面进入应用
    }
}
// iOS 10 Support  // 自定义消息
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
    // Required
    //清除角标
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService setBadge:0];
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    //清除角标
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService setBadge:0];
    
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
//  iOS 10之前前台没有通知栏
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Required,For systems with less than or equal to iOS6
    
    //  iOS 10之前前台没有通知栏
    if ([UIDevice currentDevice].systemVersion.floatValue < 10.0 && [UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        
    }
    [JPUSHService handleRemoteNotification:userInfo];
}
//显示  1 跳转到登录也    非1  不是
-(void) showPromptView:(NSString *)alertMsg andType:(NSString *)type{
    AppDelegate *appdel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //删除
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:alertMsg preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([type isEqualToString:@"1"]) {
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
        }
    }]];
    [appdel.window.rootViewController presentViewController:alertController animated:YES completion:nil];
}
#pragma mark ----- 任务中心消息模块 --------
// 任务消息弹框
-(void) showTaskTypePromtView:(NSDictionary *) taskDict{
    YWTTaskCenterReultPromptView *taskCenterView = [[YWTTaskCenterReultPromptView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH)];
    taskCenterView.dict = taskDict;
    
    __weak typeof(self) weakSelf = self;
    [[UIApplication sharedApplication].keyWindow addSubview:taskCenterView];
    
    __weak typeof(taskCenterView) weakTaskCenterView = taskCenterView;
    // 跳转到指定任务中心
    taskCenterView.selectTaskCenter = ^(NSDictionary * _Nonnull taskDict) {
        // 移除view
        [weakTaskCenterView removeFromSuperview];
        
        //跳转到指定页面
        REFrostedViewController *erfostView =(REFrostedViewController *) weakSelf.window.rootViewController;
        UITabBarController *tabbar = (UITabBarController *)erfostView.contentViewController;
        SDRootNavigationController *rootNavi = tabbar.viewControllers[0];
        
        YWTTaskCenterListController *listVC = [[YWTTaskCenterListController alloc]init];
        listVC.moduleNameStr = @"任务中心";
        //        listVC.titleStr = [NSString stringWithFormat:@"%@",taskDict[@"resourceName"]];
        
        [rootNavi pushViewController:listVC animated:YES];
    };
    // 跳转指定模块
    taskCenterView.selectModeName = ^(NSDictionary * _Nonnull taskDict) {
        // 移除view
        [weakTaskCenterView removeFromSuperview];
        
        [weakSelf pushJudeViewContorllerTaskDict:taskDict];
    };
}
// 跳转到指定模块
-(void) pushJudeViewContorllerTaskDict:(NSDictionary *)taskDict{
    __weak typeof(self) weakSelf = self;
    //跳转到指定页面
    REFrostedViewController *erfostView =(REFrostedViewController *) weakSelf.window.rootViewController;
    UITabBarController *tabbar = (UITabBarController *)erfostView.contentViewController;
    SDRootNavigationController *rootNavi = tabbar.viewControllers[0];
    // 任务需要跳得模块名称
    NSString *modeNameStr = [NSString stringWithFormat:@"%@",taskDict[@"modeName"]];
    // 搜索条件
    NSString *resourceNameStr = [NSString stringWithFormat:@"%@",taskDict[@"resourceName"]];
    if ([modeNameStr isEqualToString:@"libayExercise"]) {
        // 题库练习
        YWTlibayExerciseController *libayExerVC = [[YWTlibayExerciseController alloc]init];
        libayExerVC.titleStr = resourceNameStr;
        // app模块名【可能为空】
        libayExerVC.moduleNameStr = [NSString stringWithFormat:@"%@",taskDict[@"appName"]];
        [rootNavi pushViewController:libayExerVC animated:YES];
    }else if ([modeNameStr isEqualToString:@"examPaper"]){
        // 模拟考试
        YWTExamPaperListController *examPaperVC = [[YWTExamPaperListController alloc]init];
        examPaperVC.titleStr = resourceNameStr;
        [rootNavi pushViewController:examPaperVC animated:YES];
    }else if ([modeNameStr isEqualToString:@"examCenter"]){
        // 正式考试
        YWTExamCenterListController *examCenterVC = [[YWTExamCenterListController alloc]init];
        examCenterVC.titleStr = @"";
        [rootNavi pushViewController:examCenterVC animated:YES];
    }else if ([modeNameStr isEqualToString:@"myStudies"]){
        // 我的学习
        YWTMyStudiesController *myStudiesVC = [[YWTMyStudiesController alloc]init];
        myStudiesVC.moduleNameStr = [NSString stringWithFormat:@"%@",taskDict[@"appName"]];
        [rootNavi pushViewController:myStudiesVC animated:YES];
    }else if ([modeNameStr isEqualToString:@"riskDisplay"] ){
        // 风险展示
        
    }else if ([modeNameStr isEqualToString:@"exposureStation"]){
        // 曝光台
        
        
    }else if ([modeNameStr isEqualToString:@"securityCheck"]){
        // 安全检查
        YWTBaseTableViewController *baseVC = [[YWTBaseTableViewController alloc]init];
        baseVC.veiwBaseType =  showViewControllerSafetyType;
        baseVC.scoureType =  showBaseAddSoucreType;
        // app模块名【可能为空】
        baseVC.moduleNameStr = [NSString stringWithFormat:@"%@",taskDict[@"appName"]];
        [rootNavi pushViewController:baseVC animated:YES];
    }else if ([modeNameStr isEqualToString:@"classRecord"] ){
        // 班会记录
        YWTBaseTableViewController *baseVC = [[YWTBaseTableViewController alloc]init];
        baseVC.veiwBaseType =  showViewControllerMeetingType;
        baseVC.scoureType =  showBaseAddSoucreType;
        // app模块名【可能为空】
        baseVC.moduleNameStr = [NSString stringWithFormat:@"%@",taskDict[@"appName"]];
        [rootNavi pushViewController:baseVC animated:YES];
    }else if ([modeNameStr isEqualToString:@"technicalDisclosure"] ){
        // 技术交底
        YWTBaseTableViewController *baseVC = [[YWTBaseTableViewController alloc]init];
        baseVC.veiwBaseType =  showViewControllerTechnoloType;
        baseVC.scoureType =  showBaseAddSoucreType;
        // app模块名【可能为空】
        baseVC.moduleNameStr = [NSString stringWithFormat:@"%@",taskDict[@"appName"]];
        [rootNavi pushViewController:baseVC animated:YES];
    }else if ([modeNameStr isEqualToString:@"violationHan"]){
        // 违章处理
        YWTBaseTableViewController *baseVC = [[YWTBaseTableViewController alloc]init];
        baseVC.veiwBaseType =  showViewControllerViolationType;
        baseVC.scoureType =  showBaseAddSoucreType;
        // app模块名【可能为空】
        baseVC.moduleNameStr = [NSString stringWithFormat:@"%@",taskDict[@"appName"]];
        [rootNavi pushViewController:baseVC animated:YES];
    } else if ([modeNameStr isEqualToString:@"attendanceAtte"]){
        // 考勤签到
        YWTAttendanceChenkController *attendanceVC = [[YWTAttendanceChenkController alloc]init];
        // app模块名【可能为空】
        attendanceVC.moduleNameStr = [NSString stringWithFormat:@"%@",taskDict[@"appName"]];
        [rootNavi pushViewController:attendanceVC animated:YES];
    }
}

/// 在这里写支持的旋转方向，为了防止横屏方向，应用启动时候界面变为横屏模式
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationMaskPortrait;
}


@end
