//
//  BaseModuleController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/5.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTBaseModuleController.h"

#import "YWTExamPaperListController.h"
#import "YWTlibayExerciseController.h"
#import "YWTExamCenterListController.h"
#import "YWTBaseTableViewController.h"
#import "YWTAttendanceChenkController.h"
#import "YWTMyStudiesController.h"
#import "YWTBaseShowListController.h"
#import "YWTTaskCenterListController.h"
#import "YWTBaseShowListController.h"

#import "YWTBaseModuleHeaderView.h"
#import "YWTBaseVerticalCollectionCell.h"
#define BASEVERTICALCOLLECTION_CELL @"YWTBaseVerticalCollectionCell"
#import "YWTBaseHorizontalCollectionCell.h"
#define BASEHORISONTALCOLLECTION_CELL @"YWTBaseHorizontalCollectionCell"

@interface YWTBaseModuleController ()
<
UICollectionViewDelegateFlowLayout,
UICollectionViewDelegate,
UICollectionViewDataSource
>
@property (nonatomic,strong) YWTBaseModuleHeaderView *moduleHeaderView;

@property (nonatomic,strong) UICollectionView *baseConllection;



@end

@implementation YWTBaseModuleController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [self setNavi];
    // 创建Collectionview
    [self createCollectionView];
}
#pragma mark --- 创建Collectionview --------
-(void) createCollectionView{
    self.view.backgroundColor = [UIColor colorTextWhiteColor];
    // 创建HeaderView
    [self.view insertSubview:self.moduleHeaderView atIndex:0];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 16;
    layout.minimumInteritemSpacing = 12;
    layout.sectionInset = UIEdgeInsetsMake(12, 12, 12, 12);
    
    self.baseConllection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, KSIphonScreenH(120)+KSNaviTopHeight, KScreenW, KScreenH-KSIphonScreenH(120)-KSTabbarH-KSNaviTopHeight) collectionViewLayout:layout];
    [self.view addSubview:self.baseConllection];
    
    self.baseConllection.delegate = self;
    self.baseConllection.dataSource = self;
    self.baseConllection.backgroundColor = [UIColor colorTextWhiteColor];
    
    [self.baseConllection registerClass:[YWTBaseVerticalCollectionCell class] forCellWithReuseIdentifier:BASEVERTICALCOLLECTION_CELL];
    [self.baseConllection registerClass:[YWTBaseHorizontalCollectionCell class] forCellWithReuseIdentifier:BASEHORISONTALCOLLECTION_CELL];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = self.dataArr[indexPath.row];
    if (self.dataArr.count % 2 != 0) {
        if (self.dataArr.count-1 == indexPath.row) {
            YWTBaseHorizontalCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BASEHORISONTALCOLLECTION_CELL forIndexPath:indexPath];
            cell.dict = dict;
            return cell;
        }else{
            YWTBaseVerticalCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BASEVERTICALCOLLECTION_CELL forIndexPath:indexPath];
            cell.dict = dict;
            return cell;
        }
    }else{
        YWTBaseVerticalCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BASEVERTICALCOLLECTION_CELL forIndexPath:indexPath];
        cell.dict = dict;
        return cell;
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArr.count % 2 != 0) {
        if (self.dataArr.count-1 == indexPath.row) {
            return CGSizeMake(KScreenW-KSIphonScreenW(24), KSIphonScreenH(100));
        }else{
            NSDictionary *dict = self.dataArr[indexPath.row];
            NSString *titleEnglishStr = [NSString stringWithFormat:@"%@",dict[@"titleEnglish"]];
            // 隐藏
            if ([titleEnglishStr isEqualToString:@""]) {
                return CGSizeMake((KScreenW-KSIphonScreenW(24)-KSIphonScreenW(12))/2, KSIphonScreenH(146));
            }else{
               return CGSizeMake((KScreenW-KSIphonScreenW(24)-KSIphonScreenW(12))/2, KSIphonScreenH(169));
            }
        }
    }else{
        NSDictionary *dict = self.dataArr[indexPath.row];
        NSString *titleEnglishStr = [NSString stringWithFormat:@"%@",dict[@"titleEnglish"]];
        // 隐藏
        if ([titleEnglishStr isEqualToString:@""]) {
            return CGSizeMake((KScreenW-KSIphonScreenW(24)-KSIphonScreenW(12))/2, KSIphonScreenH(146));
        }else{
            return CGSizeMake((KScreenW-KSIphonScreenW(24)-KSIphonScreenW(12))/2, KSIphonScreenH(169));
        }
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = self.dataArr[indexPath.row];
    NSString *moduleNameStr =[NSString stringWithFormat:@"%@",dict[@"name"]];
    if ([moduleNameStr isEqualToString:@"examCenter"]) {
        // 我的考试
        YWTExamCenterListController *examCenterVC = [[YWTExamCenterListController alloc]init];
        examCenterVC.viewControStatu = showViewControllerExamCenterListStatu;
        examCenterVC.titleStr = [NSString stringWithFormat:@"%@",dict[@"title"]];
        [self.navigationController pushViewController:examCenterVC animated:YES];
    }else if ([moduleNameStr isEqualToString:@"myStudies"]){
        // 我的学习
        YWTMyStudiesController *myStudiesVC = [[YWTMyStudiesController alloc]init];
        myStudiesVC.moduleNameStr = [NSString stringWithFormat:@"%@",dict[@"title"]];
        [self.navigationController pushViewController:myStudiesVC animated:YES];
        
    }else if ([moduleNameStr isEqualToString:@"libayExercise"]){
        //  题库练习
        YWTlibayExerciseController *libayExerVC = [[YWTlibayExerciseController alloc]init];
        libayExerVC.titleStr = @"";
        libayExerVC.moduleNameStr = [NSString stringWithFormat:@"%@",dict[@"title"]];
        [self.navigationController pushViewController:libayExerVC animated:YES];
    }else if ([moduleNameStr isEqualToString:@"examPaper"]){
        //  模拟考试
        YWTExamPaperListController *listVC = [[YWTExamPaperListController alloc]init];
        listVC.titleStr = @"";
        [self.navigationController pushViewController:listVC animated:YES];
    }else if ([moduleNameStr isEqualToString:@"securityCheck"]){
        //  安全检查
        [self requestModuleAuthDataType:@"1" andDict:dict];

    }else if ([moduleNameStr isEqualToString:@"classRecord"]){
        //  班会记录
        [self requestModuleAuthDataType:@"2" andDict:dict];
        
    }else if ([moduleNameStr isEqualToString:@"technicalDisclosure"]){
        //  技术交底
        [self requestModuleAuthDataType:@"3" andDict:dict];
        
    }else if ([moduleNameStr isEqualToString:@"violationHan"]){
        //  违章处理
        [self requestModuleAuthDataType:@"4" andDict:dict];
       
    }else if ([moduleNameStr isEqualToString:@"attendanceAtte"]){
        //  考勤签到
        [self requestModuleAuthDataType:@"5" andDict:dict];
    }else if ([moduleNameStr isEqualToString:@"exposureStation"]){
        //曝光台
        YWTBaseShowListController *showListVC = [[YWTBaseShowListController alloc]init];
        showListVC.listType = showControllerExposureListType;
        showListVC.moduleNameStr = [NSString stringWithFormat:@"%@",dict[@"title"]];
        [self.navigationController pushViewController:showListVC animated:YES];
    }else if ([moduleNameStr isEqualToString:@"taskCenter"]){
        //任务中心
        YWTTaskCenterListController *listVC = [[YWTTaskCenterListController alloc]init];
        listVC.moduleNameStr = [NSString stringWithFormat:@"%@",dict[@"title"]];
        [self.navigationController pushViewController:listVC animated:YES];
    }else if ([moduleNameStr isEqualToString:@"riskDisplay"]){
        //风险展示
        YWTBaseShowListController *showListVC = [[YWTBaseShowListController alloc]init];
        showListVC.listType = showControllerRiskListType;
        showListVC.moduleNameStr = [NSString stringWithFormat:@"%@",dict[@"title"]];
        [self.navigationController pushViewController:showListVC animated:YES];
    }
}

