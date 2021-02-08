//
//  ExamAnswerRecordCardView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/18.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTExamAnswerRecordCardView.h"

#import "TempDetailQuestionModel.h"

#import "YWTAnswerCardCollectionViewCell.h"
#define ANSWERCSRDCOLLECTIONVIEW_CELL @"YWTAnswerCardCollectionViewCell"

#import "YWTAnswerCardHeaderReusableView.h"
#define ANSWERCSRDHEADERREUSABLEVIEW  @"YWTAnswerCardHeaderReusableView"

#define ANSWERCSRDFOOTERREUSABLEVIEW  @"FOOTER"


@interface YWTExamAnswerRecordCardView ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>
//
@property (nonatomic,strong) UIButton *headerSuccessBtn;
@property (nonatomic,strong) UIButton *headerErrorBtn;
@property (nonatomic,strong) UIButton *headerUnknownBtn;

@property (nonatomic,strong) UICollectionView *cardCollectionView;

@property (nonatomic,strong) NSMutableArray *dataArr;
//题序 数据源
@property (nonatomic,strong) NSMutableArray *titleDataArr;
@end

@implementation YWTExamAnswerRecordCardView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       [self createRecordView];
    }
    return self;
}

-(void) createRecordView{
    __weak typeof(self) weakSelf = self;
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.35;
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectBgView)];
    [bgView addGestureRecognizer:tap];
    
    
    UIView *bigView = [[UIView alloc]init];
    [self addSubview:bigView];
    bigView.backgroundColor = [UIColor colorTextWhiteColor];
    [bigView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf);
        make.height.equalTo(@(KSIphonScreenH(480)+KSIphonScreenH(44)));
    }];
    
    UIView *headerView = [[UIView alloc]init];
    [bigView addSubview:headerView];
    headerView.backgroundColor  =[UIColor colorWithHexString:@"#f3f3f3"];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(bigView);
        make.height.equalTo(@(KSIphonScreenH(44)));
    }];
    
    UILabel *showRecordLab = [[UILabel alloc]init];
    [headerView addSubview:showRecordLab];
    showRecordLab.text = @"答题记录";
    showRecordLab.textColor = [UIColor colorCommonBlackColor];
    showRecordLab.font = Font(16);
    [showRecordLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(KSIphonScreenW(12));
        make.centerY.equalTo(headerView.mas_centerY);
    }];
    
    self.headerSuccessBtn = [[UIButton alloc]init];
    [headerView addSubview:self.headerSuccessBtn];
    self.headerSuccessBtn.userInteractionEnabled =NO;
    [self.headerSuccessBtn setTitle:@" 已作答" forState:UIControlStateNormal];
    [self.headerSuccessBtn setTitleColor:[UIColor colorWithHexString:@"#0679dc"] forState:UIControlStateNormal];
    [self.headerSuccessBtn setImage:[UIImage imageNamed:@"examAnswer_success"] forState:UIControlStateNormal];
    self.headerSuccessBtn.titleLabel.font = Font(13);
    [self.headerSuccessBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(showRecordLab.mas_right).offset(KSIphonScreenW(31));
        make.centerY.equalTo(headerView.mas_centerY);
    }];
    
    self.headerErrorBtn = [[UIButton alloc]init];
    [headerView addSubview:self.headerErrorBtn];
    self.headerErrorBtn.userInteractionEnabled = NO;
    [self.headerErrorBtn setTitle:@" 未作答" forState:UIControlStateNormal];
    [self.headerErrorBtn setTitleColor:[UIColor colorCommonBlackColor] forState:UIControlStateNormal];
    // 根据颜色生产的图片
    UIImage *errorImage = [YWTTools imageWithColor:[UIColor colorWithHexString:@"#e3e3e3"] andCGRect:CGRectMake(0, 0, 12, 12) andCornersSize:6];
    [self.headerErrorBtn setImage:errorImage forState:UIControlStateNormal];
    self.headerErrorBtn.titleLabel.font = Font(13);
    [self.headerErrorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headerSuccessBtn.mas_right).offset(KSIphonScreenW(31));
        make.centerY.equalTo(headerView.mas_centerY);
    }];
    
    self.headerUnknownBtn = [[UIButton alloc]init];
    [headerView addSubview:self.headerUnknownBtn];
    self.headerUnknownBtn.userInteractionEnabled = NO;
    [self.headerUnknownBtn setTitle:@" 未知" forState:UIControlStateNormal];
    [self.headerUnknownBtn setTitleColor:[UIColor colorCommonBlackColor] forState:UIControlStateNormal];
    // 根据颜色生产的图片
    UIImage *unknowImage = [YWTTools imageWithColor:[UIColor colorWithHexString:@"#ffb400"] andCGRect:CGRectMake(0, 0, 12, 12) andCornersSize:6];
    [self.headerUnknownBtn setImage:unknowImage forState:UIControlStateNormal];
    self.headerUnknownBtn.titleLabel.font = Font(13);
    [self.headerUnknownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headerErrorBtn.mas_right).offset(KSIphonScreenW(31));
        make.centerY.equalTo(headerView.mas_centerY);
    }];
    self.headerUnknownBtn.hidden = YES;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = KSIphonScreenH(10);
    layout.minimumInteritemSpacing = KSIphonScreenW(10);
    layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
   
    self.cardCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,KSIphonScreenH(44), KScreenW, KSIphonScreenH(480))  collectionViewLayout:layout];
    [bigView addSubview:self.cardCollectionView];
    self.cardCollectionView.backgroundColor = [UIColor colorTextWhiteColor];
    self.cardCollectionView.dataSource = self;
    self.cardCollectionView.delegate = self;
    
    [self.cardCollectionView registerClass:[YWTAnswerCardCollectionViewCell class] forCellWithReuseIdentifier:ANSWERCSRDCOLLECTIONVIEW_CELL];
    [self.cardCollectionView registerClass:[ YWTAnswerCardHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ANSWERCSRDHEADERREUSABLEVIEW];
    [self.cardCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:ANSWERCSRDFOOTERREUSABLEVIEW];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArr.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.answerCardMode ==  showAnswerCardAnswerMode) {
        NSDictionary *dict = self.dataArr[section];
        NSArray *arr = dict[@"list"];
        if (arr.count > 12) {
            // 点击  1展开 2 收起 按钮
            NSString *spreadStr = [NSString stringWithFormat:@"%@",dict[@"spread"]];
            if ([spreadStr isEqualToString:@"1"]) {
                return 12;
            }else{
                return arr.count;
            }
        }else{
             return arr.count;
        }
    }else{
        SheetModel *model = self.dataArr[section];
        NSArray *arr = model.list;
        if (arr.count > 12) {
            // 点击  1展开 2 收起 按钮
            NSString *spreadStr = [NSString stringWithFormat:@"%@",model.spread];
            if ([spreadStr isEqualToString:@"1"]) {
                return 12;
            }else{
                return arr.count;
            }
        }else{
            return arr.count;
        }
    }
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YWTAnswerCardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ANSWERCSRDCOLLECTIONVIEW_CELL forIndexPath:indexPath];
    // 查找当前题号
    cell.questId = self.questId;
    if (self.answerCardMode == showAnswerCardAnswerMode ) {
        //计算题号
        if (indexPath.section == 0) {
            cell.questNumber  = [NSString stringWithFormat:@"%ld",indexPath.row +1];
        }else{
            NSInteger questNumber = 0;
            for (NSInteger index = 0; index <= indexPath.section-1; index ++) {
                NSDictionary *dict = self.dataArr[index];
                NSArray *arr = dict[@"list"];
                questNumber = questNumber +arr.count;
            }
            cell.questNumber = [NSString stringWithFormat:@"%ld",(indexPath.row +1 +questNumber)];
        }
        NSDictionary *dict = self.dataArr[indexPath.section];
        NSArray *arr = dict[@"list"];
        cell.model = arr[indexPath.row];
    }else{
        //计算题号
        if (indexPath.section == 0) {
            cell.questNumber  = [NSString stringWithFormat:@"%ld",indexPath.row +1];
        }else{
            NSInteger questNumber = 0;
            for (NSInteger index = 0; index <= indexPath.section-1; index ++) {
                SheetModel *model = self.dataArr[index];
                NSArray *arr = model.list;
                questNumber = questNumber +arr.count;
            }
            cell.questNumber = [NSString stringWithFormat:@"%ld",(indexPath.row +1 +questNumber)];
        }
        SheetModel *model = self.dataArr[indexPath.section];
        cell.listModel = model.list[indexPath.row];
    }
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //判断是否是isiPhoneX 系列
    BOOL  isiPhoneX = [[YWTTools deviceModelName]containsString:@"X"];
    if (isiPhoneX) {
        return CGSizeMake((KScreenW-10*5-60)/6, 44);
    }else{
          return CGSizeMake((KScreenW-KSIphonScreenW(10)*5-KSIphonScreenW(60))/6, KSIphonScreenH(44));
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(KScreenW, 50);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(KScreenW, 0.01);
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        YWTAnswerCardHeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ANSWERCSRDHEADERREUSABLEVIEW forIndexPath:indexPath];
        headerView.indexPath = indexPath;
        if (self.answerCardMode ==  showAnswerCardAnswerMode) {
            headerView.headerMode =  showAnswerCardHeaderAnswerMode;
            NSDictionary *dict = self.dataArr[indexPath.section];
            headerView.dict = dict;
            headerView.switchBtnBlcok = ^(NSString *spreadStr) {
                // 修改数据源
                NSMutableDictionary *mutabDict = weakSelf.dataArr[indexPath.section];
                mutabDict[@"spread"] = spreadStr;
                //贴换数据源
                [weakSelf.dataArr replaceObjectAtIndex:indexPath.section withObject:mutabDict];
                // 刷新
                [CATransaction setDisableActions:YES];
                [weakSelf.cardCollectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
                [CATransaction commit];
            };
        }else{
            headerView.headerMode =  showAnswerCardHeaderDetailMode;
            SheetModel *model = self.dataArr[indexPath.section];
            headerView.model = model;
            headerView.switchBtnBlcok = ^(NSString *spreadStr) {
                // 修改数据源
                SheetModel *spreadModel = weakSelf.dataArr[indexPath.section];
                spreadModel.spread = spreadStr;
                //贴换数据源
                [weakSelf.dataArr replaceObjectAtIndex:indexPath.section withObject:spreadModel];
                // 刷新
                [CATransaction setDisableActions:YES];
                [weakSelf.cardCollectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
                [CATransaction commit];
            };
        }
        return headerView;
    }else{
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:ANSWERCSRDFOOTERREUSABLEVIEW forIndexPath:indexPath];
        return footer;
    }
}

