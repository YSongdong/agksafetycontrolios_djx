//
//  TempExamBaseFooterView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/24.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTTempExamBaseFooterView.h"

@interface YWTTempExamBaseFooterView ()
// 你的答案
@property (nonatomic,strong) UILabel *userAnswerLab;
// 正确答案
@property (nonatomic,strong) UILabel *successAnswerLab;
// 答案状态
@property (nonatomic,strong) UIImageView *answerStatuImageV;
// 本题得分
@property (nonatomic,strong) UILabel *thisQuestScoreLab;
// 本题分值
@property (nonatomic,strong) UILabel *questScoreLab;
//显示 专业解析
@property (nonatomic,strong) UILabel *showProfAnalLab;
// 专业解析
@property (nonatomic,strong) UILabel *profAnalLab;

@end

@implementation YWTTempExamBaseFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createBaseFooterView];
    }
    return self;
}
-(void) createBaseFooterView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorTextWhiteColor];
    
    UIView *answerView = [[UIView alloc]init];
    [self addSubview:answerView];
    answerView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    
    self.userAnswerLab = [[UILabel alloc]init];
    [answerView addSubview:self.userAnswerLab];
    self.userAnswerLab.text = @"您的答案";
    self.userAnswerLab.textColor = [UIColor colorCommonBlackColor];
    self.userAnswerLab.font = Font(15);
    [self.userAnswerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(answerView).offset(KSIphonScreenW(12));
        make.top.equalTo(answerView).offset(KSIphonScreenH(15));
    }];
    
    self.successAnswerLab = [[UILabel alloc]init];
    [answerView addSubview:self.successAnswerLab];
    self.successAnswerLab.text = @"正确答案：";
    self.successAnswerLab.textColor = [UIColor colorCommonBlackColor];
    self.successAnswerLab.font = Font(15);
    [self.successAnswerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(answerView).offset(KSIphonScreenW(215));
        make.centerY.equalTo(weakSelf.userAnswerLab.mas_centerY);
    }];
    
    self.thisQuestScoreLab = [[UILabel alloc]init];
    [answerView addSubview:self.thisQuestScoreLab];
    self.thisQuestScoreLab.text = @"本题得分：";
    self.thisQuestScoreLab.textColor = [UIColor colorCommonBlackColor];
    self.thisQuestScoreLab.font = Font(15);
    [self.thisQuestScoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.userAnswerLab.mas_left);
        make.top.equalTo(weakSelf.userAnswerLab.mas_bottom).offset(KSIphonScreenH(15));
    }];
    
    self.questScoreLab = [[UILabel alloc]init];
    [answerView addSubview:self.questScoreLab];
    self.questScoreLab.text =@"本题分值：";
    self.questScoreLab.textColor = [UIColor colorCommonBlackColor];
    self.questScoreLab.font = Font(15);
    [self.questScoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.successAnswerLab.mas_left);
        make.centerY.equalTo(weakSelf.thisQuestScoreLab.mas_centerY);
    }];
    
    [answerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(KSIphonScreenH(15));
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(15));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(15));
        make.bottom.equalTo(weakSelf.thisQuestScoreLab.mas_bottom).offset(KSIphonScreenH(15));
    }];
    answerView.layer.cornerRadius = KSIphonScreenH(10)/2;
    answerView.layer.masksToBounds = YES;
    answerView.layer.borderWidth = 1;
    answerView.layer.borderColor = [UIColor colorWithHexString:@"#e3e3e3"].CGColor;
    
    // 显示专业解析
    self.showProfAnalLab = [[UILabel alloc]init];
    [self addSubview:self.showProfAnalLab];
    self.showProfAnalLab.text = @"专业解析";
    self.showProfAnalLab.textColor = [UIColor colorConstantCommonBlueColor];
    self.showProfAnalLab.font = Font(16);
    [self.showProfAnalLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(answerView.mas_bottom).offset(KSIphonScreenH(25));
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(15));
    }];
    
    // 专业解析
    self.profAnalLab = [[UILabel alloc]init];
    [self addSubview:self.profAnalLab];
    self.profAnalLab.text = @"作业人员";
    self.profAnalLab.textColor = [UIColor colorCommonBlackColor];
    self.profAnalLab.font = Font(16);
    self.profAnalLab.numberOfLines = 0;
    [self.profAnalLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.showProfAnalLab.mas_bottom).offset(KSIphonScreenH(15));
        make.left.equalTo(weakSelf.showProfAnalLab.mas_left);
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(15));
    }];
    // 间距
    [UILabel changeLineSpaceForLabel:self.profAnalLab WithSpace:3];
}

-(void)setFootModel:(QuestionListModel *)footModel{
    _footModel = footModel;
    
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSInteger footerSize = [userD objectForKey:@"Font"] ? [[userD objectForKey:@"Font"][@"Footer"]integerValue] : 16 ;
    // 您的答案
    NSString *userAnswerStr ;
    if ([footModel.userAnswer isEqualToString:@""]) {
        userAnswerStr = @"-";
    }else{
        userAnswerStr = footModel.userAnswer;
    }
    self.userAnswerLab.text = [NSString stringWithFormat:@"您的答案: %@",userAnswerStr];
    self.userAnswerLab.font = Font(footerSize);
    
    // 正确答案
    self.successAnswerLab.text = [NSString stringWithFormat:@"正确答案: %@",footModel.answer];
    self.successAnswerLab.font = Font(footerSize);
    
    // 本题得分
    self.thisQuestScoreLab.text = [NSString stringWithFormat:@"本题得分: %@分",footModel.score];
    self.thisQuestScoreLab.font = Font(footerSize);
    
    // 本题分值
    self.questScoreLab.text = [NSString stringWithFormat:@"本题分值: %@分",footModel.minute];
    self.questScoreLab.font = Font(footerSize);
    
    // 解析
    NSString *analyzeStr = [NSString stringWithFormat:@"%@",footModel.analyze];
    self.profAnalLab.font = Font(footerSize);
    self.showProfAnalLab.font = Font(footerSize);
    if (![analyzeStr isEqualToString:@""]) {
        self.profAnalLab.hidden = NO;
        self.showProfAnalLab.hidden  = NO;
        
        self.profAnalLab.text =analyzeStr;
    }else{
        self.profAnalLab.hidden = YES;
        self.showProfAnalLab.hidden  = YES;
    }
}

//计算高度
+(CGFloat)getLabelHeightWithDict:(QuestionListModel *)footModel{
    CGFloat height =0 ;

    height += 130;
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSInteger analyzeSize = [userD objectForKey:@"Font"] ? [[userD objectForKey:@"Font"][@"Footer"]integerValue] : 16 ;
    
    // 解析
    NSString *analyzeStr = [NSString stringWithFormat:@"%@",footModel.analyze];
    if (![analyzeStr isEqualToString:@""]) {
        UILabel *lab = [[UILabel alloc]init];
        lab.text = footModel.analyze;
        height += [YWTTools getSpaceLabelHeight:lab.text withFont:analyzeSize withWidth:KScreenW-30 withSpace:3]+40;
    }
    
    // 参考答案
    NSString *answerStr = [NSString stringWithFormat:@"%@",footModel.answer];
    if (![answerStr isEqualToString:@""]) {
        UILabel *lab = [[UILabel alloc]init];
        lab.text = footModel.answer;
        height += [YWTTools getSpaceLabelHeight:lab.text withFont:analyzeSize withWidth:KScreenW-30 withSpace:3]+40;
    }
    return height ;
}




@end

