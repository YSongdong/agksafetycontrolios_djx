//
//  CreditChartRankingView.m
//  PartyBuildingStar
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import "CreditChartRankingView.h"

#import "CreditChartRankingCell.h"
#define CREDITCHARTRANKING_CELL @"CreditChartRankingCell"

@interface CreditChartRankingView ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic,strong) UITableView *rankTableView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,assign) NSInteger page;
@end

@implementation CreditChartRankingView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createRankingView];
        self.page = 1;
        [self requestCreditLeaderBoardData];
    }
    return self;
}
-(void) createRankingView{
    __weak typeof(self) weakSelf = self;
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    bgView.layer.cornerRadius = 8 ;
    bgView.layer.masksToBounds = YES;
    
    self.rankTableView = [[UITableView alloc]init];
    [bgView addSubview:self.rankTableView];
    [self.rankTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bgView);
    }];
    
    self.rankTableView.delegate = self;
    self.rankTableView.dataSource = self;
    self.rankTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rankTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    [self.rankTableView registerClass:[CreditChartRankingCell class] forCellReuseIdentifier:CREDITCHARTRANKING_CELL];
    
    [self.rankTableView bindGlobalStyleForHeadRefreshHandler:^{
        weakSelf.page = 1;
        [weakSelf requestCreditLeaderBoardData];
    }];
    
    [self.rankTableView bindGlobalStyleForFootRefreshHandler:^{
        weakSelf.page ++;
        [weakSelf requestCreditLeaderBoardData];
    }];
}
#pragma mark ----- UITableViewDataSource ---
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CreditChartRankingCell *cell = [tableView dequeueReusableCellWithIdentifier:CREDITCHARTRANKING_CELL forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dict = self.dataArr[indexPath.row];
    cell.dict = dict;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 62;
}

#pragma mark ----- get 方法 -----
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

#pragma mark -- 数据接口 ----
-(void) requestCreditLeaderBoardData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"page"] = [NSNumber numberWithInteger:self.page];
    param[@"pageSize"] = @"15";
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPSERVICEAPIMYTASKTASKCREDITLEADERBOARD_URL params:param withModel:nil waitView:self complateHandle:^(id showdata, NSString *error) {
        
        [self.rankTableView.headRefreshControl endRefreshing];
        [self.rankTableView.footRefreshControl endRefreshing];
        
        if (error) {
            return ;
        }
        if ([showdata isKindOfClass:[NSDictionary class]]) {
            if (self.page == 1) {
                [self.dataArr removeAllObjects];
            }
            //当前用户信息
            NSDictionary *userDict = showdata[@"currentUser"];
            self.currentUser(userDict);
            
            //排行榜列表
            NSArray *leaderboardListArr = (NSArray *)showdata[@"leaderboardList"];
            [self.dataArr addObjectsFromArray:leaderboardListArr];
            
            [self.rankTableView reloadData];
        }
        
    }];
}



@end
