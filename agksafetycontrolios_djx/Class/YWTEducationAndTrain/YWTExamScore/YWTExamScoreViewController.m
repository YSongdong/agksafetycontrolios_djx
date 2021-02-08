//
//  ExamScoreViewController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/21.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTExamScoreViewController.h"

typedef enum {
    showExamScoreResultNomalStatu = 0, // 正常显示
    showExamScoreResultUnNomalStatu,   // 不显示
}showExamScoreResultStatu;

#import "YWTExamQuestionController.h"
#import "YWTExamPaperDetailController.h"
#import "YWTExamPaperExerciseController.h"


#import "YWTExamPaperScoreTableViewCell.h"
#define EXAMPAPERSCORETABLEVIEW_CELL @"YWTExamPaperScoreTableViewCell"

#import "YWTExamScoreBaseTableViewCell.h"
#define EXAMSCOREBSAETABLEVIEW_CELL @"YWTExamScoreBaseTableViewCell"

#import "YWTExamScoreUnpublishTableViewCell.h"
#define EXAMSCOREUNPUBLISHTABLEVIEW_CELL @"YWTExamScoreUnpublishTableViewCell"
#import "YWTExamScoreUnpubilshContentCell.h"
#define EXAMSCOREUNPUBLISHCONTEENT_CELL @"YWTExamScoreUnpubilshContentCell"
#import "YWTExamScoreUnpubilshBtnCell.h"
#define EXAMSCOREUNPUBILSHBTN_CELL @"YWTExamScoreUnpubilshBtnCell"

@interface YWTExamScoreViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
// 显示成绩结果状态
@property (nonatomic,assign) showExamScoreResultStatu examResultStatu;

@property (nonatomic,strong) UITableView *scoreTableView;

@property (nonatomic,strong) NSMutableArray *dataArr;


@end

@implementation YWTExamScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [self setNavi];
    // 创建TableView-
    [self createTableView];
    // 请求数据结果
    [self requestExamResultData];
}
#pragma mark --- 创建TableView--------
-(void) createTableView{
    self.view.backgroundColor = [UIColor colorTextWhiteColor];
    
    self.scoreTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH)];
    [self.view insertSubview:self.scoreTableView atIndex:0];
    
    self.scoreTableView.dataSource = self;
    self.scoreTableView.delegate = self;
    self.scoreTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.scoreTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
