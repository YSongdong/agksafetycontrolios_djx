//
//  MyStudiesDetailController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/4/10.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTMyStudiesDetailController.h"

#import <WebKit/WebKit.h>

#import "YWTAnnexLookOverJSController.h"

#import "YWTDetailBottomToolView.h"
#import "YWTBaseZFPlayerView.h"
#import "YWTShowVerifyIdentidyErrorView.h"

#import "YWTVideoDetailTableViewCell.h"
#define VIDEODETAILTABLEVIEW_CELL @"YWTVideoDetailTableViewCell"
#import "YWTPhotoDetailTableViewCell.h"
#define PHOTODETAILTABLEVIEW_CELL @"YWTPhotoDetailTableViewCell"
#import "YWTFileMarkTableViewCell.h"
#define FILEMARKTABLEVIEW_CELL @"YWTFileMarkTableViewCell"


@interface YWTMyStudiesDetailController ()
<
UITableViewDelegate,
UITableViewDataSource,
WKUIDelegate
>{
    CGFloat webContentHeight;
}
// 底部工具view
@property (nonatomic,strong) YWTDetailBottomToolView *toolView;
// 视频播放view
@property (nonatomic,strong) YWTBaseZFPlayerView  *zFPlayerView;
// 验证失败view
@property (nonatomic,strong)YWTShowVerifyIdentidyErrorView *showVeriIndeErrorView;

@property (nonatomic,strong) UITableView *detaTableView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) NSMutableDictionary *dataDict;

@property (strong,nonatomic) WKWebView *wkWebView;

@property (strong,nonatomic) UIScrollView *wbScrollView;
// 记录当前人脸规则的数据源
@property (nonatomic,strong) NSDictionary *nowVeriDict;
// 记录 进入页面得时间【时间戳】
@property (nonatomic,assign) NSInteger startTimer;
// 只能使用一次
@property (nonatomic ,assign) BOOL isOne;
// 记录规则中随机次数数组
@property (nonatomic,strong) NSMutableArray *recordRandomArr;
// 记录音视频播放状态  YES 播放  NO  暂停  默认 NO
@property (nonatomic,assign) BOOL isPlayStatu;
@end

