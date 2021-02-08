//
//  YWTQuestResultController.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/17.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTQuestResultController.h"

#import "YWTQuestResultImageCell.h"
#define YWTQUESTRESULTIMAGE_CELL @"YWTQuestResultImageCell"
#import "YWTQuestResultContentCell.h"
#define YWTQUESTRESULTCONTENT_CELL @"YWTQuestResultContentCell"
#import "YWTExamScoreUnpubilshBtnCell.h"
#define EXAMSCOREUNPUBILSHBTN_CELL @"YWTExamScoreUnpubilshBtnCell"

@interface YWTQuestResultController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic,strong) UITableView *resultTableView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation YWTQuestResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [self setNavi];
    //
    [self.view insertSubview:self.resultTableView atIndex:0];
    // 在需要侧滑到指定控制器的控制器的
    [self removeView];
    // 请求数据
    [self requestResultData];
}
#pragma mark --- UITableViewDataSource --------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        YWTQuestResultImageCell *cell = [tableView dequeueReusableCellWithIdentifier:YWTQUESTRESULTIMAGE_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 1){
        YWTQuestResultContentCell *cell = [tableView dequeueReusableCellWithIdentifier:YWTQUESTRESULTCONTENT_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        YWTExamScoreUnpubilshBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:EXAMSCOREUNPUBILSHBTN_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        // 返回首页
        __weak typeof(self) weakSelf = self;
        cell.backHomeBlock = ^{
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        };
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return KSIphonScreenH(KSNaviTopHeight+KSIphonScreenH(191));
    }else if (indexPath.row == 1){
        return KSIphonScreenH(222);
    }else{
        return KSIphonScreenH(100);
    }
}
#pragma mark --- 左滑拦截 --------
-(void) removeView{
    //在需要侧滑到指定控制器的控制器的 view 加载完毕后偷偷将当前控制器与目标控制器之间的所有控制器出栈
    //1 获取当行控制器所有子控制器
    NSMutableArray <UIViewController *>* tmp = self.navigationController.viewControllers.mutableCopy;
    //2 获取目标控制器索引
    UIViewController * targetVC = nil;
    for (NSInteger i = 0 ; i < tmp.count; i++) {
        UIViewController * vc = tmp[i];
        if ([vc isKindOfClass:NSClassFromString(@"YWTQuestionnaireListController")]){
            targetVC = vc;
            // 也可在此直接获取 i 的数值
            break;
        }
    }
    NSInteger index = [tmp indexOfObject:targetVC];
    // 3. 移除目标控制器与当前控制器之间的所有控制器
    NSRange  range = NSMakeRange(index + 1, tmp.count - 1 - (index + 1));
    
    [tmp removeObjectsInRange:range];
    // 4. 重新赋值给导航控制器
    self.navigationController.viewControllers = [tmp copy];
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:0];
    
    self.customNavBar.title = @"问卷调查";
    
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    __weak typeof(self) weakSelf = self;
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popToViewController:[weakSelf.navigationController.viewControllers objectAtIndex:weakSelf.navigationController.viewControllers.count-3] animated:YES];
    };
}
-(UITableView *)resultTableView{
    if (!_resultTableView) {
        _resultTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH)];
        _resultTableView.dataSource = self;
        _resultTableView.delegate = self;
        _resultTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _resultTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        [_resultTableView registerClass:[YWTQuestResultImageCell class] forCellReuseIdentifier:YWTQUESTRESULTIMAGE_CELL];
        [_resultTableView registerClass:[YWTQuestResultContentCell class] forCellReuseIdentifier:YWTQUESTRESULTCONTENT_CELL];
         [_resultTableView registerClass:[YWTExamScoreUnpubilshBtnCell class] forCellReuseIdentifier:EXAMSCOREUNPUBILSHBTN_CELL];
        if (@available(iOS 11.0, *)) {
            _resultTableView.estimatedRowHeight = 0;
            _resultTableView.estimatedSectionFooterHeight = 0;
            _resultTableView.estimatedSectionHeaderHeight = 0 ;
            _resultTableView.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _resultTableView;
}
-(void)setIdStr:(NSString *)idStr{
    _idStr = idStr;
}
#pragma mark ----- 数据相关 ------
-(void)requestResultData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [YWTTools getNewToken];
    param[@"id"] = self.idStr;
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTSERICEAPISERVICEAPIRESEARCH_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if ([showdata isKindOfClass:[NSDictionary class]]) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
            YWTQuestResultContentCell *cell = [self.resultTableView cellForRowAtIndexPath:indexPath];
            [cell updateResultCellData:showdata];
        }
    }];
}




@end
