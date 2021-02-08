//
//  YWTPartyMemberAreaDetailController.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/11.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTPartyMemberAreaDetailController.h"

#import "YWTAreaPlayVideoController.h"

#import "YWTBtnOperationAreaView.h"
#import "YWTDetailHeaderView.h"
#import "YWTSendCommentView.h"

#import "YWTDetailCommentModel.h"
#import "YWTPartyEemberAreaModel.h"


#import "YWTDetailInfoCell.h"
#define YWTDETAILINFO_CELL @"YWTDetailInfoCell"
#import "YWTDetailCommentCell.h"
#define YWTDETAILCOMMENT_CELL @"YWTDetailCommentCell"

@interface YWTPartyMemberAreaDetailController ()
<
UITableViewDelegate,
UITableViewDataSource,
YWTDetailInfoCellDelegate,
YWTBtnOperationAreaViewDeleagate
>
// 按钮操作view
@property (nonatomic,strong) YWTBtnOperationAreaView *btnOperationView;
// headerView
@property (nonatomic,strong) YWTDetailHeaderView *headerView;

@property (nonatomic,strong) YWTSendCommentView *showCommentView;

@property (nonatomic,strong) UITableView *detailTabelView;

@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,assign) NSInteger page;
// 记录时间戳
@property (nonatomic,strong) NSString  *startTimeStr;
@end

@implementation YWTPartyMemberAreaDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorTextWhiteColor];
    self.page = 1;
    // 设置导航栏
    [self setNavi];
    // 添加操作按钮view
    [self.view addSubview:self.btnOperationView];
    // 创建TableView
    [self.view addSubview:self.detailTabelView];
    // 请求
    [self requestComDetail];
    // 文章评论列表
    [self requestEvaluationLoad];
}
#pragma mark --- UITableViewDataSource --------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.dataArr[section];
    return arr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        YWTDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:YWTDETAILINFO_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *arr = self.dataArr[indexPath.section];
        YWTPartyEemberAreaModel *model = arr[indexPath.row];
        cell.delegate = self;
        cell.model = model;
        // 渲染图片
        [cell loadPicture];
        return cell;
    }else{
        YWTDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:YWTDETAILCOMMENT_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *arr = self.dataArr[indexPath.section];
        cell.model = arr[indexPath.row];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NSArray *arr = self.dataArr[indexPath.section];
        YWTPartyEemberAreaModel *model  = arr[indexPath.row];
        return model.rowHeight;
    }else{
        NSArray *arr = self.dataArr[indexPath.section];
        YWTDetailCommentModel *model = arr[indexPath.row];
         return [YWTDetailCommentCell getWithCommentCellHeight:model];
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 1)];
        return view;
    }else{
        self.headerView = [[YWTDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 40)];
        NSArray *arr = self.dataArr[section];
        self.headerView.allCommitLab.text = [NSString stringWithFormat:@"全部评论 (%lu)",(unsigned long)arr.count];
        return self.headerView;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 10)];
        footerView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
        return footerView;
    }else{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 1)];
        return view;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.001;
    }else{
        return 40;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else{
        return 0.01;
    }
}
#pragma mark  -----  YWTDetailInfoCellDelegate  -----
// 选中文章详情
-(void) selectOPerateMenu:(YWTDetailInfoCell*)cell operateType:(YWTOperateType)operateType{
    switch (operateType) {
        case 1:
        {
            break;
        }
        case 2:
        {
            
            break;
        }
        case 3:
        { // 播放视频
            YWTAreaPlayVideoController *VideoVC = [[YWTAreaPlayVideoController alloc]init];
            NSString *videoUrl = [cell.model.filelist firstObject];
            YWTAddModel *videoModel = [[YWTAddModel alloc]init];
            videoModel.urlStr = videoUrl;
            videoModel.photoImege = cell.cellVideoView.coverImageV.image;
            videoModel.fileName = cell.model.content;
            VideoVC.addModel = videoModel;
            [self.navigationController pushViewController:VideoVC animated:YES];
            break;
        }
        case 4:
        { // 用户详情
            
            break;
        }
        default:
            break;
    }
}
#pragma mark  -----  YWTBtnOperationAreaViewDeleagate  -----
-(void) selectOPerateMenuOperateType:(YWTOperateType)operateType{
    NSArray *arr = self.dataArr[0];
    switch (operateType) {
           case 1:
           {  // 点赞
               if (arr.count == 0) {
                   return;
               }
               [self requestGiveLikeLoad];
               break;
           }
           case 2:
           { // 评论
               if (arr.count == 0) {
                  return;
               }
               [self createCommentView];
               break;
           }
           default:
               break;
       }
}
#pragma mark --- 系统回调 左滑返回拦截--------
- (void)willMoveToParentViewController:(UIViewController*)parent{
    [super willMoveToParentViewController:parent];
    if (!parent) {
       // 上报时间
       [self requestLeaRecord];
    }
}
- (void)didMoveToParentViewController:(UIViewController*)parent{
    [super didMoveToParentViewController:parent];
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    self.customNavBar.title = @"详情";
    
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    __weak typeof(self) weakSelf = self;
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    if (self.detailType == partyAreaDetailOtherType) {
        return;
    }
    // 删除文章
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"Party_detail_delete"]];
    self.customNavBar.onClickRightButton = ^{
        // 删除文章
        [weakSelf requestDelegateCom];
    };
}
#pragma mark --- 创建评论提示框 --------
-(void) createCommentView{
    self.showCommentView = [[YWTSendCommentView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    [self.view addSubview:self.showCommentView];
    WS(weakSelf);
    self.showCommentView.selectCommit = ^(NSString * _Nonnull commitText) {
        if (commitText.length == 0) {
            [weakSelf.view showErrorWithTitle:@"请填写评论" autoCloseTime:0.5];
            return ;
        }
        [weakSelf requestReplySubmit:commitText];
    };
}
-(NSString *)getNowTimeTimestamp{
    //现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
   
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)([datenow timeIntervalSince1970]*1000)];

    return timeSp;
}
#pragma mark ---  get  --------
-(YWTBtnOperationAreaView *)btnOperationView{
    if (!_btnOperationView) {
        _btnOperationView = [[YWTBtnOperationAreaView alloc]initWithFrame:CGRectMake(0, KScreenH-KSIphonScreenH(50)-KSTabbarH, KScreenW, KSIphonScreenH(50))];
        _btnOperationView.delegate = self;
    }
    return _btnOperationView;
}
-(UITableView *)detailTabelView{
    if (!_detailTabelView) {
        _detailTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KScreenH-KSNaviTopHeight-KSTabbarH-CGRectGetHeight(self.btnOperationView.frame)) style:UITableViewStyleGrouped];
        
        _detailTabelView.delegate = self;
        _detailTabelView.dataSource = self;
        _detailTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _detailTabelView.backgroundColor = [UIColor colorTextWhiteColor];
        
        [_detailTabelView registerClass:[YWTDetailInfoCell class] forCellReuseIdentifier:YWTDETAILINFO_CELL];
        [_detailTabelView registerClass:[YWTDetailCommentCell class] forCellReuseIdentifier:YWTDETAILCOMMENT_CELL];
        WS(weakSelf);
        [_detailTabelView bindGlobalStyleForHeadRefreshHandler:^{
            weakSelf.page = 1;
            [weakSelf requestEvaluationLoad];
        }];
        [_detailTabelView bindGlobalStyleForFootRefreshHandler:^{
            weakSelf.page ++;
            [weakSelf requestEvaluationLoad];
        }];
    }
    return _detailTabelView;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
        NSMutableArray *userArr = [NSMutableArray array];
        NSMutableArray *commitArr = [NSMutableArray array];
        [_dataArr addObject:userArr];
        [_dataArr addObject:commitArr];
    }
    return _dataArr;
}
-(void)setIdStr:(NSString *)idStr{
    _idStr = idStr;
}
-(void)setTaskIdStr:(NSString *)taskIdStr{
    _taskIdStr = taskIdStr;
}
#pragma mark ---- 数据相关 -----
-(void) requestComDetail{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"id"] = self.idStr;
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTSERICEAPICOMMUNITYCOMDETAILS_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        [self.detailTabelView.headRefreshControl endRefreshing];
        [self.detailTabelView.footRefreshControl endRefreshing];
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if (![showdata isKindOfClass:[NSDictionary class]]) {
            return;
        }
        // 记录开始时间戳
        self.startTimeStr = [self getNowTimeTimestamp];
        // 1 已点赞 2未点赞
        NSString *giveStr = [NSString stringWithFormat:@"%@",showdata[@"give"]];
        if ([giveStr isEqualToString:@"1"]) {
            self.btnOperationView.likeBtn.selected = YES;
        }else{
            self.btnOperationView.likeBtn.selected = NO;
        }
        NSMutableArray *userArr = self.dataArr[0];
        if (self.page == 1) {
            // 删除之前的数据
            [userArr removeAllObjects];
        }
        YWTPartyEemberAreaModel *model = [YWTPartyEemberAreaModel yy_modelWithDictionary:showdata];
        [userArr addObject:model];
        
        [self.dataArr replaceObjectAtIndex:0 withObject:userArr];
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
        [self.detailTabelView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    }];
}
// 文章评论列表
-(void) requestEvaluationLoad{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"id"] = self.idStr;
    param[@"page"] = [NSNumber numberWithInteger:self.page];
    param[@"taskid"] = self.taskIdStr;
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTSERICEAPICOMMUNITYEVALUATION_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        [self.detailTabelView.footRefreshControl  endRefreshing];
        [self.detailTabelView.headRefreshControl endRefreshing];
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if (![showdata isKindOfClass:[NSArray class]]) {
            return;
        }
        NSArray *arr = (NSArray*)showdata;
    
        NSMutableArray *commentArr = self.dataArr[1];
        if (self.page == 1) {
            // 删除之前的数据
            [commentArr removeAllObjects];
        }
        for (NSDictionary *dict in arr) {
            YWTDetailCommentModel *model = [YWTDetailCommentModel yy_modelWithDictionary:dict];
            [commentArr addObject:model];
        }
        [self.dataArr replaceObjectAtIndex:1 withObject:commentArr];
       
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:1];
        [self.detailTabelView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        // 是否滚动到评论
        if (self.isComment) {
            if (commentArr.count == 0) {
                return;
            }
           NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
           [self.detailTabelView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }];
}
#pragma mark --- 点赞/取消点赞 -----
-(void) requestGiveLikeLoad{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    NSArray *infoArr = self.dataArr[0];
    YWTPartyEemberAreaModel *model = infoArr[0];
    param[@"id"] = model.Id;
    if ([model.give isEqualToString:@"1"]) {
        param[@"give"] = @"dl";
    }else{
        param[@"give"] = @"ge";
        param[@"taskid"] = self.taskIdStr;
    }
    [[KRMainNetTool sharedKRMainNetTool]postRequstWith:HTTP_ATTSERICEAPICOMMUNITYGIVELIKE_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if ([model.give isEqualToString:@"1"]) {
            // 取消点赞
            model.give = @"2";
            self.btnOperationView.likeBtn.selected = NO;
        }else{
            model.give = @"1";
            self.btnOperationView.likeBtn.selected = YES;
        }
        // 贴换数据源
        NSMutableArray *infoArr = self.dataArr[0];
        [infoArr replaceObjectAtIndex:0 withObject:model];
        [self.dataArr replaceObjectAtIndex:0 withObject:infoArr];
    }];
}

