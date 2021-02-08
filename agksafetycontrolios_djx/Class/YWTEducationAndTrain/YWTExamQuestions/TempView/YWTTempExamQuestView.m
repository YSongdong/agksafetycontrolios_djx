//
//  TempExamQuestView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/17.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTTempExamQuestView.h"

#import "YWTTempExamQuestTableViewCell.h"
#define TEMPEXAMQUESTTABLEVIEW_CELL @"YWTTempExamQuestTableViewCell"
#import "YWTTempFillBlankQuestTableViewCell.h"
#define TEMPFILLBLANKQUESTTABLEVIEW_CELL  @"YWTTempFillBlankQuestTableViewCell"

#import "YWTTempExamQuestHeaderView.h"
#import "YWTTempExamFillInAnswerView.h"
#import "YWTTempExamBaseFooterView.h"
#import "YWTTempExamGapFillingFootView.h"

@interface YWTTempExamQuestView ()
<
UITableViewDelegate,
UITableViewDataSource
>
// 填空题，主观题 填写答案view
@property (nonatomic,strong) YWTTempExamFillInAnswerView *fillInAnswerView;
@property (nonatomic,strong) UITableView *questTableView;
// 用户当前选中IndexPath
@property (nonatomic,strong) NSIndexPath *userSelectIndexPath;

@end

