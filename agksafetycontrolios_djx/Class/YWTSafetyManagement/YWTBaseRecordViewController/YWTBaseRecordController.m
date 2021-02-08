//
//  BaseRecordController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/11.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTBaseRecordController.h"

#import "YWTBaseDetailController.h"
#import "YWTBaseTableViewController.h"

#import "YWTBaseHeaderSearchView.h"
#import "YWTAttendanceAddMarkView.h"
#import "YWTShowNoSourceView.h"
#import "YWTExamPaperListSiftView.h"

#import "YWTBaseRecordTableViewCell.h"
#define BASERECORDTABLEVIEW_CELL @"YWTBaseRecordTableViewCell"
#import "YWTCheckRecordTableViewCell.h"
#define CHECKRECORDTABLEVIEW_CELL @"YWTCheckRecordTableViewCell"

@interface YWTBaseRecordController ()
<
UITableViewDelegate,
UITableViewDataSource,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
ExamPaperListSiftViewDelegate
>
// 头部搜索view
@property (nonatomic,strong) YWTBaseHeaderSearchView  *headerSearchView;
// 添加/查看备注
@property (nonatomic,strong) YWTAttendanceAddMarkView *markView;
// 筛选view
@property (nonatomic,strong) YWTExamPaperListSiftView *listSiftView;
// 空白页
@property (nonatomic,strong) YWTShowNoSourceView *showNoSoucreView;
@property (nonatomic,strong) UITableView *recordTableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
// 添加备注图片
@property (nonatomic,strong) NSMutableArray *markImageArr;
// 搜索参数
@property (nonatomic,strong) NSString *titleStr;
// 筛选条
@property (nonatomic,strong) NSString *tagIdStr;
// 页面
@property (nonatomic,assign) NSInteger page;

@end

