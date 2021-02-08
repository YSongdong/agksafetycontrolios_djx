//
//  DetailQuestInfoTableViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/16.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTDetailQuestInfoTableViewCell.h"

@interface YWTDetailQuestInfoTableViewCell ()
// 来源题库
@property (nonatomic,strong) YYLabel *sourceQuestionBankLab;
// 题数量
@property (nonatomic,strong) UILabel *questNumberLab;
// 考试时长
@property (nonatomic,strong) UILabel *examTimerLab;
// 试卷总分
@property (nonatomic,strong) UILabel *examPaperTotalLab;
// 及格分数
@property (nonatomic,strong) UILabel *passFractionLab;

@end

@implementation YWTDetailQuestInfoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createQuestTitleView];
    }
    return self;
}

-(void) createQuestTitleView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    UIView *questionInfoView = [[UIView alloc]init];
    [self addSubview:questionInfoView];
    questionInfoView.backgroundColor = [UIColor colorTextWhiteColor];
    [questionInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf).offset(-KSIphonScreenH(10));
    }];
 
    //显示show
    UILabel *showSourceQuestionBankLab = [[UILabel alloc]init];
    [questionInfoView addSubview:showSourceQuestionBankLab];
    showSourceQuestionBankLab.text = @"来源题库";
    showSourceQuestionBankLab.textColor = [UIColor colorCommonGreyBlackColor];
    showSourceQuestionBankLab.font = Font(14);
    [showSourceQuestionBankLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(questionInfoView).offset(KSIphonScreenH(15));
        make.left.equalTo(questionInfoView).offset(KSIphonScreenW(12));
    }];
   
    self.sourceQuestionBankLab = [[YYLabel alloc]init];
    [questionInfoView addSubview:self.sourceQuestionBankLab];
    self.sourceQuestionBankLab.textColor = [UIColor colorCommonBlackColor];
    self.sourceQuestionBankLab.font = Font(14);
    [self.sourceQuestionBankLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(showSourceQuestionBankLab.mas_top);
        make.left.equalTo(questionInfoView).offset(KSIphonScreenW(90));
        make.right.equalTo(questionInfoView).offset(-KSIphonScreenW(12));
    }];
    
    
    // 题数量
    self.questNumberLab = [[UILabel alloc]init];
    [questionInfoView addSubview:self.questNumberLab];
    self.questNumberLab.textColor = [UIColor colorCommonBlackColor];
    self.questNumberLab.font = Font(14);
    [self.questNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(questionInfoView).offset(KSIphonScreenW(90));
        make.top.equalTo(weakSelf.sourceQuestionBankLab.mas_bottom).offset(KSIphonScreenH(25));
    }];
    
    //显示 试卷题量
    UILabel *showQuestNumberLab = [[UILabel alloc]init];
    [questionInfoView addSubview:showQuestNumberLab];
    showQuestNumberLab.text = @"试卷题量";
    showQuestNumberLab.textColor = [UIColor colorCommonGreyBlackColor];
    showQuestNumberLab.font = Font(14);
    [showQuestNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(showSourceQuestionBankLab.mas_left);
        make.centerY.equalTo(weakSelf.questNumberLab.mas_centerY);
    }];
    
    //显示 考试时长
    UILabel *showExamTimeLab = [[UILabel alloc]init];
    [questionInfoView addSubview:showExamTimeLab];
    showExamTimeLab.textColor = [UIColor colorCommonGreyBlackColor];
    showExamTimeLab.text = @"考试时长";
    showExamTimeLab.font = Font(14);
    [showExamTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(questionInfoView).offset(KSIphonScreenW(212));
        make.centerY.equalTo(showQuestNumberLab.mas_centerY);
    }];
    
    //考试时长
    self.examTimerLab = [[UILabel alloc]init];
    [questionInfoView addSubview:self.examTimerLab];
    self.examTimerLab.font =Font(14);
    self.examTimerLab.textColor = [UIColor colorCommonBlackColor];
    [self.examTimerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(showExamTimeLab.mas_right).offset(KSIphonScreenW(30));
        make.centerY.equalTo(showExamTimeLab.mas_centerY);
    }];
    
    //显示 试卷总分
    UILabel *showExamPaperTotalLab = [[UILabel alloc]init];
    [questionInfoView addSubview:showExamPaperTotalLab];
    showExamPaperTotalLab.textColor = [UIColor colorCommonGreyBlackColor];
    showExamPaperTotalLab.text = @"试卷总分";
    showExamPaperTotalLab.font = Font(14);
    [showExamPaperTotalLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(showSourceQuestionBankLab.mas_left);
        make.top.equalTo(showQuestNumberLab.mas_bottom).offset(KSIphonScreenH(28));
    }];
    
    self.examPaperTotalLab = [[UILabel alloc]init];
    [questionInfoView addSubview:self.examPaperTotalLab];
    self.examPaperTotalLab.textColor = [UIColor colorCommonBlackColor];
    self.examPaperTotalLab.font = Font(14);
    [self.examPaperTotalLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.questNumberLab.mas_left);
        make.centerY.equalTo(showExamPaperTotalLab.mas_centerY);
    }];
    
    // 显示及格分数
    UILabel *showPassFractionLab = [[UILabel alloc]init];
    [questionInfoView addSubview:showPassFractionLab];
    showPassFractionLab.textColor = [UIColor colorCommonGreyBlackColor];
    showPassFractionLab.text = @"合格分数";
    showPassFractionLab.font = Font(14);
    [showPassFractionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(showExamTimeLab.mas_left);
        make.centerY.equalTo(showExamPaperTotalLab.mas_centerY);
    }];
    
    // 及格分数
    self.passFractionLab = [[UILabel alloc]init];
    [questionInfoView addSubview:self.passFractionLab];
    self.passFractionLab.textColor = [UIColor colorCommonBlackColor];
    self.passFractionLab.font = Font(14);
    [self.passFractionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(showPassFractionLab.mas_right).offset(KSIphonScreenH(28));
        make.centerY.equalTo(showPassFractionLab.mas_centerY);
    }];

}

