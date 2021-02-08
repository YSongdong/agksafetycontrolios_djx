//
//  ExamPaperExerciseController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/16.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTExamPaperExerciseController.h"

#import "YWTPhotoCollectionController.h"
#import "YWTExamQuestionController.h"
#import "YWTShowVerifyIdentidyErrorView.h"
#import "YWTShowCountDownView.h"

#import "YWTCandidateInfoTableViewCell.h"
#define CANDIDATEINFOTABLEVIEW_CELL @"YWTCandidateInfoTableViewCell"
#import "YWTExamPaperInfoTableViewCell.h"
#define EXAMPAPERINFOTABLEVIEW_CELL @"YWTExamPaperInfoTableViewCell"
#import "YWTSubmitBtnTableViewCell.h"
#define SUBMITBTNTABLEVIEW_CELL @"YWTSubmitBtnTableViewCell"
#import "YWTExamCenterInfoTableViewCell.h"
#define EXAMCENTERINFOTABLEVIEW_CELL @"YWTExamCenterInfoTableViewCell"


@interface YWTExamPaperExerciseController ()
<
UITableViewDelegate,
UITableViewDataSource
>
// 验证失败view
@property (nonatomic,strong)YWTShowVerifyIdentidyErrorView *showVeriIndeErrorView;

// 显示提示框
@property (nonatomic,strong)YWTShowCountDownView *showCountDownView;

@property (nonatomic,strong) UITableView *exerTableView;
// 数据源数组
@property (nonatomic,strong) NSMutableArray *dataArr;
// 数据源字典
@property (nonatomic,strong) NSMutableDictionary *dataDict;
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
// i记录任务id
//@property (nonatomic,strong) NSString *taskidStr;
@end

