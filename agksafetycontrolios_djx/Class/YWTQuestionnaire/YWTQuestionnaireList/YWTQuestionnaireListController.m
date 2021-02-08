//
//  YWTQuestionnaireListController.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/17.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTQuestionnaireListController.h"

#import "YWTQuestionnaireController.h"

#import "YWTShowNoSourceView.h"
#import "YWTBaseHeaderSearchView.h"
#import "YWTQuestionnaireListCell.h"
#define YWTQUESTIONNAIRELIST_CELL @"YWTQuestionnaireListCell"

@interface YWTQuestionnaireListController ()
<
UITableViewDelegate,
UITableViewDataSource
>
// 头部搜索view
@property (nonatomic,strong) YWTBaseHeaderSearchView  *headerSearchView;
// 空白页
@property (nonatomic,strong) YWTShowNoSourceView *showNoSoucreView;
@property (nonatomic,strong) UITableView *listTableView;
@property (nonatomic,strong) NSMutableArray *dataArr;

// 搜索参数
@property (nonatomic,strong) NSString *searchStr;
// 页码
@property (nonatomic,assign) NSInteger page;

@end

@implementation YWTQuestionnaireListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    // 设置导航栏
    [self setNavi];
    // 创建搜索view
    [self createSearchView];
    //
    [self.view addSubview:self.listTableView];
    // 请求列表
    [self requestQuestionListData];
}
#pragma mark --- UITableViewDataSource --------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return  self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWTQuestionnaireListCell *cell = [tableView dequeueReusableCellWithIdentifier:YWTQUESTIONNAIRELIST_CELL forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dict = self.dataArr[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = self.dataArr[indexPath.row];
    return [YWTQuestionnaireListCell getWithListCellHeight:dict];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = self.dataArr[indexPath.row];
    NSString *statusStr = [NSString stringWithFormat:@"%@",dict[@"status"]];
    if ([statusStr isEqualToString:@"2"]) {
        [self.view showErrorWithTitle:@"调查次数已完成!" autoCloseTime:0.5];
        return;
    }
    YWTQuestionnaireController *questVC = [[YWTQuestionnaireController alloc]init];
    questVC.paperId = [NSString stringWithFormat:@"%@",dict[@"qid"]];
    questVC.taskIdStr= self.taskIdStr;
    [self.navigationController pushViewController:questVC animated:YES];
}
#pragma mark --- 创建搜索view --------
-(void) createSearchView{
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.headerSearchView];
    self.headerSearchView.searchTextField.placeholder = @"请输入资源名搜索";
    self.headerSearchView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    self.headerSearchView.bgView.backgroundColor = [UIColor  colorTextWhiteColor];
    self.headerSearchView.searchTextField.backgroundColor = [UIColor colorTextWhiteColor];
    
    self.headerSearchView.searchBlock = ^(NSString * _Nonnull search) {
        weakSelf.searchStr = search;
        weakSelf.page = 1;
        [weakSelf requestQuestionListData];
    };
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];

    self.customNavBar.title = @"问卷调查";
   
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    __weak typeof(self) weakSelf = self;
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}
#pragma marm   -----  懒加载  ------
-(UITableView *)listTableView{
    if (!_listTableView) {
        _listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight+KSIphonScreenH(60), KScreenW, KScreenH-KSNaviTopHeight-KSIphonScreenH(60)-KSTabbarH)];
        _listTableView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        [_listTableView registerClass:[YWTQuestionnaireListCell class] forCellReuseIdentifier:YWTQUESTIONNAIRELIST_CELL];
        // 添加空白页
        [_listTableView addSubview:self.showNoSoucreView];
        
        WS(weakSelf);
        [_listTableView bindGlobalStyleForHeadRefreshHandler:^{
            weakSelf.page = 1;
            [weakSelf requestQuestionListData];
        }];
        
        [_listTableView bindGlobalStyleForFootRefreshHandler:^{
            weakSelf.page ++;
            [weakSelf requestQuestionListData];
        }];
    }
    return _listTableView;
}
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
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

#pragma mark ---- get ----
-(void)setTaskIdStr:(NSString *)taskIdStr{
    _taskIdStr= taskIdStr;
}
#pragma mark ---- 数据相关 ----
-(void) requestQuestionListData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"page"] = [NSNumber numberWithInteger:self.page];
    param[@"pageSize"] = @"20";
    param[@"title"] = self.searchStr;
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTSERICEAPIAPPQUESTIONLIST_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        [self.listTableView.footRefreshControl endRefreshing];
        [self.listTableView.headRefreshControl endRefreshing];
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if (![showdata isKindOfClass:[NSDictionary class]]) {
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
    }];
}




@end