@implementation YWTTempExamQuestView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createTempView];
        [self addGestureRecognizerForHideKeyBoard];
    }
    return self;
}
-(void) createTempView{
    self.questTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KScreenH-KSNaviTopHeight-KSTabbarH-KSIphonScreenH(50)) style:UITableViewStyleGrouped];
    [self addSubview:self.questTableView];
    
    self.questTableView.delegate = self;
    self.questTableView.dataSource = self;
    self.questTableView.backgroundColor = [UIColor colorTextWhiteColor];
    self.questTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    self.questTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    [self.questTableView registerClass:[YWTTempExamQuestTableViewCell class] forCellReuseIdentifier:TEMPEXAMQUESTTABLEVIEW_CELL];
    [self.questTableView registerClass:[YWTTempFillBlankQuestTableViewCell class] forCellReuseIdentifier:TEMPFILLBLANKQUESTTABLEVIEW_CELL];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tempQuestModel.optionList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   // 单选 多选 判断
    if (self.questType == tempExamQuestSingleSelectType || self.questType == tempExamQuestMultipleSelectType || self.questType == tempExamQuestJudgmentType) {
        
        YWTTempExamQuestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TEMPEXAMQUESTTABLEVIEW_CELL forIndexPath:indexPath];
        
        //  答题样式
        OptionListModel *listModel =self.tempQuestModel.optionList[indexPath.row];
        // 图片地址等于空
        if ([listModel.photo isEqualToString:@""]) {
            // 纯文字
            cell.anserQuestType = showAnswerQuestTextType;
        }else if (![listModel.photo isEqualToString:@""] && ![listModel.title isEqualToString:@""]){
            // 图文混排
            cell.anserQuestType = showAnswerQuestPhotoAndTextType;
        }else if (![listModel.photo isEqualToString:@""] && [listModel.title isEqualToString:@""]){
            // 纯图片
            cell.anserQuestType = showAnswerQuestPhotoType;
        }
        cell.questionModel = self.tempQuestModel;
        cell.listModel = self.tempQuestModel.optionList[indexPath.row];
        
        // 答题模式
        if (self.questMode == tempExamQuestAnswerMode) {
            // 答题模式
            cell.questMode =  showQuestAnswerMode;
        }else if (self.questMode == tempExamQuestDetailMode){
            cell.questMode =  showQuestDetailMode;
        }
        return cell;
    }else if (self.questType == tempExamQuestFillingType || self.questType == tempExamQuestThemeType){
        YWTTempFillBlankQuestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TEMPFILLBLANKQUESTTABLEVIEW_CELL forIndexPath:indexPath];
        // 获取用户答案
        NSString *userAnswerStr = [[DataBaseManager sharedManager] getObtainUserSelectAnswer:self.tempQuestModel.Id];
        // 答题模式
        if (self.questMode == tempExamQuestAnswerMode) {
            // 答题模式
            cell.fillBlankQuestMode =  showFillBlankQuestAnswerMode;
            
            [cell getWithFillinAnswer:userAnswerStr andMode:@"1"];
        }else if (self.questMode == tempExamQuestDetailMode){
            // 详情模式
            cell.fillBlankQuestMode =  showFillBlankQuestDetailMode;
            
            [cell getWithFillinAnswer:userAnswerStr andMode:@"2"];
        }
        __weak typeof(self) weakSelf = self;
        // textView 开始编辑和结束编辑的回调
        cell.fsTextViewEditing = ^(BOOL isBeginEditing) {
            [weakSelf getWithKeyBoard:isBeginEditing];
        };
        //用户确定答案回调方法
        cell.fillinAnswerBlock = ^(NSString * _Nonnull useAnswer) {
            //1、更新本地数据 用户答案
            [[DataBaseManager sharedManager]updateFMDBDataQuestId:weakSelf.tempQuestModel.Id andUserAnswer:useAnswer];
            //3、刷新界面
            [weakSelf.questTableView reloadData];
        };
        return cell;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 单选 多选 判断
    if (self.questType == tempExamQuestSingleSelectType || self.questType == tempExamQuestMultipleSelectType || self.questType == tempExamQuestJudgmentType) {
        //  答题样式
        OptionListModel *listModel =self.tempQuestModel.optionList[indexPath.row];
        // 图片地址等于空
        if ([listModel.photo isEqualToString:@""]) {
            // 纯文字
            return  [YWTTempExamQuestTableViewCell getLabelHeightWithDict:self.tempQuestModel.optionList[indexPath.row] andQuestType:showAnswerQuestTextType];
        }else if (![listModel.photo isEqualToString:@""] && ![listModel.title isEqualToString:@""]){
            // 图文混排
            return  [YWTTempExamQuestTableViewCell getLabelHeightWithDict:self.tempQuestModel.optionList[indexPath.row] andQuestType:showAnswerQuestPhotoAndTextType];
        }else if (![listModel.photo isEqualToString:@""] && [listModel.title isEqualToString:@""]){
            // 纯图片
            return  [YWTTempExamQuestTableViewCell getLabelHeightWithDict:self.tempQuestModel.optionList[indexPath.row] andQuestType:showAnswerQuestPhotoType];
        }else{
            return 10;
        }
    }else if (self.questType == tempExamQuestFillingType){
        // 获取用户答案
        NSString *userAnswerStr = [[DataBaseManager sharedManager] getObtainUserSelectAnswer:self.tempQuestModel.Id];
        
        CGFloat height = [YWTTempFillBlankQuestTableViewCell getCellHeightWithStr:userAnswerStr andType:@"5"];
        return height;
    }else if (self.questType == tempExamQuestThemeType){
        // 获取用户答案
        NSString *userAnswerStr = [[DataBaseManager sharedManager] getObtainUserSelectAnswer:self.tempQuestModel.Id];
        CGFloat height = [YWTTempFillBlankQuestTableViewCell getCellHeightWithStr:userAnswerStr andType:@"6"];
        return height;
    }
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    YWTTempExamQuestHeaderView *tempHeaderView = [[YWTTempExamQuestHeaderView alloc]init];
    // 答题样式
    if (self.questMode ==tempExamQuestAnswerMode ) {
        tempHeaderView.questHeaderMode = tempExamQuestHeaderAnswerMode;
    }else{
        tempHeaderView.questHeaderMode = tempExamQuestHeaderDetailMode;
        tempHeaderView.dataHeaderModel = self.tempDataModel;
    }
    //  答题类型
    if ([self.tempQuestModel.typeId isEqualToString:@"1"]) {
        tempHeaderView.questHeaderType = tempExamQuestHeaderSingleSelectType;
    }else if ([self.tempQuestModel.typeId isEqualToString:@"2"]){
         tempHeaderView.questHeaderType = tempExamQuestHeaderMultipleSelectType;
    }else if ([self.tempQuestModel.typeId isEqualToString:@"3"]){
        tempHeaderView.questHeaderType = tempExamQuestHeaderJudgmentType;
    }else if ([self.tempQuestModel.typeId isEqualToString:@"5"]){
        tempHeaderView.questHeaderType = tempExamQuestHeaderFillingType;
    }else if ([self.tempQuestModel.typeId isEqualToString:@"6"] || [self.tempQuestModel.typeId isEqualToString:@"4"]){
        tempHeaderView.questHeaderType = tempExamQuestHeaderThemeType;
    }
    tempHeaderView.nowQuestNumberStr = self.nowQuestNumberStr;
    tempHeaderView.questModel = self.tempQuestModel;
    
    return tempHeaderView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.questMode ==tempExamQuestAnswerMode ) {
        return [YWTTempExamQuestHeaderView getLabelHeightWithDict:self.tempQuestModel andHeaderModo:tempExamQuestHeaderAnswerMode];
    }else{
        return [YWTTempExamQuestHeaderView getLabelHeightWithDict:self.tempQuestModel andHeaderModo:tempExamQuestHeaderDetailMode];
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.questMode ==tempExamQuestDetailMode ) {
        if ([self.tempQuestModel.typeId integerValue] < 4) {
            YWTTempExamBaseFooterView *footerView = [[YWTTempExamBaseFooterView alloc]init];
            footerView.footModel = self.tempQuestModel;
            return footerView;
        }else{
            YWTTempExamGapFillingFootView *gapFillFootView = [[YWTTempExamGapFillingFootView alloc]init];
            gapFillFootView.footModel = self.tempQuestModel;
            return gapFillFootView;
        }
    }else{
        return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.questMode ==tempExamQuestDetailMode ) {
        if ([self.tempQuestModel.typeId integerValue] < 4) {
            return [YWTTempExamBaseFooterView getLabelHeightWithDict:self.tempQuestModel];
        }else{
            return [YWTTempExamGapFillingFootView getLabelHeightWithDict:self.tempQuestModel];
        }
    }else{
        return 10;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 详情 直接返回
    if (self.questMode ==  tempExamQuestDetailMode) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        return;
    }
    if ([self.tempQuestModel.typeId isEqualToString:@"1"] || [self.tempQuestModel.typeId isEqualToString:@"3"] ) {
        // 单选 和 判断
        // 当前
        OptionListModel *model = self.tempQuestModel.optionList[indexPath.row];
       
        // 更新本地数据 用户答案
        [[DataBaseManager sharedManager]updateFMDBDataQuestId:self.tempQuestModel.Id andUserAnswer:model.title];
        
    }else if ([self.tempQuestModel.typeId isEqualToString:@"2"]){
        // 当前
        OptionListModel *model = self.tempQuestModel.optionList[indexPath.row];
        // 添加答案方法
        [self addMultipleSelectQuestionAnswer:model];
    }
    [self.questTableView reloadData];
}
/**
 添加多选题答案方法
 @param listModel  传入当前的数据源
 */