@implementation YWTMyStudiesDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 默认 
    self.isOne = YES;
    self.isPlayStatu = NO;
    // 设置导航栏
    [self setNavi];
    // 判断是否是文件
    if (self.detaType == showDetailViewFileType || self.detaType ==  showDetailViewPhotoType) {
         // 创建底部工具view
        [self createToolView];
    }else{
        [self createPlayerView];
    }
    // 添加TableView
    [self.view insertSubview:self.detaTableView atIndex:0];
    // 请求数据
    [self requestFileManageInfo];
}
#pragma mark --- UITableViewDelegate --------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        if (self.detaType ==  showDetailViewFileType || self.detaType ==  showDetailViewPhotoType) {
            // 图片
            YWTPhotoDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PHOTODETAILTABLEVIEW_CELL forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.dict = self.dataDict;
            return cell;
        }else{
            YWTVideoDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:VIDEODETAILTABLEVIEW_CELL forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.dict = self.dataDict;
            return cell;
        }
    }else{
        YWTFileMarkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FILEMARKTABLEVIEW_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSDictionary *dict = self.dataArr[indexPath.row];
        cell.dict = dict;
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        if (self.detaType ==  showDetailViewFileType  || self.detaType ==  showDetailViewPhotoType) {
            // 图片
            return [YWTPhotoDetailTableViewCell getWithHeightCell:self.dataDict];
        }else{
            return [YWTVideoDetailTableViewCell getWithHeightCell:self.dataDict];
        }
    }else{
       NSDictionary *dict = self.dataArr[indexPath.row];
       return [YWTFileMarkTableViewCell getWithFileMarkHeightCell:dict];
    }
}
#pragma mark --- 创建底部工具view --------
-(void) createToolView{
    [self.view addSubview:self.toolView];
    __weak typeof(self) weakSelf = self;
    self.toolView.selectLearnBtn = ^{
        NSString *typeStr = [NSString stringWithFormat:@"%@",weakSelf.dataDict[@"type"]];
        // 判断是否是图片
        if ([typeStr isEqualToString:@"images"]) {
            [weakSelf createCheckPhoto:weakSelf.dataDict];
            return ;
        }
        // 判断是否 文件
        if ([typeStr isEqualToString:@"pdf"] || [typeStr isEqualToString:@"doc"] ||
            [typeStr isEqualToString:@"ppt"] || [typeStr isEqualToString:@"xls"]) {
            
            // 判断size 大小  大于5M  提示
            NSString *sizeStr = [NSString stringWithFormat:@"%@",weakSelf.dataDict[@"size"]];
            if ([YWTTools getWithFileSizePass5MFileNameStr:sizeStr]) {
                [weakSelf showOpenFilePrmptView];
                return ;
            }
            
            // 判断是否找到人脸规则
            if (![weakSelf getByMonitorNameHaveFoundMonitorDict:@"start"]) {
                // 跳转到文件详情页面  （hl5）
                [weakSelf pushFileDetailViewController];
                return;
            }
            // 通过规则 调用人脸识别
            NSDictionary *faceDict = [weakSelf createFaveVerificationStr:@"start"];
            weakSelf.nowVeriDict = nil;
            weakSelf.nowVeriDict = faceDict;
            // 开始人脸认证
            [weakSelf passRulesConductFaceVeri:faceDict];
           
        }else{
            [weakSelf.view showErrorWithTitle:@"无法打开文件" autoCloseTime:0.5];
        }
    };
}
// 跳转到文件详情页面  （hl5）
-(void) pushFileDetailViewController{
    __weak typeof(self) weakSelf = self;
    NSString *typeStr = [NSString stringWithFormat:@"%@",weakSelf.dataDict[@"fileName"]];
    YWTAnnexLookOverJSController *annexLookVC = [[YWTAnnexLookOverJSController alloc]init];
    annexLookVC.mIdStr = [NSString stringWithFormat:@"%@",weakSelf.dataDict[@"id"]];
    annexLookVC.fileNameStr = typeStr;
    annexLookVC.monitorRulesArr = weakSelf.monitorRulesArr;
    annexLookVC.taskIdStr = self.taskIdStr;
    annexLookVC.fileType = @"2";
    [weakSelf.navigationController pushViewController:annexLookVC animated:YES];
}
// 文件超过w5M 提示
-(void) showOpenFilePrmptView {
    __weak typeof(self) weakSelf = self;
    UIAlertController *alterView = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"文件大于5M 加载过程缓慢是否继续打开" preferredStyle:UIAlertControllerStyleAlert];
    
    [alterView addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [alterView addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        // 判断是否找到人脸规则
        if (![weakSelf getByMonitorNameHaveFoundMonitorDict:@"start"]) {
            // 跳转到文件详情页面  （hl5）
            [weakSelf pushFileDetailViewController];
            return;
        }
        // 通过规则 调用人脸识别
        NSDictionary *faceDict = [weakSelf createFaveVerificationStr:@"start"];
        weakSelf.nowVeriDict = nil;
        weakSelf.nowVeriDict = faceDict;
        // 开始人脸认证
        [weakSelf passRulesConductFaceVeri:faceDict];
    }]];
    [self presentViewController:alterView animated:YES completion:nil];
}
#pragma mark ---创建查看图片view --------
-(void)createCheckPhoto:(NSDictionary *) dict{
    NSMutableArray *items = [NSMutableArray array];
    UIImageView *imageView = [[UIImageView alloc]init];
    NSString *urlStr = [NSString stringWithFormat:@"%@",dict[@"fileUrl"]];
    NSURL *url = [NSURL URLWithString:urlStr];
    KSPhotoItem *item = [KSPhotoItem itemWithSourceView:imageView imageUrl:url];
    [items addObject:item];
    KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:items selectedIndex:0];
    [browser showFromViewController:self];
}
#pragma mark - WKNavigationDelegate -------
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //这个方法也可以计算出webView滚动视图滚动的高度
    [webView evaluateJavaScript:@"document.body.scrollWidth"completionHandler:^(id _Nullable result,NSError * _Nullable error){
        [webView evaluateJavaScript:@"document.body.scrollHeight"completionHandler:^(id _Nullable result,NSError * _Nullable error){
            CGFloat newHeight = [result floatValue];
            
            [self resetWebViewFrameWithHeight:newHeight];
            
            if (newHeight < CGRectGetHeight(self.view.frame)) {
                //如果webView此时还不是满屏，就需要监听webView的变化  添加监听来动态监听内容视图的滚动区域大小
                [self.wbScrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
            }
        }];
    }];
}
#pragma mark  ----- KVO回调 -------
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    //更具内容的高重置webView视图的高度
    CGFloat newHeight = self.wbScrollView.contentSize.height;
    [self resetWebViewFrameWithHeight:newHeight];
}