-(void)setDetaModel:(YWTExamExerDetaModel *)detaModel{
    _detaModel = detaModel;
    
    // 来源题库
    self.sourceQuestionBankLab.text = @"";
    
    NSArray *libaryListArr = detaModel.libaryList;
    // title
    NSMutableString *mutableStr = [NSMutableString string];
    //是跳转数据源
    NSMutableArray *jumpArr = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    if (libaryListArr.count > 0) {
        for (int i=0; i<libaryListArr.count; i++) {
            libaryListModel *model = libaryListArr[i];
            [mutableStr appendString:[NSString stringWithFormat:@"%@",model.title]];
            [mutableStr appendString:@";"];
            //1是可以跳转 2是不能跳转
            NSString *jumpStr = [NSString stringWithFormat:@"%@",model.jump];
            if ([jumpStr isEqualToString:@"1"]) {
                [jumpArr addObject:model.title];
            }
        }
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:mutableStr];
        text.yy_font = Font(14);
        text.yy_lineSpacing = 4;
        text.yy_color = [UIColor colorConstantCommonBlueColor];
        if (jumpArr.count > 0) {
            for (NSString *jumpStr in jumpArr) {
                NSRange range ;
                range = [mutableStr rangeOfString:jumpStr];
                [text yy_setTextHighlightRange:range color:[UIColor colorConstantCommonBlueColor] backgroundColor:[UIColor colorTextWhiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                    
                    NSString *textStr = [mutableStr substringWithRange:range];
                    weakSelf.pushLibayExer(textStr);
                }];
            }
        }
        self.sourceQuestionBankLab.numberOfLines = 0;
        //设置最大的宽度
        self.sourceQuestionBankLab.preferredMaxLayoutWidth =KScreenW-KSIphonScreenW(100);
        self.sourceQuestionBankLab.attributedText = text;
        
    }
    
    // 试卷总分
    self.examPaperTotalLab.text = [NSString stringWithFormat:@"%ld分",(long)[detaModel.totalScore integerValue]];
    
    // 合格分数
    self.passFractionLab.text = [NSString stringWithFormat:@"%ld分",(long)[detaModel.passScore integerValue]];
    
    // 题目数量
    self.questNumberLab.text = [NSString stringWithFormat:@"%ld题",(long)[detaModel.questionNum integerValue]];
    // 考试时长
    self.examTimerLab.text = [NSString stringWithFormat:@"%ld分",(long)[detaModel.examTotalTime integerValue]];
    
}

//计算高度
+(CGFloat)getLabelHeightWithDict:(YWTExamExerDetaModel*) model{
    CGFloat height = 0.0;
    height += 130;
    
     NSArray *libaryListArr = model.libaryList;
    // title
    NSMutableString *mutableStr = [NSMutableString string];
    //是跳转数据源
    NSMutableArray *jumpArr = [NSMutableArray array];
    if (libaryListArr.count > 0) {
        for (int i=0; i<libaryListArr.count; i++) {
            libaryListModel *model = libaryListArr[i];
            [mutableStr appendString:[NSString stringWithFormat:@"%@",model.title]];
            [mutableStr appendString:@";"];
            //1是可以跳转 2是不能跳转
            NSString *jumpStr = [NSString stringWithFormat:@"%@",model.jump];
            if ([jumpStr isEqualToString:@"1"]) {
                [jumpArr addObject:model.title];
            }
        }
    }
    CGFloat questHeight = [YWTTools getSpaceLabelHeight:mutableStr withFont:14 withWidth:KScreenW-KSIphonScreenW(118) withSpace:2];
    height += questHeight;
    
    height += KSIphonScreenH(5);
    
    return height;
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
