//
//  YWTSelectUnitController.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/16.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTSelectUnitController.h"
#import "YWTSelectUnitModel.h"
#import "YWTBaseHeaderSearchView.h"
#import "YWTSelectUnitHeaderView.h"
#import "YWTShowNoSourceView.h"

#import "YWTBaseSelectCell.h"
#define YWTBASESELECT_CELL @"YWTBaseSelectCell"

@interface YWTSelectUnitController ()
<
UITableViewDelegate,
UITableViewDataSource,
YWTBaseSelectCellDelegate
>
// 头部搜索view
@property (nonatomic,strong) YWTBaseHeaderSearchView  *headerSearchView;
//
@property (nonatomic,strong) YWTSelectUnitHeaderView *unitHeaderView;
// 空白页
@property (nonatomic,strong) YWTShowNoSourceView *showNoSoucreView;
@property (nonatomic,strong) UITableView *selectTableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
//@property (nonatomic,strong) NSMutableArray *titleArr;
// 选中
@property (nonatomic,strong) NSIndexPath *selectIndexPath;
// 搜索参数
@property (nonatomic,strong) NSString *searchStr;
// 上级id
@property (nonatomic,strong) NSString *parentIdStr;
// 页码
@property (nonatomic,assign) NSInteger page;

@end

@implementation YWTSelectUnitController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.parentIdStr = @"0";
    self.view.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    // 设置导航栏
    [self setNavi];
    // 创建搜索view
    [self createSearchView];
    if (self.selectType == SelectUnitType) {
        [self createUnitHeaderView];
    }
    //
    [self.view addSubview:self.selectTableView];
    // 请求数据
    [self requestLoadListData];
}
#pragma mark --- UITableViewDataSource --------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWTBaseSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:YWTBASESELECT_CELL forIndexPath:indexPath];
    cell.selectCellType = self.selectType;
    cell.indexPath = indexPath;
    cell.delegate = self;
    cell.model = self.dataArr[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectType == SelectUnitType) {
        return KSIphonScreenH(55);
    }else{
        return KSIphonScreenH(60);
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.selectType == SelectUnitType) {
        YWTSelectUnitModel *model = self.dataArr[indexPath.row];
        if ([model.end isEqualToString:@"2"]) {
            [self.view showErrorWithTitle:@"当前部门无下一级" autoCloseTime:0.5];
            return;
        }
        self.parentIdStr = model.Id;
        [self requestLoadListData];
    }
    
}