@implementation YWTExamPaperExerciseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.veriErrorNumberStr = 0;
    // 设置导航栏
    [self setNavi];
    // 创建TableView
    [self createTableView];
    // 请求数据
    [self requestExamUserDetail];
}
#pragma mark --- 创建TableView --------
-(void) createTableView{
    self.view.backgroundColor = [UIColor colorTextWhiteColor];
    
    self.exerTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KScreenH-KSNaviTopHeight-KSTabbarH)];
    [self.view addSubview:self.exerTableView];
    self.exerTableView.delegate = self;
    self.exerTableView.dataSource = self;
    self.exerTableView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    self.exerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.exerTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.exerTableView registerClass:[YWTCandidateInfoTableViewCell class] forCellReuseIdentifier:CANDIDATEINFOTABLEVIEW_CELL];
    [self.exerTableView registerClass:[YWTExamPaperInfoTableViewCell class] forCellReuseIdentifier:EXAMPAPERINFOTABLEVIEW_CELL];
    [self.exerTableView registerClass:[YWTSubmitBtnTableViewCell class] forCellReuseIdentifier:SUBMITBTNTABLEVIEW_CELL];
    [self.exerTableView registerClass:[YWTExamCenterInfoTableViewCell class] forCellReuseIdentifier:EXAMCENTERINFOTABLEVIEW_CELL];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        YWTCandidateInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CANDIDATEINFOTABLEVIEW_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dict = self.dataArr[indexPath.row];
        return cell;
    }else if (indexPath.row == 1){
        if (self.examType == showTableViewExamPaperType) {
            YWTExamPaperInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EXAMPAPERINFOTABLEVIEW_CELL forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.dict = self.dataArr[indexPath.row];
            return cell;
        }else{
            YWTExamCenterInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EXAMCENTERINFOTABLEVIEW_CELL forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.dict = self.dataArr[indexPath.row];
            return cell;
        }
    }else{
        YWTSubmitBtnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SUBMITBTNTABLEVIEW_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.examType == showTableViewExamPaperType) {
            [cell.submitBtn setTitle:@"开始测验" forState:UIControlStateNormal];
        }else{
           [cell.submitBtn setTitle:@"开始考试" forState:UIControlStateNormal];
        }
        __weak typeof(self) weakSelf = self;
        // 点击进入考试按钮
        cell.selectSubmitBlock = ^{
            [weakSelf beginExamLogicalProecess];
        };
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return KSIphonScreenH(175);
    }else if (indexPath.row ==1 ){
        if (self.examType == showTableViewExamPaperType) {
            return KSIphonScreenH(300);
        }else{
            NSDictionary *dict = self.dataArr[indexPath.row];
            return  [YWTExamCenterInfoTableViewCell getLabelHeightWithDict:dict];
        }
    }else{
        return KSIphonScreenH(80);
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        NSDictionary *dict = self.dataArr[indexPath.row];
        NSString *vFaceStr = [NSString stringWithFormat:@"%@",dict[@"vFace"]];
        YWTPhotoCollectionController *photoVC = [[YWTPhotoCollectionController alloc]init];
        if ([vFaceStr isEqualToString:@"1"]) {
            photoVC.photoStatu = photoStatuCheckSucces;
        }else if ([vFaceStr isEqualToString:@"2"]){
            photoVC.photoStatu = photoStatuNotUploaded;
        }else if ([vFaceStr isEqualToString:@"3"]){
            photoVC.photoStatu = photoStatuCheckError;
        }else if ([vFaceStr isEqualToString:@"4"]){
            photoVC.photoStatu = photoStatuChecking;
        }
        [self.navigationController pushViewController:photoVC animated:YES];
    }
}
#pragma mark --- 开始考试--------
-(void) beginExamLogicalProecess{
    __weak typeof(self)weakSelf = self;
    // 判断是否开启人脸  1启用监控 2不启用监控
    if ([self.monitorStr isEqualToString:@"1"]) {
        BOOL  isStart = NO;
        NSMutableDictionary *motionDict = [NSMutableDictionary dictionary];
        // 如果开启z监控 但是没有返回规则 直接跳出验证规则
        if (self.monitorRulesArr.count == 0) {
            [self createJumpExamViewControllerView];
            return;
        }
        for (NSDictionary *dict in weakSelf.monitorRulesArr) {
            // 获取检测规则key
            NSString *ruleKeyStr = [NSString stringWithFormat:@"%@",dict[@"rule"]];
            if ([ruleKeyStr isEqualToString:@"start"]) {
                isStart = YES;
                // 是否开启强制
                weakSelf.forceStr = [NSString stringWithFormat:@"%@",dict[@"force"]];
                // 记录验证次数
                weakSelf.veriNumberStr = [NSString stringWithFormat:@"%@",dict[@"number"]];
                // 记录规则
                motionDict = [NSMutableDictionary dictionaryWithDictionary:dict];
            }
        }
        if (isStart) {
            [weakSelf createTransferFaceSDk:motionDict[@"motion"]];
        }else{
           // 不开启监控
           [self createJumpExamViewControllerView];
        }
    }else{
        // 不开启监控
        [self createJumpExamViewControllerView];
    }
}
//调用百度云SDK
-(void) createTransferFaceSDk:(NSString *)motionStr;{
    __weak typeof(self) weakSelf = self;
    if ([[FaceSDKManager sharedInstance] canWork]) {
        NSString* licensePath = [[NSBundle mainBundle] pathForResource:FACE_LICENSE_NAME ofType:FACE_LICENSE_SUFFIX];
        [[FaceSDKManager sharedInstance] setLicenseID:FACE_LICENSE_ID andLocalLicenceFile:licensePath];
    }
     NSArray *motionRulesArr = [motionStr componentsSeparatedByString:@","];
    if ([motionRulesArr containsObject:@"10"]) {
        DetectionViewController* dvc = [[DetectionViewController alloc] init];
        SDRootNavigationController *navi = [[SDRootNavigationController alloc] initWithRootViewController:dvc];
        navi.navigationBarHidden = true;
        navi.modalPresentationStyle = UIModalPresentationFullScreen;
        //点击关闭视图
        dvc.closeViewControllBlock = ^{
            [weakSelf  createShowVeriIndeErrorViewAndType:@"1"];
        };
        // 如果超时
        dvc.CodeTimeoutBlock = ^{
            [weakSelf  createShowVeriIndeErrorViewAndType:@"1"];
        };
        // 采集成功
        dvc.fackBlcok = ^(UIImage *image) {
            [weakSelf requestMonitorFaceRecogintion:image];
        };
        [self presentViewController:navi animated:YES completion:nil];
        return;
    }
    LivenessViewController* lvc = [[LivenessViewController alloc] init];
    //获取人脸规则数组
    NSArray *motionArr = [self createFaceVierMotion:motionStr];
    [lvc livenesswithList:motionArr order:YES numberOfLiveness:2];
    SDRootNavigationController *navi = [[SDRootNavigationController alloc] initWithRootViewController:lvc];
    navi.navigationBarHidden = true;
    navi.modalPresentationStyle = UIModalPresentationFullScreen;
    // 超时
    lvc.CodeTimeoutBlock = ^{
        [weakSelf  createShowVeriIndeErrorViewAndType:@"1"];
    };
    // 点击关闭
    lvc.closeViewControllBlock = ^{
        [weakSelf  createShowVeriIndeErrorViewAndType:@"1"];
    };
    // 采集成功
    lvc.fackBlcok = ^(UIImage *image) {
        [weakSelf requestMonitorFaceRecogintion:image];
    };
    [self presentViewController:navi animated:YES completion:nil];
}
-(NSArray *) createFaceVierMotion:(NSString *)motionStr{
    NSMutableArray *liveActionArr = [NSMutableArray array];
    NSArray *motionArr = [motionStr componentsSeparatedByString:@","];
    for (int i=0; i<motionArr.count; i++) {
        NSString *str = motionArr[i];
        [liveActionArr addObject:[NSNumber numberWithInteger:[str integerValue]]];
    }
    return liveActionArr.copy;
}
#pragma mark --- 跳转到考试页面--------
-(void) createJumpExamViewControllerView{
    YWTExamQuestionController *examQuestVC = [[YWTExamQuestionController alloc]init];
    if (self.examType == showTableViewExamPaperType) {
        examQuestVC.controllerExamType = controllerMockExamType;
    }else{
        examQuestVC.controllerExamType = controllerOfficialExamType;
    }
    // 任务id
    examQuestVC.taskidStr = self.taskIdStr;
    examQuestVC.examIdStr = self.examIdStr;
    examQuestVC.examRoomIdStr = self.examRoomIdStr;
    examQuestVC.examBatchIdStr = self.examBatchIdStr;
    examQuestVC.controllerQuestMode = controllerExamQuestAnswerMode;
    examQuestVC.monitorRulesArr = self.monitorRulesArr.copy;
    examQuestVC.descriptionStr = [NSString stringWithFormat:@"%@",self.dataDict[@"description"]];
    [self.navigationController pushViewController:examQuestVC animated:YES];
}
#pragma mark --- 创建验证失败的view --------
-(void) createShowVeriIndeErrorViewAndType:(NSString *)typeStr{
    __weak typeof(self) weakSelf = self;
     self.showVeriIndeErrorView = [[YWTShowVerifyIdentidyErrorView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH) andType:typeStr];
    [self.view addSubview:self.showVeriIndeErrorView];

    // 再次验证
    self.showVeriIndeErrorView.againBtnBlock = ^{
        [weakSelf.showVeriIndeErrorView removeFromSuperview];
        [weakSelf beginExamLogicalProecess];
    };
    // 直接进入考试
    self.showVeriIndeErrorView.enterBtnBlcok = ^{
        [weakSelf.showVeriIndeErrorView removeFromSuperview];
        [weakSelf createJumpExamViewControllerView];
    };
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    if (self.examType == showTableViewExamPaperType) {
        self.customNavBar.title = @"模拟测验";
    }else{
        self.customNavBar.title = @"考试中心";
    }
    __weak typeof(self) weakSelf = self;
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}
#pragma mark -----懒加载-------
-(YWTShowCountDownView *)showCountDownView{
    if (!_showCountDownView) {
        _showCountDownView = [[YWTShowCountDownView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH)];
    }
    return _showCountDownView;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(NSMutableDictionary *)dataDict{
    if (!_dataDict) {
        _dataDict = [NSMutableDictionary dictionary];
    }
    return _dataDict;
}
-(NSMutableArray *)monitorRulesArr{
    if (!_monitorRulesArr) {
        _monitorRulesArr = [NSMutableArray array];
    }
    return _monitorRulesArr;
}
-(void)setExamType:(showTableViewExamType)examType{
    _examType = examType;
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
-(void)setPaperIdStr:(NSString *)paperIdStr{
    _paperIdStr = paperIdStr;
}
-(void)setTaskIdStr:(NSString *)taskIdStr{
    _taskIdStr = taskIdStr;
}
#pragma mark -----请求人员详情接口-------
-(void) requestExamUserDetail{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] =  [YWTTools getNewToken];
    param[@"examid"] =  self.paperIdStr;
    param[@"examRoomId"] = self.examRoomIdStr;
    if (self.examType == showTableViewExamPaperType) {
        param[@"type"] = @"2";
    }else{
        param[@"type"] = @"1";
    }
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPQUESTIONEXAMUESRDETAILS_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:1];
            return ;
        }
        if (![showdata isKindOfClass:[NSDictionary class]]) {
            [self.view showErrorWithTitle:@"返回数据格式错误" autoCloseTime:1];
            return;
        }
        // 记录数据源字典
        [self.dataDict  addEntriesFromDictionary:showdata];
        // 判断是否开启人脸  1启用监控 2不启用监控
        self.monitorStr = [NSString stringWithFormat:@"%@",showdata[@"monitor"]];
        // 记录 监控规则数组
        self.monitorRulesArr = [NSMutableArray arrayWithArray:showdata[@"monitorRules"]];
