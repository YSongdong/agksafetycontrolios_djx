//
//  SDHomeViewController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/7.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTHomeViewController.h"

#import "YWTUpdateView.h"
#import "YWTShowHomePromptExamView.h"
#import "YWTPhotoCollectionController.h"
#import "YWTExamPaperListController.h"
#import "YWTlibayExerciseController.h"
#import "YWTMessageCenterController.h"

#import "YWTExamQuestionController.h"
#import "YWTExamCenterListController.h"
#import "YWTBaseModuleController.h"
#import "YWTPlatformAnnouncentController.h"
#import "YWTBaseTableViewController.h"
#import "YWTBaseShowListController.h"
#import "YWTTaskCenterListController.h"
#import "YWTPartyMemberAreaListController.h"
#import "YWTSubmitSuggestionController.h"
#import "YWTQuestionnaireListController.h"
#import "YWTMyStudiesController.h"

#import "WKWebViewOrJSText.h"
#import "YWTExamScoreViewController.h"
#import "YWTShowVerifyIdentidyErrorView.h"

#import "YWTHomeBottomView.h"

#import "YWTTaskCenterListController.h"

#import "YWTHomeViewModel.h"
#import "HomeScrollCollectionViewCell.h"
#define HOMESCROLLCOLLECTIONVIEW_CELL @"HomeScrollCollectionViewCell"
#import "YWTHomeModuleCollectionViewCell.h"
#define  HOMOMODULECOLLECTIONVIEW_CELL @"YWTHomeModuleCollectionViewCell"
#import "AnnouncementCollectionViewCell.h"
#define ANNOUNCEMINTCOLLECTIONVIEW_CELL @"AnnouncementCollectionViewCell"

#define UICOLLECTIONVIEWFOOTER  @"FOOTER"
#define UICOLLECTIONVIEWHEADER  @"HEADER"
@interface YWTHomeViewController ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>

@property (nonatomic,strong) YWTHomeViewModel *viewModel;

@property (nonatomic,strong) UICollectionView *homeCollectionView;

@property (nonatomic,strong) NSMutableArray *dataArr;
// 底部view
@property (nonatomic,strong) YWTHomeBottomView *homeBottomView;
// 版本更新view
@property (nonatomic,strong) YWTUpdateView *updateView;
// 继续考试提示框
@property (nonatomic,strong) YWTShowHomePromptExamView *showPromptExamView;
// 验证失败view
@property (nonatomic,strong) YWTShowVerifyIdentidyErrorView *showVeriIndeErrorView;
// 监控规则数组
@property (nonatomic,strong) NSMutableArray *monitorRulesArr;
// 是否开启强制
@property (nonatomic,strong) NSString *forceStr;
// 1启用监控 2不启用监控
@property (nonatomic,strong) NSString *monitorStr;
// 记录验证次数
@property (nonatomic,strong) NSString *veriNumberStr;
// 记录验证失败次数
@property (nonatomic,assign) NSInteger veriErrorNumberStr;
// 记录是否有start 规则 YES 有 NO
@property (nonatomic,assign) BOOL isStartMonitor;
//考试ID
@property (nonatomic,strong) NSString *examIdStr;
//考场ID
@property (nonatomic,strong) NSString *examRoomIdStr;
//场次ID
@property (nonatomic,strong) NSString *examBatchIdStr;
// 消息背景view
@property (nonatomic,strong) UIView *msgBgView;
// 消息内容lab
@property (nonatomic,strong) UILabel *unreadMsgLab;



@end