#pragma mark  ----  YWTBaseSelectCellDelegate- ---------
// 选中
-(void)selectBaseBtnIndexPath:(NSIndexPath*)indexPath isSelect:(BOOL)isSelect{
    if (self.selectIndexPath == nil) {
        YWTSelectUnitModel *model = self.dataArr[indexPath.row];
        model.isSelect = isSelect;
        // 贴换数据源
        [self.dataArr replaceObjectAtIndex:indexPath.row withObject:model];
        // 刷新UI
        [self.selectTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        self.selectIndexPath = indexPath;
    }else{
        // 以前 选中
        YWTSelectUnitModel *oldModel = self.dataArr[self.selectIndexPath.row];
        oldModel.isSelect = NO;
        // 贴换数据源
        [self.dataArr replaceObjectAtIndex:self.selectIndexPath.row withObject:oldModel];
        // 当前选中
        YWTSelectUnitModel *model = self.dataArr[indexPath.row];
        model.isSelect = isSelect;
        // 贴换数据源
        [self.dataArr replaceObjectAtIndex:indexPath.row withObject:model];
        // 刷新UI
        [self.selectTableView reloadRowsAtIndexPaths:@[indexPath,self.selectIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        self.selectIndexPath = indexPath;
    }
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    if (self.selectType == SelectUnitType) {
        self.customNavBar.title = @"选择单位";
    }else{
        self.customNavBar.title = @"选择人员";
    }
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    __weak typeof(self) weakSelf = self;
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    [self.customNavBar wr_setRightButtonWithTitle:@"确定" titleColor:[UIColor colorTextWhiteColor]];
    self.customNavBar.onClickRightButton = ^{
        YWTSelectUnitModel *model = weakSelf.dataArr[weakSelf.selectIndexPath.row];
        if (self.selectType == SelectUnitType) {
            // 单位
            if (weakSelf.selectIndexPath == nil) {
                [weakSelf.view showErrorWithTitle:@"请选择单位！" autoCloseTime:0.5];
                return ;
            }
            if ([weakSelf.delegate respondsToSelector:@selector(selectSelectUnitTargetIdStr:targetName:)]) {
                [weakSelf.delegate selectSelectUnitTargetIdStr:model.Id targetName:model.unitName];
            }
        }else{
            // 人员
            if (weakSelf.selectIndexPath == nil) {
                [weakSelf.view showErrorWithTitle:@"请选择人员！" autoCloseTime:0.5];
                return ;
            }
            if ([weakSelf.delegate respondsToSelector:@selector(selectSelectUnitTargetIdStr:targetName:)]) {
                [weakSelf.delegate selectSelectUnitTargetIdStr:model.userid targetName:model.realname];
            }
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}
#pragma mark --- 创建单位的头部视图--------
-(void) createUnitHeaderView{
    self.unitHeaderView = [[YWTSelectUnitHeaderView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight+KSIphonScreenH(60), KScreenW, 0)];
    [self.view addSubview:self.unitHeaderView];
    WS(weakSelf);
    self.unitHeaderView.selectUnit = ^(NSString *parentIdStr) {
        weakSelf.selectIndexPath = nil;
        weakSelf.page = 1;
        weakSelf.parentIdStr = parentIdStr;
        [weakSelf requestLoadListData];
    };
}
#pragma mark --- 创建搜索view --------
-(void) createSearchView{
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.headerSearchView];
    self.headerSearchView.searchTextField.placeholder = @"请输入单位名称进行搜索";
    self.headerSearchView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    self.headerSearchView.bgView.backgroundColor = [UIColor  colorTextWhiteColor];
    self.headerSearchView.searchTextField.backgroundColor = [UIColor colorTextWhiteColor];
    self.headerSearchView.isExamCenterRcord = YES;
    self.headerSearchView.searchBlock = ^(NSString * _Nonnull search) {
        weakSelf.searchStr = search;
        weakSelf.page = 1 ;
        [weakSelf requestLoadListData];
    };
}
#pragma mark --- get --------
-(UITableView *)selectTableView{
    if (!_selectTableView) {
        _selectTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight+KSIphonScreenH(60), KScreenW, KScreenH-KSNaviTopHeight-KSIphonScreenH(60)-KSTabbarH)];
        _selectTableView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
        _selectTableView.dataSource = self;
        _selectTableView.delegate = self;
        _selectTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _selectTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        [_selectTableView registerClass:[YWTBaseSelectCell class] forCellReuseIdentifier:YWTBASESELECT_CELL];
        self.showNoSoucreView =  [[YWTShowNoSourceView alloc]initWithFrame:_selectTableView.frame];
        [_selectTableView addSubview:self.showNoSoucreView];
        WS(weakSelf);
        // 刷新
        [_selectTableView bindGlobalStyleForHeadRefreshHandler:^{
            weakSelf.page = 1;
            [weakSelf requestLoadListData];
        }];
        [_selectTableView bindGlobalStyleForFootRefreshHandler:^{
            weakSelf.page ++;
            [weakSelf requestLoadListData];
        }];
    }
    return _selectTableView;
}
-(YWTBaseHeaderSearchView *)headerSearchView{
    if (!_headerSearchView) {
        _headerSearchView = [[YWTBaseHeaderSearchView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KSIphonScreenH(60))];
    }
    return _headerSearchView;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(void)setSelectType:(SelectType)selectType{
    _selectType = selectType;
}

#pragma mark ----- 数据相关 ------
-(void) requestLoadListData{
    NSString *url ;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] =  [YWTTools getNewToken];
    param[@"keyword"]  = self.searchStr;
    param[@"page"] = [NSNumber numberWithInteger:self.page];
    if (self.selectType == SelectUnitType) {
        // 单位
        url = HTTP_ATTSERICEAPISUGGESTIONBOXUNITLIST_URL;
        param[@"parentid"] = self.parentIdStr;
    }else{
        // 人员
        url = HTTP_ATTSERICEAPISUGGESTIONBOXMEMBERLIST_URL;
    }
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:url params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        [self.selectTableView.footRefreshControl endRefreshing];
        [self.selectTableView.headRefreshControl endRefreshing];
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if (self.selectType ==  SelectUnitType ) {
            // 单位
            if (![showdata isKindOfClass:[NSDictionary class]]) {
                [self.view showErrorWithTitle:@"数据报错!" autoCloseTime:0.5];
                return;
            }
            if (self.page == 1) {
                [self.dataArr removeAllObjects];
            }
            NSArray *childArr = showdata[@"child"];
            for (NSDictionary *dict in childArr) {
                YWTSelectUnitModel *model = [YWTSelectUnitModel yy_modelWithDictionary:dict];
                [self.dataArr addObject:model];
            }
            NSArray *titleArr = showdata[@"title"];
            //更新单位的头部视图
            CGFloat titleHeight = [YWTSelectUnitHeaderView getSelectUnitHeaderViewHgith:titleArr];
            WS(weakSelf);
            [self.unitHeaderView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.view).offset(KSNaviTopHeight+KSIphonScreenH(60));
                make.left.right.equalTo(weakSelf.view);
                make.height.equalTo(@(titleHeight));
            }];
            self.unitHeaderView.titleArr = titleArr;
            
            // 更新TableVIew
            CGFloat height = KSNaviTopHeight+KSIphonScreenH(60)+titleHeight;
            [self.selectTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.view).offset(height);
                make.left.right.equalTo(weakSelf.view);
                make.bottom.equalTo(weakSelf.view).offset(-KSTabbarH);
            }];
            // 更新空白页
            [self.showNoSoucreView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.view).offset(height);
                make.left.right.equalTo(weakSelf.view);
                make.bottom.equalTo(weakSelf.view).offset(-KSTabbarH);
            }];
            
        }else{
            // 人员
            if (![showdata isKindOfClass:[NSArray class]]) {
                [self.view showErrorWithTitle:@"数据报错!" autoCloseTime:0.5];
                return;
            }
            if (self.page == 1) {
                [self.dataArr removeAllObjects];
            }
            NSArray *arr = (NSArray*)showdata;
            for (NSDictionary *dict in arr) {
                YWTSelectUnitModel *model = [YWTSelectUnitModel yy_modelWithDictionary:dict];
                [self.dataArr addObject:model];
            }
        }
        if (self.dataArr.count > 0) {
            self.showNoSoucreView.hidden = YES;
        }else{
            self.showNoSoucreView.hidden = NO;
        }
        [self.selectTableView reloadData];
    }];
}





@end