#pragma mark -----选中点击方法-----
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.answerCardMode == showAnswerCardAnswerMode) {
        NSDictionary *dict = self.dataArr[indexPath.section];
        NSArray *arr = dict[@"list"];
        QuestionListModel *model = arr[indexPath.row];
        self.selectQuetionBlock(model.Id);
    }else{
        SheetModel *model = self.dataArr[indexPath.section];
        ListModel *listModel = model.list[indexPath.row];
        self.selectQuetionBlock(listModel.qid);
    }
}
// 点击背景view 取消视图
-(void) selectBgView{
    [self removeFromSuperview];
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
#pragma mark -----get 方法 ----
-(void)setAnswerCardMode:(showAnswerCardMode)answerCardMode{
    _answerCardMode = answerCardMode;
}
-(void)setQuestId:(NSString *)questId{
    _questId = questId;
}
-(void)setSourceArr:(NSArray *)sourceArr{
    _sourceArr = sourceArr;
    // 1单选
    NSMutableDictionary *singleDcit = [NSMutableDictionary dictionary];
    NSMutableArray *singleArr = [NSMutableArray array];
    // 2多选
    NSMutableDictionary *moreDcit = [NSMutableDictionary dictionary];
    NSMutableArray *moreArr = [NSMutableArray array];
    // 3判断
    NSMutableDictionary *judgeDcit = [NSMutableDictionary dictionary];
    NSMutableArray *judgeArr = [NSMutableArray array];
    // 4：问答题
    NSMutableDictionary *essayQuestionDcit = [NSMutableDictionary dictionary];
    NSMutableArray *essayQuestionArr = [NSMutableArray array];
    // 5填空题
    NSMutableDictionary *gapFillingDcit = [NSMutableDictionary dictionary];
    NSMutableArray *gapFillingArr = [NSMutableArray array];
    // 6主观题
    NSMutableDictionary *subjectivityDcit = [NSMutableDictionary dictionary];
    NSMutableArray *subjectivityArr = [NSMutableArray array];
    for (QuestionListModel *model in sourceArr) {
        if ([model.typeId isEqualToString:@"1"]) {
            [singleArr addObject:model];
        }else if ([model.typeId isEqualToString:@"2"]){
            [moreArr addObject:model];
        }else if ([model.typeId isEqualToString:@"3"]){
            [judgeArr addObject:model];
        }else if ([model.typeId isEqualToString:@"4"]){
            [essayQuestionArr addObject:model];
        }else if ([model.typeId isEqualToString:@"5"]){
            [gapFillingArr addObject:model];
        }else if ([model.typeId isEqualToString:@"6"]){
            [subjectivityArr addObject:model];
        }
    }
    if (singleArr.count > 0) {
        singleDcit[@"key"] = @"单选题";
        singleDcit[@"list"] = singleArr.copy;
        singleDcit[@"spread"] = @"1";
        [self.dataArr addObject:singleDcit];
    }
    if (moreArr.count > 0) {
        moreDcit[@"key"] = @"多选题";
        moreDcit[@"list"] = moreArr.copy;
        moreDcit[@"spread"] = @"1";
        [self.dataArr addObject:moreDcit];
    }
    if (judgeArr.count > 0) {
        judgeDcit[@"key"] = @"判断题";
        judgeDcit[@"list"] = judgeArr.copy;
        judgeDcit[@"spread"] = @"1";
        [self.dataArr addObject:judgeDcit];
    }
    if (essayQuestionArr.count > 0) {
        essayQuestionDcit[@"key"] = @"问答题";
        essayQuestionDcit[@"list"] = essayQuestionArr.copy;
        essayQuestionDcit[@"spread"] = @"1";
        [self.dataArr addObject:essayQuestionDcit];
    }
    if (gapFillingArr.count > 0) {
        gapFillingDcit[@"key"] = @"填空题";
        gapFillingDcit[@"list"] = gapFillingArr.copy;
        gapFillingDcit[@"spread"] = @"1";
        [self.dataArr addObject:gapFillingDcit];
    }
    if (subjectivityArr.count > 0) {
        subjectivityDcit[@"key"] = @"主观题";
        subjectivityDcit[@"list"] = subjectivityArr.copy;
        subjectivityDcit[@"spread"] = @"1";
        [self.dataArr addObject:subjectivityDcit];
    }
    
    // 获取所有的题
    NSArray *userAswerArr = [[DataBaseManager sharedManager] selectAllApps];
    NSInteger succes = 0;
    NSInteger error  = 0;
    for (NSDictionary *dict in userAswerArr) {
        NSString *userAswerStr = [NSString stringWithFormat:@"%@",dict[@"userAnswer"]];
        if (![userAswerStr isEqualToString:@""]) {
            succes += 1;
        }else{
            error += 1;
        }
    }
    [self.headerSuccessBtn setTitle:[NSString stringWithFormat:@" 已作答 %ld",(long)succes] forState:UIControlStateNormal];
    
    [self.headerErrorBtn setTitle:[NSString stringWithFormat:@" 未作答 %ld",(long)error] forState:UIControlStateNormal];
    // 刷新
    [self.cardCollectionView reloadData];
}
-(void)setDetaSourceArr:(NSArray *)detaSourceArr{
    _detaSourceArr = detaSourceArr;
    
    [self.dataArr addObjectsFromArray:detaSourceArr];
    
    NSInteger succes = 0;
    NSInteger error  = 0;
    NSInteger unknown = 0;
    for (SheetModel *model in self.dataArr) {
        for (ListModel *listModel in model.list) {
            if ([listModel.selected isEqualToString:@"2"]) {
                succes += 1;
            }else if ([listModel.selected isEqualToString:@"3"]){
                error += 1;
            }else if ([listModel.selected isEqualToString:@"4"]){
                unknown += 1;
            }
        }
    }
    if (unknown > 0) {
        self.headerUnknownBtn.hidden = NO;
        [self.headerUnknownBtn setTitle:[NSString stringWithFormat:@" 未知%ld",(long)unknown] forState:UIControlStateNormal];
        [self.headerUnknownBtn setTitleColor:[UIColor colorWithHexString:@"#ffb400"] forState:UIControlStateNormal];
        [self.headerSuccessBtn setImage:[UIImage imageNamed:@"detail_answerCardUn"] forState:UIControlStateNormal];
    }

    [self.headerSuccessBtn setTitle:[NSString stringWithFormat:@" 正确%ld",(long)succes] forState:UIControlStateNormal];
    [self.headerSuccessBtn setTitleColor:[UIColor colorWithHexString:@"#33c500"] forState:UIControlStateNormal];
    [self.headerSuccessBtn setImage:[UIImage imageNamed:@"detail_answerCardSuccess"] forState:UIControlStateNormal];
    
    
    [self.headerErrorBtn setTitle:[NSString stringWithFormat:@" 错误%ld",(long)error] forState:UIControlStateNormal];
    [self.headerErrorBtn setTitleColor:[UIColor colorWithHexString:@"#ff3030"] forState:UIControlStateNormal];
    [self.headerErrorBtn setImage:[UIImage imageNamed:@"detail_answerCardError"] forState:UIControlStateNormal];
    
    // 刷新
    [self.cardCollectionView reloadData];
}





@end
