//
//  YWTBoxRecordController.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/17.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTBoxRecordController.h"

#import "YWTSuggestionBoxDetail.h"

#import "YWTShowNoSourceView.h"

#import "YWTBoxRecordTopView.h"
#import "YWTBaseHeaderSearchView.h"
#import "YWTBoxRecordCell.h"
#define YWTBOXRECORD_CELL @"YWTBoxRecordCell"

@interface YWTBoxRecordController ()
<
UITableViewDelegate,
UITableViewDataSource
>
// 顶部按钮view
@property (nonatomic,strong) YWTBoxRecordTopView *boxRecordTopView;
// 头部搜索view
@property (nonatomic,strong) YWTBaseHeaderSearchView  *headerSearchView;
// 空白页
@property (nonatomic,strong) YWTShowNoSourceView *showNoSoucreView;

@property (nonatomic,strong) UITableView *recordTableView;

@property (nonatomic,strong) NSMutableArray *dataArr;
// 顶部消息背景
@property (nonatomic,strong) UIView *topBgView;
// 顶部消息内容
@property (nonatomic,strong) UILabel *topLabel;
// 搜索参数
@property (nonatomic,strong) NSString *searchStr;

@property (nonatomic,assign) NSInteger page;

@end

@implementation YWTBoxRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.boxType = YWTSuggestionBoxListBoxType;
    self.page = 1;
    // 设置导航栏
    [self setNavi];
    //  创建搜索view
    [self createSearchView];
    //
    [self.view addSubview:self.recordTableView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestSuggetionRecordLoadData];
    // 接收但未读数量
    [self requestSuggestionBoxUnreadData];
}
#pragma mark --- UITableViewDataSource --------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWTBoxRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:YWTBOXRECORD_CELL forIndexPath:indexPath];
    if (self.boxType == YWTSuggestionBoxListBoxType) {
        cell.cellType = SuggestionBoxListBoxCellType;
    }else{
        cell.cellType = SuggestionBoxReplyBoxCellType;
    }
    cell.dict = self.dataArr[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    YWTSuggestionBoxDetail *detaVC = [[YWTSuggestionBoxDetail alloc]init];
    NSDictionary *dict = self.dataArr[indexPath.row];
    detaVC.suggestionBoxId = [NSString stringWithFormat:@"%@",dict[@"id"]];
    [self.navigationController pushViewController:detaVC animated:YES];
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    __weak typeof(self) weakSelf = self;
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    [self.customNavBar addSubview:self.boxRecordTopView];
    self.boxRecordTopView.selectBtnBlock = ^(NSInteger btnTag) {
        if (btnTag == 0) {
            // 我发布的
            weakSelf.boxType = YWTSuggestionBoxListBoxType;
        }else{
            // 接收的
            weakSelf.boxType = YWTSuggestionBoxReplyBoxType;
            // 接收但未读数量
            [weakSelf requestSuggestionBoxUnreadData];
        }
        weakSelf.page = 1;
        [weakSelf requestSuggetionRecordLoadData];
    };
    // 消息view
    [self.topBgView addSubview:self.topLabel];
    [self.customNavBar addSubview:self.topBgView];
    [self.topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.boxRecordTopView.mas_right).offset(-5);
        make.top.equalTo(weakSelf.boxRecordTopView.mas_top);
        make.width.height.equalTo(@17);
    }];
    self.topBgView.layer.cornerRadius  = 17/2;
    self.topBgView.layer.masksToBounds = YES;
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.topBgView.mas_centerX);
        make.centerY.equalTo(weakSelf.topBgView.mas_centerY);
    }];
    // 默认隐藏
    self.topBgView.hidden = YES;
}
#pragma mark --- 创建搜索view --------
-(void) createSearchView{
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.headerSearchView];
    self.headerSearchView.searchTextField.placeholder = @"请输入接收人/单位/意见内容搜索";
    self.headerSearchView.isExamCenterRcord = YES;
    self.headerSearchView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    self.headerSearchView.bgView.backgroundColor = [UIColor  colorTextWhiteColor];
    self.headerSearchView.searchTextField.backgroundColor = [UIColor colorTextWhiteColor];
    [UIView animateWithDuration:0.25 animations:^{
        // 更新约束
        [weakSelf.headerSearchView.searchImageV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.headerSearchView.bgView).offset((KScreenW-24)/5);
        }];
    }];
    self.headerSearchView.searchBlock = ^(NSString * _Nonnull search) {
        weakSelf.searchStr = search;
        weakSelf.page = 1;
        [weakSelf requestSuggetionRecordLoadData];
    };
}
#pragma mark ---  懒加载 -----
-(YWTBoxRecordTopView *)boxRecordTopView{
    if (!_boxRecordTopView) {
        _boxRecordTopView = [[YWTBoxRecordTopView alloc]initWithFrame:CGRectMake((KScreenW-15-KSIphonScreenW(166))/2, KSStatusHeight+(22-KSIphonScreenH(30)/2), KSIphonScreenW(166), KSIphonScreenH(30))];
    }
    return _boxRecordTopView;
}
-(YWTBaseHeaderSearchView *)headerSearchView{
    if (!_headerSearchView) {
        _headerSearchView = [[YWTBaseHeaderSearchView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KSIphonScreenH(60))];
    }
    return _headerSearchView;
}
-(UITableView *)recordTableView{
    if (!_recordTableView) {
        _recordTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight+KSIphonScreenH(60), KScreenW, KScreenH-KSNaviTopHeight-KSIphonScreenH(60)-KSTabbarH)];
        _recordTableView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
        _recordTableView.delegate = self;
        _recordTableView.dataSource = self;
        _recordTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _recordTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _recordTableView.keyboardDismissMode =  UIScrollViewKeyboardDismissModeOnDrag;
        // 添加空白页
        [_recordTableView addSubview:self.showNoSoucreView];
        [_recordTableView registerClass:[YWTBoxRecordCell class] forCellReuseIdentifier:YWTBOXRECORD_CELL];
        WS(weakSelf);
        [_recordTableView bindGlobalStyleForHeadRefreshHandler:^{
            weakSelf.page = 1;
            [weakSelf requestSuggetionRecordLoadData];
        }];
        [_recordTableView bindGlobalStyleForFootRefreshHandler:^{
            weakSelf.page ++;
            [weakSelf requestSuggetionRecordLoadData];
        }];
    }
    return _recordTableView;
}
-(YWTShowNoSourceView *)showNoSoucreView{
    if (!_showNoSoucreView) {
        _showNoSoucreView = [[YWTShowNoSourceView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSNaviTopHeight-KSIphonScreenH(60)-KSTabbarH)];
    }
    return _showNoSoucreView;
}
-(UIView *)topBgView{
    if (!_topBgView) {
        _topBgView = [[UIView alloc]init];
        _topBgView.backgroundColor = [UIColor  colorTextWhiteColor];
    }
    return _topBgView;
}
-(UILabel *)topLabel{
    if (!_topLabel) {
        _topLabel = [[UILabel alloc]init];
        _topLabel.text = @"99";
        _topLabel.textColor = [UIColor colorLineCommonBlueColor];
        _topLabel.font = Font(12);
        _topLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _topLabel;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

#pragma mark ---- 数据相关 ---------
-(void) requestSuggetionRecordLoadData{
    NSString *url;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"keyword"] = self.searchStr;
    param[@"page"] = [NSNumber numberWithInteger:self.page];
    if (self.boxType ==YWTSuggestionBoxListBoxType ) {
        url = HTTP_ATTSERICEAPISUGGESTIONBOXLISTBOX_URL;
    }else{
        url = HTTP_ATTSERICEAPISUGGESTIONBOXREPLYBOX_URL;
    }
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:url params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        [self.recordTableView.headRefreshControl endRefreshing];
        [self.recordTableView.footRefreshControl endRefreshing];
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if (![showdata isKindOfClass:[NSArray class]]) {
            return;
        }
        if (self.page == 1) {
            [self.dataArr removeAllObjects];
        }
        [self.dataArr addObjectsFromArray:showdata];
        if (self.dataArr.count > 0) {
            self.showNoSoucreView.hidden =  YES;
        }else{
            self.showNoSoucreView.hidden =  NO;
        }
        [self.recordTableView reloadData];
    }];
}
// 接收但未读数量
-(void) requestSuggestionBoxUnreadData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTSERICEAPISUGGESTIONBOXUNREAD_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if (![showdata isKindOfClass:[NSDictionary class]]) {
            return;
        }
        NSString *receivenumStr = [NSString stringWithFormat:@"%@",showdata[@"receivenum"]];
        if ([receivenumStr integerValue] == 0) {
            // 我接收的
            self.topBgView.hidden = YES;
        }else{
            // 我接收的
            self.topLabel.text = receivenumStr;
            self.topBgView.hidden = NO;
        }
    }];
}




@end
