//
//  SpecialTrainingController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/2/14.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTSpecialTrainingController.h"

#import "WKWebViewOrJSText.h"
#import "YWTShowVerifyIdentidyErrorView.h"

#import "YWTQuestTypeCollectionViewCell.h"
#define QUESTTYPECOLLECTIONVIEW_CELL @"YWTQuestTypeCollectionViewCell"

#import "YWTQuestChapterCollectionViewCell.h"
#define QUESTCHAPTERCOLLECTIONVIEW_CELL @"YWTQuestChapterCollectionViewCell"
#import "YWTSpecialTraiChapterHeaderView.h"
#define SPECTALTRAICHAPTERHEADERVIEW  @"YWTSpecialTraiChapterHeaderView"
#import "YWTSpeciaTraiTypeHeaderView.h"
#define SPECIATRAITYPEHEADERVIEW  @"YWTSpeciaTraiTypeHeaderView"

@interface YWTSpecialTrainingController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>

@property (nonatomic,strong) UICollectionView *specialCollection;

// 验证失败view
@property (nonatomic,strong)YWTShowVerifyIdentidyErrorView *showVeriIndeErrorView;

@property (nonatomic,strong) NSMutableArray *dataArr;
// 全部题目数量
@property (nonatomic,strong) NSString *totalNumStr;
// 记录题库当前数据源
@property (nonatomic,strong) NSDictionary *nowDataDict;
// 人脸规则数组
@property (nonatomic,strong) NSArray *monitorRulesArr;
// 记录当前人脸规则的数据源
@property (nonatomic,strong) NSDictionary *nowVeriDict;
// 记录当前indexPath
@property (nonatomic,strong) NSIndexPath *selectIndexPath;
// 是否强制人脸 1强制 2非强制
@property (nonatomic,strong) NSString *forceStr;
// 记录规则验证失败次数
@property (nonatomic,strong) NSString *veriNumberStr;
// 记录验证失败次数
@property (nonatomic,assign) NSInteger veriErrorNumber;

@end

