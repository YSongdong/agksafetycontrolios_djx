//
//  YWTSuggestionBoxDetail.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/18.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTSuggestionBoxDetail.h"

#import "YWTDetailReplyPromptView.h"
#import "YWTDetailReplyBtnView.h"

#import "YWTUserInfoDetailCell.h"
#define YWTUSERINFODETAIL_CELL @"YWTUserInfoDetailCell"
#import "YWTDetailContentCell.h"
#define YWTDETAILCONTENT_CELL @"YWTDetailContentCell"

@interface YWTSuggestionBoxDetail ()
<
UITableViewDelegate,
UITableViewDataSource,
YWTDetailReplyPromptViewDelegate
>
@property (nonatomic,strong) YWTDetailReplyPromptView *showReplyPromptView;

@property (nonatomic,strong) YWTDetailReplyBtnView *detailReplyBtnView;

@property (nonatomic,strong) UITableView *detaTableView;

@property (nonatomic,strong) NSMutableArray *dataArr;


@end

@implementation YWTSuggestionBoxDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [self setNavi];
    // 撤回按钮view
    [self   createDetailReplyView];
    // 创建Tableview
    [self.view addSubview:self.detaTableView];
    // 请求数据
    [self requestOpinionDetails];
}
#pragma mark --- UITableViewDataSource--------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        YWTUserInfoDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:YWTUSERINFODETAIL_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dict = self.dataArr[indexPath.row];
        return cell;
    }else {
        YWTDetailContentCell *cell = [tableView dequeueReusableCellWithIdentifier:YWTDETAILCONTENT_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dict = self.dataArr[indexPath.row];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 297;
    }else {
        NSDictionary *dict = self.dataArr[indexPath.row];
        return [YWTDetailContentCell getWithDetailConntentCellHeight:dict];
    }
}
#pragma mark ----  YWTDetailReplyPromptViewDelegate  -------
// 回复信息
-(void) selectReplyWithdrawContent:(NSString *)contentText{
    if ([contentText isEqualToString:@""]) {
        [self.view showErrorWithTitle:@"请填写回复内容" autoCloseTime:0.5];
        return;
    }
    // 移除回复框
    [self.showReplyPromptView removeFromSuperview];
    
    [self requestReplySUbmitContent:contentText];
}
#pragma mark --- 创建撤回view --------
-(void) createDetailReplyView{
    self.detailReplyBtnView = [[YWTDetailReplyBtnView alloc]initWithFrame:CGRectMake(0, KScreenH-KSIphonScreenH(62)-KSTabbarH, KScreenW, KSIphonScreenH(62))];
    [self.view addSubview:self.detailReplyBtnView];
    WS(weakSelf);
    self.detailReplyBtnView.selectReplyAction = ^(BOOL isReply) {
        if (isReply) {
            // 回复
            [weakSelf.view addSubview:weakSelf.showReplyPromptView];
            weakSelf.showReplyPromptView.delegate = weakSelf;
        }else{
           // 撤回
            [weakSelf requestMsgWithdraw];
        }
    };
}

#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    self.customNavBar.title = @"意见详情";
    
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    __weak typeof(self) weakSelf = self;
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}
#pragma mark --- 懒加载--------
-(UITableView *)detaTableView{
    if (!_detaTableView) {
        _detaTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KScreenH-KSNaviTopHeight-KSTabbarH-KSIphonScreenH(62))];
        _detaTableView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
        _detaTableView.delegate = self;
        _detaTableView.dataSource = self;
        _detaTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
        _detaTableView.tableFooterView  =[[UIView alloc]initWithFrame:CGRectZero];
        [_detaTableView registerClass:[YWTUserInfoDetailCell class] forCellReuseIdentifier:YWTUSERINFODETAIL_CELL];
        [_detaTableView registerClass:[YWTDetailContentCell class] forCellReuseIdentifier:YWTDETAILCONTENT_CELL];
    }
    return _detaTableView;
}
-(YWTDetailReplyPromptView *)showReplyPromptView{
    if (!_showReplyPromptView) {
        _showReplyPromptView = [[YWTDetailReplyPromptView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH)];
    }
    return _showReplyPromptView;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(void)setSuggestionBoxId:(NSString *)suggestionBoxId{
    _suggestionBoxId = suggestionBoxId;
}
#pragma mark -----  数据相关 ------
-(void) requestOpinionDetails{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"id"] = self.suggestionBoxId;
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTSERICEAPISUGGESTIONBOXOPINIONDETAILSD_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if (![showdata isKindOfClass:[NSDictionary class]]) {
            [self.view showErrorWithTitle:@"数据出错!" autoCloseTime:0.5];
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        // 移除所有数据源
        [self.dataArr removeAllObjects];
        // 已撤回
        NSString *statusStr = [NSString stringWithFormat:@"%@",showdata[@"status"]];
        if ([statusStr isEqualToString:@"3"]) {
            // 是已被撤回
            [self.view showErrorWithTitle:@"该消息已撤回!" autoCloseTime:0.5];
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        
        [self.dataArr addObject:showdata];
        [self.dataArr addObject:showdata];
        // 意见发起人
        NSString *initiateStr = [NSString stringWithFormat:@"%@",showdata[@"initiate"]];
        NSString *replyscontentStr = [NSString stringWithFormat:@"%@",showdata[@"replyscontent"]];
        if ([initiateStr isEqualToString:@"2"] && ![replyscontentStr isEqualToString:@""]) {
            [self.detailReplyBtnView removeFromSuperview];
            WS(weakSelf);
            [self.detaTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.view).offset(KSNaviTopHeight);
                make.left.right.equalTo(weakSelf.view);
                make.bottom.equalTo(weakSelf.view).offset(-KSTabbarH);
            }];
        }
        // 更新底部view
        self.detailReplyBtnView.dict =  showdata;
        //刷新UI
        [self.detaTableView reloadData];
    }];
}

// 消息撤回
-(void)requestMsgWithdraw{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"id"] = self.suggestionBoxId;
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTSERICEAPISUGGESTIONBOXMSGWITH_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if (![showdata isKindOfClass:[NSDictionary class]]) {
            [self.view showErrorWithTitle:@"数据结构错误!" autoCloseTime:0.5];
            return;
        }
        // 更新数据源
        NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:self.detailReplyBtnView.dict];
        mutableDict[@"status"] =  @"3";
        
        // 更新UI
        self.detailReplyBtnView.dict = mutableDict.copy;
    }];
}

// 提交回复意见
-(void) requestReplySUbmitContent:(NSString*)replyText{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"id"] = self.suggestionBoxId;
    param[@"content"] = replyText;
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTSERICEAPISUGGESTIONBOXREPLYSUBMIT_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if ([showdata isKindOfClass:[NSDictionary class]]) {
            NSString *idStr = [NSString stringWithFormat:@"%@",showdata[@"id"]];
            self.suggestionBoxId = idStr;
            // 重新请求详情数据
            [self requestOpinionDetails];
        }
    }];
}


@end
