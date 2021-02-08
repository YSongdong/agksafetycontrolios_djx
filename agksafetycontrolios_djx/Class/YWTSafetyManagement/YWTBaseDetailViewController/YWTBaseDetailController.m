//
//  BaseDetailController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/12.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTBaseDetailController.h"

#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

#import "YWTBottomToolView.h"
#import "YWTDetaCancelPropmtView.h"
#import "YETBaseDetailAnnexHeaderView.h"
#import "YWTBaseDetailAnnexFootView.h"

#import "YWTBaseTableViewController.h"
#import "YWTAnnexLookOverJSController.h"
#import "YWTBaseRecordController.h"
#import "YWTBaseDetailAnnexCell.h"
#define BASEDETAILANNEX_CELL @"YWTBaseDetailAnnexCell"
#import "YWTBaseDetaUserInfoCell.h"
#define BASEDETAUSERINFO_CELL  @"YWTBaseDetaUserInfoCell"

@interface YWTBaseDetailController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic,strong) YWTBottomToolView *toolView;
// 撤销提示框
@property (nonatomic,strong) YWTDetaCancelPropmtView *cancelPropmtView;
//
@property (nonatomic,strong) YWTBaseDetailAnnexFootView  *annexFootView;

// 音频播放view
@property (nonatomic,strong) YWTBaseVodPlayView *playView;