-(void)resetWebViewFrameWithHeight:(CGFloat)height{
    //如果是新高度，那就重置
    if (height != webContentHeight) {
        [self.wkWebView setFrame:CGRectMake(0, 0, KScreenW, height)];
        [self.detaTableView reloadData];
        webContentHeight = height;
    }
}
#pragma mark ---- <UIScrollViewDelegate>----
//只要滚动了就会触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y > 130) {
        [UIView animateWithDuration:0.25 animations:^{
            [self.customNavBar wr_setBackgroundAlpha:1];
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            [self.customNavBar wr_setBackgroundAlpha:0];
        }];
    }
}
-(void)dealloc{
    // 移除KVO
    [self.wbScrollView removeObserver:self forKeyPath:@"contentSize"];
    // 判断是否是文件
    if (self.detaType == showDetailViewFileType) {
        return;
    }
    [self.zFPlayerView.player.currentPlayerManager pause];
    self.zFPlayerView.player = nil;
    [self.zFPlayerView removeFromSuperview];
}
#pragma mark --- 创建视频播放view --------
-(void) createPlayerView{
    _zFPlayerView = [[YWTBaseZFPlayerView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KSIphonScreenH(235))];
    if (self.detaType == showDetailViewAudioType) {
        _zFPlayerView.isShowCoverImageV = YES;
        _zFPlayerView.isVideoType = NO;
    }else if (self.detaType == showDetailViewVideoType){
        _zFPlayerView.isVideoType = YES;
    }
   
    [self.view addSubview:_zFPlayerView];
     __weak typeof(self) weakSelf = self;
    
    // 当封面上点击播放
    self.zFPlayerView.selecCoverPlayBtn = ^{
        // 记录 进入页面得时间【时间戳】
        weakSelf.startTimer = [YWTTools getNowTimestamp];
    };
    
    // 点击返回按钮
    self.zFPlayerView.selectBackBtn = ^{
        [weakSelf clickBackBtn];
    };
    
    // 当前播放时间进度回调
    self.zFPlayerView.videoPlayerCurrentTime = ^(NSDictionary *currentTimeDict) {
        
        // 判断是否找到人脸规则
        if (![weakSelf getByMonitorNameHaveFoundMonitorDict:@"random"]) {
            return;
        }
        
        // 初始化人脸随机验证
        if (!weakSelf.recordRandomArr) {
            weakSelf.recordRandomArr = [NSMutableArray array];
            // 总时间
            NSNumber *totalTime = currentTimeDict[@"totalTime"];
            // 获取规则字典
            NSDictionary *dict = [weakSelf createFaveVerificationStr:@"random"];
            for (int i=0; i< [dict[@"number"] integerValue]; i++) {
                [weakSelf.recordRandomArr addObject:[NSNumber numberWithInteger:arc4random()%[totalTime integerValue]]];
            }
        }
        // 当前播放时间
        NSNumber *currentTime = currentTimeDict[@"currentTime"];
        if ([weakSelf.recordRandomArr containsObject:currentTime]) {
            // 暂停播放
            [weakSelf.zFPlayerView.player.currentPlayerManager pause];
            
            weakSelf.isPlayStatu = YES;
            
            // 通过规则 调用人脸识别
            NSDictionary *faceDict = [weakSelf createFaveVerificationStr:@"random"];
            weakSelf.nowVeriDict = nil;
            weakSelf.nowVeriDict = faceDict;
            // 开始人脸认证
            [weakSelf passRulesConductFaceVeri:faceDict];
            // 从随机次数中移除识别过的随机数
            [weakSelf.recordRandomArr removeObject:currentTime];
        }
    };
}
-(BOOL)shouldAutorotate{
    return self.zFPlayerView.player.shouldAutorotate;
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    if (self.zFPlayerView.player.isFullScreen) {
        return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskPortrait;
}
#pragma mark --- 关于开启任务人脸识别模块--------
// 通过规则名称 判断是否能找到规则源  YES 能 NO  不能
-(BOOL) getByMonitorNameHaveFoundMonitorDict:(NSString *)nameStr{
    BOOL  isFound = NO;
    // 赋值
    self.monitorRules = self.monitorRulesArr;
    // 找到对应的规则数据源
    NSDictionary *dict = [self createFaveVerificationStr:nameStr];
    if (dict.count != 0) {
        isFound = YES;
    }
    return isFound;
}
// 人脸采集成功回调方法
-(void)returnFaceSuccessImage:(NSDictionary *)dict{
    // 调人脸对比接口
    [self requestMonitorFaceRecogintion:dict[@"faceSuccess"] andRuleStr:dict[@"rule"]];
}
// 超时
-(void)codeTimeOut{

    [self.zFPlayerView.player.currentPlayerManager pause];
    // 只执行一次
    self.isOne = YES;
    
    NSString *ruleStr = [NSString stringWithFormat:@"%@",self.nowVeriDict[@"rule"]];
    if ([ruleStr isEqualToString:@"random"]) {
        // 随机
        [self createShowVeriIndeErrorViewAndType:@"1"];
    }
}
// 关闭
-(void)closeViewControll{
 
    [self.zFPlayerView.player.currentPlayerManager pause];
    
    // 只执行一次
    self.isOne = YES;
    
    NSString *ruleStr = [NSString stringWithFormat:@"%@",self.nowVeriDict[@"rule"]];
    if ([ruleStr isEqualToString:@"random"]) {
        // 随机
        [self createShowVeriIndeErrorViewAndType:@"1"];
    }
}
#pragma mark --- 创建验证失败的view --------
-(void) createShowVeriIndeErrorViewAndType:(NSString *)typeStr{
    __weak typeof(self) weakSelf = self;
    self.showVeriIndeErrorView = [[YWTShowVerifyIdentidyErrorView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH) andType:typeStr];
    [self.view addSubview:self.showVeriIndeErrorView];
   
    NSString *ruleStr = [NSString stringWithFormat:@"%@",self.nowVeriDict[@"rule"]];
    if ([ruleStr isEqualToString:@"random"]) {
        // 点击其他区域不能取消view
        self.showVeriIndeErrorView.isColseBigBgView = YES;
    }else{
        // 点击其他区域不能取消view
        self.showVeriIndeErrorView.isColseBigBgView = NO;
    }
    // 再次验证
    self.showVeriIndeErrorView.againBtnBlock = ^{
        [weakSelf.showVeriIndeErrorView removeFromSuperview];
        // 重新调起人脸
        [weakSelf passRulesConductFaceVeri:weakSelf.nowVeriDict];
    };
    // 直接进入考试
    self.showVeriIndeErrorView.enterBtnBlcok = ^{
        [weakSelf.showVeriIndeErrorView removeFromSuperview];
    };
}
#pragma mark --- 系统回调 左滑返回拦截--------
- (void)willMoveToParentViewController:(UIViewController*)parent{
    [super willMoveToParentViewController:parent];
    __weak typeof(self) weakSelf = self;
    if (!parent) {
        //   音频 视频
        if (self.detaType == showDetailViewFileType) {
            return;
        }
        // 只能使用一次
        if (!self.isOne) {
            return;
        }
        if ([weakSelf.taskIdStr isEqualToString:@""]) {
            return;
        }
        // 判断是否找到人脸规则
        if (![weakSelf getByMonitorNameHaveFoundMonitorDict:@"end"]) {
            // 上报时间
            [weakSelf requestFileLeaRecordData];
            return;
        }
        if ([weakSelf getByMonitorNameHaveFoundMonitorDict:@"end"]) {
            // 通过规则 调用人脸识别
            NSDictionary *faceDict = [weakSelf createFaveVerificationStr:@"end"];
            weakSelf.nowVeriDict = nil;
            weakSelf.nowVeriDict = faceDict;
            // 开始人脸认证
            [weakSelf passRulesConductFaceVeri:faceDict];
        }
    }
}
- (void)didMoveToParentViewController:(UIViewController*)parent{
    [super didMoveToParentViewController:parent];
}

#pragma mark ---学习时间上报--------
-(void) requestFileLeaRecordData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"taskid"] = self.taskIdStr;
    param[@"fileName"] = [NSString stringWithFormat:@"%@",self.dataDict[@"fileName"]];
    param[@"id"] = [NSString stringWithFormat:@"%@",self.dataDict[@"id"]];
    param[@"startTime"] = [NSNumber numberWithInteger:self.startTimer];
    NSString *startTimeStr = [YWTTools timestampSwitchTime:self.startTimer andFormatter:@"YYYY-MM-dd HH:mm:s"];
    NSString *endTimeStr = [YWTTools timestampSwitchTime:[YWTTools getNowTimestamp] andFormatter:@"YYYY-MM-dd HH:mm:s"];
    NSTimeInterval  interval = [YWTTools pleaseInsertStarTime:startTimeStr andInsertEndTime:endTimeStr andFormatter:@"YYYY-MM-dd HH:mm:s"];
    param[@"taskTotalTime"] = [NSNumber numberWithInteger:interval];
    // 学习时间上报
    [self requestFileLeaRecordDict:param.copy];
}