//    self.scoreTableView.tableHeaderView = self.examScoreHeaderView;
    
    [self.scoreTableView registerClass:[YWTExamPaperScoreTableViewCell class] forCellReuseIdentifier:EXAMPAPERSCORETABLEVIEW_CELL];
    [self.scoreTableView registerClass:[YWTExamScoreBaseTableViewCell class] forCellReuseIdentifier:EXAMSCOREBSAETABLEVIEW_CELL];
    [self.scoreTableView registerClass:[YWTExamScoreUnpublishTableViewCell class] forCellReuseIdentifier:EXAMSCOREUNPUBLISHTABLEVIEW_CELL];
    [self.scoreTableView registerClass:[YWTExamScoreUnpubilshContentCell class] forCellReuseIdentifier:EXAMSCOREUNPUBLISHCONTEENT_CELL];
    [self.scoreTableView registerClass:[YWTExamScoreUnpubilshBtnCell class] forCellReuseIdentifier:EXAMSCOREUNPUBILSHBTN_CELL];
    
    if (@available(iOS 11.0, *)) {
        self.scoreTableView.estimatedRowHeight = 0;
        self.scoreTableView.estimatedSectionFooterHeight = 0;
        self.scoreTableView.estimatedSectionHeaderHeight = 0 ;
        self.scoreTableView.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.examResultStatu == showExamScoreResultNomalStatu) {
         return self.dataArr.count;
    }else{
        return self.dataArr.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.examResultStatu == showExamScoreResultNomalStatu) {
        if (indexPath.row == 0) {
            YWTExamPaperScoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EXAMPAPERSCORETABLEVIEW_CELL forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSDictionary *dict = self.dataArr[indexPath.row];
            cell.dict =dict;
            if (self.scoreType == showExamScoreExerType) {
                cell.cellScoreType = showCellExamScoreExerType;
            }else{
                cell.cellScoreType = showCellExamScoreExamPaperType;
            }
            __weak typeof(self) weakSelf = self;
            // 点击重新练习
            cell.selectAgainExamBlock = ^{
                YWTExamPaperExerciseController *exerciseVC = [[YWTExamPaperExerciseController alloc]init];
                exerciseVC.examType = showTableViewExamPaperType;
                exerciseVC.paperIdStr = [NSString stringWithFormat:@"%@",dict[@"paperId"]];
                exerciseVC.examIdStr =  [NSString stringWithFormat:@"%@",dict[@"examId"]];
                exerciseVC.examRoomIdStr =  [NSString stringWithFormat:@"%@",dict[@"examRoomId"]];
                exerciseVC.examBatchIdStr = [NSString stringWithFormat:@"%@",dict[@"examBatchId"]];
                exerciseVC.taskIdStr = weakSelf.taskIdStr;
                [weakSelf.navigationController pushViewController:exerciseVC animated:YES];
            };
            // 点击详情
            cell.detailBlock = ^{
                YWTExamPaperDetailController *examDetailVC = [[YWTExamPaperDetailController alloc]init];
                examDetailVC.examRecordIdStr = weakSelf.idStr;
                [weakSelf.navigationController pushViewController:examDetailVC animated:YES];
            };
            return cell;
        }else{
            YWTExamScoreBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EXAMSCOREBSAETABLEVIEW_CELL forIndexPath:indexPath];
            if (self.scoreType == showExamScoreExerType) {
                cell.cellType = showExamScoreCellExerType;
            }else{
                cell.cellType = showExamScoreCellExamPaperType;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            NSDictionary *dict = self.dataArr[indexPath.row];
            cell.dict =dict;
            return cell;
        }
    }else{
        if (indexPath.row == 0) {
            YWTExamScoreUnpublishTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EXAMSCOREUNPUBLISHTABLEVIEW_CELL forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
           
            return cell;
        }else if (indexPath.row ==1 ){
            YWTExamScoreUnpubilshContentCell *cell = [tableView dequeueReusableCellWithIdentifier:EXAMSCOREUNPUBLISHCONTEENT_CELL forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSDictionary *dict = self.dataArr[indexPath.row];
            cell.dict =dict;
            return cell;
        }else{
            YWTExamScoreUnpubilshBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:EXAMSCOREUNPUBILSHBTN_CELL forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            // 返回首页
            __weak typeof(self) weakSelf = self;
            cell.backHomeBlock = ^{
                weakSelf.navigationController.interactivePopGestureRecognizer.enabled = YES;
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            };
            return cell;
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.examResultStatu == showExamScoreResultNomalStatu) {
        if (indexPath.row == 0) {
            if (self.scoreType == showExamScoreExerType) {
                //练习
                return KSIphonScreenH(KSNaviTopHeight+KSIphonScreenH(340));
            }else{
                return KSIphonScreenH(KSNaviTopHeight+KSIphonScreenH(300));
            }
        }else{
            return KSIphonScreenH(65);
        }
    }else{
        if (indexPath.row == 0) {
            return KSIphonScreenH(KSNaviTopHeight+KSIphonScreenH(191));
        }else if (indexPath.row == 1){
            return KSIphonScreenH(180);
        }else{
            return KSIphonScreenH(100);
        }
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.scoreType == showExamScoreExerType) {
        // 取消选中状态
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        YWTExamPaperDetailController *exaPaperVC = [[YWTExamPaperDetailController alloc]init];
        exaPaperVC.examRecordIdStr = self.idStr;
        NSDictionary *dict = self.dataArr[indexPath.row];
        exaPaperVC.speciJumpQuestNumberStr = [NSString stringWithFormat:@"%@",dict[@"id"]];
        [self.navigationController pushViewController:exaPaperVC animated:YES];
    }
}

#pragma mark -----系统回调--------
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:0];
    
    __weak typeof(self) weakSelf = self;
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    self.customNavBar.onClickLeftButton = ^{
        weakSelf.navigationController.interactivePopGestureRecognizer.enabled = YES;
        [weakSelf.navigationController popToViewController:[weakSelf.navigationController.viewControllers objectAtIndex:2]animated:YES];
    };
    
    if (self.scoreType == showExamScoreExerType) {
         self.customNavBar.title = @"试卷练习";
    }else{
         self.customNavBar.title = @"考试中心";
    }

    //回到首页
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@""]];
    [self.customNavBar.rightButton  setTitle:@"回到首页" forState:UIControlStateNormal];
    [self.customNavBar.rightButton setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.customNavBar.rightButton.titleLabel.font = Font(16);
    self.customNavBar.rightButton.frame = CGRectMake(KScreenW - 80, KSStatusHeight, 70 , 44);
    [self.customNavBar setOnClickRightButton:^{
         weakSelf.navigationController.interactivePopGestureRecognizer.enabled = YES;
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    }];
}
#pragma mark --- get 方法 --------
-(void)setScoreType:(showExamScoreType)scoreType{
    _scoreType = scoreType;
}
-(void)setExamResultStatu:(showExamScoreResultStatu )examResultStatu{
    _examResultStatu = examResultStatu;
    if (examResultStatu == showExamScoreResultNomalStatu) {
        self.customNavBar.rightButton.hidden = NO;
    }else{
        self.customNavBar.rightButton.hidden = YES;
    }
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
-(void)setExamRoomIdStr:(NSString *)examRoomIdStr{
    _examRoomIdStr = examRoomIdStr;
}
-(void)setTaskIdStr:(NSString *)taskIdStr{
    _taskIdStr = taskIdStr;
}
#pragma mark --- 请求考试结果 --------
-(void) requestExamResultData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] =  [YWTTools getNewToken];
    param[@"examRoomId"] = self.examRoomIdStr;
    param[@"id"] = self.idStr;
    if (self.scoreType == showExamScoreExerType) {
        param[@"type"] = @"2";
        param[@"taskid"] = self.taskIdStr;
    }else{
        param[@"type"] = @"1";
    }
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPPAPEREXAMRESULTS_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:1];
            return ;
        }
        if (![showdata isKindOfClass:[NSDictionary class]]) {
            return;
        }
        if (self.scoreType == showExamScoreExerType) {
            // 组装成绩字典
            NSMutableDictionary *scoreDict = [NSMutableDictionary dictionary];
            scoreDict[@"isPass"] =showdata[@"isPass"];
            scoreDict[@"examTitle"] =showdata[@"examTitle"];
            scoreDict[@"score"] =showdata[@"score"];
            scoreDict[@"examUserTotalTime"] =showdata[@"examUserTotalTime"];
            scoreDict[@"percent"] =showdata[@"percent"];
            scoreDict[@"examRoomId"] =showdata[@"examRoomId"];
            scoreDict[@"examId"] =showdata[@"examId"];
            scoreDict[@"examBatchId"] =showdata[@"examBatchId"];
            scoreDict[@"paperId"] =showdata[@"paperId"];
            [self.dataArr addObject:scoreDict];
            
            // 组装题类型数据
            [self.dataArr addObjectsFromArray:showdata[@"list"]];
            
        }else{
            NSString *isPassStr = [NSString stringWithFormat:@"%@",showdata[@"isPass"]];
            if ([isPassStr isEqualToString:@"1"]) {
                // 不显示
                self.examResultStatu = showExamScoreResultUnNomalStatu;
                
                [self.dataArr addObject:showdata];
                // 组装成绩字典
                NSMutableDictionary *scoreDict = [NSMutableDictionary dictionary];
                scoreDict[@"examTitle"] =showdata[@"examTitle"];
                scoreDict[@"examUserTotalTime"] =showdata[@"examUserTotalTime"];
                scoreDict[@"score"] =showdata[@"score"];
            
                // 组装题类型数据
                [self.dataArr addObject:scoreDict];
                
                [self.dataArr addObject:showdata];
            }else{
                // 正常显示
                self.examResultStatu = showExamScoreResultNomalStatu;
                // 组装成绩字典
                NSMutableDictionary *scoreDict = [NSMutableDictionary dictionary];
                scoreDict[@"isPass"] =showdata[@"isPass"];
                scoreDict[@"examTitle"] =showdata[@"examTitle"];
                scoreDict[@"score"] =showdata[@"score"];
                scoreDict[@"examUserTotalTime"] =showdata[@"examUserTotalTime"];
                scoreDict[@"percent"] =showdata[@"percent"];
                
                [self.dataArr addObject:scoreDict];
                
                // 组装题类型数据
                [self.dataArr addObjectsFromArray:showdata[@"list"]];
            }
        }
        [self.scoreTableView reloadData];
    }];
}

@end