@implementation YWTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置导航栏
    [self setNavigationView];
    // 加载数据源
    [self loadData];
    // 创建Collectionview
    [self createCollectionView];
    //检查系统更新
    [self requestDataIsShowUpdateView];
    //检查是否有对于的弹框
    [self requestExamRoomTest];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //隐藏tabbar
    self.tabBarController.tabBar.hidden = YES;
    // 请求个人资料
    [self requestPersonalInfoData];
    // 请求未读信息
    [self requestMsgMailMsgStatistics];
    // 请求轮播图
    [self requestHomeBannerData];
    // 公告列表
    [self requestAnnouListData];
}
// 加载数据源
-(void) loadData{
    /*
     self.dataArr  数组元素 表示显示几组，每组几个元素
     */
    // 一组
    NSMutableArray *headerArr = [NSMutableArray array];
    NSMutableArray *banarArr = [NSMutableArray array];
   
    NSMutableArray *adArr = [NSMutableArray array];
    [headerArr addObject:banarArr];
    [headerArr addObject:adArr];
    [self.dataArr addObject:headerArr];
    // 二组
    NSMutableArray *moduleArr = [NSMutableArray array];
    NSArray *moduleConfigArr = [YWTUserInfo obtainWithModuleConfig];
    if (moduleConfigArr.count == 0) {
        NSArray *arr = @[@"libayExercise",@"examPaper",@"examCenter",@"taskCenter",@"safetyControl"];
        for (NSString *keyStr in arr) {
            [moduleArr addObject:[self getWriteModuleNameStr:keyStr]];
        }
        [self.dataArr addObject:moduleArr];
        return;
    }
    for (NSDictionary *dict in moduleConfigArr) {
        if ([dict[@"display"] boolValue]) {
            NSMutableDictionary * param = [NSMutableDictionary dictionary];
            param[@"name"] = dict[@"actionName"];
            NSDictionary *iconDict = dict[@"icon"];
            param[@"image"] = iconDict[@"xxx"];
            param[@"modeName"] = dict[@"modeName"];
            param[@"title"] = dict[@"title"];
            param[@"titleEnglish"] = dict[@"titleEnglish"];
            param[@"actionName"] = dict[@"actionName"];
            param[@"child"] = dict[@"child"];
            param[@"newest"] = dict[@"newest"];
            [moduleArr addObject: param];
        }
    }
    [self.dataArr addObject:moduleArr];
}
-(void)createCollectionView{
    self.view.backgroundColor = [UIColor colorTextWhiteColor];
    
    // 添加底部view
    [self.view addSubview:self.homeBottomView];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    self.homeCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH-KSIphonScreenH(40)) collectionViewLayout:layout];
    [self.view insertSubview:self.homeCollectionView atIndex:0];
    self.homeCollectionView.delegate = self;
    self.homeCollectionView.dataSource = self;
    self.homeCollectionView.showsVerticalScrollIndicator = NO;
    self.homeCollectionView.backgroundColor = [UIColor colorStyleLeDarkWithConstantColor:[UIColor colorConstantStyleDarkColor]normalCorlor:[UIColor colorTextWhiteColor]];
    
    [self.homeCollectionView registerNib:[UINib nibWithNibName:HOMESCROLLCOLLECTIONVIEW_CELL bundle:nil] forCellWithReuseIdentifier:HOMESCROLLCOLLECTIONVIEW_CELL];
    [self.homeCollectionView registerClass:[YWTHomeModuleCollectionViewCell class] forCellWithReuseIdentifier:HOMOMODULECOLLECTIONVIEW_CELL];
    [self.homeCollectionView registerNib:[UINib nibWithNibName:ANNOUNCEMINTCOLLECTIONVIEW_CELL bundle:nil] forCellWithReuseIdentifier:ANNOUNCEMINTCOLLECTIONVIEW_CELL];
    [self.homeCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:UICOLLECTIONVIEWFOOTER];
    [self.homeCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:UICOLLECTIONVIEWHEADER];
    
    if (@available(iOS 11.0, *)) {
        self.homeCollectionView.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArr.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *arr = self.dataArr[section];
    return arr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
             HomeScrollCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HOMESCROLLCOLLECTIONVIEW_CELL forIndexPath:indexPath];
            NSArray *bannerArr = self.dataArr[indexPath.section];
            NSArray *arr = bannerArr[indexPath.row];
            cell.bannerArr = [NSMutableArray arrayWithArray:arr];
            return cell;
        }else  {
           AnnouncementCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ANNOUNCEMINTCOLLECTIONVIEW_CELL forIndexPath:indexPath];
            NSArray *bannerArr = self.dataArr[indexPath.section];
            NSArray *arr = bannerArr[indexPath.row];
            cell.annouArr =  [NSMutableArray arrayWithArray:arr];
            return cell;
        }
    }else {
        YWTHomeModuleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HOMOMODULECOLLECTIONVIEW_CELL forIndexPath:indexPath];
        NSArray *arr = self.dataArr[indexPath.section];
        cell.dict = arr[indexPath.row];
        return cell;
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return CGSizeMake(KScreenW, KSIphonScreenH(250));
        }else{
            return CGSizeMake(KScreenW, KSIphonScreenH(55));
        }
    }else {
        return CGSizeMake(KScreenW/3, KSIphonScreenH(144));
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(KScreenW, KSIphonScreenH(11));
    }else{
        return CGSizeMake(KScreenW, 0.01);
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(KScreenW, 0.01);
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:UICOLLECTIONVIEWFOOTER forIndexPath:indexPath];
        footer.backgroundColor =  [UIColor colorStyleLeDarkWithConstantColor:[UIColor colorWithHexString:@"#1d2635"]normalCorlor:[UIColor colorCommonGreyColor]];
        return footer;
    }else{
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:UICOLLECTIONVIEWHEADER forIndexPath:indexPath];
        headerView.backgroundColor =  [UIColor colorStyleLeDarkWithConstantColor:[UIColor colorWithHexString:@"#1d2635"]normalCorlor:[UIColor colorCommonGreyColor]];
        return headerView;
    }
}
-(void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        YWTHomeModuleCollectionViewCell *cell =(YWTHomeModuleCollectionViewCell *) [self.homeCollectionView cellForItemAtIndexPath:indexPath];
        [cell setBackgroundColor:[UIColor colorWithHexString:@"#efefef"]];
    }
}
-(void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        YWTHomeModuleCollectionViewCell *cell =(YWTHomeModuleCollectionViewCell *) [self.homeCollectionView cellForItemAtIndexPath:indexPath];
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            YWTPlatformAnnouncentController *annouVC = [[YWTPlatformAnnouncentController alloc]init];
            [self.navigationController pushViewController:annouVC animated:YES];
        }
    }else if (indexPath.section == 1) {
        NSArray *moduleArr = self.dataArr[indexPath.section];
        NSDictionary *dict = moduleArr[indexPath.row];
        NSString *moduleNameStr = dict[@"name"];
        if ([moduleNameStr isEqualToString:@"libayExercise"]) {
            // 题库练习
            YWTlibayExerciseController *libaryVC = [[YWTlibayExerciseController alloc]init];
            libaryVC.title = @"";
            libaryVC.moduleNameStr = [NSString stringWithFormat:@"%@",dict[@"title"]];
            [self.navigationController pushViewController:libaryVC animated:YES];
        }else if([moduleNameStr isEqualToString:@"examPaper"]){
            // 模拟考试
            YWTExamPaperListController *examPaperVC = [[YWTExamPaperListController alloc]init];
            examPaperVC.title = @"";
            [self.navigationController pushViewController:examPaperVC animated:YES];
        }else if([moduleNameStr isEqualToString:@"examCenter"]){
            // 我的考试
            YWTExamCenterListController *examCenterVC = [[YWTExamCenterListController alloc]init];
            examCenterVC.title = @"";
            examCenterVC.titleStr = [NSString stringWithFormat:@"%@",dict[@"title"]];
            [self.navigationController pushViewController:examCenterVC animated:YES];
        }else if ([moduleNameStr isEqualToString:@"educationTraining"]) {
            //教育培训
            NSArray *childArr = dict[@"child"];
            if (childArr.count == 0) {
                return;
            }
            YWTBaseModuleController *moduleVC = [[YWTBaseModuleController alloc]init];
            moduleVC.moduleType = showBaseModuleEducationType;
            moduleVC.dataArr = [NSMutableArray arrayWithArray:[self getConversionNSArr:childArr]];
            moduleVC.titleStr = [NSString stringWithFormat:@"%@",dict[@"title"]];
            [self.navigationController pushViewController:moduleVC animated:YES];
        }else if ([moduleNameStr isEqualToString:@"safetyControl"]){
           //安全管控
            NSArray *childArr = dict[@"child"];
            if (childArr.count == 0) {
                return;
            }
            // 判断是否有模块权限
            [self requestModuleAuthDataArr:childArr andDict:dict];
            
        }else if ([moduleNameStr isEqualToString:@"exposureStation"]){
           //曝光台
            YWTBaseShowListController *showListVC = [[YWTBaseShowListController alloc]init];
            showListVC.listType = showControllerExposureListType;
            showListVC.moduleNameStr = [NSString stringWithFormat:@"%@",dict[@"title"]];
            [self.navigationController pushViewController:showListVC animated:YES];
        }else if ([moduleNameStr isEqualToString:@"taskCenter"]){
            //任务中心
            YWTTaskCenterListController *listVC = [[YWTTaskCenterListController alloc]init];
            listVC.moduleNameStr = [NSString stringWithFormat:@"%@",dict[@"title"]];
            [self.navigationController pushViewController:listVC animated:YES];
        }else if ([moduleNameStr isEqualToString:@"riskDisplay"]){
            //风险展示
            YWTBaseShowListController *showListVC = [[YWTBaseShowListController alloc]init];
            showListVC.listType = showControllerRiskListType;
            showListVC.moduleNameStr = [NSString stringWithFormat:@"%@",dict[@"title"]];
            [self.navigationController pushViewController:showListVC animated:YES];
        }else if ([moduleNameStr isEqualToString:@"activityarea"]){
            //党员活动区
            YWTPartyMemberAreaListController *areaListVC = [[YWTPartyMemberAreaListController alloc]init];
            areaListVC.listType = partyAreaListOtherType;
            areaListVC.moduleNameStr = [NSString stringWithFormat:@"%@",dict[@"title"]];
            [self.navigationController pushViewController:areaListVC animated:YES];
        }else if ([moduleNameStr isEqualToString:@"suggestionbox"]){
            //意见箱
            YWTSubmitSuggestionController *submitSuggestionVC = [[YWTSubmitSuggestionController alloc]init];
            [self.navigationController pushViewController:submitSuggestionVC animated:YES];
        }else if ([moduleNameStr isEqualToString:@"questionnaire"]){
            //问卷调查
            YWTQuestionnaireListController *listVC = [[YWTQuestionnaireListController alloc]init];
            [self.navigationController pushViewController:listVC animated:YES];
        }else if ([moduleNameStr isEqualToString:@"myStudies"]){
            //文件学习
            YWTMyStudiesController *listVC = [[YWTMyStudiesController alloc]init];
            listVC.moduleNameStr = [NSString stringWithFormat:@"%@",dict[@"title"]];
            [self.navigationController pushViewController:listVC animated:YES];
        }
        
        
    }
}
#pragma mark -----写入对应的模块数据源-------
-(NSDictionary *) getWriteModuleNameStr:(NSString *)moduleNameStr{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    if ([moduleNameStr isEqualToString:@"libayExercise"]) {
        dict[@"name"] = moduleNameStr;
        dict[@"image"] = @"home_libayExercise";
        dict[@"title"] = @"题库练习";
        dict[@"titleEnglish"] = @"Education Training";
    }else if ([moduleNameStr isEqualToString:@"examPaper"]){
        dict[@"name"] = moduleNameStr;
        dict[@"image"] = @"home_examPaper";
        dict[@"title"] = @"模拟测验";
        dict[@"titleEnglish"] = @"Risk Display";
    }else if ([moduleNameStr isEqualToString:@"examCenter"]){
        dict[@"name"] = moduleNameStr;
        dict[@"image"] = @"home_examCenter";
        dict[@"title"] = @"考试中心";
        dict[@"titleEnglish"] = @"Exposure Station";
    }else if ([moduleNameStr isEqualToString:@"TaskCenter"]){
        dict[@"name"] = moduleNameStr;
        dict[@"image"] = @"home_taskCenter";
        dict[@"title"] = @"任务中心";
        dict[@"titleEnglish"] = @"Task Center";
    }else if ([moduleNameStr isEqualToString:@"SafetyControl"]){
        dict[@"name"] = moduleNameStr;
        dict[@"image"] = @"home_safetyControl";
        dict[@"title"] = @"安全管控";
        dict[@"titleEnglish"] = @"Safety control";
    }
    return dict;
}
#pragma mark ---- 通过配置数组获取子页面的数据源 -------
-(NSArray *)getConversionNSArr:(NSArray *)arr{
    NSMutableArray *moduleArr = [NSMutableArray array];
    for (NSDictionary *dict in arr) {
        if ([dict[@"display"] boolValue]) {
            NSMutableDictionary * param = [NSMutableDictionary dictionary];
            param[@"name"] = dict[@"actionName"];
            NSDictionary *iconDict = dict[@"icon"];
            param[@"image"] = iconDict[@"xxx"];
            param[@"modeName"] = dict[@"modeName"];
            param[@"title"] = dict[@"title"];
            param[@"titleEnglish"] = dict[@"titleEnglish"];
            param[@"actionName"] = dict[@"actionName"];
            param[@"child"] = dict[@"child"];
            param[@"newest"] = dict[@"newest"];
            [moduleArr addObject: param];
        }
    }
    return  moduleArr.copy;
}
#pragma mark -----创建继续考试提示框--------
/*
 typeStr  1 人脸 2 正式考试
 */
