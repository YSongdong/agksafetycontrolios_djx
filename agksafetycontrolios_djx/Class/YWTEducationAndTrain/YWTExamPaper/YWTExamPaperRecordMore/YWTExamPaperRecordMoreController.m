//
//  ExamPaperRecordMoreController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/17.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTExamPaperRecordMoreController.h"

#import "YWTExamPaperDetailController.h"

#import "YWTExerRecordHeaderView.h"
#import "YWTRecordMoreTableViewCell.h"
#define RECORDMORETABLEVIEW_CELL @"YWTRecordMoreTableViewCell"

@interface YWTExamPaperRecordMoreController ()
<
UITableViewDelegate,
UITableViewDataSource
>
// 头部视图
@property (nonatomic,strong)YWTExerRecordHeaderView *recordHeaderView;

@property (nonatomic,strong) UITableView *recordTableView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,assign) NSInteger page;

@end

@implementation YWTExamPaperRecordMoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    // 设置导航栏
    [self setNavi];
     [self.view insertSubview:self.recordHeaderView atIndex:0];
    // 创建TableView
    [self createTableView];
    // 请求记录列表
    [self requestMockListDetail];
}
#pragma mark --- 创建TableView --------
-(void) createTableView{
    self.view.backgroundColor  =[UIColor colorTextWhiteColor];
    self.recordTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight+KSIphonScreenH(50), KScreenW, KScreenH-KSTabbarH-KSNaviTopHeight-KSIphonScreenH(50)) ];
    [self.view addSubview:self.recordTableView];
    
    self.recordTableView.dataSource = self;
    self.recordTableView.delegate  = self;
    self.recordTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.recordTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    [self.recordTableView registerClass:[YWTRecordMoreTableViewCell class] forCellReuseIdentifier:RECORDMORETABLEVIEW_CELL];
    
    if (@available(iOS 11.0, *)) {
        self.recordTableView.estimatedRowHeight = 0;
        self.recordTableView.estimatedSectionFooterHeight = 0;
        self.recordTableView.estimatedSectionHeaderHeight = 0 ;
        self.recordTableView.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    __weak typeof(self)weakSelf = self;
    // 刷新
    [self.recordTableView bindGlobalStyleForHeadRefreshHandler:^{
        weakSelf.page = 1;
        [weakSelf requestMockListDetail];
    }];
    
    [self.recordTableView bindGlobalStyleForFootRefreshHandler:^{
        weakSelf.page ++;
        [weakSelf requestMockListDetail];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWTRecordMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RECORDMORETABLEVIEW_CELL forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexPath = indexPath;
    NSDictionary *dict = self.dataArr[indexPath.row];
    cell.dict = dict;
    // 点击详情
    __weak typeof(self) weakSelf = self;
    cell.detailBlock = ^{
        YWTExamPaperDetailController *examDetailVC = [[YWTExamPaperDetailController alloc]init];
        examDetailVC.examRecordIdStr = [NSString stringWithFormat:@"%@",dict[@"id"]];
        [weakSelf.navigationController pushViewController:examDetailVC animated:YES];
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KSIphonScreenH(50);
}

#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:0];
    
    self.customNavBar.title = @"测验记录";
    
    __weak typeof(self) weakSelf = self;
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}
#pragma mark -----懒加载-----
-(YWTExerRecordHeaderView *)recordHeaderView{
    if (!_recordHeaderView) {
        _recordHeaderView = [[YWTExerRecordHeaderView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KSIphonScreenH(50)+KSNaviTopHeight)];
    }
    return _recordHeaderView;
}
-(void)setPaperIdStr:(NSString *)paperIdStr{
    _paperIdStr = paperIdStr;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
#pragma mark -----请求练习记录列表-----
-(void) requestMockListDetail{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] =  [YWTTools getNewToken];
    param[@"paperid"] = self.paperIdStr;
    param[@"page"] = [NSNumber numberWithInteger:self.page];
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPQUESTMOCKLISTDETAILS_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        // 结束刷新控件
        [self.recordTableView.headRefreshControl endRefreshing];
        [self.recordTableView.footRefreshControl endRefreshing];
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:1];
            return ;
        }
        if (![showdata isKindOfClass:[NSArray class]]) {
            [self.view showErrorWithTitle:@"返回数据格式错误" autoCloseTime:1];
            return;
        }
        if (self.page == 1) {
            [self.dataArr removeAllObjects];
        }
        [self.dataArr addObjectsFromArray:showdata];
        [self.recordTableView reloadData];

    }];
}




@end
