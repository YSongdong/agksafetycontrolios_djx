//
//  ExamPaperListController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/15.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTExamPaperListController.h"

typedef enum {
    showTableViewExamListType = 0, // 试卷列表
    showTableViewExerRecordType    // 练习记录
}showTableViewType;

#import "YWTExamExerDetailController.h"
#import "YWTExamPaperExerciseController.h"
#import "YWTExamPaperRecordMoreController.h"
#import "YWTExamPaperExerciseController.h"
#import "YWTExamQuestionController.h"

#import "YWTExamPaperDetailController.h"

#import "YWTExamPaperListTopBtnView.h"
#import "YWTExamPaperListSiftView.h"
#import "YWTBaseHeaderSearchView.h"
#import "YWTShowNoSourceView.h"
#import "YWTShowUnNetWorkStatuView.h"
#import "YWTShowServicePromptView.h"

#import "YWTExamPaperListTableViewCell.h"
#define EXAMPAPERLISTTABLEVIEW_CELL @"YWTExamPaperListTableViewCell"
#import "YWTExamPaperRecordTableViewCell.h"
#define EXAMPAPERRECORDTBLEVIEW_CELL @"YWTExamPaperRecordTableViewCell"


@interface YWTExamPaperListController ()
<
UITableViewDelegate,
UITableViewDataSource,
ExamPaperListSiftViewDelegate
>
// 顶部按钮view
@property (nonatomic,strong) YWTExamPaperListTopBtnView *topBtnView;
// TbaleView类型
@property (nonatomic,assign) showTableViewType   tableViewType;
// 筛选view
@property (nonatomic,strong) YWTExamPaperListSiftView *listSiftView;
// 头部搜索view
@property (nonatomic,strong) YWTBaseHeaderSearchView  *headerSearchView;
// 空白页
@property (nonatomic,strong) YWTShowNoSourceView *showNoSoucreView;
// 没有网络view
@property (nonatomic,strong) YWTShowUnNetWorkStatuView *showNetWorkStatuView;
// 提示框
@property (nonatomic,strong) YWTShowServicePromptView *showPromptView;
@property (nonatomic,strong) UITableView *listTableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
 
//  筛选条
@property (nonatomic,strong) NSString *tagIdStr;
// 页数
@property (nonatomic,assign) NSInteger page;
@end