#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:0];
    
    if (self.detaType == showDetailViewFileType ) {
        self.customNavBar.title = @"文件详情";
    }else if (self.detaType == showDetailViewAudioType) {
        self.customNavBar.title = @"音频详情";
    }else if (self.detaType == showDetailViewPhotoType) {
        self.customNavBar.title = @"文件详情";
    }else{
         self.customNavBar.title = @"视频详情";
    }
    __weak typeof(self) weakSelf = self;
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf clickBackBtn];
    };
}
// 点击返回按钮
-(void) clickBackBtn{
     __weak typeof(self) weakSelf = self;
    // 判断不是音频和视频 直接返回
    if (weakSelf.detaType == showDetailViewFileType) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
        return;
    }
   
    // 判断是否找到人脸规则
    if (![weakSelf getByMonitorNameHaveFoundMonitorDict:@"end"]) {
        // 返回
        [weakSelf.navigationController popViewControllerAnimated:YES];
        
        return;
    }
    // 记录当前播放状态
    if (weakSelf.zFPlayerView.player.currentPlayerManager.isPlaying) {
        weakSelf.isPlayStatu = YES;
    }else{
        weakSelf.isPlayStatu = NO;
    }
    
    // 通过规则 调用人脸识别
    NSDictionary *faceDict = [weakSelf createFaveVerificationStr:@"end"];
    weakSelf.nowVeriDict = nil;
    weakSelf.nowVeriDict = faceDict;
    // 开始人脸认证
    [weakSelf passRulesConductFaceVeri:faceDict];
    
}

