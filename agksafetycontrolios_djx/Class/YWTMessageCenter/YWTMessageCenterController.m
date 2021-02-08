//
//  MessageCenterController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/4.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTMessageCenterController.h"

#import "YWTShowNoSourceView.h"

#import "YWTShowMessageSiftView.h"
#import "YWTMsgCenterTableViewCell.h"
#define MSGCENTERTABLEVIEW_CELL @"YWTMsgCenterTableViewCell"

@interface YWTMessageCenterController ()
<
UITableViewDelegate,
UITableViewDataSource
>
// 筛选view
@property (nonatomic,strong) YWTShowMessageSiftView *showMsgSiftView;
// 空白页
@property (nonatomic,strong) YWTShowNoSourceView *showNoSoucreView;

@property (nonatomic,strong) UITableView *msgTableView;

@property (nonatomic,strong) NSMutableArray *dataArr;
// 筛选
@property (nonatomic,strong) NSString *tagIdStr;
// 分页
@property (nonatomic,assign) NSInteger page;
@end

@implementation YWTMessageCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tagIdStr = @"";
    self.page = 1;
    // 设置导航栏
    [self setNavi];
    // 创建TableView
    [self createTableView];
    // 请求数据
    [self requestMsgListData];
}
#pragma mark --- 创建TableView--------
-(void) createTableView{
    self.msgTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KScreenH-KSTabbarH-KSNaviTopHeight)];
    [self.view insertSubview:self.msgTableView atIndex:0];
    
    self.msgTableView.dataSource = self;
    self.msgTableView.delegate = self;
    self.msgTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.msgTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.msgTableView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    [self.msgTableView registerClass:[YWTMsgCenterTableViewCell class] forCellReuseIdentifier:MSGCENTERTABLEVIEW_CELL];
    
    if (@available(iOS 11.0, *)) {
        self.msgTableView.estimatedRowHeight = 0;
        self.msgTableView.estimatedSectionFooterHeight = 0;
        self.msgTableView.estimatedSectionHeaderHeight = 0 ;
        self.msgTableView.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    __weak typeof(self) weakSelf = self;
    // 刷新
    [self.msgTableView bindGlobalStyleForHeadRefreshHandler:^{
        weakSelf.page ++;
        [weakSelf requestMsgListData];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWTMsgCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MSGCENTERTABLEVIEW_CELL forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dict = self.dataArr[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = self.dataArr[indexPath.row];
    return [YWTMsgCenterTableViewCell getWithCellHeight:dict];
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    self.customNavBar.title = @"消息中心";
    
    __weak typeof(self) weakSelf = self;
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    // 筛选
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageChangeName:@"nav_ico_sift"]];
    self.customNavBar.onClickRightButton = ^{
        weakSelf.showMsgSiftView = [[YWTShowMessageSiftView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH)];
        [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.showMsgSiftView];
        weakSelf.showMsgSiftView.tagIdStr = weakSelf.tagIdStr;
        __weak typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.showMsgSiftView.selectType = ^(NSString * _Nonnull typeStr) {
            strongSelf.tagIdStr = typeStr;
            strongSelf.page = 1;
            [strongSelf requestMsgListData];
            if (![typeStr isEqualToString:@"0"]) {
                [weakSelf.customNavBar.rightButton setImage:[UIImage imageChangeName:@"nav_ico_sift_select"] forState:UIControlStateNormal];
            }else{
                [weakSelf.customNavBar.rightButton setImage:[UIImage imageChangeName:@"nav_ico_sift"] forState:UIControlStateNormal];
            }
        };
    };
}
// 滚动到最底部
-(void)scrollToBottom {
    if (self.dataArr.count > 0) {
        if ([self.msgTableView numberOfRowsInSection:0] > 0) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([self.msgTableView numberOfRowsInSection:0]-1) inSection:0];
            [self.msgTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
    }
}
#pragma mark -----------懒加载--------
//-(ShowMessageSiftView *)showMsgSiftView{
//    if (!_showMsgSiftView) {
//        _showMsgSiftView = [[ShowMessageSiftView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH)];
//    }
//    return _showMsgSiftView;
//}
-(YWTShowNoSourceView *)showNoSoucreView{
    if (!_showNoSoucreView) {
        _showNoSoucreView = [[YWTShowNoSourceView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSNaviTopHeight-KSTabbarH)];
        _showNoSoucreView.showMarkLab.text = @"暂无消息";
    }
    return _showNoSoucreView;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

#pragma  mark -------- 消息列表 -------
-(void) requestMsgListData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] =  [YWTTools getNewToken];
    param[@"tagId"] = self.tagIdStr;
    param[@"page"] = [NSNumber numberWithInteger:self.page];
//    param[@"pageSize"] = @"4";
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPSERVICAPIMGMAILMSGLIST_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        [self.msgTableView.headRefreshControl endRefreshing];
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if ([showdata isKindOfClass:[NSArray class]]) {
            if (self.page == 1) {
                [self.dataArr removeAllObjects];
                //
                [self.dataArr addObjectsFromArray:showdata];
               
            }else{
                NSArray *arr = (NSArray*)showdata;
                for (NSInteger i = arr.count; i > 0 ; i--) {
                    NSDictionary *dict = arr[i-1];
                    [self.dataArr insertObject:dict atIndex:0];
                }
            }
            if (self.dataArr.count == 0) {
                // 添加空白页
                [self.msgTableView addSubview:self.showNoSoucreView];
            }else{
                [self.showNoSoucreView removeFromSuperview];
            }
            [self.msgTableView reloadData];
            if (self.page == 1) {
                // 滚动到最底部
                [self scrollToBottom];
            }
        }
    }];
}



@end