@implementation YWTBaseRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.tagIdStr = @"";
    // 设置导航栏
    [self setNavi];
    //  创建搜索view
    [self createSearchView];
    // 创建TableView
    [self createTableView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestManagementList];
}
#pragma mark --- 创建TableView --------
-(void) createTableView{
    self.recordTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight+KSIphonScreenH(60), KScreenW, KScreenH-KSNaviTopHeight-KSTabbarH-KSIphonScreenH(60))];
    [self.view addSubview:self.recordTableView];
    
    self.recordTableView.delegate = self;
    self.recordTableView.dataSource = self;
    self.recordTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.recordTableView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    [self.recordTableView registerClass:[YWTBaseRecordTableViewCell class] forCellReuseIdentifier:BASERECORDTABLEVIEW_CELL];
     [self.recordTableView registerClass:[YWTCheckRecordTableViewCell class] forCellReuseIdentifier:CHECKRECORDTABLEVIEW_CELL];
    
    if (@available(iOS 11.0, *)) {
        self.recordTableView.estimatedRowHeight = 0;
        self.recordTableView.estimatedSectionFooterHeight = 0;
        self.recordTableView.estimatedSectionHeaderHeight = 0 ;
        self.recordTableView.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    __weak typeof(self) weakSelf = self;
    // 刷新
    [self.recordTableView bindGlobalStyleForHeadRefreshHandler:^{
        weakSelf.page = 1;
        [weakSelf requestManagementList];
    }];
    
    [self.recordTableView bindGlobalStyleForFootRefreshHandler:^{
        weakSelf.page ++;
        [weakSelf requestManagementList];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.recordType == showBaseRecordCheckType) {
        YWTCheckRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CHECKRECORDTABLEVIEW_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSDictionary *dict = self.dataArr[indexPath.row];
        cell.dict = dict;
        // 添加/查看备注
        __weak typeof(self) weakSelf = self;
        cell.addMark = ^{
            [weakSelf createAttendanceMarkView:dict];
        };
        return cell;
    }else{
        YWTBaseRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BASERECORDTABLEVIEW_CELL forIndexPath:indexPath];
        if (self.recordType == showBaseRecordSafetyType) {
            // 安全检查
            cell.cellType =  showBaseRecordCellSafetyType;
        }else if (self.recordType == showBaseRecordMeetingType){
            // 2班会记录
           cell.cellType =  showBaseRecordCellMeetingType;
        }else if (self.recordType == showBaseRecordViolationType){
            //4违章处理
            cell.cellType =  showBaseRecordCellViolationType;
        }else if (self.recordType == showBaseRecordTechnoloType){
            // 3技术交底
            cell.cellType =  showBaseRecordCellTechnoloType;
        }
        cell.dict = self.dataArr[indexPath.row];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.recordType == showBaseRecordCheckType) {
         return KSIphonScreenH(100);
    }else{
         return KSIphonScreenH(86);
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.recordType == showBaseRecordCheckType) {
        // 考勤签到
        return;
    }
    NSDictionary *dict = self.dataArr[indexPath.row];
    NSString *revokeIsStr = [NSString stringWithFormat:@"%@",dict[@"revokeIs"]];
    // 编辑中，  存入草稿
    if ([revokeIsStr isEqualToString:@"3"]) {
        YWTBaseTableViewController *baseVC = [[YWTBaseTableViewController alloc]init];
        // 修改
        baseVC.scoureType = showBaseAlterSoucreType;
        //数据源存入草稿
        baseVC.saveDataType = showBaseSaveDataAlterType;
        if (self.recordType == showBaseRecordSafetyType) {
            // 安全检查
            baseVC.veiwBaseType = showViewControllerSafetyType;
            baseVC.moduleNameStr = @"安全检查";
        }else if (self.recordType == showBaseRecordMeetingType){
            // 2班会记录
            baseVC.veiwBaseType = showViewControllerMeetingType;
            baseVC.moduleNameStr = @"班会记录";
        }else if (self.recordType == showBaseRecordViolationType){
            //4违章处理
            baseVC.veiwBaseType = showViewControllerViolationType;
            baseVC.moduleNameStr = @"违章处理";
        }else if (self.recordType == showBaseRecordTechnoloType){
            // 3技术交底
            baseVC.veiwBaseType = showViewControllerTechnoloType;
            baseVC.moduleNameStr = @"技术交底";
        }
        baseVC.editIdStr = [NSString stringWithFormat:@"%@",dict[@"id"]];
        [self.navigationController pushViewController:baseVC animated:YES];
        return;
    }
    
    YWTBaseDetailController *detaVC = [[YWTBaseDetailController alloc]init];
    if ([revokeIsStr isEqualToString:@"1"]) {
        detaVC.toolType = showBaseToolNormalType;
    }else{
        detaVC.toolType = showBaseToolUNormalType;
    }
    if (self.recordType == showBaseRecordSafetyType) {
        // 安全检查
        detaVC.detailType = showBaseDetailSafetyType;
       
    }else if (self.recordType == showBaseRecordMeetingType){
        // 2班会记录
        detaVC.detailType = showBaseDetailMeetingType;
    }else if (self.recordType == showBaseRecordViolationType){
        //4违章处理
        detaVC.detailType = showBaseDetailViolationType;
    }else if (self.recordType == showBaseRecordTechnoloType){
        // 3技术交底
        detaVC.detailType = showBaseDetailTechnoloType;
    }
    detaVC.idStr = [NSString stringWithFormat:@"%@",dict[@"id"]];
    [self.navigationController pushViewController:detaVC animated:YES];
}
#pragma mark --- 创建添加/查看备注view --------
-(void) createAttendanceMarkView:(NSDictionary *)dict{
    __weak typeof(self) weakSelf = self;
    self.markView = [[YWTAttendanceAddMarkView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH)];
    [weakSelf.view addSubview:self.markView];
    
    NSString *isRemarkStr = [NSString stringWithFormat:@"%@",dict[@"isRemark"]];
    if ([isRemarkStr isEqualToString:@"1"]) {
        // 默认添加一个元素
        NSMutableArray *normalArr = [NSMutableArray array];
        [normalArr addObject:[UIImage imageNamed:@"base_attendance_add"]];
        self.markView.dataArr = [NSMutableArray arrayWithObject:normalArr];
        
        self.markView.markType =showAttendanceAddMarkType;
    }else{
        NSMutableArray *normalArr = [NSMutableArray array];
        [normalArr addObject:dict[@"addressConter"]];
        self.markView.dataArr =[NSMutableArray arrayWithArray:normalArr];
        self.markView.markConterStr = [NSString stringWithFormat:@"%@",dict[@"conter"]];
        self.markView.markType =showAttendanceLookMarkType;
    }
    // 打开相册
    self.markView.openLibary = ^{
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIImagePickerController *photos = [[UIImagePickerController alloc]init];
            photos.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            photos.delegate = weakSelf;
            [weakSelf presentViewController:photos animated:YES completion:nil];
        }else{
            [weakSelf.view showErrorWithTitle:@"当前设备部支持访问" autoCloseTime:0.5];
        }
    };
    
    // 查看大图
    self.markView.selectBigPhoto = ^(NSDictionary * _Nonnull dict) {
        if ([isRemarkStr isEqualToString:@"1"]) {
            [weakSelf chenkBigImageView:dict andType:@"1"];
        }else{
           [weakSelf chenkBigImageView:dict andType:@"2"];
        }
    };
    
    // 点击关闭
    self.markView.selectCancelBtn = ^(NSDictionary * _Nonnull markDict) {
        if ([isRemarkStr isEqualToString:@"2"]) {
            [weakSelf.markView removeFromSuperview];
            return ;
        }
        if ([isRemarkStr isEqualToString:@"1"]) {
            NSMutableArray *imageArr = [NSMutableArray arrayWithArray:markDict[@"imageArr"]];
            // 移除最后一个
            [imageArr removeLastObject];
            weakSelf.markImageArr = imageArr;
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            param[@"token"] = [YWTTools getNewToken];
            param[@"userId"] = [YWTUserInfo obtainWithUserId];
            param[@"unitId"] = [YWTUserInfo obtainWithCompanyId];
            param[@"id"] = dict[@"id"];
            param[@"note"] = markDict[@"markNote"];
            // 请求添加备注
            [weakSelf requestAttendanceAddSignNote:param];
        }
    };
}
#pragma mark ---------查看大图------
// 1 添加备注 2查看备注
-(void) chenkBigImageView:(NSDictionary *)dict andType:(NSString *)type{
    NSInteger index = [dict[@"indexPath"] integerValue];
    NSArray *arr = dict[@"imageArr"];
    NSMutableArray *items = [NSMutableArray array];
    if ([type isEqualToString:@"1"]) {
        for (int i=0; i<arr.count-1; i++) {
            UIImageView *imageView = [[UIImageView alloc]init];
            KSPhotoItem *item = [KSPhotoItem itemWithSourceView:imageView image:arr[i]];
            [items addObject:item];
             }
    }else{
        for (int i=0; i<arr.count; i++) {
            UIImageView *imageView = [[UIImageView alloc]init];
            KSPhotoItem *item = [KSPhotoItem itemWithSourceView:imageView imageUrl:[NSURL URLWithString:arr[i]]];
            [items addObject:item];
        }
    }
    KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:items selectedIndex:index];
    [browser showFromViewController:self];
}
#pragma mark - UIImagePickerControllerDelegate代理 --------
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //获取选中的原始图片
    UIImage *img1 = info[UIImagePickerControllerOriginalImage];
    // 赋值
    [self.markView addUserSelectPhoto:img1];
    //一定要关闭相册界面
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark --- 创建搜索view --------
-(void) createSearchView{
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.headerSearchView];
    self.headerSearchView.searchTextField.placeholder = @"请输入标题、内容关键词搜索";
    self.headerSearchView.isExamCenterRcord = YES;
    if (![self.titleStr isEqualToString:@""]) {
        [UIView animateWithDuration:0.25 animations:^{
            // 更新约束
            [weakSelf.headerSearchView.searchImageV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.headerSearchView.bgView).offset((KScreenW-24)/5);
            }];
        }];
    }
    self.headerSearchView.searchBlock = ^(NSString * _Nonnull search) {
        weakSelf.titleStr = search;
        weakSelf.page = 1;
        [weakSelf requestManagementList];
    };
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    if (self.recordType == showBaseRecordSafetyType) {
        self.customNavBar.title = @"安全检查记录";
    }else if (self.recordType == showBaseRecordMeetingType){
        self.customNavBar.title = @"班会记录";
    }else if (self.recordType == showBaseRecordViolationType){
        self.customNavBar.title = @"违章处理记录";
    }else if (self.recordType == showBaseRecordTechnoloType){
        self.customNavBar.title = @"技术交底记录";
    }else if (self.recordType == showBaseRecordCheckType){
        // 考勤签到
        self.customNavBar.title = @"考勤签到记录";
    }
    __weak typeof(self) weakSelf = self;
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popToViewController:[weakSelf.navigationController.viewControllers objectAtIndex:1] animated:YES];
    };
    
    if (self.recordType == showBaseRecordCheckType){
        // 考勤签到
        return;
    }
    
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageChangeName:@"nav_ico_sift"]];
    __block  bool isCreateListSiftView = YES;
    self.customNavBar.onClickRightButton = ^{
        if (isCreateListSiftView) {
            [weakSelf.view addSubview:weakSelf.listSiftView];
            weakSelf.listSiftView.siftType = showListSiftSafetContolRecordType;
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
    self.tagIdStr = tagIdStr;
    self.titleStr = @"";
    self.page = 1;
    [self requestManagementList];
}
#pragma mark --- 系统回调 左滑返回拦截--------
-(void)willMoveToParentViewController:(UIViewController *)parent{
    [super willMoveToParentViewController:parent];
}
-(void)didMoveToParentViewController:(UIViewController *)parent{
    [super willMoveToParentViewController:parent];
    if (parent) {
        // 考勤签到 直接返回
        if (self.recordType == showBaseRecordCheckType) {
            return;
        }
        // 改变数据源
        NSMutableArray * mTmp = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        for (int i=2; i< mTmp.count; i++) {
            [mTmp removeObjectAtIndex:i];
        }
        self.navigationController.viewControllers = (NSArray *)mTmp;
    }
}
#pragma mark --- get方法 ----
-(YWTShowNoSourceView *)showNoSoucreView{
    if (!_showNoSoucreView) {
        _showNoSoucreView = [[YWTShowNoSourceView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSNaviTopHeight-KSIphonScreenH(60)-KSTabbarH)];
        _showNoSoucreView.showMarkLab.text = @"暂无记录!";
    }
    return _showNoSoucreView;
}
-(YWTBaseHeaderSearchView *)headerSearchView{
    if (!_headerSearchView) {
        _headerSearchView = [[YWTBaseHeaderSearchView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KSIphonScreenH(60))];
    }
    return _headerSearchView;
}
-(YWTExamPaperListSiftView *)listSiftView{
    if (!_listSiftView) {
        _listSiftView = [[YWTExamPaperListSiftView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KScreenH-KSNaviTopHeight)];
    }
    return _listSiftView;
}
-(void)setRecordType:(showBaseRecordType)recordType{
    _recordType = recordType;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr  =[NSMutableArray array];
    }
    return _dataArr;
}
-(NSMutableArray *)markImageArr{
    if (!_markImageArr) {
        _markImageArr = [NSMutableArray array];
    }
    return _markImageArr;
}
#pragma mark -------  列表 ---------
-(void) requestManagementList{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"]= [YWTTools getNewToken];
    param[@"platformCode"] = [YWTUserInfo obtainWithLoginPlatformCode];
    param[@"keyword"] = self.titleStr;
    param[@"filter"] = self.tagIdStr;
    param[@"page"] = [NSNumber numberWithInteger:self.page];
    param[@"pageSize"] = [NSNumber numberWithInteger:15];
    NSString *url;
    if (self.recordType == showBaseRecordSafetyType) {
        // 安全检查
        param[@"type"] = @"1";
        url = HTTP_ATTAPPSAFETYMANAGEMENTCENTERGETLISTS_URL;
    }else if (self.recordType == showBaseRecordMeetingType){
        // 2班会记录
        param[@"type"] = @"2";
        url = HTTP_ATTAPPSAFETYMANAGEMENTCENTERGETLISTS_URL;
    }else if (self.recordType == showBaseRecordViolationType){
        //4违章处理
        param[@"type"] = @"4";
        url = HTTP_ATTAPPSAFETYMANAGEMENTCENTERGETLISTS_URL;
    }else if (self.recordType == showBaseRecordTechnoloType){
        // 3技术交底
        param[@"type"] = @"3";
        url = HTTP_ATTAPPSAFETYMANAGEMENTCENTERGETLISTS_URL;
    }else if (self.recordType == showBaseRecordCheckType){
        // 考勤签到
        param[@"userId"] = [YWTUserInfo obtainWithUserId];
        url = HTTP_ATTAPPATTENDANCEGETATTENDANCELISTS_URL;
    }
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:url params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        [self.recordTableView.headRefreshControl endRefreshing];
        [self.recordTableView.footRefreshControl endRefreshing];
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if ([showdata isKindOfClass:[NSArray class]]) {
            if (self.page == 1) {
                [self.dataArr removeAllObjects];
            }
            [self.dataArr addObjectsFromArray:showdata];
            
            if (self.dataArr.count == 0) {
                // 添加空白页
                [self.recordTableView addSubview:self.showNoSoucreView];
            }else{
                // 移除空白页
                [self.showNoSoucreView removeFromSuperview];
            }
            [self.recordTableView reloadData];
        }
    }];
}
#pragma mark -------  用户签到备注 ---------
-(void) requestAttendanceAddSignNote:(NSDictionary *)dict{
    [[KRMainNetTool sharedKRMainNetTool] upLoadData:HTTP_ATTAPPATTENDANCESIGNINNOTE_URL params:dict andData:self.markImageArr waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        [self.markView removeFromSuperview];
        // 刷新列表
        [self.recordTableView.headRefreshControl beginRefreshing];
    }];
}



@end