#pragma mark --- get 方法 --------
-(void)setDetaType:(showDetailViewType)detaType{
    _detaType = detaType;
}
-(YWTDetailBottomToolView *)toolView{
    if (!_toolView) {
        _toolView = [[YWTDetailBottomToolView alloc]initWithFrame:CGRectMake(0, KScreenH-KSTabbarH-KSIphonScreenH(48), KScreenW, KSIphonScreenH(48))];
    }
    return _toolView;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(void)setIdStr:(NSString *)idStr{
    _idStr = idStr;
}
-(NSMutableDictionary *)dataDict{
    if (!_dataDict) {
        _dataDict = [NSMutableDictionary dictionary];
    }
    return _dataDict;
}

-(void)setMonitorRulesArr:(NSArray *)monitorRulesArr{
    _monitorRulesArr = monitorRulesArr;
}
-(void)setTaskIdStr:(NSString *)taskIdStr{
    _taskIdStr = taskIdStr;
}
-(NSDictionary *)nowVeriDict{
    if (!_nowVeriDict) {
        _nowVeriDict = [NSDictionary dictionary];
    }
    return _nowVeriDict;
}
-(UITableView *)detaTableView{
    if (!_detaTableView) {
        if (self.detaType == showDetailViewFileType || self.detaType ==  showDetailViewPhotoType) {
            _detaTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH)];
        }else{
            _detaTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KSIphonScreenH(235), KScreenW, KScreenH-KSIphonScreenH(235)-KSTabbarH)];
        }
        _detaTableView.delegate = self;
        _detaTableView.dataSource = self;
        _detaTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        [_detaTableView registerClass:[YWTVideoDetailTableViewCell class] forCellReuseIdentifier:VIDEODETAILTABLEVIEW_CELL];
        [_detaTableView registerClass:[YWTPhotoDetailTableViewCell class] forCellReuseIdentifier:PHOTODETAILTABLEVIEW_CELL];
        [_detaTableView registerClass:[YWTFileMarkTableViewCell class] forCellReuseIdentifier:FILEMARKTABLEVIEW_CELL];
        
        if (@available(iOS 11.0, *)) {
            self.detaTableView.estimatedRowHeight = 0;
            self.detaTableView.estimatedSectionFooterHeight = 0;
            self.detaTableView.estimatedSectionHeaderHeight = 0 ;
            self.detaTableView.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _detaTableView;
}
-(WKWebView *)wkWebView{
    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc]init];
        _wkWebView.UIDelegate = self;
        _wkWebView.backgroundColor = [UIColor colorTextWhiteColor];
        _wbScrollView = _wkWebView.scrollView;
        _wbScrollView.scrollEnabled = NO;
        _wbScrollView.bounces = NO;
    }
    return _wkWebView;
}

