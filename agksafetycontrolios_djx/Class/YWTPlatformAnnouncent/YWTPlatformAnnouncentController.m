//
//  PlatformAnnouncentController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/1.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTPlatformAnnouncentController.h"

#import "YWTShowNoSourceView.h"

#import "YWTPlatformAnnoTableViewCell.h"
#define PLATFORMANNOTABLEVIEW_CELL @"YWTPlatformAnnoTableViewCell"

@interface YWTPlatformAnnouncentController ()
<
UITableViewDelegate,
UITableViewDataSource
>
// 空白页
@property (nonatomic,strong) YWTShowNoSourceView *showNoSoucreView;
@property (nonatomic,strong) UITableView *platTableView;

@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,assign) NSInteger page;
@end

@implementation YWTPlatformAnnouncentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    // 设置导航栏
    [self setNavi];
    // 创建TableViw
    [self createPlatformTableView];
    // 请求公告数据
    [self requestAnnouListData];
}
#pragma mark --- 创建TableViw --------
-(void) createPlatformTableView{
    self.view.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    self.platTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight+KSIphonScreenH(11), KScreenW, KScreenH-KSNaviTopHeight-KSIphonScreenH(11)-KSTabbarH)];
    [self.view addSubview:self.platTableView];
    
    self.platTableView.delegate = self;
    self.platTableView.dataSource = self;
    self.platTableView.estimatedRowHeight = 50;
    self.platTableView.rowHeight =UITableViewAutomaticDimension;
    self.platTableView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    self.platTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.platTableView registerClass:[YWTPlatformAnnoTableViewCell class] forCellReuseIdentifier:PLATFORMANNOTABLEVIEW_CELL];

    if (@available(iOS 11.0, *)) {
        self.platTableView.estimatedRowHeight = 50;
        self.platTableView.estimatedSectionFooterHeight = 0;
        self.platTableView.estimatedSectionHeaderHeight = 0 ;
        self.platTableView.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    __weak typeof(self) weakSelf = self;
    // 刷新
    [self.platTableView bindGlobalStyleForHeadRefreshHandler:^{
        weakSelf.page = 1;
        [weakSelf requestAnnouListData];
    }];
    
    [self.platTableView bindGlobalStyleForFootRefreshHandler:^{
        weakSelf.page ++;
        [weakSelf requestAnnouListData];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWTPlatformAnnoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PLATFORMANNOTABLEVIEW_CELL forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dict = self.dataArr[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{\
    return UITableViewAutomaticDimension;
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    self.customNavBar.title = @"平台公告";
    
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    __weak typeof(self) weakSelf = self;
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}
#pragma mark --- 懒加载--------
-(YWTShowNoSourceView *)showNoSoucreView{
    if (!_showNoSoucreView) {
        _showNoSoucreView = [[YWTShowNoSourceView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSNaviTopHeight-KSTabbarH)];
        _showNoSoucreView.showMarkLab.text = @"暂无公告";
    }
    return _showNoSoucreView;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
#pragma mark ------- 公告列表 ---------
-(void) requestAnnouListData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] =[YWTTools getNewToken];
    param[@"pageSize"] =@"10";
    param[@"page"] =[NSNumber numberWithInteger:self.page];
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPSERVICEAPIANNOUALIST_URL params:param withModel:nil waitView:nil complateHandle:^(id showdata, NSString *error) {
        [self.platTableView.footRefreshControl endRefreshing];
        [self.platTableView.headRefreshControl endRefreshing];
        if (error) {
            return ;
        }
        if ([showdata isKindOfClass:[NSArray class]]) {
            if (self.page == 1) {
                [self.dataArr removeAllObjects];
            }
            [self.dataArr addObjectsFromArray:showdata];
            
            if (self.dataArr.count == 0) {
                // 添加空白页
                [self.platTableView addSubview:self.showNoSoucreView];
            }
            [self.platTableView reloadData];
        }
    }];
}



@end
