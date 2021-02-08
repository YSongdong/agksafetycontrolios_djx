//
//  ExamPaperListTableViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/15.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTExamPaperListTableViewCell.h"

@interface YWTExamPaperListTableViewCell ()
// 题库来源
@property (nonatomic,strong) UILabel *questionBankSourceLab;
// 更新时间
@property (nonatomic,strong) UILabel *updateTimeLab;
//试卷名称
@property (nonatomic,strong) UILabel *examNameLab;
//考试数目
@property (nonatomic,strong) UILabel *questionNumberLab;
// 考试时长
@property (nonatomic,strong) UILabel *examTimerLab;
// 考试总分
@property (nonatomic,strong) UILabel *examTotalScoreLab;
// 及格分数
@property (nonatomic,strong) UILabel *passScoreLab;
// 开始练习按钮
@property (nonatomic,strong) UIButton *beginExerciseBtn;

@end

@implementation YWTExamPaperListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createTableViewCellView];
    }
    return self;
}

-(void) createTableViewCellView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor  = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
        make.bottom.equalTo(weakSelf).offset(-KSIphonScreenH(12));
    }];
    bgView.layer.cornerRadius = KSIphonScreenH(8);
    bgView.layer.masksToBounds = YES;
    bgView.layer.borderWidth = 1;
    bgView.layer.borderColor =  [UIColor colorLineCommonGreyBlackColor].CGColor;
    
    UIImageView *leftImageV = [[UIImageView alloc]init];
    [bgView addSubview:leftImageV];
    leftImageV.image = [UIImage imageNamed:@"ico_lytk"];
    [leftImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(KSIphonScreenH(15));
        make.left.equalTo(bgView).offset(KSIphonScreenW(15));
        make.height.equalTo(@(KSIphonScreenH(18)));
        make.width.equalTo(@(KSIphonScreenW(45)));
    }];
    
    // 题库来源
    self.questionBankSourceLab = [[UILabel alloc]init];
    [bgView addSubview:self.questionBankSourceLab];
    self.questionBankSourceLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.questionBankSourceLab.font = Font(13);
    self.questionBankSourceLab.text = @"工程造价管理基础理论知识";
    [self.questionBankSourceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftImageV.mas_right).offset(KSIphonScreenW(5));
        make.centerY.equalTo(leftImageV.mas_centerY);
    }];
    // 更新时间
    self.updateTimeLab = [[UILabel alloc]init];
    [bgView addSubview:self.updateTimeLab];
    self.updateTimeLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.updateTimeLab.text = @"更新时间：2018.10.14";
    self.updateTimeLab.font = Font(13);
    self.updateTimeLab.textAlignment = NSTextAlignmentRight;
    [self.updateTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.questionBankSourceLab.mas_right).offset(KSIphonScreenW(8));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(15));
        make.centerY.equalTo(leftImageV.mas_centerY);
        make.width.equalTo(@(KSIphonScreenW(132)));
    }];
    
    //试卷名称
    self.examNameLab = [[UILabel alloc]init];
    [bgView addSubview:self.examNameLab];
    self.examNameLab.text = @"工程造价";
    self.examNameLab.textColor = [UIColor colorCommonBlackColor];
    self.examNameLab.font = BFont(18);
    [self.examNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftImageV.mas_bottom).offset(KSIphonScreenH(20));
        make.left.equalTo(leftImageV.mas_left);
        make.right.equalTo(weakSelf.updateTimeLab.mas_right);
    }];
    
    UIView *bottomView = [[UIView alloc]init];
    [bgView addSubview:bottomView];
    bottomView.backgroundColor = [UIColor colorTextWhiteColor];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.examNameLab.mas_bottom).offset(KSIphonScreenH(15));
        make.left.right.equalTo(weakSelf.examNameLab);
        make.height.equalTo(@(KSIphonScreenH(40)));
    }];
    
    // 考试数目说明
    UILabel *showQuestNumberLab = [[UILabel alloc]init];
    [bottomView addSubview:showQuestNumberLab];
    showQuestNumberLab.text = @"试题数目";
    showQuestNumberLab.textColor =[UIColor colorCommon65GreyBlackColor];
    showQuestNumberLab.font = Font(12);
    [showQuestNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView);
        make.bottom.equalTo(bottomView).offset(-KSIphonScreenH(3));
    }];
    
    //考试数目
    self.questionNumberLab = [[UILabel alloc]init];
    [bottomView addSubview:self.questionNumberLab];
    self.questionNumberLab.textColor = [UIColor colorCommonBlackColor];
    self.questionNumberLab.font = Font(12);
    [self.questionNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(showQuestNumberLab.mas_top).offset(-KSIphonScreenH(5));
        make.centerX.equalTo(showQuestNumberLab.mas_centerX);
    }];

    // 线条
    UIImageView *numberLineImageV = [[UIImageView alloc]init];
    [bottomView addSubview:numberLineImageV];
    numberLineImageV.image = [UIImage imageNamed:@"ico_line"];
    [numberLineImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(KSIphonScreenW(53));
        make.width.equalTo(@1);
        make.height.equalTo(bottomView.mas_height);
        make.centerY.equalTo(bottomView.mas_centerY);
    }];

    // 考试时长说明
    UILabel *showTimerLab = [[UILabel alloc]init];
    [bottomView addSubview:showTimerLab];
    showTimerLab.text = @"考试时长";
    showTimerLab.textColor =[UIColor colorCommon65GreyBlackColor];
    showTimerLab.font = Font(12);
    [showTimerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(numberLineImageV.mas_right).offset(KSIphonScreenW(8));
        make.bottom.equalTo(showQuestNumberLab.mas_bottom);
    }];
    
    // 考试时长
    self.examTimerLab = [[UILabel alloc]init];
    [bottomView addSubview:self.examTimerLab];
    self.examTimerLab.textColor = [UIColor colorCommonBlackColor];
    self.examTimerLab.font = Font(12);
    [self.examTimerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(showTimerLab.mas_centerX);
        make.centerY.equalTo(weakSelf.questionNumberLab.mas_centerY);
    }];
    // 时长lineView
    UIImageView *timerLineImageV = [[UIImageView alloc]init];
    [bottomView addSubview:timerLineImageV];
    timerLineImageV.image = [UIImage imageNamed:@"ico_line"];
    [timerLineImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(numberLineImageV.mas_right).offset(KSIphonScreenW(66));
        make.width.height.equalTo(numberLineImageV);
        make.centerY.equalTo(numberLineImageV.mas_centerY);
    }];

    // 试卷总分说明
    UILabel *showExamTotalLab = [[UILabel alloc]init];
    [bottomView addSubview:showExamTotalLab];
    showExamTotalLab.text = @"试卷总分";
    showExamTotalLab.textColor =[UIColor colorCommon65GreyBlackColor];
    showExamTotalLab.font = Font(12);
    [showExamTotalLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timerLineImageV.mas_right).offset(KSIphonScreenW(8));
        make.bottom.equalTo(showTimerLab.mas_bottom);
    }];
    
    // 考试总分
    self.examTotalScoreLab = [[UILabel alloc]init];
    [bottomView addSubview:self.examTotalScoreLab];
    self.examTotalScoreLab.textColor = [UIColor colorCommonBlackColor];
    self.examTotalScoreLab.font = Font(12);
    [self.examTotalScoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(showExamTotalLab.mas_centerX);
        make.centerY.equalTo(weakSelf.questionNumberLab.mas_centerY);
    }];
    
    // 总分分割线
    UIImageView *totalScoreLineImageV = [[UIImageView alloc]init];
    [bottomView addSubview:totalScoreLineImageV];
    totalScoreLineImageV.image = [UIImage imageNamed:@"ico_line"];
    [totalScoreLineImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timerLineImageV.mas_right).offset(KSIphonScreenW(66));
        make.width.height.equalTo(timerLineImageV);
        make.centerY.equalTo(timerLineImageV.mas_centerY);
    }];
    
    // 及格分数说明
    UILabel *showPassScoreLab = [[UILabel alloc]init];
    [bottomView addSubview:showPassScoreLab];
    showPassScoreLab.text = @"及格分数";
    showPassScoreLab.textColor =[UIColor colorCommon65GreyBlackColor];
    showPassScoreLab.font = Font(12);
    [showPassScoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(totalScoreLineImageV.mas_right).offset(KSIphonScreenW(10));
        make.bottom.equalTo(showTimerLab.mas_bottom);
        make.width.equalTo(@(KSIphonScreenW(50)));
    }];
    
    // 及格分数
    self.passScoreLab = [[UILabel alloc]init];
    [bottomView addSubview:self.passScoreLab];
    self.passScoreLab.textColor = [UIColor colorCommonBlackColor];
    self.passScoreLab.font = Font(12);
    [self.passScoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(showPassScoreLab.mas_centerX);
        make.centerY.equalTo(weakSelf.questionNumberLab.mas_centerY);
    }];
    
    // 开始练习按钮
    self.beginExerciseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomView addSubview:self.beginExerciseBtn];
    [self.beginExerciseBtn setTitle:@"开始测验" forState:UIControlStateNormal];
    self.beginExerciseBtn.titleLabel.font = Font(12);
    [self.beginExerciseBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    [self.beginExerciseBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorLineCommonBlueColor]] forState:UIControlStateNormal];
    [self.beginExerciseBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorClickCommonBlueColor]] forState:UIControlStateHighlighted];
    [self.beginExerciseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView);
        make.centerY.equalTo(bottomView.mas_centerY);
        make.left.equalTo(showPassScoreLab.mas_right).offset(KSIphonScreenW(15));
        make.height.equalTo(@(KSIphonScreenH(32)));
    }];
    self.beginExerciseBtn.layer.cornerRadius = KSIphonScreenH(32)/2;
    self.beginExerciseBtn.layer.masksToBounds = YES;
    [self.beginExerciseBtn addTarget:self action:@selector(selectExerBtn:) forControlEvents:UIControlEventTouchUpInside];
    
}
// 练习按钮
-(void) selectExerBtn:(UIButton *) sender{
    self.selectExerBlock();
}
// UILabel 富文本
/*
 nameStr : 传入的文字
 colorStr   : 要想修改的文字
*/
-(NSMutableAttributedString *) getAttrbuteNameStr:(NSString *)nameStr andAlterColorStr:(NSString *)colorStr{
    NSMutableAttributedString  *attributStr = [[NSMutableAttributedString alloc]initWithString:nameStr];
    NSRange range;
    range = [nameStr rangeOfString:colorStr];
    if (range.location != NSNotFound) {
        // 设置颜色
        [attributStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorConstantCommonBlueColor] range:range];
        // 设置字体
        [attributStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:range];
    }
    return attributStr;
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    // 来源题库
    NSArray *libaryIdArr = [dict[@"libaryId"] componentsSeparatedByString:@","];
    if (libaryIdArr.count == 0) {
        self.questionBankSourceLab.text = @"";
    }else{
        NSMutableString *questStr = [NSMutableString string];
        for (NSString *str in libaryIdArr) {
            [questStr appendString:str];
        }
        self.questionBankSourceLab.text =questStr;
    }
    
    //   状态  1继续考试 2开始考试
    NSString *statuStr = [NSString stringWithFormat:@"%@",dict[@"status"]];
    if ([statuStr isEqualToString:@"2"]) {
        [self.beginExerciseBtn setTitle:@"开始测验" forState:UIControlStateNormal];
    }else{
        [self.beginExerciseBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorContinueBtnIsSelectColor:NO]] forState:UIControlStateNormal];
        [self.beginExerciseBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorContinueBtnIsSelectColor:YES]] forState:UIControlStateSelected|UIControlStateHighlighted];
        [self.beginExerciseBtn setTitle:@"继续测验" forState:UIControlStateNormal];
    }
    
    //试卷名称
    self.examNameLab.text = dict[@"title"];
    // 更新时间
    self.updateTimeLab.text =[NSString stringWithFormat:@"更新时间:%@",dict[@"updateTime"]];
    // 题目数量
    NSString *questStr = [NSString stringWithFormat:@"%@",dict[@"topic"]];
    self.questionNumberLab.attributedText = [self getAttrbuteNameStr:[NSString stringWithFormat:@"%@/题",questStr] andAlterColorStr:questStr];
    
    // 考试时长
    NSString *examStr =[NSString stringWithFormat:@"%@",dict[@"examTotalTime"]];
    self.examTimerLab.attributedText = [self getAttrbuteNameStr:[NSString stringWithFormat:@"%@/分钟",examStr] andAlterColorStr:examStr];
    
    // 总分
    NSString *examTotalStr =[NSString stringWithFormat:@"%@",dict[@"totalScore"]];
    self.examTotalScoreLab.attributedText = [self getAttrbuteNameStr:[NSString stringWithFormat:@"%@/分",examTotalStr] andAlterColorStr:examTotalStr];
    
    // 及格分数
    NSString *passScoreStr =[NSString stringWithFormat:@"%@",dict[@"passScore"]];
    self.passScoreLab.attributedText = [self getAttrbuteNameStr:[NSString stringWithFormat:@"%@/分",passScoreStr] andAlterColorStr:passScoreStr];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