-(void) addMultipleSelectQuestionAnswer:(OptionListModel*)listModel{
    // 获取当前题的用户答案
    NSString *userAnswerStr = [[DataBaseManager sharedManager] getObtainUserSelectAnswer:self.tempQuestModel.Id];
    NSString *answerStr = [NSString stringWithFormat:@"%@,",listModel.title];
    // 判断在保存本地是否找到答案选项   YES  是  NO  不是
    if ([userAnswerStr containsString:listModel.title]) {
        //1、找到位置范围
        NSRange range = [userAnswerStr rangeOfString:answerStr];
        //2、删除指定字符
        NSMutableString *mutabeUserAnswer = [NSMutableString stringWithString:userAnswerStr];
        [mutabeUserAnswer deleteCharactersInRange:range];
        //3、 更新本地数据 用户答案
        [[DataBaseManager sharedManager]updateFMDBDataQuestId:self.tempQuestModel.Id andUserAnswer:mutabeUserAnswer.copy];
    }else{
        //1、 先添加
        NSMutableString *addAnswerStr = [NSMutableString stringWithString:userAnswerStr];
        [addAnswerStr appendString:answerStr];
        //2、更新本地数据 用户答案
        [[DataBaseManager sharedManager]updateFMDBDataQuestId:self.tempQuestModel.Id andUserAnswer:addAnswerStr.copy];
    }
}
#pragma mark ------ 填空题主观题 编辑和收起键盘方法--------
-(void) getWithKeyBoard:(BOOL)isBeginEditing{
    //判断是否是isiPhoneX 系列
    BOOL  isiPhoneX = [[YWTTools deviceModelName]containsString:@"X"];
    __weak typeof(self) weakSelf = self;
    if (isBeginEditing) {
        if (isiPhoneX) {
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.questTableView.center = CGPointMake(weakSelf.questTableView.center.x, KScreenH-KSNaviTopHeight-KSIphonScreenH(50)-KSTabbarH-88-weakSelf.questTableView.frame.size.height/2);
            }];
        }else{
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.questTableView.center = CGPointMake(weakSelf.questTableView.center.x, KScreenH-KSNaviTopHeight-KSIphonScreenH(50)-KSTabbarH-64-weakSelf.questTableView.frame.size.height/2);
            }];
        }
    }else{
        if (isiPhoneX) {
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.questTableView.center = CGPointMake(weakSelf.questTableView.center.x, KScreenH-KSNaviTopHeight-KSIphonScreenH(50)-KSTabbarH-weakSelf.questTableView.frame.size.height/2+88);
            }];
        }else{
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.questTableView.center = CGPointMake(weakSelf.questTableView.center.x, KScreenH-KSNaviTopHeight-KSIphonScreenH(50)-KSTabbarH-weakSelf.questTableView.frame.size.height/2+64);
            }];
        }
    }
}
#pragma mark ------ 添加键盘收起方法--------
- (void)addGestureRecognizerForHideKeyBoard {
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewTouchInSide)];
    tableViewGesture.numberOfTapsRequired = 1;
    tableViewGesture.cancelsTouchesInView = NO;
    [self.questTableView addGestureRecognizer:tableViewGesture];
}
// ------tableView 上添加的自定义手势
- (void)tableViewTouchInSide{
    [self endEditing:YES];
    if (self.questType == tempExamQuestFillingType || self.questType == tempExamQuestThemeType){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        YWTTempFillBlankQuestTableViewCell *cell = [self.questTableView cellForRowAtIndexPath:indexPath];
        //1、更新本地数据 用户答案
        [[DataBaseManager sharedManager]updateFMDBDataQuestId:self.tempQuestModel.Id andUserAnswer:cell.fsTextView.text];
    }
}
// 刷新界面
-(void)refreshUI{
    [self.questTableView reloadData];
}
#pragma mark ----get 方法 ------
-(void)setQuestMode:(tempExamQuestMode)questMode{
    _questMode = questMode;
}
-(void)setQuestType:(tempExamQuestType)questType{
    _questType = questType;
}
-(void)setQuestStyle:(showAnswerQuestStyle)questStyle{
    _questStyle = questStyle;
}
-(void)setTempQuestModel:(QuestionListModel *)tempQuestModel{
    _tempQuestModel = tempQuestModel;
}
-(void)setNowQuestNumberStr:(NSString *)nowQuestNumberStr{
    _nowQuestNumberStr = nowQuestNumberStr;
}
-(void)setTempDataModel:(TempDetailQuestionModel *)tempDataModel{
    _tempDataModel = tempDataModel;
}
@end
