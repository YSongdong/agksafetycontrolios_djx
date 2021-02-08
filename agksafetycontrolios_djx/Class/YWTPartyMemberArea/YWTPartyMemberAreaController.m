//
//  YWTPartyMemberAreaController.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/4.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTPartyMemberAreaListController.h"
#import "YWTBaseHeaderSearchView.h"
#import "YBPopupMenu.h"

#import "YWTBaseParyMemberCell.h"
#define YWTBASEPARTYMEMBER_CELL @"YWTBaseParyMemberCell"

@interface YWTPartyMemberAreaListController ()
<
UITableViewDelegate,
UITableViewDataSource,
YBPopupMenuDelegate
>
// 头部搜索view
@property (nonatomic,strong) YWTBaseHeaderSearchView  *headerSearchView;
@property (nonatomic,strong) YBPopupMenu *popupMuenView;

@property (nonatomic,strong) UITableView *partyTableView;
// 搜索参数
@property (nonatomic,strong) NSString *searchStr;

@end

@implementation YWTPartyMemberAreaListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [self setNavi];
    // 搜索view
    [self createSearchView];
    // 创建 UITableView
    [self createTableView];
}
#pragma mark --- UITableViewDataSource --------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWTBaseParyMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:YWTBASEPARTYMEMBER_CELL forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
}

#pragma mark --- 创建 UITableView --------
-(void) createTableView{
    self.partyTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight+KSIphonScreenH(60), KScreenW, KScreenH-KSNaviTopHeight-KSIphonScreenH(60)-KSTabbarH)];
    [self.view addSubview:self.partyTableView];
    
    self.partyTableView.delegate = self;
    self.partyTableView.dataSource = self;
    self.partyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.partyTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    [self.partyTableView registerClass:[YWTBaseParyMemberCell class] forCellReuseIdentifier:YWTBASEPARTYMEMBER_CELL];
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    self.customNavBar.title = @"党员互动区";
    
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    __weak typeof(self) weakSelf = self;
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
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
        
    };
}
/* ------------ YBPopupMenuDelegate  ----------------*/
- (void)ybPopupMenu:(YBPopupMenu *)ybPopupMenu didSelectedAtIndex:(NSInteger)index{
    
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
    };
}

#pragma marm   -----  懒加载  ------
-(YWTBaseHeaderSearchView *)headerSearchView{
    if (!_headerSearchView) {
        _headerSearchView = [[YWTBaseHeaderSearchView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KSIphonScreenH(60))];
    }
    return _headerSearchView;
}


@end