//        // 记录任务id
//        self.taskidStr = [NSString stringWithFormat:@"%@",showdata[@"taskid"]];
        
        if (self.examType == showTableViewExamPaperType) {
            // 用户信息
            NSMutableDictionary *userDict = [NSMutableDictionary dictionary];
            userDict[@"realName"] = showdata[@"realName"];
            userDict[@"sn"] = showdata[@"sn"];
            userDict[@"unitName"] = showdata[@"unitName"];
            userDict[@"photo"] = showdata[@"photo"];
            userDict[@"vFace"] = showdata[@"vFace"];
            [self.dataArr addObject:userDict.copy];
            
            //试卷信息
            NSMutableDictionary *examPaperDict = [NSMutableDictionary dictionary];
            examPaperDict[@"questionNum"] = showdata[@"questionNum"];
            examPaperDict[@"examTotalTime"] = showdata[@"examTotalTime"];
            examPaperDict[@"passScore"] = showdata[@"passScore"];
            examPaperDict[@"totalScore"] = showdata[@"totalScore"];
            examPaperDict[@"title"] = showdata[@"title"];
            [self.dataArr addObject:examPaperDict.copy];
            
            [self.dataArr addObject:showdata];
            
            [self.exerTableView reloadData];
        }else{
            // 用户信息
            NSMutableDictionary *userDict = [NSMutableDictionary dictionary];
            userDict[@"realName"] = showdata[@"realName"];
            userDict[@"sn"] = showdata[@"sn"];
            userDict[@"unitName"] = showdata[@"unitName"];
            userDict[@"photo"] = showdata[@"photo"];
            userDict[@"vFace"] = showdata[@"vFace"];
            [self.dataArr addObject:userDict.copy];
            
            //试卷信息
            NSMutableDictionary *examPaperDict = [NSMutableDictionary dictionary];
            examPaperDict[@"questionNum"] = showdata[@"questionNum"];
            examPaperDict[@"examTotalTime"] = showdata[@"examTotalTime"];
            examPaperDict[@"passScore"] = showdata[@"passScore"];
            examPaperDict[@"totalScore"] = showdata[@"totalScore"];
            examPaperDict[@"title"] = showdata[@"title"];
            examPaperDict[@"examRoomName"] = showdata[@"examRoomName"];
            examPaperDict[@"examName"] = showdata[@"examName"];
            examPaperDict[@"examType"] = showdata[@"examType"];
            examPaperDict[@"description"] = showdata[@"description"];
            examPaperDict[@"timeSlot"] = showdata[@"timeSlot"];
            [self.dataArr addObject:examPaperDict.copy];
            
            [self.dataArr addObject:showdata];
            
            [self.exerTableView reloadData];
        }
        // 判断是否需要弹提示框
        NSString  *remindStr = [NSString stringWithFormat:@"%@",showdata[@"remind"]];
        if ([remindStr isEqualToString:@"1"]) {
            NSString *contentStr = [NSString stringWithFormat:@"%@",showdata[@"remContent"]];
            [[UIApplication sharedApplication].keyWindow addSubview:self.showCountDownView];
            self.showCountDownView.contentLab.text = contentStr;
            self.showCountDownView.isOffTime = YES;
        }
    }];
}
#pragma mark -----人脸识别对比---------
-(void) requestMonitorFaceRecogintion:(UIImage *)faceImage{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] = [YWTUserInfo obtainWithUserId];
    param[@"token"] = [YWTTools getNewToken];
    param[@"platformCode"] = [YWTUserInfo obtainWithLoginPlatformCode];
    param[@"examId"] = self.examIdStr;
    param[@"examRoomId"] = self.examRoomIdStr;
    param[@"type"] = @"1";
    if (self.examType == showTableViewExamPaperType) {
        param[@"source"] = @"2";
    }else{
        param[@"source"] = @"1";
    }
    param[@"rule"] = @"start";
    
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
    // 任务id