#pragma mark ----- 请求详情-----
-(void) requestFileManageInfo{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"id"] = self.idStr;
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPFILEMANAGEMENTGETINFO_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if ([showdata isKindOfClass:[NSDictionary class]]) {
            // 字典数据源
            [self.dataDict addEntriesFromDictionary:showdata];
            // 数组数据源
            [self.dataArr addObject:showdata];
            [self.dataArr addObject:showdata];
            //播放音视频
            if (self.detaType == showDetailViewAudioType || self.detaType == showDetailViewVideoType) {
                NSString *url = showdata[@"fileUrl"];
                NSString *encodedUrl = [NSString byAddingAllCharactersStr:url];
                self.zFPlayerView.playerUrl = encodedUrl;
                self.zFPlayerView.fileNameStr = [NSString stringWithFormat:@"%@",self.dataDict[@"fileName"]];
            }
            // 记录 进入页面得时间【时间戳】
            self.startTimer = [YWTTools getNowTimestamp];
            // 刷新
            [self.detaTableView reloadData];
        }
    }];
}

/**
 人脸识别对比
 @param faceImage 传入人脸获取图片
 @param ruleStr 人脸规则 的位置  【start开始前 random考试中随机 end交卷验证
 */
-(void) requestMonitorFaceRecogintion:(UIImage *)faceImage andRuleStr:(NSString *)ruleStr{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] = [YWTUserInfo obtainWithUserId];
    param[@"token"] = [YWTTools getNewToken];
    param[@"platformCode"] = [YWTUserInfo obtainWithLoginPlatformCode];
    param[@"examId"] = @"0";
    param[@"examRoomId"] = @"0";
    param[@"type"] = @"2";
    param[@"source"] = @"4";
    param[@"rule"] = ruleStr;
    param[@"terminal"] = [NSNumber numberWithInteger:1];
    //获取本地软件的版本号
    NSString *localVersion =  [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    param[@"appVersion"] = localVersion;
    // 手机系统版本
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    // 手机型号
    NSString *phoeModel = [YWTTools deviceModelName];
    NSString *systemVersionStr = [NSString stringWithFormat:@"%@-%@",phoeModel,phoneVersion];
    param[@"systemVersion"] = systemVersionStr;
    // 任务id
    param[@"taskId"] = self.taskIdStr;
    
    [[KRMainNetTool sharedKRMainNetTool] upLoadPhotoUrl:HTTP_ATTAPPMOITORAPIFACERECOGINTION_URL params:param photo:faceImage waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            // 只能使用一次
            self.isOne =  YES;
            
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if (![showdata isKindOfClass:[NSDictionary class]]) {
            return;
        }
        // 只能使用一次
        self.isOne =  NO;
        
        // 期间 人脸随机
        if ([ruleStr isEqualToString:@"random"]) {
            // 继续播放
            [self.zFPlayerView.player.currentPlayerManager play];
            return;
        }
        
        // 开始人脸
        if ([ruleStr isEqualToString:@"start"]) {
            // 判断不是音频和视频 直接返回
            if (self.detaType == showDetailViewFileType ) {
                // 跳转到文件详情页面  （hl5）
                [self pushFileDetailViewController];
                return;
            }
            return;
        }
        // 结束 人脸
        if ([ruleStr isEqualToString:@"end"]) {
            // 上报时间
            [self requestFileLeaRecordData];
            return;
        }
    }];
}
#pragma mark ------ 学习时间上报  ----
-(void) requestFileLeaRecordDict:(NSDictionary *)dict{
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPFILEMANAGEMENTLEARECORD_URL params:dict withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        // 返回上一页
        [self.navigationController popViewControllerAnimated:YES];
    
    }];
}


@end