@implementation YWTSpecialTrainingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [self setNavi];
    // 创建collection
    [self createCollectionView];
    // 请求数据
    [self requestLibaySpectInfos];
}
#pragma mark --- 创建collection --------
-(void) createCollectionView{
    self.view.backgroundColor = [UIColor colorTextWhiteColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    self.specialCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KScreenH-KSTabbarH-KSNaviTopHeight) collectionViewLayout:layout];
    [self.view addSubview:self.specialCollection];
    self.specialCollection.delegate = self;
    self.specialCollection.dataSource = self;
    self.specialCollection.backgroundColor  = [UIColor colorTextWhiteColor];
    
    [self.specialCollection registerClass:[YWTQuestTypeCollectionViewCell class] forCellWithReuseIdentifier:QUESTTYPECOLLECTIONVIEW_CELL];
    [self.specialCollection registerClass:[YWTQuestChapterCollectionViewCell class] forCellWithReuseIdentifier:QUESTCHAPTERCOLLECTIONVIEW_CELL];
    [self.specialCollection registerClass:[YWTSpecialTraiChapterHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SPECTALTRAICHAPTERHEADERVIEW];
    [self.specialCollection registerClass:[YWTSpeciaTraiTypeHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SPECIATRAITYPEHEADERVIEW];
    [self.specialCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FOOTER"];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArr.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *arr = self.dataArr[section];
    return arr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        YWTQuestTypeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:QUESTTYPECOLLECTIONVIEW_CELL forIndexPath:indexPath];
        cell.indexPath = indexPath;
        NSArray *typeArr = self.dataArr[indexPath.section];
        NSDictionary *dict = typeArr[indexPath.row];
        cell.dict = dict;
        return cell;
    }else{
        YWTQuestChapterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:QUESTCHAPTERCOLLECTIONVIEW_CELL forIndexPath:indexPath];
        cell.indexPath = indexPath;
        NSArray *chapterArr = self.dataArr[indexPath.section];
        NSDictionary *dict = chapterArr[indexPath.row];
        cell.dict = dict;
        return cell;
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(KScreenW/2, KSIphonScreenH(44));
    }else{
        return CGSizeMake(KScreenW, KSIphonScreenH(44));
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
         return CGSizeMake(KScreenW, KSIphonScreenH(55));
    }else{
         return CGSizeMake(KScreenW, KSIphonScreenH(90));
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(KScreenW, 10);
    }else{
        return CGSizeMake(KScreenW, 0.001);
    }
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.section == 0) {
            YWTSpeciaTraiTypeHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SPECIATRAITYPEHEADERVIEW forIndexPath:indexPath];
            return headerView;
        }else{
            YWTSpecialTraiChapterHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SPECTALTRAICHAPTERHEADERVIEW forIndexPath:indexPath];
            headerView.totalQusetNumberLab.text = [NSString stringWithFormat:@"%@",self.totalNumStr];
            return headerView;
        }
    }else{
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FOOTER" forIndexPath:indexPath];
        footer.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
        return footer;
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    // 高亮状态
    if (indexPath.section == 1) {
        YWTQuestChapterCollectionViewCell *cell =(YWTQuestChapterCollectionViewCell *) [collectionView cellForItemAtIndexPath: indexPath];
        cell.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            cell.backgroundColor = [UIColor colorTextWhiteColor];
        });
    }
    
    NSArray *arr = self.dataArr[indexPath.section];
    NSDictionary *dict = arr[indexPath.row];
    //记录当前indexPath
    self.selectIndexPath = indexPath;
    // 判断是否开启人脸
    if ([YWTTools getWithFaceMonitorStr:[NSString stringWithFormat:@"%@",self.dataDict[@"monitor"]]]) {
        self.monitorRulesArr = nil;
        self.monitorRulesArr = (NSArray*)self.dataDict[@"monitorRules"];
        // 记录题库当前数据源
        self.nowDataDict = nil;
        self.nowDataDict = dict;
        // 判断是否找到人脸规则
        if ([self getByMonitorNameHaveFoundMonitorDict:@"start"]) {
            // 通过规则 调用人脸识别
            NSDictionary *faceDict = [self createFaveVerificationStr:@"start"];
            self.nowVeriDict = nil;
            self.nowVeriDict = faceDict;
            // 是否强制人脸 1强制 2非强制
            self.forceStr = [NSString stringWithFormat:@"%@",faceDict[@"force"]];
            // 记录验证失败次数
            self.veriNumberStr = [NSString stringWithFormat:@"%@",faceDict[@"number"]];
            // 开始人脸认证
            [self passRulesConductFaceVeri:faceDict];
        }else{
             // 跳转到详情页
            [self pushJScontrollerDict:dict andTaskFace:YES andIndexPath:indexPath];
        }
    }else{
        // 跳转到详情页
        [self pushJScontrollerDict:dict andTaskFace:NO andIndexPath:indexPath];
    }
}
#pragma mark --- 关于开启任务人脸识别模块 --------
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
    
}
// 关闭
-(void)closeViewControll{
    
}
#pragma mark --- 创建验证失败的view --------
-(void) createShowVeriIndeErrorViewAndType:(NSString *)typeStr{
    __weak typeof(self) weakSelf = self;
    self.showVeriIndeErrorView = [[YWTShowVerifyIdentidyErrorView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSTabbarH) andType:typeStr];
    [self.view addSubview:self.showVeriIndeErrorView];
    // 点击其他区域不能取消view
    self.showVeriIndeErrorView.isColseBigBgView = NO;
    
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

// TaskFace  开启任务人脸  YES 是  NO 不是
-(void) pushJScontrollerDict:(NSDictionary*)dict andTaskFace:(BOOL)isFace andIndexPath:(NSIndexPath *)indexPath{
    WKWebViewOrJSText *wkWebVC = [[WKWebViewOrJSText alloc]init];
    wkWebVC.titleType = showLibaryTitleSpecialTrainType;
    wkWebVC.libaryIdStr = self.libaryIdStr;
    if (indexPath.section == 0) {
        // 试题类型
        wkWebVC.typeIdStr = [NSString stringWithFormat:@"%@",dict[@"typeStr"]];
        wkWebVC.chapterIdStr = @"0";
    }else{
        // 章节id【专项练习使用】
        wkWebVC.typeIdStr = @"0";
        wkWebVC.chapterIdStr = [NSString stringWithFormat:@"%@",dict[@"chapterId"]];
    }
    // 判断是否开启人脸
    if (isFace) {
        wkWebVC.taskIdStr = [NSString stringWithFormat:@"%@",dict[@"taskid"]];
        wkWebVC.monitorRulesArr = self.monitorRulesArr;
    }else{
        wkWebVC.taskIdStr = @"";
    }
    [self.navigationController pushViewController:wkWebVC animated:YES];
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    self.customNavBar.title = @"专项练习";
    
    __weak typeof(self) weakSelf = self;
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}
#pragma mark --- 懒加载 --------
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(void)setLibaryIdStr:(NSString *)libaryIdStr{
    _libaryIdStr = libaryIdStr;
}
-(void)setDataDict:(NSDictionary *)dataDict{
    _dataDict = dataDict;
}
-(NSArray *)monitorRulesArr{
    if (!_monitorRulesArr) {
        _monitorRulesArr = [NSArray array];
    }
   return _monitorRulesArr;
}
#pragma mark --- 专项联系详情 --------
-(void) requestLibaySpectInfos{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"libaryId"] = self.libaryIdStr;
    param[@"token"] = [YWTTools getNewToken];
    [[KRMainNetTool sharedKRMainNetTool] postRequstWith:HTTP_ATTAPPQUSTLISPECIALPRACTICEINFOS_URL params:param withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if (![showdata isKindOfClass:[NSDictionary class]]) {
            [self.view showErrorWithTitle:@"返回数据格式错误！" autoCloseTime:0.5];
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        NSDictionary *typeDict = showdata[@"typeQuestion"];
        NSMutableArray *typeArr = [NSMutableArray array];
        // 单选
        if ([[typeDict allKeys] containsObject:@"single"]) {
            NSMutableDictionary *singleDict = [NSMutableDictionary dictionary];
            singleDict[@"type"] = @"单选题";
            singleDict[@"typeStr"] = @"1";
            singleDict[@"number"] = typeDict[@"single"];
            singleDict[@"image"] = @"zxlx_ico01";
            [typeArr addObject:singleDict];
        }
        // 多选
        if ([[typeDict allKeys] containsObject:@"more"]) {
            NSMutableDictionary *moreDict = [NSMutableDictionary dictionary];
            moreDict[@"type"] = @"多选题";
            moreDict[@"typeStr"] = @"2";
            moreDict[@"number"] = typeDict[@"more"];
            moreDict[@"image"] = @"zxlx_ico02";
            [typeArr addObject:moreDict];
        }
        // 判断题
        if ([[typeDict allKeys] containsObject:@"judge"]) {
            NSMutableDictionary *judgeDict = [NSMutableDictionary dictionary];
            judgeDict[@"type"] = @"判断题";
            judgeDict[@"typeStr"] = @"3";
            judgeDict[@"number"] = typeDict[@"judge"];
            judgeDict[@"image"] = @"zxlx_ico03";
            [typeArr addObject:judgeDict];
        }
//        // 问答题
//        if ([[typeDict allKeys] containsObject:@"essayQuestion"]) {
//            NSMutableDictionary *essayQuestionDict = [NSMutableDictionary dictionary];
//            essayQuestionDict[@"type"] = @"问答题";
//            essayQuestionDict[@"typeStr"] = @"4";
//            essayQuestionDict[@"number"] = typeDict[@"essayQuestion"];
//            essayQuestionDict[@"image"] = @"zxlx_ico04";
//            [typeArr addObject:essayQuestionDict];
//        }
        // 填空题
        if ([[typeDict allKeys] containsObject:@"gapFilling"]) {
            NSMutableDictionary *gapFillingDict = [NSMutableDictionary dictionary];
            gapFillingDict[@"type"] = @"填空题";
            gapFillingDict[@"typeStr"] = @"5";
            gapFillingDict[@"number"] = typeDict[@"gapFilling"];
            gapFillingDict[@"image"] = @"zxlx_ico04";
            [typeArr addObject:gapFillingDict];
        }
        // 填空题
        if ([[typeDict allKeys] containsObject:@"subjectivity"]) {
            NSMutableDictionary *subjectivityDict = [NSMutableDictionary dictionary];
            subjectivityDict[@"type"] = @"主观题";
            subjectivityDict[@"typeStr"] = @"6";
            subjectivityDict[@"number"] = typeDict[@"subjectivity"];
            subjectivityDict[@"image"] = @"zxlx_ico05";
            [typeArr addObject:subjectivityDict];
        }
        // 按题目类型练习
        [self.dataArr addObject:typeArr];
        
        // 全部题目数量
        self.totalNumStr = [NSString stringWithFormat:@"%@",showdata[@"totalNum"]];
        
        // 按章节练习
        [self.dataArr addObject:showdata[@"typeChapter"]];
        // 刷新UI
        [self.specialCollection reloadData];
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
    param[@"source"] = @"3";
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
    
    [[KRMainNetTool sharedKRMainNetTool] upLoadPhotoUrl:HTTP_ATTAPPMOITORAPIFACERECOGINTION_URL params:param photo:faceImage waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (error) {
            [self.view showErrorWithTitle:error autoCloseTime:0.5];
            return ;
        }
        if (![showdata isKindOfClass:[NSDictionary class]]) {
            return;
        }
        // 1强制 2非强制
        if ([self.forceStr isEqualToString:@"1"]) {
            NSString *succStr = [NSString stringWithFormat:@"%@",showdata[@"succ"]];
            if ([succStr isEqualToString:@"1"]) {
                // 是否开始验证
                if ([ruleStr isEqualToString:@"start"]) {
                    // 跳转到文件详情页面  （hl5）
                    [self pushJScontrollerDict:self.nowDataDict andTaskFace:YES andIndexPath:self.selectIndexPath];
                }
            }else{
                // 创建失败view
                [self createShowVeriIndeErrorViewAndType:@"1"];
            }
        }else{
            NSString *succStr = [NSString stringWithFormat:@"%@",showdata[@"succ"]];
            if ([succStr isEqualToString:@"1"]) {
                // 是否开始验证
                if ([ruleStr isEqualToString:@"start"]) {
                    // 跳转到文件详情页面  （hl5）
                    [self pushJScontrollerDict:self.nowDataDict andTaskFace:YES andIndexPath:self.selectIndexPath];
                }
            }else{
                //记录验证失败次数
                self.veriErrorNumber += 1;
                if (self.veriErrorNumber >= [self.veriNumberStr integerValue]) {
                    [self.showVeriIndeErrorView removeFromSuperview];
                    // 是否开始验证
                    if ([ruleStr isEqualToString:@"start"]) {
                        // 跳转到文件详情页面  （hl5）
                        [self pushJScontrollerDict:self.nowDataDict andTaskFace:YES andIndexPath:self.selectIndexPath];
                    }
                }else{
                    // 创建失败view
                    [self createShowVeriIndeErrorViewAndType:@"1"];
                }
            }
        }
    }];
}


@end