#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];

    self.customNavBar.title =self.titleStr;
    
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    __weak typeof(self) weakSelf = self;
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}
#pragma mark --- 懒加载 --------
-(YWTBaseModuleHeaderView *)moduleHeaderView{
    if (!_moduleHeaderView) {
        _moduleHeaderView = [[YWTBaseModuleHeaderView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KSIphonScreenH(120))];
        NSString *totalStr = [NSString stringWithFormat:@"做好 %lu 件事",(unsigned long)self.dataArr.count];
        NSString *alterStr = [NSString stringWithFormat:@"%lu",(unsigned long)self.dataArr.count];
        _moduleHeaderView.contentLab.attributedText = [YWTTools getAttrbuteTotalStr:totalStr andAlterTextStr:alterStr andTextColor:[UIColor colorCommonBlackColor] andTextFont:BFont(24)];
    }
    return _moduleHeaderView;
}
-(void)setModuleType:(showBaseModuleType )moduleType{
    _moduleType = moduleType;
}
-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
}
#pragma mark ----- 请求模块权限 --------
-(void) requestModuleAuthDataType:(NSString *)type andDict:(NSDictionary *)dict{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"]= [YWTTools getNewToken];
    param[@"platformCode"] = [YWTUserInfo obtainWithLoginPlatformCode];
    param[@"type"] = type;
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPMODULEAUTHMODULEAUTH_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if ([type isEqualToString:@"1"]) {
            //  安全检查
            YWTBaseTableViewController *baseVC = [[YWTBaseTableViewController alloc]init];
            baseVC.veiwBaseType =  showViewControllerSafetyType;
            baseVC.moduleNameStr = [NSString stringWithFormat:@"%@",dict[@"title"]];
            [self.navigationController pushViewController:baseVC animated:YES];
        }else if ([type isEqualToString:@"2"]){
            //  班会记录
            YWTBaseTableViewController *baseVC = [[YWTBaseTableViewController alloc]init];
            baseVC.veiwBaseType =  showViewControllerMeetingType;
            baseVC.moduleNameStr = [NSString stringWithFormat:@"%@",dict[@"title"]];
            [self.navigationController pushViewController:baseVC animated:YES];
        }else if ([type isEqualToString:@"3"]){
            //  技术交底
            YWTBaseTableViewController *baseVC = [[YWTBaseTableViewController alloc]init];
            baseVC.veiwBaseType =  showViewControllerTechnoloType;
            baseVC.moduleNameStr = [NSString stringWithFormat:@"%@",dict[@"title"]];
            [self.navigationController pushViewController:baseVC animated:YES];
        }else if ([type isEqualToString:@"4"]){
            //  违章处理
            YWTBaseTableViewController *baseVC = [[YWTBaseTableViewController alloc]init];
            baseVC.veiwBaseType =  showViewControllerViolationType;
            baseVC.moduleNameStr = [NSString stringWithFormat:@"%@",dict[@"title"]];
            [self.navigationController pushViewController:baseVC animated:YES];
        }else if ([type isEqualToString:@"5"]){
             //  考勤签到
            YWTAttendanceChenkController *attendanceVC = [[YWTAttendanceChenkController alloc]init];
            attendanceVC.moduleNameStr = [NSString stringWithFormat:@"%@",dict[@"title"]];
            [self.navigationController pushViewController:attendanceVC animated:YES];
        }
    }];
}






@end
