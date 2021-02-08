//
//  ExamCenterRecordController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/23.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTExamCenterRecordController.h"

#import "YWTBaseHeaderSearchView.h"
#import "YWTShowVerifyIdentidyErrorView.h"
#import "YWTShowNoSourceView.h"

#import "YWTExamCenterRecordTableViewCell.h"
#define EXAMCENTERRECORDTABLEVIEW_CELL @"YWTExamCenterRecordTableViewCell"
#import "YWTExamCenterRecordUnpublishCell.h"
#define EXAMCENTERRECORDUNPUBLISH_CELL @"YWTExamCenterRecordUnpublishCell"

@interface YWTExamCenterRecordController ()
<
UITableViewDelegate,
UITableViewDataSource
>
// 搜索view
@property (nonatomic,strong) YWTBaseHeaderSearchView *headerSearchView;
// 空白页
@property (nonatomic,strong) YWTShowNoSourceView *showNoSoucreView;
@property (nonatomic,strong) UITableView *recordTableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) NSString *titleStr;
@property (nonatomic,assign) NSInteger page;
@end

@implementation YWTExamCenterRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    self.page = 1;
    // 设置导航栏
    [self setNavi];
    // 创建搜索view
    [self createSearchView];
    // 创建TableView
    [self createTableView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 请求数据
    [self requestExamHistoryList];
}
#pragma mark --- 创建搜索view --------
-(void) createSearchView{
    [self.view addSubview:self.headerSearchView];
    self.headerSearchView.searchTextField.placeholder = @"请输入考试/考场/试卷名称搜索";
    self.headerSearchView.isExamCenterRcord = YES;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        // 更新约束
        [weakSelf.headerSearchView.searchImageV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.headerSearchView.bgView).offset((KScreenW-24)/5);
        }];
    }];
    self.headerSearchView.searchBlock = ^(NSString * _Nonnull search) {
        weakSelf.titleStr = search;
        weakSelf.page = 1;
        [weakSelf requestExamHistoryList];
    };
}
#pragma mark --- 创建TableView --------
-(void) createTableView{
    self.recordTableView = [[UITableView alloc ]initWithFrame:CGRectMake(0, KSNaviTopHeight+KSIphonScreenH(60), KScreenW, KScreenH-KSNaviTopHeight-KSIphonScreenH(60)-KSTabbarH)];
    [self.view addSubview:self.recordTableView];
    self.recordTableView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    self.recordTableView.dataSource = self;
    self.recordTableView.delegate = self;
    self.recordTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.recordTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    
    // 添加空白页
    [self.recordTableView addSubview:self.showNoSoucreView];
    
    [self.recordTableView registerClass:[YWTExamCenterRecordTableViewCell class] forCellReuseIdentifier:EXAMCENTERRECORDTABLEVIEW_CELL];
    [self.recordTableView registerClass:[YWTExamCenterRecordUnpublishCell class] forCellReuseIdentifier:EXAMCENTERRECORDUNPUBLISH_CELL];
    
    __weak typeof(self) weakSelf = self;
    // 刷新
    [self.recordTableView bindGlobalStyleForHeadRefreshHandler:^{
        weakSelf.page = 1;
        [weakSelf requestExamHistoryList];
    }];
    
    [self.recordTableView bindGlobalStyleForFootRefreshHandler:^{
        weakSelf.page ++;
        [weakSelf requestExamHistoryList];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = self.dataArr[indexPath.row];
    NSString *isValidStr = [NSString stringWithFormat:@"%@",dict[@"isValid"]];
    if ([isValidStr isEqualToString:@"4"]) {
        YWTExamCenterRecordUnpublishCell *cell = [tableView dequeueReusableCellWithIdentifier:EXAMCENTERRECORDUNPUBLISH_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dict = dict;
        return cell;
    }else{
        YWTExamCenterRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EXAMCENTERRECORDTABLEVIEW_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dict = dict;
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = self.dataArr[indexPath.row];
    NSString *isValidStr = [NSString stringWithFormat:@"%@",dict[@"isValid"]];
    if ([isValidStr isEqualToString:@"4"]) {
        return [YWTExamCenterRecordUnpublishCell getWithRecordCellHeight:dict];
    }else{
        return [YWTExamCenterRecordTableViewCell getWithRecordCellHeight:dict];
    }
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    self.customNavBar.title = @"考试成绩";
    
    __weak typeof(self) weakSelf = self;
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}
#pragma mark --- 懒加载 --------
-(YWTBaseHeaderSearchView *)headerSearchView{
    if (!_headerSearchView) {
        _headerSearchView = [[YWTBaseHeaderSearchView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KSIphonScreenH(60))];
    }
    return _headerSearchView;
}
-(YWTShowNoSourceView *)showNoSoucreView{
    if (!_showNoSoucreView) {
        _showNoSoucreView = [[YWTShowNoSourceView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSNaviTopHeight-KSIphonScreenH(60)-KSTabbarH)];
        _showNoSoucreView.showMarkLab.text = @"暂无成绩";
    }
    return _showNoSoucreView;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
#pragma mark ----- 请求考试成绩-------
-(void) requestExamHistoryList{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"userId"] = [YWTUserInfo obtainWithUserId];
    param[@"keyword"] = self.titleStr;
    param[@"page"] = [NSNumber numberWithInteger:self.page];
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPEXAMUSERHISTORYLIST_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        // 结束刷新控件
        [self.recordTableView.headRefreshControl endRefreshing];
        [self.recordTableView.footRefreshControl endRefreshing];
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:1];
            return ;
        }
        if (![showdata isKindOfClass:[NSArray class]]) {
            [self.view showErrorWithTitle:@"返回格式错误!" autoCloseTime:1];
            return;
        }
        if (self.page ==  1) {
            [self.dataArr removeAllObjects];
        }
        [self.dataArr addObjectsFromArray:showdata];
        
        if (self.dataArr.count > 0) {
            self.showNoSoucreView.hidden = YES;
        }else{
            self.showNoSoucreView.hidden = NO;
        }
        [self.recordTableView reloadData];
    }]; 
}



@end
