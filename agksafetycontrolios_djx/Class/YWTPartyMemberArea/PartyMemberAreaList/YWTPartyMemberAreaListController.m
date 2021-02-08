//
//  YWTPartyMemberAreaController.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/4.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTPartyMemberAreaListController.h"

#import "YWTPartyMemberAreaAddController.h"
#import "YWTPartyMemberAreaDetailController.h"
#import "YWTAreaPlayVideoController.h"

#import "YWTSendCommentView.h"
#import "YWTShowNoSourceView.h"

#import "YWTBaseHeaderSearchView.h"
#import "YBPopupMenu.h"

#import "YWTBaseParyMemberCell.h"
#define YWTBASEPARTYMEMBER_CELL @"YWTBaseParyMemberCell"

@interface YWTPartyMemberAreaListController ()
<
UITableViewDelegate,
UITableViewDataSource,
YBPopupMenuDelegate,
YWTBaseParyMemberCellDelegate
>
// 头部搜索view
@property (nonatomic,strong) YWTBaseHeaderSearchView  *headerSearchView;
// 空白页
@property (nonatomic,strong) YWTShowNoSourceView *showNoSoucreView;
@property (nonatomic,strong) YBPopupMenu *popupMuenView;

@property (nonatomic,strong) UITableView *partyTableView;

@property (nonatomic,strong) NSMutableArray *dataArr;
// 搜索参数
@property (nonatomic,strong) NSString *searchStr;

@property (nonatomic,assign) NSInteger page;

@end

@implementation YWTPartyMemberAreaListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    // 设置导航栏
    [self setNavi];
    // 搜索view
    [self createSearchView];
    // 创建 UITableView
    [self.view addSubview:self.partyTableView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 请求数据
    [self requestComListLoadData];
}
#pragma mark --- UITableViewDataSource --------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWTBaseParyMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:YWTBASEPARTYMEMBER_CELL forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    cell.tag = indexPath.row;
    cell.delegate = self;
    YWTPartyEemberAreaModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    // 渲染图片
    [cell loadPicture];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWTPartyEemberAreaModel *model = self.dataArr[indexPath.row];
    return model.rowHeight;
}