-(void) createShowPromptExamView:(NSDictionary *)dict andType:(NSString *)typeStr andVFaceStr:(NSString *)vFaceStr {
    __weak typeof(self) weakSelf = self;
    _showPromptExamView = [[YWTShowHomePromptExamView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH)];
    [self.view addSubview:self.showPromptExamView];
    // 解析html 标签
    if ([typeStr isEqualToString:@"2"]) {
        NSAttributedString *attrStr = [[NSAttributedString alloc]initWithData:[dict[@"content"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:[UIFont boldSystemFontOfSize:18] } documentAttributes:nil error:nil];
        _showPromptExamView.showContentLab.attributedText = attrStr;
    }else{
        NSString *contentStr = @"您的留底照片 未上传/未通过 ，j将影响您的正常学习或考试，是否立即前往上传本人留底照片。";
        _showPromptExamView.showContentLab.attributedText = [YWTTools getAttrbuteTotalStr:contentStr andAlterTextStr:@"未上传/未通过" andTextColor:[UIColor colorLineCommonBlueColor] andTextFont:Font(15)];
    }
    if ([typeStr isEqualToString:@"1"]) {
        [self.showPromptExamView.ignoreBtn setTitle:@"下次再说" forState:UIControlStateNormal];
        [self.showPromptExamView.continueExamBtn setTitle:@"立即前往" forState:UIControlStateNormal];
    }
    // 忽略
    self.showPromptExamView.cancelProptView = ^{
        [weakSelf.showPromptExamView removeFromSuperview];
        if ([typeStr isEqualToString:@"1"]) {
            return ;
        }
        if ([vFaceStr isEqualToString:@"2"] || [vFaceStr isEqualToString:@"3"]) {
            [weakSelf createShowPromptExamView:dict andType:@"1" andVFaceStr:vFaceStr];
        }
    };
    // 继续考试
    self.showPromptExamView.continueExamBlock = ^{
        if ([typeStr isEqualToString:@"2"]) {
            // 1需要识别 2不需要
            NSString *monitorStr = [NSString stringWithFormat:@"%@",dict[@"monitor"]];
            if ([monitorStr isEqualToString:@"1"]) {
                [weakSelf createFaceVierExamMonitor:dict[@"monitorRules"]];
                return ;
            }
            [weakSelf pushViewControllerDict];
        }else{
           NSString *vMobileStr = [NSString stringWithFormat:@"%@",dict[@"vFace"]];
           [weakSelf pushPhotoViewControllervMobileStr:vMobileStr];
        }
    };
}
#pragma mark --- 创建验证失败的view --------
-(void) createShowVeriIndeErrorView{
    __weak typeof(self) weakSelf = self;
    self.showVeriIndeErrorView = [[YWTShowVerifyIdentidyErrorView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH) andType:@"1"];
    [[UIApplication sharedApplication].keyWindow addSubview:self.showVeriIndeErrorView];
    // 再次验证
    self.showVeriIndeErrorView.againBtnBlock = ^{
        [weakSelf.showVeriIndeErrorView removeFromSuperview];
        [weakSelf createFaceVierExamMonitor:weakSelf.monitorRulesArr];
    };
    // 直接进入考试
    self.showVeriIndeErrorView.enterBtnBlcok = ^{
        [weakSelf.showVeriIndeErrorView removeFromSuperview];
        [weakSelf pushViewControllerDict];
    };
}
// 判断有没有规则
-(void)createFaceVierExamMonitor:(NSArray *)monitorRulesArr{
    __weak typeof(self) weakSelf = self;
    if (self.monitorRulesArr.count == 0) {
        // 如果数据源未空 ，就直接跳转到页面也
        [weakSelf pushViewControllerDict];
        return;
    }
    BOOL  isStart = NO;
    for (NSDictionary *dict in self.monitorRulesArr) {
        // 获取检测规则key
        NSString *ruleKeyStr = [NSString stringWithFormat:@"%@",dict[@"rule"]];
        if ([ruleKeyStr isEqualToString:@"start"]) {
            isStart = YES;
            // 记录规则数组有
           self.monitorRules = self.monitorRulesArr;
           NSDictionary *monitorDic = [self createFaveVerificationStr:@"start"];
           [self createBeginExamMonitor:monitorDic];
        }
    }
    // 如果没有找到规则 ，就直接跳转到页面也
    if (!isStart) {
         [weakSelf pushViewControllerDict];
    }
}
//
-(void)createBeginExamMonitor:(NSDictionary *)monitorDict{
    __weak typeof(self) weakSelf = self;
    // 是否开启强制
    weakSelf.forceStr = [NSString stringWithFormat:@"%@",monitorDict[@"force"]];
    // 记录验证次数
    weakSelf.veriNumberStr = [NSString stringWithFormat:@"%@",monitorDict[@"number"]];
    // 进入人脸采集
    [self passRulesConductFaceVeri:monitorDict];
}
// 人脸采集成功回调方法
-(void)returnFaceSuccessImage:(NSDictionary *)dict{
    [self requestMonitorFaceRecogintion:dict[@"faceSuccess"] andRuleStr:dict[@"rule"]];
}
#pragma mark -----跳转到指定的控制器--------
-(void) pushViewControllerDict{
    // 移除人脸验证失败提示框
    [self.showPromptExamView removeFromSuperview];
     __weak typeof(self) weakSelf = self;
    YWTExamQuestionController *examQuestVC = [[YWTExamQuestionController alloc]init];
    examQuestVC.controllerExamType = controllerOfficialExamType;
    examQuestVC.examIdStr = self.examIdStr;
    examQuestVC.examRoomIdStr = self.examRoomIdStr;
    examQuestVC.examBatchIdStr = self.examBatchIdStr;
    examQuestVC.controllerQuestMode = controllerExamQuestAnswerMode;
    examQuestVC.monitorRulesArr = self.monitorRulesArr;
    [weakSelf.navigationController pushViewController:examQuestVC animated:YES];
}
#pragma mark -----跳转到指定的控制器--------
-(void) pushPhotoViewControllervMobileStr:(NSString *)vMobileStr {
    __weak typeof(self) weakSelf = self;
    YWTPhotoCollectionController *photoVC = [[YWTPhotoCollectionController alloc]init];
    if ([vMobileStr isEqualToString:@"2"]) {
        //2未认证
        photoVC.photoStatu = photoStatuNotUploaded;
    }else if ([vMobileStr isEqualToString:@"1"]){
        //1认证
        photoVC.photoStatu = photoStatuCheckSucces;
    }else if ([vMobileStr isEqualToString:@"3"]){
        //认证不通过
        photoVC.photoStatu = photoStatuCheckError;
    }else if ([vMobileStr isEqualToString:@"4"]){
        //4审核中
        photoVC.photoStatu = photoStatuChecking;
    }
    [weakSelf.navigationController pushViewController:photoVC animated:YES];
}
#pragma mark -----导航栏--------
- (void) setNavigationView{
    //设置导航栏透明色
    [self.customNavBar wr_setBackgroundAlpha:0];
  
    NSString *platformNameStr = [YWTUserInfo obtainWithLoginPlatformName];
    if ([platformNameStr isEqualToString:@""] || platformNameStr == nil || [platformNameStr isKindOfClass:[NSNull class]]) {
         self.customNavBar.title = @"安全管控云平台服务中心";
    }else{
         self.customNavBar.title = platformNameStr;
    }
     __weak typeof(self) weakSelf = self;
    // 个人中心
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"sy_nav_ico01"]];
    self.customNavBar.onClickLeftButton = ^{
         [weakSelf.frostedViewController presentMenuViewController];
    };
    
    // 消息
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"sy_nav_ico02"]];
    self.customNavBar.onClickRightButton = ^{
        YWTMessageCenterController *msgVC = [[YWTMessageCenterController alloc]init];
        [weakSelf.navigationController pushViewController:msgVC animated:YES];
    };
    self.msgBgView = [[UIView alloc]init];
    [self.customNavBar addSubview:self.msgBgView];
    self.msgBgView.backgroundColor = [UIColor colorTextWhiteColor];
    self.msgBgView.userInteractionEnabled =NO;
    [self.msgBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.customNavBar.rightButton.mas_centerX).offset(8);
        make.centerY.equalTo(weakSelf.customNavBar.rightButton.mas_centerY).offset(-5);
        make.width.height.equalTo(@16);
    }];
    self.msgBgView.layer.cornerRadius = 8;
    self.msgBgView.layer.masksToBounds = YES;
    self.msgBgView.hidden = YES;
    // 未读消息lab
    self.unreadMsgLab = [[UILabel alloc]init];
    [self.msgBgView addSubview:self.unreadMsgLab];
    self.unreadMsgLab.text = @"0";
    self.unreadMsgLab.textColor = [UIColor colorLineCommonBlueColor];
    self.unreadMsgLab.font = Font(10);
    [self.unreadMsgLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.msgBgView.mas_centerX);
        make.centerY.equalTo(weakSelf.msgBgView.mas_centerY);
    }];
    
    //设置全屏右滑
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
}
//滑动显示侧边栏
- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender{
    [self.frostedViewController panGestureRecognized:sender];
}
#pragma mark -----懒加载--------
-(YWTHomeBottomView *)homeBottomView{
    if (!_homeBottomView) {
        _homeBottomView = [[YWTHomeBottomView alloc]initWithFrame:CGRectMake(0, KScreenH-KSIphonScreenH(40)-KSTabbarH, KScreenW, KSIphonScreenH(40))];
    }
    return _homeBottomView;
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(NSMutableArray *)monitorRulesArr{
    if (!_monitorRulesArr) {
        _monitorRulesArr = [NSMutableArray array];
    }
    return _monitorRulesArr;
}
#pragma mark -----判断是否显示更新View--------
-(void) requestDataIsShowUpdateView{
    //获取本地软件的版本号
    NSString *localVersion =  [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"system"] =  @"1";
    param[@"version"] = localVersion;
    param[@"appId"] = @"lhagk_red";
    [[KRMainNetTool sharedKRMainNetTool]postRequstWith:HTTP_ATTENDANCESYSTEMUPGRADE_URL params:param withModel:nil waitView:nil complateHandle:^(id showdata, NSString *error) {
        if (error) {
            return ;
        }
        //判断是否需要更新  false 不需要更新  true  需要更新
        if (![showdata[@"update"] boolValue]) {
            return;
        }
        //判断是否强制更新  1 强制更新 2 非强制更新
        NSString *forceStr = [NSString stringWithFormat:@"%@",showdata[@"force"]];
        self.updateView  =[[YWTUpdateView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
        if ([forceStr isEqualToString:@"1"]) {
            self.updateView.typeStatu = updateTypeForceStatu;
        }
        self.updateView.contentLab.text = showdata[@"releaseNotes"];
        self.updateView.titleLab.text = [NSString stringWithFormat:@"发现新版本V%@版",showdata[@"version"]];
        [[UIApplication sharedApplication].keyWindow addSubview:self.updateView];
    }];
}
#pragma mark ----个人资料-----
-(void) requestPersonalInfoData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] =[YWTUserInfo obtainWithUserId];
    param[@"token"] = [YWTTools getNewToken];
    
    [[KRMainNetTool sharedKRMainNetTool]postRequstWith:HTTP_ATTAPPPERSONALCENTER_URL params:param withModel:nil waitView:nil complateHandle:^(id showdata, NSString *error) {
        if (error) {
            return ;
        }
        if ([showdata isKindOfClass:[NSDictionary class]]) {
            // 修改用户信息
            [YWTUserInfo alterUserInfoDictionary:showdata];
            // 修改我的学分
            NSString *creditStr = [NSString stringWithFormat:@"%@",showdata[@"credit"]];
            [YWTUserInfo alterUserCreditStr:creditStr];
        }
    }];
}
#pragma mark -----轮播图----
-(void) requestHomeBannerData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"platformCode"] = @"dsjt";
    param[@"token"] =  [YWTTools getNewToken];
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPINDEXBANNER_URL params:param withModel:nil waitView:nil complateHandle:^(id showdata, NSString *error) {
        if (error) {
            return ;
        }
        if ([showdata isKindOfClass:[NSArray class]]) {
        
            NSMutableArray *setArr = self.dataArr[0];
            NSMutableArray *bannerArr = setArr[0];
            // 移除所有数据
            [bannerArr removeAllObjects];
            // 重新添加数据源
            [bannerArr addObjectsFromArray:showdata];
            // 贴换数据源
            [setArr replaceObjectAtIndex:0 withObject:bannerArr];
            [self.dataArr replaceObjectAtIndex:0 withObject:setArr];
             // 刷新UI
            [self.homeCollectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
        }
    }];
}
#pragma mark ------- 公告列表 ---------
-(void) requestAnnouListData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] =[YWTTools getNewToken];

    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPANNOUHOMEANNOU_URL params:param withModel:nil waitView:nil complateHandle:^(id showdata, NSString *error) {
        if (error) {
            return ;
        }
        if ([showdata isKindOfClass:[NSArray class]]) {
            NSMutableArray *setArr = self.dataArr[0];
            NSMutableArray *bannerArr = setArr[1];
            // 移除所有数据
            [bannerArr removeAllObjects];
            for (NSDictionary *dict in showdata) {
                // 重新添加数据源
                [bannerArr addObject:dict[@"contents"]];
            }
            // 贴换数据源
            [setArr replaceObjectAtIndex:1 withObject:bannerArr];
            [self.dataArr replaceObjectAtIndex:0 withObject:setArr];
            // 刷新UI
            [self.homeCollectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
        }
    }];
}
#pragma mark ------- 首页检测用户是否正式考试 ---------
-(void) requestExamRoomTest{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] =[YWTTools getNewToken];
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPSERVICEAPIINDEXEXAMROOTEST_URL params:param withModel:nil waitView:nil complateHandle:^(id showdata, NSString *error) {
        if (error) {
//            [self.view showErrorWithTitle:error autoCloseTime:1];
            return ;
        }
        if (![showdata isKindOfClass:[NSDictionary class]]) {
            return;
        }
        self.examIdStr = [NSString stringWithFormat:@"%@",showdata[@"examId"]];
        self.examRoomIdStr = [NSString stringWithFormat:@"%@",showdata[@"examRoomId"]];
        self.examBatchIdStr = [NSString stringWithFormat:@"%@",showdata[@"examBatchId"]];
        self.monitorRulesArr = [NSMutableArray arrayWithArray:showdata[@"monitorRules"]];
        NSString *statusStr = [NSString stringWithFormat:@"%@",showdata[@"status"]];
        if ([statusStr isEqualToString:@"1"]) {
            NSString *vFaceStr = [NSString stringWithFormat:@"%@",showdata[@"vFace"]];
            [self createShowPromptExamView:showdata andType:@"2" andVFaceStr:vFaceStr];
        }
    }];
}
// 获取未读消息当前数量
-(void) requestMsgMailMsgStatistics{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPMSGMAILMSGSTATISTICS_URL params:param withModel:nil waitView:nil complateHandle:^(id showdata, NSString *error) {
        if (error) {
            return ;
        }
        if ([showdata isKindOfClass:[NSDictionary class]] || [showdata isKindOfClass:[NSMutableDictionary class]]) {
            NSNumber *num = showdata[@"num"];
            NSInteger number = [num integerValue];
            if (number > 0) {
                self.msgBgView.hidden = NO;
                self.unreadMsgLab.text = [NSString stringWithFormat:@"%ld",(long)number];
            }else{
                self.msgBgView.hidden = YES;
            }
        }
    }];
}
#pragma mark ----- 请求模块权限 --------
-(void) requestModuleAuthDataArr:(NSArray *)childArr andDict:(NSDictionary *)dict{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"]= [YWTTools getNewToken];
    param[@"platformCode"] = [YWTUserInfo obtainWithLoginPlatformCode];
    param[@"type"] = @"6";
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPMODULEAUTHMODULEAUTH_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        
        YWTBaseModuleController *moduleVC = [[YWTBaseModuleController alloc]init];
        moduleVC.moduleType = showBaseModuleSafetyManageType;
        moduleVC.dataArr = [NSMutableArray arrayWithArray:[self getConversionNSArr:childArr]];
        moduleVC.titleStr = [NSString stringWithFormat:@"%@",dict[@"title"]];
        [self.navigationController pushViewController:moduleVC animated:YES];
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
    param[@"type"] = @"1";
    param[@"source"] = @"1";
    param[@"rule"] = ruleStr;
    param[@"terminal"] = [NSNumber numberWithInteger:1];
    //获取本地软件的版本号
    NSString *localVersion =  [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    param[@"appVersion"] = localVersion;
    // 手机系统版本
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    // 手机型号
    NSString *phoeModel = [YWTTools deviceModelName];
    NSString *systemVersionStr = [NSString stringWithFormat:@"%@-%@",phoeModel,phoneVersion];;
    param[@"systemVersion"] = systemVersionStr;

    [[KRMainNetTool sharedKRMainNetTool] upLoadPhotoUrl:HTTP_ATTAPPMOITORAPIFACERECOGINTION_URL params:param photo:faceImage waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if (![showdata isKindOfClass:[NSDictionary class]]) {
            return;
        }
        
        NSString *succStr = [NSString stringWithFormat:@"%@",showdata[@"succ"]];
        // 1强制 2非强制
        if ([self.forceStr isEqualToString:@"1"]) {
            if ([succStr isEqualToString:@"1"]) {
                [self pushViewControllerDict];
            }else{
                [self createShowVeriIndeErrorView];
            }
            return;
        }else{
            // 非强制 --
            if ([succStr isEqualToString:@"1"]) {
                [self pushViewControllerDict];
            }else{
                //记录验证失败次数
                self.veriErrorNumberStr += 1;
                if (self.veriErrorNumberStr >= [self.veriNumberStr integerValue]) {
                    [self.showVeriIndeErrorView removeFromSuperview];
                    [self pushViewControllerDict];
                }else{
                    [self createShowVeriIndeErrorView];
                }
            }
        }
    }];
}

@end