@property (nonatomic,strong) UITableView *detaTableView;
// 附件数据源数组
@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation YWTBaseDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorTextWhiteColor];
    // 设置导航栏
    [self setNavi];
    // 创建TableView
    [self.view addSubview:self.detaTableView];
    // 请求详情
    [self requestWithCheckInfos];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.dataArr[section];
    if (section == 0) {
       return arr.count;
    }else{
        if (arr.count == 0) {
            return 1;
        }
        return arr.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        YWTBaseDetaUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:BASEDETAUSERINFO_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *arr = self.dataArr[indexPath.section];
        NSDictionary *dict = arr[indexPath.row];
        if (self.detailType == showBaseDetailSafetyType) {
            // 安全检查
            cell.cellType =showBaseUserInfoSafetyType;
        }else if (self.detailType == showBaseDetailMeetingType){
            // 会议
            cell.cellType = showBaseUserInfoMeetingType;
        }else if (self.detailType == showBaseDetailViolationType){
            // 违章
           cell.cellType =  showBaseUserInfoViolationType;
        }else if (self.detailType == showBaseDetailTechnoloType){
            // 技术
           cell.cellType = showBaseUserInfoTechnoloType;
        }
        cell.dict = dict;
        return cell;
    }else{
        YWTBaseDetailAnnexCell *cell = [tableView dequeueReusableCellWithIdentifier:BASEDETAILANNEX_CELL forIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *arr = self.dataArr[indexPath.section];
        if (arr.count == 0) {
            cell.isShowSpace = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }else{
            cell.isShowSpace = NO;
            NSDictionary *dict = arr[indexPath.row];
            cell.dict = dict;
        }
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NSArray *arr = self.dataArr[indexPath.section];
        NSDictionary *dict = arr[indexPath.row];
        if (self.detailType == showBaseDetailSafetyType) {
            // 安全检查
            return [YWTBaseDetaUserInfoCell getWithBaseDetaUserInfoHeightCell:dict andCellType:showBaseUserInfoSafetyType];
        }else if (self.detailType == showBaseDetailMeetingType){
            // 会议
            return [YWTBaseDetaUserInfoCell getWithBaseDetaUserInfoHeightCell:dict andCellType:showBaseUserInfoMeetingType];
        }else if (self.detailType == showBaseDetailViolationType){
            // 违章
            return [YWTBaseDetaUserInfoCell getWithBaseDetaUserInfoHeightCell:dict andCellType:showBaseUserInfoViolationType];
        }else if (self.detailType == showBaseDetailTechnoloType){
            // 技术
            return [YWTBaseDetaUserInfoCell getWithBaseDetaUserInfoHeightCell:dict andCellType:showBaseUserInfoTechnoloType];
        }
        return 0.01;
    }else{
        NSArray *arr = self.dataArr[indexPath.section];
        if (arr.count == 0 ) {
            return  KSIphonScreenH(300);
        }else{
             return KSIphonScreenH(50);
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return KSIphonScreenH(11);
    }else{
        NSArray *arr = self.dataArr[0];
        NSDictionary *dict = [arr firstObject];
        return  [YETBaseDetailAnnexHeaderView getWithAnnexHeaderHeight:dict];
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 11)];
        headerView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
        return headerView;
    }else{
        YETBaseDetailAnnexHeaderView *headerView = [[YETBaseDetailAnnexHeaderView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 70)];
        NSArray *arr = self.dataArr[0];
        NSDictionary *dict = [arr firstObject];
        headerView.dict = dict;
        return headerView;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return KSIphonScreenH(10);
    }else{
         return 0.01;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KSIphonScreenH(11))];
        footView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
        return footView;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 等于人员信息 直接返回
    if (indexPath.section == 0) {
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSArray *arr = self.dataArr[indexPath.section];
    if (arr.count == 0) {
        return;
    }
    NSDictionary *dict = arr[indexPath.row];
    NSString *typeStr = [NSString stringWithFormat:@"%@",dict[@"type"]];
    if ([typeStr isEqualToString:@"images"]) {
        // 图片
        [self createCheckPhoto:dict];
    }else if ([typeStr isEqualToString:@"video"]){
        // 视频
        [self createVodpalyView:dict];
    }else if ([typeStr isEqualToString:@"audio"]){
        // 音频
        NSString *urlStr =[NSString stringWithFormat:@"%@",dict[@"url"]];
        [self createAudioPlay:urlStr];
    }else if ([typeStr isEqualToString:@"pdf"]){
        // pdf
        NSString *sizeStr = [NSString stringWithFormat:@"%@",dict[@"size"]];
        if ([YWTTools getWithFileSizePass5MFileNameStr:sizeStr]) {
            [self showOpenFilePrmptViewDict:dict];
        }else{
            [self pushJSonHDetailViewController:dict];
        }
    }else if ([typeStr isEqualToString:@"doc"]){
        // doc
        NSString *sizeStr = [NSString stringWithFormat:@"%@",dict[@"size"]];
        if ([YWTTools getWithFileSizePass5MFileNameStr:sizeStr]) {
            [self showOpenFilePrmptViewDict:dict];
        }else{
            [self pushJSonHDetailViewController:dict];
        }
    }else if ([typeStr isEqualToString:@"ppt"]){
        // ppt
        NSString *sizeStr = [NSString stringWithFormat:@"%@",dict[@"size"]];
        if ([YWTTools getWithFileSizePass5MFileNameStr:sizeStr]) {
            [self showOpenFilePrmptViewDict:dict];
        }else{
            [self pushJSonHDetailViewController:dict];
        }
    }else if ([typeStr isEqualToString:@"xls"]){
        // xls
        NSString *sizeStr = [NSString stringWithFormat:@"%@",dict[@"size"]];
        if ([YWTTools getWithFileSizePass5MFileNameStr:sizeStr]) {
            [self showOpenFilePrmptViewDict:dict];
        }else{
            [self pushJSonHDetailViewController:dict];
        }
    }else{
        // 其他
        [self.view showErrorWithTitle:@"无法打开" autoCloseTime:0.5];
    }
}
// 文件超过w5M 提示
-(void) showOpenFilePrmptViewDict:(NSDictionary *)annexDict {
    __weak typeof(self) weakSelf = self;
    UIAlertController *alterView = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"文件大于5M 加载过程缓慢是否继续打开" preferredStyle:UIAlertControllerStyleAlert];
    
    [alterView addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [alterView addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 确认跳转
        [weakSelf pushJSonHDetailViewController:annexDict];
    }]];
    [self presentViewController:alterView animated:YES completion:nil];
}
// 跳转到html (h5)详情页面
-(void) pushJSonHDetailViewController:(NSDictionary *)dict{
    YWTAnnexLookOverJSController * jsVC = [[YWTAnnexLookOverJSController alloc]init];
    NSString  *midStr = [NSString stringWithFormat:@"%@",dict[@"id"]];
    jsVC.mIdStr = midStr;
    jsVC.fileNameStr = [NSString stringWithFormat:@"%@",dict[@"name"]];
    jsVC.fileType = @"1";
    [self.navigationController pushViewController:jsVC animated:YES];
}
#pragma mark ---创建查看图片view --------
-(void)createCheckPhoto:(NSDictionary *) dict{
    NSMutableArray *items = [NSMutableArray array];
    UIImageView *imageView = [[UIImageView alloc]init];
    NSString *urlStr = [NSString stringWithFormat:@"%@",dict[@"url"]];
    NSURL *url = [NSURL URLWithString:urlStr];
    KSPhotoItem *item = [KSPhotoItem itemWithSourceView:imageView imageUrl:url];
    [items addObject:item];
    KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:items selectedIndex:0];
    [browser showFromViewController:self];
}
#pragma mark ---创建视频播放View --------
-(void) createVodpalyView:(NSDictionary *) dict{
    AVPlayerViewController *ctrl = [[AVPlayerViewController alloc] init];
    NSString *str =[NSString stringWithFormat:@"%@",dict[@"url"]];
    NSString *urlStr = [NSString byAddingAllCharactersStr:str];
    NSURL *url = [NSURL URLWithString:urlStr];
    ctrl.player = [[AVPlayer alloc]initWithURL:url];
    [self presentViewController:ctrl animated:YES completion:nil];
}
#pragma mark ---创建音频播放 --------
-(void) createAudioPlay:(NSString *) urlNameStr{
    self.playView = [[YWTBaseVodPlayView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    self.playView.filePath= urlNameStr;
    [self.view addSubview:self.playView];
}
#pragma mark --- 跳转到修改页面 --------
-(void) pushViewController{
    __weak typeof(self) weakSelf = self;
    YWTBaseTableViewController *baseVC = [[YWTBaseTableViewController alloc]init];
    if (self.detailType == showBaseDetailSafetyType) {
        // 安全检查
        baseVC.veiwBaseType = showViewControllerSafetyType;
        baseVC.moduleNameStr = @"安全检查";
    }else if (self.detailType == showBaseDetailMeetingType){
        // 会议
        baseVC.veiwBaseType = showViewControllerMeetingType;
        baseVC.moduleNameStr = @"班会记录";
    }else if (self.detailType == showBaseDetailViolationType){
        // 违章
        baseVC.veiwBaseType = showViewControllerViolationType;
        baseVC.moduleNameStr = @"违章处理";
    }else if (self.detailType == showBaseDetailTechnoloType){
        // 技术
        baseVC.veiwBaseType = showViewControllerTechnoloType;
        baseVC.moduleNameStr = @"技术交底";
    }
    baseVC.scoureType = showBaseAlterSoucreType;
    baseVC.saveDataType = showBaseSaveDataSubmitType;
    // 赋值
    baseVC.alterDataArr =[self createAssemblyData];
    [weakSelf.navigationController pushViewController:baseVC animated:YES];
}
// 组装数据源
-(NSMutableArray *) createAssemblyData{
    NSMutableArray *dataArr = [NSMutableArray array];
    NSArray *arr = self.dataArr[0];
    NSDictionary *dict = arr[0];
    if (self.detailType == showBaseDetailSafetyType) {
        // 安全检查
        NSMutableDictionary *userDict = [NSMutableDictionary dictionary];
        userDict[@"realName"] = dict[@"realName"];
        userDict[@"userId"] = dict[@"userId"];
        userDict[@"platformId"] = dict[@"platformId"];
        userDict[@"unitId"] = dict[@"unitId"];
        userDict[@"type"] = dict[@"type"];
        userDict[@"unitName"] = dict[@"unitName"];
        userDict[@"time"] = [YWTTools timestampSwitchTime:[YWTTools getNowTimestamp] andFormatter:@"YYYY.MM.dd HH:mm"];
        userDict[@"id"] = dict[@"id"];
        [dataArr addObject:userDict];
        
        //  内容字典
        NSMutableDictionary *contentDict = [NSMutableDictionary dictionary];
        contentDict[@"beingCheckUnitName"] = dict[@"beingCheckUnitName"];
        contentDict[@"securityCheckAddress"] = dict[@"securityCheckAddress"];
        contentDict[@"voltageLevels"] = dict[@"voltageLevels"];
        contentDict[@"workTicketNumber"] = dict[@"workTicketNumber"];
        contentDict[@"securityCheckTitle"] = dict[@"securityCheckTitle"];
        contentDict[@"securityCheckContent"] = dict[@"securityCheckContent"];
        [dataArr addObject:contentDict];
    
    }else if (self.detailType == showBaseDetailMeetingType){
        // 会议
        NSMutableDictionary *userDict = [NSMutableDictionary dictionary];
        userDict[@"realName"] = dict[@"realName"];
        userDict[@"userId"] = dict[@"userId"];
        userDict[@"unitId"] = dict[@"unitId"];
        userDict[@"type"] = dict[@"type"];
        userDict[@"unitName"] = dict[@"unitName"];
        userDict[@"platformId"] = dict[@"platformId"];
        userDict[@"id"] = dict[@"id"];
        [dataArr addObject:userDict];
        
        //  内容字典
        NSMutableDictionary *contentDict = [NSMutableDictionary dictionary];
        contentDict[@"workTicketNumber"] = dict[@"workTicketNumber"];
        contentDict[@"classRecordAddress"] = dict[@"classRecordAddress"];
        contentDict[@"classRecordTitle"] = dict[@"classRecordTitle"];
        contentDict[@"classRecordContent"] = dict[@"classRecordContent"];
        [dataArr addObject:contentDict];
    }else if (self.detailType == showBaseDetailViolationType){
        // 违章
        NSMutableDictionary *userDict = [NSMutableDictionary dictionary];
        userDict[@"realName"] = dict[@"realName"];
        userDict[@"userId"] = dict[@"userId"];
        userDict[@"unitId"] = dict[@"unitId"];
        userDict[@"type"] = dict[@"type"];
        userDict[@"unitName"] = dict[@"unitName"];
        userDict[@"platformId"] = dict[@"platformId"];
        userDict[@"id"] = dict[@"id"];
        [dataArr addObject:userDict];
        
        //  内容字典
        NSMutableDictionary *contentDict = [NSMutableDictionary dictionary];
        contentDict[@"violationUserInfo"] = dict[@"violationUserInfo"];
        contentDict[@"violationUnitName"] = dict[@"violationUnitName"];
        contentDict[@"levels"] = dict[@"levels"];
        contentDict[@"violationHanTitle"] = dict[@"violationHanTitle"];
        contentDict[@"violationHanContent"] = dict[@"violationHanContent"];
        [dataArr addObject:contentDict];
    }else if (self.detailType == showBaseDetailTechnoloType){
        // 技术
        NSMutableDictionary *userDict = [NSMutableDictionary dictionary];
        userDict[@"realName"] = dict[@"realName"];
        userDict[@"userId"] = dict[@"userId"];
        userDict[@"unitId"] = dict[@"unitId"];
        userDict[@"type"] = dict[@"type"];
        userDict[@"unitName"] = dict[@"unitName"];
        userDict[@"platformId"] = dict[@"platformId"];
        userDict[@"id"] = dict[@"id"];
        [dataArr addObject:userDict];
        
        //  内容字典
        NSMutableDictionary *contentDict = [NSMutableDictionary dictionary];
        contentDict[@"technicalDisclosureAddress"] = dict[@"technicalDisclosureAddress"];
        contentDict[@"workTicketNumber"] = dict[@"workTicketNumber"];
        contentDict[@"technicalDisclosureTitle"] = dict[@"technicalDisclosureTitle"];
        contentDict[@"technicalDisclosureContent"] = dict[@"technicalDisclosureContent"];
        [dataArr addObject:contentDict];
    }
    [dataArr addObject:dict[@"enclosure"]];
    return dataArr;
}

#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    if (self.detailType == showBaseDetailSafetyType) {
        self.customNavBar.title = @"安全检查详情";
    }else if (self.detailType == showBaseDetailMeetingType){
         self.customNavBar.title = @"班会记录详情";
    }else if (self.detailType == showBaseDetailViolationType){
        self.customNavBar.title = @"违章处理详情";
    }else if (self.detailType == showBaseDetailTechnoloType){
        self.customNavBar.title = @"技术交底详情";
    }
    __weak typeof(self) weakSelf = self;
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    self.customNavBar.onClickLeftButton = ^{
        YWTBaseRecordController *baseRecordVC = [[YWTBaseRecordController alloc]init];
        if (weakSelf.detailType == showBaseDetailSafetyType) {
            baseRecordVC.recordType = showBaseRecordSafetyType;
        }else if (weakSelf.detailType == showBaseDetailMeetingType){
            baseRecordVC.recordType = showBaseRecordMeetingType;
        }else if (weakSelf.detailType == showBaseDetailViolationType){
            baseRecordVC.recordType = showBaseRecordViolationType;
        }else if (weakSelf.detailType == showBaseDetailTechnoloType){
            baseRecordVC.recordType = showBaseRecordTechnoloType;
        }
        [weakSelf.navigationController pushViewController:baseRecordVC animated:YES];
    };
}
#pragma mark --- 系统回调 左滑返回-------
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}
#pragma mark --- get 方法--------
-(UITableView *)detaTableView{
    if (!_detaTableView) {
        _detaTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KScreenH-KSTabbarH-KSNaviTopHeight) style:UITableViewStyleGrouped];
        _detaTableView.backgroundColor = [UIColor colorTextWhiteColor];
        _detaTableView.delegate = self;
        _detaTableView.dataSource = self;
        _detaTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_detaTableView registerClass:[YWTBaseDetailAnnexCell class] forCellReuseIdentifier:BASEDETAILANNEX_CELL];
        [_detaTableView registerClass:[YWTBaseDetaUserInfoCell class] forCellReuseIdentifier:BASEDETAUSERINFO_CELL];
    }
    return _detaTableView;
}
-(YWTBaseDetailAnnexFootView *)annexFootView{
    if (!_annexFootView) {
        _annexFootView = [[YWTBaseDetailAnnexFootView alloc]initWithFrame:CGRectMake(0, KScreenH-KSTabbarH-KSIphonScreenH(50), KScreenW, KSIphonScreenH(50))];
       // 撤销
        __weak typeof(self) weakSelf = self;
        _annexFootView.selectRevokelsBtn = ^{
            // 创建撤销提示框
            [weakSelf.view addSubview:weakSelf.cancelPropmtView];
            __weak typeof(weakSelf) strongSelf =  weakSelf;
            weakSelf.cancelPropmtView.selectTureCancel = ^{
                // 移除提示框
                [strongSelf.cancelPropmtView removeFromSuperview];
                // 请求接口
                [strongSelf requestManagemetCenterRevokels];
            };
        };
        // 修改
        _annexFootView.selelctAlterBtn = ^{
             [weakSelf pushViewController];
        };
    }
    return _annexFootView;
}
-(YWTDetaCancelPropmtView *)cancelPropmtView{
    if (!_cancelPropmtView) {
        _cancelPropmtView = [[YWTDetaCancelPropmtView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH)];
    }
    return _cancelPropmtView;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr  =[NSMutableArray array];
    }
    return _dataArr;
}

