//
//  BaseShowListController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/23.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTBaseShowListController.h"

#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "YWTAnnexLookOverJSController.h"
#import "BaseShowListModel.h"

#import "YWTExamPaperListSiftView.h"
#import "YWTBaseHeaderSearchView.h"
#import "YWTShowNoSourceView.h"
#import "STTagFrame.h"

#import "YWTShowListTypeTableViewCell.h"
#define SHOWLISTTYPETABLEIVEW_CELL @"YWTShowListTypeTableViewCell"


@interface YWTBaseShowListController ()
<
UITableViewDelegate,
UITableViewDataSource,
ExamPaperListSiftViewDelegate
>
// 头部搜索view
@property (nonatomic,strong) YWTBaseHeaderSearchView  *headerSearchView;
// 筛选view
@property (nonatomic,strong) YWTExamPaperListSiftView *listSiftView;
// 空白页
@property (nonatomic,strong) YWTShowNoSourceView *showNoSoucreView;

@property (nonatomic,strong) UITableView *listTableView;

@property (nonatomic,strong) NSMutableArray *dataArr;
// 页面
@property (nonatomic,assign) NSInteger page;

// 筛选id
@property (nonatomic,strong) NSString *tagldsStr;
@end

@implementation YWTBaseShowListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [self setNavi];
    self.page = 1;
    self.titleStr = @"";
    self.tagldsStr = @"";
    //创建搜索view
    [self createSearchView];
    //创建TableView
    [self createTableView];
    // 请求数据
    [self requestContentCenterGetList];
}
#pragma mark --- 创建搜索view --------
-(void) createSearchView{
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.headerSearchView];
    self.headerSearchView.searchTextField.placeholder = @"请输入标题/内容搜索";
    self.headerSearchView.isExamCenterRcord = YES;
    if (![self.titleStr isEqualToString:@""]) {
        [UIView animateWithDuration:0.25 animations:^{
            // 更新约束
            [weakSelf.headerSearchView.searchImageV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.headerSearchView.bgView).offset((KScreenW-24)/5);
            }];
        }];
    }
  
    self.headerSearchView.searchBlock = ^(NSString * _Nonnull search) {
        weakSelf.tagldsStr = @"";
        weakSelf.titleStr = search;
        weakSelf.page = 1;
        [weakSelf requestContentCenterGetList];
    };
}
#pragma mark --- 创建TableView --------
-(void) createTableView{
    self.listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KSIphonScreenH(60)+KSNaviTopHeight, KScreenW, KScreenH - KSIphonScreenH(60) -KSTabbarH-KSNaviTopHeight)];
    [self.view addSubview:self.listTableView];
    self.listTableView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.listTableView registerClass:[YWTShowListTypeTableViewCell class] forCellReuseIdentifier:SHOWLISTTYPETABLEIVEW_CELL];
    
    // 添加空白页
    [self.listTableView addSubview:self.showNoSoucreView];
    
    if (@available(iOS 11.0, *)) {
        self.listTableView.estimatedRowHeight = 0;
        self.listTableView.estimatedSectionFooterHeight = 0;
        self.listTableView.estimatedSectionHeaderHeight = 0 ;
        self.listTableView.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    __weak typeof(self) weakSelf = self;
    // 刷新
    [self.listTableView bindGlobalStyleForHeadRefreshHandler:^{
        weakSelf.page = 1;
        [weakSelf requestContentCenterGetList];
    }];
    
    [self.listTableView bindGlobalStyleForFootRefreshHandler:^{
        weakSelf.page ++;
        [weakSelf requestContentCenterGetList];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWTShowListTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SHOWLISTTYPETABLEIVEW_CELL forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BaseShowListModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    __weak typeof(self) weakSelf = self;
    // 选中附件
    cell.selectAnnex = ^(NSDictionary * _Nonnull annexDict) {
        // 判断
        NSString *typeStr = [NSString stringWithFormat:@"%@",annexDict[@"type"]];
        if ([typeStr isEqualToString:@"video"] || [typeStr isEqualToString:@"audio"]
            || [typeStr isEqualToString:@"images"] ){
            // 视频 音频 图片
            [weakSelf createOpenAnnexDict:annexDict];
        }else {
            NSString *sizeStr = [NSString stringWithFormat:@"%@",annexDict[@"size"]];
            if ([YWTTools getWithFileSizePass5MFileNameStr:sizeStr]) {
                [weakSelf showOpenFilePrmptViewDict:annexDict];
            }else{
                [weakSelf createOpenAnnexDict:annexDict];
            }
        }
    };
    //
    cell.selectMoreBtn = ^(BaseShowListModel *heightModel) {
        // 贴换数据源
        [weakSelf.dataArr replaceObjectAtIndex:indexPath.row withObject:heightModel];
        // 刷新某一行
        [weakSelf.listTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseShowListModel *model = self.dataArr[indexPath.row];
    NSArray *arr = model.enclosure;
    if (arr.count == 0) {
        return [self getTypeCellHeader:model];
    }else{
        // 判断是否展开
        if (model.isExqand) {
            return model.cellHeight;
        }else{
             return [self getTypeCellHeader:model];
        }
    }
}
// 计算高度
-(CGFloat) getTypeCellHeader:(BaseShowListModel *)model{
    CGFloat heiht = KSIphonScreenH(17);
    // 标题
    NSString *titleStr = [NSString stringWithFormat:@"%@",model.title];
    CGFloat titleHight = [YWTTools getSpaceLabelHeight:titleStr withFont:18 withWidth:KScreenW-KSIphonScreenW(40) withSpace:3];
    heiht += titleHight;
    
    NSArray *tagArr = model.tag;
    if (tagArr.count == 0) {
        NSString *markStr = [NSString stringWithFormat:@"%@",model.content];
        if (![markStr isEqualToString:@""]) {
            CGFloat  markHight = [YWTTools getSpaceLabelHeight:markStr withFont:13 withWidth:KScreenW-KSIphonScreenW(54) withSpace:3];
            heiht += markHight;
        }
        heiht += KSIphonScreenH(45);
        
        if (model.enclosure.count == 0) {
            // 如果没有附件
            // 添加 更多按钮的高度
            heiht += KSIphonScreenH(40);
            return heiht;
        }
        // 添加只显示一个cell 高度
        heiht += KSIphonScreenH(110);
        
        return heiht;
    }
    
    STTagFrame * tagFrame = [STTagFrame tagFrameWithContentInsets:UIEdgeInsetsMake(0, 0, 0, 0) labelContentInsets:UIEdgeInsetsMake(2, 6, 2, 6) horizontalSpacing:10 verticalSpacing:10 textFont:[UIFont systemFontOfSize:12] tagArray:tagArr];
    tagFrame.width = KScreenW-KSIphonScreenW(54) ;
    tagFrame.tagsArray = tagArr.mutableCopy;
    heiht += tagFrame.height;
    
    heiht += KSIphonScreenH(33);
    // 说明
    NSString *markStr = [NSString stringWithFormat:@"%@",model.content];
    if (![markStr isEqualToString:@""]) {
        CGFloat  markHight = [YWTTools getSpaceLabelHeight:markStr withFont:13 withWidth:KScreenW-KSIphonScreenW(54) withSpace:3];
        heiht += markHight;
    }
    heiht += KSIphonScreenH(40);
    
    if (model.enclosure.count == 0) {
      
        return heiht;
    }
    // 添加只显示一个cell 高度
    heiht += KSIphonScreenH(95);
    
    return heiht;
}
#pragma mark --- 条件筛选--------
-(void) selectSubmitBtnTagIdStr:(NSString *)tagIdStr{
    // 点击筛选按钮
    [self clickSiftBtn];
    // 判断是否要显示筛选红点
    if ([tagIdStr isEqualToString:@""]) {
        [self.customNavBar.rightButton setImage:[UIImage imageChangeName:@"nav_ico_sift"] forState:UIControlStateNormal];
    }else{
        NSArray *arr = [tagIdStr componentsSeparatedByString:@","];
        BOOL isSelectSift = NO;
        for (NSString *tagStr in arr) {
            if (![tagStr isEqualToString:@"0"]) {
                isSelectSift = YES;
            }
        }
        if (isSelectSift) {
            [self.customNavBar.rightButton setImage:[UIImage imageChangeName:@"nav_ico_sift_select"] forState:UIControlStateNormal];
        }else{
            [self.customNavBar.rightButton setImage:[UIImage imageChangeName:@"nav_ico_sift"] forState:UIControlStateNormal];
        }
    }
    self.tagldsStr = tagIdStr;
    self.titleStr = @"";
    self.page = 1;
    [self requestContentCenterGetList];
}
#pragma mark ------ 打开附件 -------
-(void) createOpenAnnexDict:(NSDictionary *)dict{
    NSString *typeStr = [NSString stringWithFormat:@"%@",dict[@"type"]];
    if ([typeStr isEqualToString:@"images"]) {
        // 图片
        [self createCheckPhoto:dict];
    }else if ([typeStr isEqualToString:@"video"]){
        // 视频
        [self createVodpalyView:dict];
    }else if ([typeStr isEqualToString:@"audio"]){
        // 音频
        NSString *urlStr =[NSString stringWithFormat:@"%@",dict[@"url"]];
        [self createAudioPlay:urlStr];
    }else if ([typeStr isEqualToString:@"pdf"]){
        // pdf
        YWTAnnexLookOverJSController * jsVC = [[YWTAnnexLookOverJSController alloc]init];
        NSString  *midStr = [NSString stringWithFormat:@"%@",dict[@"id"]];
        jsVC.mIdStr = midStr;
        jsVC.fileNameStr = [NSString stringWithFormat:@"%@",dict[@"name"]];
        jsVC.fileType = @"1";
        [self.navigationController pushViewController:jsVC animated:YES];
    }else if ([typeStr isEqualToString:@"doc"]){
        // doc
        YWTAnnexLookOverJSController * jsVC = [[YWTAnnexLookOverJSController alloc]init];
        NSString  *midStr = [NSString stringWithFormat:@"%@",dict[@"id"]];
        jsVC.mIdStr = midStr;
        jsVC.fileNameStr = [NSString stringWithFormat:@"%@",dict[@"name"]];
        jsVC.fileType = @"1";
        [self.navigationController pushViewController:jsVC animated:YES];
    }else if ([typeStr isEqualToString:@"ppt"]){
        // ppt
        YWTAnnexLookOverJSController * jsVC = [[YWTAnnexLookOverJSController alloc]init];
        NSString  *midStr = [NSString stringWithFormat:@"%@",dict[@"id"]];
        jsVC.mIdStr = midStr;
        jsVC.fileNameStr = [NSString stringWithFormat:@"%@",dict[@"name"]];
        jsVC.fileType = @"1";
        [self.navigationController pushViewController:jsVC animated:YES];
    }else if ([typeStr isEqualToString:@"xls"]){
        // xls
        YWTAnnexLookOverJSController * jsVC = [[YWTAnnexLookOverJSController alloc]init];
        NSString  *midStr = [NSString stringWithFormat:@"%@",dict[@"id"]];
        jsVC.mIdStr = midStr;
        jsVC.fileNameStr = [NSString stringWithFormat:@"%@",dict[@"name"]];
        jsVC.fileType = @"1";
        [self.navigationController pushViewController:jsVC animated:YES];
    }else{
        // 其他
        [self.view showErrorWithTitle:@"无法打开" autoCloseTime:0.5];
    }
}
#pragma mark ---创建查看图片view --------
-(void)createCheckPhoto:(NSDictionary *) dict{
    NSMutableArray *items = [NSMutableArray array];
    UIImageView *imageView = [[UIImageView alloc]init];
    NSString *urlStr = [NSString stringWithFormat:@"%@",dict[@"url"]];
    NSURL *url = [NSURL URLWithString:urlStr];
    KSPhotoItem *item = [KSPhotoItem itemWithSourceView:imageView imageUrl:url];
    [items addObject:item];
    KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:items selectedIndex:0];
    [browser showFromViewController:self];
}
#pragma mark ---创建视频播放View --------
-(void) createVodpalyView:(NSDictionary *) dict{
    AVPlayerViewController *ctrl = [[AVPlayerViewController alloc] init];
    NSString *str =[NSString stringWithFormat:@"%@",dict[@"url"]];
    NSString *urlStr = [NSString byAddingAllCharactersStr:str];
    NSURL *url = [NSURL URLWithString:urlStr];
    ctrl.player = [[AVPlayer alloc]initWithURL:url];
    [self presentViewController:ctrl animated:YES completion:nil];
}
#pragma mark ---创建音频播放 --------
-(void) createAudioPlay:(NSString *) urlNameStr{
    YWTBaseVodPlayView *playView = [[YWTBaseVodPlayView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    playView.filePath= urlNameStr;
    [self.view addSubview:playView];
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    self.customNavBar.title =self.moduleNameStr;
    
    __weak typeof(self) weakSelf = self;
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
     __block  bool isCreateListSiftView = YES;
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageChangeName:@"nav_ico_sift"]];
    self.customNavBar.onClickRightButton = ^{
        if (isCreateListSiftView) {
            [weakSelf.view addSubview:weakSelf.listSiftView];
            if (self.listType == showControllerRiskListType) {
                weakSelf.listSiftView.siftType = showListSiftRiskDisplayType;
            }else{
                // 曝光台
                weakSelf.listSiftView.siftType = showListSiftExposureStationType;
            }
            weakSelf.listSiftView.delegate = weakSelf;
            isCreateListSiftView = NO;
        }else{
            [weakSelf clickSiftBtn];
        }
    };
}
// 点击筛选按钮
-(void)clickSiftBtn{
    __weak typeof(self) weakSelf= self;
    weakSelf.customNavBar.rightButton.selected = !weakSelf.customNavBar.rightButton.selected;
    if (weakSelf.customNavBar.rightButton.selected) {
        weakSelf.listSiftView.hidden = YES;
    }else{
        weakSelf.listSiftView.hidden = NO;
    }
}
// 文件超过w5M 提示
-(void) showOpenFilePrmptViewDict:(NSDictionary *)annexDict {
    __weak typeof(self) weakSelf = self;
    UIAlertController *alterView = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"文件大于5M 加载过程缓慢是否继续打开" preferredStyle:UIAlertControllerStyleAlert];
    
    [alterView addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [alterView addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf createOpenAnnexDict:annexDict];
    }]];
    [self presentViewController:alterView animated:YES completion:nil];
}
#pragma  mark  ---懒加载 -----
-(YWTShowNoSourceView *)showNoSoucreView{
    if (!_showNoSoucreView) {
        _showNoSoucreView = [[YWTShowNoSourceView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSNaviTopHeight-KSIphonScreenH(60)-KSTabbarH)];
        _showNoSoucreView.showMarkLab.text = @"暂无数据";
    }
    return _showNoSoucreView;
}
-(YWTBaseHeaderSearchView *)headerSearchView{
    if (!_headerSearchView) {
        _headerSearchView = [[YWTBaseHeaderSearchView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KSIphonScreenH(60))];
    }
    return _headerSearchView;
}
-(YWTExamPaperListSiftView *)listSiftView{
    if (!_listSiftView) {
        _listSiftView = [[YWTExamPaperListSiftView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KScreenH-KSNaviTopHeight)];
    }
    return _listSiftView;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(void)setListType:(showControllerListType)listType{
    _listType = listType;
}
-(void)setModuleNameStr:(NSString *)moduleNameStr{
    _moduleNameStr = moduleNameStr;
}

#pragma  mark  ---数据相关 -----
-(void) requestContentCenterGetList{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"platformCode"] = [YWTUserInfo obtainWithLoginPlatformCode];
    if (self.listType == showControllerExposureListType) {
        // 曝光台
        param[@"type"] = @"2";
    }else{
        // 风险展示
        param[@"type"] = @"1";
    }
    param[@"tagIds"] =self.tagldsStr;
    param[@"keyword"] = self.titleStr;
    param[@"page"] = [NSNumber numberWithInteger:self.page];
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPCONTENTCENTERGETLISTS_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        // 结束刷新控件
        [self.listTableView.headRefreshControl endRefreshing];
        [self.listTableView.footRefreshControl endRefreshing];
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
        NSArray *arr = (NSArray *)showdata;
        for (NSDictionary *dict in arr) {
            BaseShowListModel *model = [BaseShowListModel yy_modelWithDictionary:dict];
            [self.dataArr addObject:model];
        }
        if (self.dataArr.count > 0) {
            self.showNoSoucreView.hidden = YES;
        }else{
            self.showNoSoucreView.hidden = NO;
        }
        [self.listTableView reloadData];
    }];

}




@end