#pragma mark --- YWTBaseParyMemberCellDelegate -----------
// 选中文章详情
-(void) selectOPerateMenu:(YWTBaseParyMemberCell*)cell operateType:(YWTOperateType)operateType{
    switch (operateType) {
        case 1:
        {   // 点赞
            [self requestGiveLikeLoadCell:cell];
            break;
        }
        case 2:
        {  // 评论
            YWTPartyMemberAreaDetailController *detailVC = [[YWTPartyMemberAreaDetailController alloc]init];
            detailVC.idStr = cell.model.Id;
            detailVC.isComment = YES;
            detailVC.taskIdStr = self.taskIdStr;
            // 类型
            if (self.listType == partyAreaListMineType) {
                detailVC.detailType =  partyAreaDetailMineType;
            }else{
                detailVC.detailType =  partyAreaDetailOtherType;
            }
            [self.navigationController pushViewController:detailVC animated:YES];
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
            YWTPartyMemberAreaDetailController *detailVC = [[YWTPartyMemberAreaDetailController alloc]init];
            detailVC.idStr = cell.model.Id;
            WS(weakSelf);
            detailVC.taskIdStr =weakSelf.taskIdStr;
            // 类型
            if (self.listType == partyAreaListMineType) {
                detailVC.detailType =  partyAreaDetailMineType;
            }else{
                detailVC.detailType =  partyAreaDetailOtherType;
            }
            [self.navigationController pushViewController:detailVC animated:YES];
            break;
        }
        case 5:
        { // 显示更多全文
            YWTPartyEemberAreaModel *model = cell.model;
            [self.dataArr replaceObjectAtIndex:cell.tag withObject:model];
            NSIndexPath * indexPath = [self.partyTableView indexPathForCell:cell];
            [UIView performWithoutAnimation:^{
                [self.partyTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }];
            break;
        }
        default:
            break;
    }
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    NSString *titleStr = @"党员互动区";
    if (self.listType ==partyAreaListMineType ) {
        // 我的文章
        titleStr = @"我的文章";
    }else{
        titleStr = [self.moduleNameStr isEqualToString:@""] ? titleStr : self.moduleNameStr;
    }
    self.customNavBar.title = titleStr;
    
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    __weak typeof(self) weakSelf = self;
    self.customNavBar.onClickLeftButton = ^{
        if (self.listType ==partyAreaListMineType ) {
            // 我的文章
           [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            // 直接返回到首页
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }
    };
    
    if (self.listType ==partyAreaListMineType ) {
        // 我的文章
        return;
    }
    // 发布
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"party_nav_publication"]];
    self.customNavBar.onClickRightButton = ^{
        weakSelf.popupMuenView = [YBPopupMenu showAtPoint:CGPointMake(KScreenW-15, CGRectGetMaxY(weakSelf.customNavBar.rightButton.frame)-10) titles:@[@"图片",@"视频"] icons:@[@"party_list_add_photo",@"party_list_add_video"] menuWidth:100 otherSettings:^(YBPopupMenu *popupMenu) {
            popupMenu.type = YBPopupMenuTypeDark;
            popupMenu.delegate = weakSelf;
        }];
    };

    // 我的
    [self.customNavBar wr_setRightTwoButtonWithImage:[UIImage imageNamed:@"party_nav_minePublication"]];
    self.customNavBar.onClickRightTwoButton = ^{
        YWTPartyMemberAreaListController *areaListVC = [[YWTPartyMemberAreaListController alloc]init];
        areaListVC.listType = partyAreaListMineType;
        areaListVC.taskIdStr = weakSelf.taskIdStr;
        [weakSelf.navigationController pushViewController:areaListVC animated:YES];
    };
}
/* ------------ YBPopupMenuDelegate  ----------------*/
- (void)ybPopupMenu:(YBPopupMenu *)ybPopupMenu didSelectedAtIndex:(NSInteger)index{
    YWTPartyMemberAreaAddController *addVC = [[YWTPartyMemberAreaAddController alloc]init];
    addVC.taskIdStr = self.taskIdStr;
    if (index == 0) {
        addVC.areaType =  partyAreaPhotoType;
    }else{
        addVC.areaType =  partyAreaVideoType;
    }
    [self.navigationController pushViewController:addVC animated:YES];
}
#pragma mark --- 创建搜索view --------
-(void) createSearchView{
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.headerSearchView];
    self.headerSearchView.backgroundColor = [UIColor colorTextWhiteColor];
    self.headerSearchView.bgView.backgroundColor = [UIColor  colorLineCommonE9E9E9GreyBlackColor];
    self.headerSearchView.searchTextField.backgroundColor = [UIColor colorLineCommonE9E9E9GreyBlackColor];
    
    self.headerSearchView.searchBlock = ^(NSString * _Nonnull search) {
        weakSelf.searchStr = search;
        weakSelf.page = 1;
        [weakSelf requestComListLoadData];
    };
}
#pragma marm   -----  懒加载  ------
-(UITableView *)partyTableView{
    if (!_partyTableView) {
        _partyTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight+KSIphonScreenH(60), KScreenW, KScreenH-KSNaviTopHeight-KSIphonScreenH(60)-KSTabbarH)];
        _partyTableView.delegate = self;
        _partyTableView.dataSource = self;
        _partyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _partyTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        // 添加空白页
        [_partyTableView addSubview:self.showNoSoucreView];
        [_partyTableView registerClass:[YWTBaseParyMemberCell class] forCellReuseIdentifier:YWTBASEPARTYMEMBER_CELL];
        WS(weakSelf);
        [_partyTableView bindGlobalStyleForHeadRefreshHandler:^{
            weakSelf.page = 1;
            [weakSelf requestComListLoadData];
        }];
        [_partyTableView bindGlobalStyleForFootRefreshHandler:^{
            weakSelf.page ++;
            [weakSelf requestComListLoadData];
        }];
    }
    return _partyTableView;
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
-(void)setModuleNameStr:(NSString *)moduleNameStr{
    _moduleNameStr = moduleNameStr;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(void)setTaskIdStr:(NSString *)taskIdStr{
    _taskIdStr = taskIdStr;
}
#pragma mark --- 数据相关 ------
-(void) requestComListLoadData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] =  [YWTTools getNewToken];
    param[@"keyword"] =self.searchStr;
    param[@"page"] = [NSNumber numberWithInteger:self.page];
    param[@"pagesize"] =@"20";
    if (self.listType == partyAreaListMineType) {
        param[@"mine"] =@"my";
    }
    [[KRMainNetTool sharedKRMainNetTool]postRequstWith:HTTP_ATTSERICEAPICOMMUNITYCOMLIST_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        [self.partyTableView.headRefreshControl endRefreshing];
        [self.partyTableView.footRefreshControl endRefreshing];
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
        NSArray *arr = (NSArray*)showdata;
        for (NSDictionary *dict in arr) {
            YWTPartyEemberAreaModel *model = [YWTPartyEemberAreaModel yy_modelWithDictionary:dict];
            [self.dataArr addObject:model];
        }
        
        if (self.dataArr.count == 0) {
            self.showNoSoucreView.hidden = NO;
        }else{
            self.showNoSoucreView.hidden = YES;
        }
        [self.partyTableView reloadData];
    }];
}

#pragma mark --- 点赞/取消点赞 -----
-(void) requestGiveLikeLoadCell:(YWTBaseParyMemberCell*)cell{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"id"] = cell.model.Id;
    if ([cell.model.give isEqualToString:@"1"]) {
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
        YWTPartyEemberAreaModel *model = cell.model;
        if ([model.give isEqualToString:@"1"]) {
            // 取消点赞
            model.give = @"2";
            NSInteger clickNum = [model.clickNum integerValue];
            clickNum --;
            model.clickNum = [NSString stringWithFormat:@"%ld",(long)clickNum];
        }else{
            model.give = @"1";
            NSInteger clickNum = [model.clickNum integerValue];
            clickNum ++;
            model.clickNum = [NSString stringWithFormat:@"%ld",(long)clickNum];
        }
        // 刷新
        [self.dataArr replaceObjectAtIndex:cell.tag withObject:model];
        NSIndexPath * indexPath = [self.partyTableView indexPathForCell:cell];
        [UIView performWithoutAnimation:^{
            [self.partyTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }];
}





@end
