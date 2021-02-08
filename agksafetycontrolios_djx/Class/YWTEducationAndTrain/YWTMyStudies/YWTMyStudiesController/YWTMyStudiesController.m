//
//  MyStudiesController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/4/10.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTMyStudiesController.h"
#import "YWTBaseHeaderSearchView.h"
#import "YWTShowNoSourceView.h"
#import "YWTExamPaperListSiftView.h"
#import "YWTShowNoSourceView.h"
#import "YWTMyStudiesDetailController.h"

#import "YWTShowVerifyIdentidyErrorView.h"

#import "YWTMyStudiesTableViewCell.h"
#define MYSTUDIESTABLEVIEW_CELL @"YWTMyStudiesTableViewCell"

@interface YWTMyStudiesController ()
<
ExamPaperListSiftViewDelegate,
UITableViewDelegate,
UITableViewDataSource
>
// 头部搜索view
@property (nonatomic,strong) YWTBaseHeaderSearchView  *headerSearchView;
// 空白页
@property (nonatomic,strong) YWTShowNoSourceView *showNoSoucreView;
// 筛选view
@property (nonatomic,strong) YWTExamPaperListSiftView *listSiftView;
// 验证失败view
@property (nonatomic,strong)YWTShowVerifyIdentidyErrorView *showVeriIndeErrorView;

@property (nonatomic,strong) UITableView *studiesTableView;

@property (nonatomic,strong) NSMutableArray *dataArr;
// 页数
@property (nonatomic,assign) NSInteger page;
//  筛选条
@property (nonatomic,strong) NSString *tagIdStr;
// 是否强制人脸 1强制 2非强制
@property (nonatomic,strong) NSString *forceStr;
// 记录当前人脸规则的数据源
@property (nonatomic,strong) NSDictionary *nowVeriDict;
// 记录验证失败次数
@property (nonatomic,strong) NSString *veriNumberStr;
// 记录验证失败次数
@property (nonatomic,assign) NSInteger veriErrorNumber;
@end

@implementation YWTMyStudiesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [self setNavi];
    // 创建搜索view
    [self createSearchView];
    //  创建Tableview
    [self.view addSubview:self.studiesTableView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 请求
    self.page =  1;
    [self requestFileManangetLitsData];
}
#pragma mark --- TableviewDelegate --------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWTMyStudiesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MYSTUDIESTABLEVIEW_CELL forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dict = self.dataArr[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KSIphonScreenH(140);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = self.dataArr[indexPath.row];

    // 只有任务开启时 才会开起人脸规则  否则不会开起人脸 是否开启人脸 1开 2不开
    NSString *monitorStr = [NSString stringWithFormat:@"%@",dict[@"monitor"]];
    if ([monitorStr isEqualToString:@"2"]) {
        // 跳转到详情页面
        [self pushNextViewControllerData:dict];
        // 结束
        return ;
    }
    //人脸规则数组
    NSArray *monitorRulesArr = dict[@"monitorRules"];
    if (monitorRulesArr.count == 0) {
        // 跳转到详情页面
        [self pushNextViewControllerData:dict];
        return;
    }
    // 赋值
    self.monitorRules = monitorRulesArr;
    // 判断有没有规则
    NSDictionary *monitorDict = [self createFaveVerificationStr:@"start"];
    if (monitorDict.count == 0) {
        // 跳转到详情页面
        [self pushNextViewControllerData:dict];
        return;
    }
    NSString *typeStr = [NSString stringWithFormat:@"%@",dict[@"type"]];
    if ([typeStr isEqualToString:@"video"]){
        // 视频
       [self createOpenFace:dict];
    }else if ([typeStr isEqualToString:@"audio"]){
        // 音频
        [self createOpenFace:dict];
    }else if ([typeStr isEqualToString:@"images"]){
        // 图片
        [self createOpenFace:dict];
    }else{
        // 跳转到详情页面
        [self pushNextViewControllerData:dict];
    }
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
    
    // 再次验证
    self.showVeriIndeErrorView.againBtnBlock = ^{
        [weakSelf.showVeriIndeErrorView removeFromSuperview];
        // 重新验证
        [weakSelf passRulesConductFaceVeri:[weakSelf createFaveVerificationStr:@"start"]];
    };
    // 直接进入考试
    self.showVeriIndeErrorView.enterBtnBlcok = ^{
        [weakSelf.showVeriIndeErrorView removeFromSuperview];
    };
}
// 创建开启人脸参数
-(void) createOpenFace:(NSDictionary *)dict{
    // 移除 当前人脸规则的数据源
    self.nowVeriDict = nil;
    
    // 记录当前人脸规则的数据源
    self.nowVeriDict = dict;
    
    // 是否强制人脸 1强制 2非强制
    self.forceStr = [NSString stringWithFormat:@"%@",dict[@"force"]];
    // 记录验证失败次数
    self.veriNumberStr = [NSString stringWithFormat:@"%@",dict[@"number"]];
    // 开始人脸认证
    [self passRulesConductFaceVeri:[self createFaveVerificationStr:@"start"]];
}
// 跳转到详情页面
-(void) pushNextViewControllerData:(NSDictionary *)dict{
    NSString *typeStr = [NSString stringWithFormat:@"%@",dict[@"type"]];
    YWTMyStudiesDetailController *studiesVC = [[YWTMyStudiesDetailController alloc]init];
    if ([typeStr isEqualToString:@"video"]){
        // 视频
        studiesVC.detaType = showDetailViewVideoType;
    }else if ([typeStr isEqualToString:@"audio"]){
        // 音频
        studiesVC.detaType = showDetailViewAudioType;
    }else if ([typeStr isEqualToString:@"images"]){
        // 图片
        studiesVC.detaType = showDetailViewPhotoType;
    }else{
        // 其他文件
        studiesVC.detaType = showDetailViewFileType;
    }
    // 详情ID
    studiesVC.idStr = [NSString stringWithFormat:@"%@",dict[@"id"]];
    
    // 任务id
//    NSString *taskIdStr = [NSString stringWithFormat:@"%@",dict[@"taskid"]];
    studiesVC.taskIdStr = self.taskIdStr;
    
    //人脸规则数组
    NSArray *monitorRulesArr = dict[@"monitorRules"];
    studiesVC.monitorRulesArr = monitorRulesArr;
    
    [self.navigationController pushViewController:studiesVC animated:YES];
}