//    param[@"taskId"] = self.taskidStr;
    
    [[KRMainNetTool sharedKRMainNetTool] upLoadPhotoUrl:HTTP_ATTAPPMOITORAPIFACERECOGINTION_URL params:param photo:faceImage waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if ([showdata isKindOfClass:[NSDictionary class]]) {
            // 1强制 2非强制
            if ([self.forceStr isEqualToString:@"1"]) {
                NSString *succStr = [NSString stringWithFormat:@"%@",showdata[@"succ"]];
                if ([succStr isEqualToString:@"1"]) {
                    [self createJumpExamViewControllerView];
                }else{
                    [self createShowVeriIndeErrorViewAndType:@"1"];
                }
            }else{
                NSString *succStr = [NSString stringWithFormat:@"%@",showdata[@"succ"]];
                if ([succStr isEqualToString:@"1"]) {
                    [self createJumpExamViewControllerView];
                }else{
                    //记录验证失败次数
                    self.veriErrorNumberStr += 1;
                    if (self.veriErrorNumberStr >= [self.veriNumberStr integerValue]) {
                        [self.showVeriIndeErrorView removeFromSuperview];
                        [self createJumpExamViewControllerView];
                    }else{
                        [self createShowVeriIndeErrorViewAndType:@"1"];
                    }
                }
            }
        }
        
    }];
}





@end