@implementation YWTExamPaperListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tagIdStr = @"";
    self.page = 1;
    // 设置导航栏
    [self setNavi];
    // 默认试卷列表
    self.tableViewType = showTableViewExamListType;
    //创建搜索view
    [self createSearchView];
    // 创建搜索TableView
    [self createTableView];
    // 
    [self requestExamListData];
    // 注册网络通知
    [self registeredNetworkTifi];
   
}
#pragma mark --- 创建搜索view --------
-(void) createSearchView{
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.headerSearchView];
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
        weakSelf.tagIdStr = @"";
        weakSelf.titleStr = search;
        weakSelf.page = 1;
        [weakSelf requestExamListData];
    };
}
#pragma mark --- 创建搜索TableView --------
-(void) createTableView{
    self.view.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    self.listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight+KSIphonScreenH(60), KScreenW, KScreenH-KSNaviTopHeight-KSIphonScreenH(60)-KSTabbarH)];
    [self.view addSubview:self.listTableView];
    self.listTableView.dataSource = self;
    self.listTableView.delegate = self;
    self.listTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.listTableView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    self.listTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    // 添加空白页
    [self.listTableView addSubview:self.showNoSoucreView];
    
    [self.listTableView registerClass:[YWTExamPaperListTableViewCell class] forCellReuseIdentifier:EXAMPAPERLISTTABLEVIEW_CELL];
     [self.listTableView registerClass:[YWTExamPaperRecordTableViewCell class] forCellReuseIdentifier:EXAMPAPERRECORDTBLEVIEW_CELL];
    if (@available(iOS 11.0, *)) {
        self.listTableView.estimatedRowHeight = 0;
        self.listTableView.estimatedSectionFooterHeight = 0;
        self.listTableView.estimatedSectionHeaderHeight = 0 ;
        self.listTableView.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    __weak typeof(self) weakSelf = self;
    // 刷新
    [self.listTableView bindGlobalStyleForHeadRefreshHandler:^{
        weakSelf.page = 1;
        [weakSelf requestExamListData];
    }];

    [self.listTableView bindGlobalStyleForFootRefreshHandler:^{
        weakSelf.page ++;
        [weakSelf requestExamListData];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     __weak typeof(self) weakSelf = self;
    if (self.tableViewType == showTableViewExamListType ) {
        YWTExamPaperListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EXAMPAPERLISTTABLEVIEW_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSDictionary *dict = self.dataArr[indexPath.row];
        cell.dict = dict;
        
        // 开始考试
        cell.selectExerBlock = ^{
            YWTExamPaperExerciseController *exerciseVC = [[YWTExamPaperExerciseController alloc]init];
            exerciseVC.examType = showTableViewExamPaperType;
            exerciseVC.paperIdStr = [NSString stringWithFormat:@"%@",dict[@"id"]];
            exerciseVC.examIdStr =  [NSString stringWithFormat:@"%@",dict[@"examId"]];
            exerciseVC.examRoomIdStr =  [NSString stringWithFormat:@"%@",dict[@"examRoomId"]];
            exerciseVC.examBatchIdStr = @"1";
            exerciseVC.taskIdStr = weakSelf.taskIdStr;
            [weakSelf.navigationController pushViewController:exerciseVC animated:YES];
        };
        return cell;
    }else{
        YWTExamPaperRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EXAMPAPERRECORDTBLEVIEW_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSDictionary *dict = self.dataArr[indexPath.row];
        cell.dict = dict;
        // 查看更多
        cell.recordMoreBlock = ^{
            YWTExamPaperRecordMoreController *recordMoreVC = [[YWTExamPaperRecordMoreController alloc]init];
            NSDictionary *dict = weakSelf.dataArr[indexPath.row];
            recordMoreVC.paperIdStr = [NSString stringWithFormat:@"%@",dict[@"paperId"]];
            [weakSelf.navigationController pushViewController:recordMoreVC animated:YES];
        };
        // 点击开始考试
        cell.beginExamBlock = ^{
            YWTExamPaperExerciseController *exerciseVC = [[YWTExamPaperExerciseController alloc]init];
            exerciseVC.examType = showTableViewExamPaperType;
            exerciseVC.paperIdStr = [NSString stringWithFormat:@"%@",dict[@"paperId"]];
            exerciseVC.examIdStr =  [NSString stringWithFormat:@"%@",dict[@"examId"]];
            exerciseVC.examRoomIdStr =  [NSString stringWithFormat:@"%@",dict[@"examRoomId"]];
            exerciseVC.examBatchIdStr = @"1";
            [weakSelf.navigationController pushViewController:exerciseVC animated:YES];
        };
        // 查看详情
        cell.seeDetailBlock = ^{
            YWTExamPaperDetailController *examQuestVC = [[YWTExamPaperDetailController alloc]init];
            examQuestVC.examRecordIdStr = [NSString stringWithFormat:@"%@",dict[@"recenPid"]];
            [weakSelf.navigationController pushViewController:examQuestVC animated:YES];
        };
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tableViewType == showTableViewExamListType ) {
         return KSIphonScreenH(160);
    }else{
         return KSIphonScreenH(230);
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    if (self.tableViewType == showTableViewExamListType ) {
        YWTExamExerDetailController *detailVC = [[YWTExamExerDetailController alloc]init];
        NSDictionary *dict = self.dataArr[indexPath.row];
        detailVC.paperIdStr = [NSString stringWithFormat:@"%@",dict[@"id"]];
        detailVC.examIdStr = [NSString stringWithFormat:@"%@",dict[@"examId"]];
        detailVC.examRoomIdStr = [NSString stringWithFormat:@"%@",dict[@"examRoomId"]];
        detailVC.statuStr = [NSString stringWithFormat:@"%@",dict[@"status"]];
        detailVC.taskIdStr = self.taskIdStr;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}
#pragma mark --- 注册网络通知 --------
-(void) registeredNetworkTifi{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unNetwork:) name:@"NetWorkStatu" object:nil];
}
// 获取网络状态
-(void)unNetwork:(NSNotification *)tifi{
    NSDictionary *dict = tifi.userInfo;
    if ([dict[@"netwrok"] isEqualToString:@"NO"]) {
        [self.view addSubview:self.showNetWorkStatuView];
        __weak typeof(self) weakSelf = self;
        self.showNetWorkStatuView.selectRetryBlock = ^{
            NSString *networkStr = [YWTTools getNetworkTypeByReachability];
            if (![networkStr isEqualToString:@"NONE"]) {
                // 重新请求数据
                [weakSelf requestExamListData];
                // 移除
                [weakSelf.showNetWorkStatuView removeFromSuperview];
            }
        };
    }
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
     __block  bool isCreateListSiftView = YES;
    __weak typeof(self) weakSelf = self;
    [self.customNavBar addSubview:self.topBtnView];
    self.topBtnView.selectBtnBlock = ^(NSInteger btnTag) {
        switch (btnTag) {
            case 0:{
                // 移除筛选view
                isCreateListSiftView = YES;
                [weakSelf.listSiftView removeFromSuperview];
                //  试卷列表
                weakSelf.tableViewType = showTableViewExamListType;
                weakSelf.page = 1;
                weakSelf.titleStr = @"";
                weakSelf.tagIdStr = @"";
                [weakSelf requestExamListData];
                break;
            }
            case 1:{
                // 移除筛选view
                isCreateListSiftView = YES;
                [weakSelf.listSiftView removeFromSuperview];
                //  练习记录
                 weakSelf.tableViewType = showTableViewExerRecordType;
                weakSelf.page = 1;
                weakSelf.titleStr = @"";
                weakSelf.tagIdStr = @"";
                weakSelf.headerSearchView.searchTextField.text = @"";
                [UIView animateWithDuration:0.25 animations:^{
                    // 更新约束
                    [weakSelf.headerSearchView.searchImageV mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(weakSelf.headerSearchView.bgView).offset((KScreenW-24)/3);
                    }];
                }];
                [weakSelf requestExamListData];
                break;
            }
            default:
                break;
        }
    };
    // 左边按钮
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    // 右边筛选按钮
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageChangeName:@"nav_ico_sift"]];
    self.customNavBar.onClickRightButton = ^{
        if (isCreateListSiftView) {
            [weakSelf.view addSubview:weakSelf.listSiftView];
            weakSelf.listSiftView.siftType = showListSiftMockTestType;
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
    [self requestExamListData];
}
#pragma mark --- 懒加载--------
-(YWTExamPaperListTopBtnView *)topBtnView{
    if (!_topBtnView) {
        _topBtnView = [[YWTExamPaperListTopBtnView alloc]initWithFrame:CGRectMake((KScreenW-15-KSIphonScreenW(166))/2, KSStatusHeight+(22-KSIphonScreenH(30)/2), KSIphonScreenW(166), KSIphonScreenH(30))];
    }
    return _topBtnView;
}
-(YWTExamPaperListSiftView *)listSiftView{
    if (!_listSiftView) {
        _listSiftView = [[YWTExamPaperListSiftView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KScreenH-KSNaviTopHeight)];
    }
    return _listSiftView;
}
-(YWTBaseHeaderSearchView *)headerSearchView{
    if (!_headerSearchView) {
        _headerSearchView = [[YWTBaseHeaderSearchView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KSIphonScreenH(60))];
    }
    return _headerSearchView;
}
-(YWTShowServicePromptView *)showPromptView{
    if (!_showPromptView) {
        _showPromptView = [[YWTShowServicePromptView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH)];
    }
    return _showPromptView;
}
-(YWTShowNoSourceView *)showNoSoucreView{
    if (!_showNoSoucreView) {
        _showNoSoucreView = [[YWTShowNoSourceView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSNaviTopHeight-KSIphonScreenH(60)-KSTabbarH)];
    }
    return _showNoSoucreView;
}
-(YWTShowUnNetWorkStatuView *)showNetWorkStatuView{
    if (!_showNetWorkStatuView) {
        _showNetWorkStatuView = [[YWTShowUnNetWorkStatuView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight+KSIphonScreenH(60), KScreenW, KScreenH-KSNaviTopHeight-KSIphonScreenH(60)-KSTabbarH)];
    }
    return _showNetWorkStatuView;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
}
-(void)setTaskIdStr:(NSString *)taskIdStr{
    _taskIdStr = taskIdStr;
}
-(void)setResourceIdStr:(NSString *)resourceIdStr{
    _resourceIdStr = resourceIdStr;
}
#pragma mark ------试卷列表-----
-(void) requestExamListData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"title"] = self.titleStr;
    param[@"page"] = [NSNumber numberWithInteger:self.page];
    param[@"tagId"] = self.tagIdStr;
    param[@"paperid"] = self.resourceIdStr;
    NSString *url;
    if (self.tableViewType == showTableViewExamListType) {
        url = HTTP_ATTAPPQUESTIONEXAMLIST_URL;
    }else{
        url = HTTP_ATTAPPQUESTIONMOCKLIST_URL;
    }
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:url params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        // 结束刷新控件
        [self.listTableView.headRefreshControl endRefreshing];
        [self.listTableView.footRefreshControl endRefreshing];
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
        
        if (self.tableViewType == showTableViewExamListType) {
            if (![showdata isKindOfClass:[NSDictionary class]]) {
                [self.view showErrorWithTitle:@"返回数据格式错误" autoCloseTime:1];
                return;
            }
            if (self.page == 1) {
                [self.dataArr removeAllObjects];
            }
            NSArray *listArr = showdata[@"list"];
            [self.dataArr addObjectsFromArray:listArr];
            
            [self.listTableView reloadData];
            
            if (self.dataArr.count > 0) {
                self.showNoSoucreView.hidden = YES;
            }else{
                self.showNoSoucreView.hidden = NO;
            }
        }else{
            if (![showdata isKindOfClass:[NSArray class]]) {
                [self.view showErrorWithTitle:@"返回数据格式错误" autoCloseTime:1];
                return;
            }
            if (self.page == 1) {
                [self.dataArr removeAllObjects];
            }
            [self.dataArr addObjectsFromArray:showdata];
            
            [self.listTableView reloadData];
            
            if (self.dataArr.count > 0) {
                self.showNoSoucreView.hidden = YES;
            }else{
                self.showNoSoucreView.hidden = NO;
            }
        }
    }];
    
    
}




@end