-(void)setDetailType:(showBaseDetailType)detailType{
    _detailType = detailType;
}
-(void)setToolType:(showBaseToolType)toolType{
    _toolType = toolType;
}

-(void)setIdStr:(NSString *)idStr{
    _idStr = idStr;
}
#pragma mark ------ 安全检查详情 ---------
-(void)requestWithCheckInfos{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"platformCode"] = [YWTUserInfo obtainWithLoginPlatformCode];
    NSString *url ;
    if (self.detailType == showBaseDetailSafetyType) {
        //安全检查详情
        param[@"checkId"] = self.idStr;
        url = HTTP_ATTAPPSECURITYCHECKINFOS_URL;
    }else if (self.detailType == showBaseDetailMeetingType){
        //班会记录详情
        param[@"classId"] = self.idStr;
        url = HTTP_ATTAPPCLASSRECORDINFOS_URL;
    }else if (self.detailType == showBaseDetailViolationType){
        //违章处理详情
        param[@"classId"] = self.idStr;
        url = HTTP_ATTAPPVIOLATIONHANINFOS_URL;
    }else if (self.detailType == showBaseDetailTechnoloType){
        //技术交底详情
        param[@"classId"] = self.idStr;
        url = HTTP_ATTAPPTECHNICALDISCLOSUREINFOS_URL;
    }
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:url params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if ([showdata isKindOfClass:[NSDictionary class]]) {
            
            NSMutableArray *userArr = [NSMutableArray array];
            [userArr addObject:showdata];
            [self.dataArr addObject:userArr];
            
            // 附件数组
            NSArray *arr = (NSArray *)showdata[@"enclosure"];
            NSMutableArray *enclosureArr = [NSMutableArray arrayWithArray:arr];
            [self.dataArr addObject:enclosureArr];
            
            // 是否需要加底部工具view
            // 撤销按钮
            NSString *revokedoStr = [NSString stringWithFormat:@"%@",showdata[@"revokedoIs"]];
            // 修改按钮
            NSString *changedoStr = [NSString stringWithFormat:@"%@",showdata[@"changedoIs"]];
            if ([revokedoStr isEqualToString:@"1"] || [changedoStr isEqualToString:@"1"]) {
                // 添加 工具view
                [self.view addSubview:self.annexFootView];
                // 赋值
                self.annexFootView.dict = showdata;
                __weak typeof(self) weakSelf = self;
                 // 修改界面UI
                [self.detaTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(weakSelf.view).offset(KSNaviTopHeight);
                    make.left.right.equalTo(weakSelf.view);
                    make.bottom.equalTo(weakSelf.annexFootView.mas_top);
                }];
            }
            [self.detaTableView reloadData];
        }
    }];
}
#pragma mark -------- 撤销 ------
-(void) requestManagemetCenterRevokels{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"platformCode"] = [YWTUserInfo obtainWithLoginPlatformCode];
    NSArray *arr = self.dataArr[0];
    NSDictionary *dict = arr[0];
    param[@"id"] = dict[@"id"];
    param[@"revokeIs"] = @"2";
    if (self.detailType == showBaseDetailSafetyType) {
        param[@"type"] = @"1";
    }else if (self.detailType == showBaseDetailMeetingType){
        param[@"type"] = @"2";
    }else if (self.detailType == showBaseDetailViolationType){
        param[@"type"] = @"4";
    }else if (self.detailType == showBaseDetailTechnoloType){
        param[@"type"] = @"3";
    }
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPSAFETYMANAGEMETCENTERREVOKEIS_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        // 修改界面UI
        self.annexFootView.hidden = YES;
        // 更新 detaTableView 约束
        [weakSelf.detaTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.view).offset(KSNaviTopHeight);
            make.left.right.equalTo(weakSelf.view);
            make.bottom.equalTo(weakSelf.view).offset(-KSTabbarH);
        }];
        
        // 重新组装数据源
        NSMutableArray *mutableArr = [NSMutableArray arrayWithArray:arr];
        NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:dict];
        mutableDict[@"revokeIs"] = @"2";
        // 贴换数据源
        [mutableArr replaceObjectAtIndex:0 withObject:mutableDict];
        
        [self.dataArr replaceObjectAtIndex:0 withObject:mutableArr];
         // 刷新UI
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.detaTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }];
}








@end