#pragma mark --- 创建搜索view --------
-(void) createSearchView{
    [self.view addSubview:self.headerSearchView];
    __weak typeof(self) weakSelf = self;
    self.headerSearchView.searchTextField.placeholder = @"请输入资源名称搜索";
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
        weakSelf.titleStr = search;
        weakSelf.page = 1;
        weakSelf.tagIdStr = @"";
        [weakSelf requestFileManangetLitsData];
    };
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    self.customNavBar.title =self.moduleNameStr;
    
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
            weakSelf.listSiftView.siftType = showListSiftMyStudiesType;
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
    [self requestFileManangetLitsData];
}
#pragma  mark ------- 懒加载 -----
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
-(YWTExamPaperListSiftView *)listSiftView{
    if (!_listSiftView) {
        _listSiftView = [[YWTExamPaperListSiftView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KScreenH-KSNaviTopHeight)];
    }
    return _listSiftView;
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
-(void)setModuleNameStr:(NSString *)moduleNameStr{
    _moduleNameStr = moduleNameStr;
}
-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
}
-(void)setResourceIdStr:(NSString *)resourceIdStr{
    _resourceIdStr = resourceIdStr;
}
-(void)setTaskIdStr:(NSString *)taskIdStr{
    _taskIdStr = taskIdStr;
}
-(UITableView *)studiesTableView{
    if (!_studiesTableView) {
        _studiesTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight+KSIphonScreenH(60), KScreenW, KScreenH-KSNaviTopHeight-KSIphonScreenH(60)-KSTabbarH)];
        
        _studiesTableView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
        _studiesTableView.dataSource = self;
        _studiesTableView.delegate  = self;
        _studiesTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
        _studiesTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        
        [_studiesTableView registerClass:[YWTMyStudiesTableViewCell class] forCellReuseIdentifier:MYSTUDIESTABLEVIEW_CELL];
        
        // 添加空白页
        [_studiesTableView addSubview:self.showNoSoucreView];
        
        // 刷新
        __weak typeof(self) weakSelf = self;
        [_studiesTableView bindGlobalStyleForHeadRefreshHandler:^{
            weakSelf.page = 1;
            [weakSelf requestFileManangetLitsData];
        }];
        
        [_studiesTableView bindGlobalStyleForFootRefreshHandler:^{
            weakSelf.page ++;
            [weakSelf requestFileManangetLitsData];
        }];
    }
    return _studiesTableView;
}

#pragma mark ----- 列表数据 -----
-(void) requestFileManangetLitsData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"page"] = [NSNumber numberWithInteger:self.page];
    param[@"keyword"] = self.titleStr;
    param[@"tagId"] = self.tagIdStr;
    param[@"pageSize"] = @"15";
    param[@"fileid"] = self.resourceIdStr;
    param[@"taskid"]= self.taskIdStr;
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPFILEMANAGEMENTLISTS_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        [self.studiesTableView.headRefreshControl endRefreshing];
        [self.studiesTableView.footRefreshControl endRefreshing];
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if ([showdata isKindOfClass:[NSArray class]]) {
            if (self.page == 1) {
                [self.dataArr removeAllObjects];
            }
            // 添加数据
            [self.dataArr addObjectsFromArray:showdata];
            
            if (self.dataArr.count > 0) {
                self.showNoSoucreView.hidden = YES;
            }else{
                self.showNoSoucreView.hidden = NO;
            }
            // 刷新UI
            [self.studiesTableView reloadData];
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
    param[@"examId"] = @"0";
    param[@"examRoomId"] = @"0";
    param[@"type"] = @"2";
    param[@"source"] = @"4";
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
                // 跳转详情页面
                [self pushNextViewControllerData:self.nowVeriDict];
            }else{
                // 创建失败view
                [self createShowVeriIndeErrorViewAndType:@"1"];
            }
        }else{
            NSString *succStr = [NSString stringWithFormat:@"%@",showdata[@"succ"]];
            if ([succStr isEqualToString:@"1"]) {
                // 跳转详情页面
                [self pushNextViewControllerData:self.nowVeriDict];
            }else{
                //记录验证失败次数
                self.veriErrorNumber += 1;
                if (self.veriErrorNumber >= [self.veriNumberStr integerValue]) {
                    [self.showVeriIndeErrorView removeFromSuperview];
                    // 跳转详情页面
                    [self pushNextViewControllerData:self.nowVeriDict];
                }else{
                    // 创建失败view
                    [self createShowVeriIndeErrorViewAndType:@"1"];
                }
            }
        }
    }];
}




@end