#pragma mark --- 评论文章 -----
-(void)requestReplySubmit:(NSString*)commentText{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] =  [YWTTools getNewToken];
    param[@"id"] = self.idStr;
    param[@"content"] =commentText;
    param[@"taskid"] = self.taskIdStr;
    [[KRMainNetTool sharedKRMainNetTool]postRequstWith:HTTP_ATTSERICEAPICOMMUNITYREPLYSUBMIT_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        self.page = 1;
        [self requestComDetail];
        [self requestEvaluationLoad];
    }];
}

#pragma mark --- 删除文章 -----
-(void)requestDelegateCom{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] =  [YWTTools getNewToken];
    param[@"id"] = self.idStr;
    [[KRMainNetTool sharedKRMainNetTool]postRequstWith:HTTP_ATTSERICEAPICOMMUNITYCOMDEL_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
// 文章浏览时间上报
-(void)requestLeaRecord{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"id"] = self.idStr;
    param[@"startTime"] = self.startTimeStr;
    param[@"endTime"] = [self getNowTimeTimestamp];
    param[@"taskid"] = self.taskIdStr;
    [[KRMainNetTool sharedKRMainNetTool]postRequstWith:HTTP_ATTSERICEAPICOMMUNITYLEARECORD_URL params:param withModel:nil waitView:nil complateHandle:^(id showdata, NSString *error) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}




@end
