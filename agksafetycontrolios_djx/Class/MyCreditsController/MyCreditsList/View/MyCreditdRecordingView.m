//
//  MyCreditdRecordingView.m
//  PartyBuildingStar
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import "MyCreditdRecordingView.h"

#import "MyCreditsRecordHeaderView.h"
#import "YWTShowNoSourceView.h"

#import "MyCreditsRecordingCell.h"
#define MYCREDITSRECORDING_CELL @"MyCreditsRecordingCell"


@interface MyCreditdRecordingView ()
<
UITableViewDelegate,
UITableViewDataSource
>
// 空白页
@property (nonatomic,strong) YWTShowNoSourceView *showNoSoucreView;

@property (nonatomic,strong) UITableView *recordTableView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,assign) NSInteger page;

@end


@implementation MyCreditdRecordingView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createRecordView];
        self.page = 1;
        // 请求数据
        [self requestMyTaskMyCreditsData];
    }
    return self;
}
-(void) createRecordView{
    __weak typeof(self) weakSelf = self;
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor  = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(KSIphonScreenH(6));
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
        make.bottom.equalTo(weakSelf).offset(-KSIphonScreenH(12));
    }];
    bgView.layer.cornerRadius = 8;
    bgView.layer.masksToBounds = YES;
    
    // 头部视图
    MyCreditsRecordHeaderView *headerView = [[MyCreditsRecordHeaderView alloc]init];
    [bgView addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(bgView);
        make.height.equalTo(@(KSIphonScreenH(44)));
    }];
    
    // 列表
    self.recordTableView = [[UITableView alloc]init];
    [bgView addSubview:self.recordTableView];
    [self.recordTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom);
        make.left.right.bottom.equalTo(bgView);
    }];
    self.recordTableView.delegate = self;
    self.recordTableView.dataSource = self;
    self.recordTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.recordTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];

    [self.recordTableView registerClass:[MyCreditsRecordingCell class] forCellReuseIdentifier:MYCREDITSRECORDING_CELL];
    
    // 添加空白页
    self.showNoSoucreView = [[YWTShowNoSourceView alloc]init];
    [self.recordTableView addSubview:self.showNoSoucreView];
    self.showNoSoucreView.backgroundColor = [UIColor colorTextWhiteColor];
    [self.showNoSoucreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom);
        make.left.right.bottom.equalTo(bgView);
    }];
    
    [self.recordTableView bindGlobalStyleForHeadRefreshHandler:^{
        weakSelf.page = 1;
        [weakSelf requestMyTaskMyCreditsData];
    }];
    
    [self.recordTableView bindGlobalStyleForFootRefreshHandler:^{
        weakSelf.page ++ ;
        [weakSelf requestMyTaskMyCreditsData];
    }];
    
}
#pragma mark ------- UITableViewDataSource ----
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyCreditsRecordingCell *cell = [tableView dequeueReusableCellWithIdentifier:MYCREDITSRECORDING_CELL forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dict = self.dataArr[indexPath.row];
    cell.dict = dict;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
#pragma mark ----- get 方法 ------
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
#pragma mark ----- 数据请求 ----
-(void) requestMyTaskMyCreditsData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] =  [YWTTools getNewToken];
    param[@"page"] =  [NSNumber numberWithInteger:self.page];
    param[@"pageSize"] = @"15";
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPSERVICEAPIMYTASKTASKMYCREDITS_URL params:param withModel:nil waitView:self complateHandle:^(id showdata, NSString *error) {
        
        [self.recordTableView.headRefreshControl endRefreshing];
        [self.recordTableView.footRefreshControl endRefreshing];
        
        if (error) {
            return ;
        }
        if ([showdata isKindOfClass:[NSDictionary class]]) {
            if (self.page == 1) {
                [self.dataArr removeAllObjects];
            }
            //我的分数
            NSString *dataSetCountStr = [NSString stringWithFormat:@"%@",showdata[@"dataSetCount"]];
            self.myCreditsSetCount(dataSetCountStr);
            
            // 学分记录
            NSArray *dataSetListArr = (NSArray *)showdata[@"dataSetList"];
            //
            [self.dataArr addObjectsFromArray:dataSetListArr];
            
            //是否显示空白页
            if (self.dataArr.count == 0) {
                self.showNoSoucreView.hidden = NO;
            }else{
               self.showNoSoucreView.hidden = YES;
            }
            
            // 刷新
            [self.recordTableView reloadData];
        }
    }];
}

@end
