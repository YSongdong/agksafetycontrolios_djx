//
//  ExamPaperInfoTableViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/16.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTExamPaperInfoTableViewCell.h"

@interface YWTExamPaperInfoTableViewCell ()
// 试卷名称
@property (nonatomic,strong) UILabel *examPaperNameLab;
// 试卷数目
@property (nonatomic,strong) UILabel *examPaperNumberLab;
// 考试时长
@property (nonatomic,strong) UILabel *examTimerLab;
// 试卷总分
@property (nonatomic,strong) UILabel *examPaperTotalScoreLab;
// 及格分数
@property (nonatomic,strong) UILabel *passScoreLab;
@end

@implementation YWTExamPaperInfoTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createInfoView];
    }
    return self;
}
-(void)createInfoView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor  =[UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(KSIphonScreenH(12));
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
        make.bottom.equalTo(weakSelf);
    }];
    bgView.layer.cornerRadius = KSIphonScreenH(7);
    bgView.layer.masksToBounds = YES;
    bgView.layer.borderWidth = 1;
    bgView.layer.borderColor =  [UIColor colorLineCommonGreyBlackColor].CGColor;
    
    UIView *infoView = [[UIView alloc]init];
    [bgView addSubview:infoView];
    infoView.backgroundColor = [UIColor colorTextWhiteColor];
    
    UIView *leftLineView = [[UIView alloc]init];
    [infoView addSubview:leftLineView];
    leftLineView.backgroundColor = [UIColor colorConstantCommonBlueColor];
    [leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infoView).offset(KSIphonScreenW(12));
        make.width.equalTo(@2);
        make.centerY.equalTo(infoView.mas_centerY);
        make.height.equalTo(@(KSIphonScreenH(10)));
    }];
    
    UILabel *showCandidateInfoLab = [[UILabel alloc]init];
    [infoView addSubview:showCandidateInfoLab];
    showCandidateInfoLab.text = @"试卷信息";
    showCandidateInfoLab.textColor = [UIColor colorCommonBlackColor];
    showCandidateInfoLab.font = BFont(14);
    [showCandidateInfoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftLineView.mas_right).offset(KSIphonScreenW(5));
        make.centerY.equalTo(leftLineView.mas_centerY);
    }];
    
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(bgView);
        make.height.equalTo(@(KSIphonScreenH(42)));
    }];
    
    UIView *infoLineView = [[UIView alloc]init];
    [infoView addSubview:infoLineView];
    infoLineView.backgroundColor = [UIColor colorLineE3E3CommonGreyBlackColor];
    [infoLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infoView).offset(KSIphonScreenW(12));
        make.right.equalTo(infoView).offset(-KSIphonScreenW(12));
        make.bottom.equalTo(infoView);
        make.height.equalTo(@1);
    }];
    
    // 试卷信息
    UIView *examPaperView = [[UIView alloc]init];
    [bgView addSubview:examPaperView];
    examPaperView.backgroundColor = [UIColor colorTextWhiteColor];
    [examPaperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoView.mas_bottom);
        make.left.right.bottom.equalTo(bgView);
    }];
    
    self.examPaperNameLab = [[UILabel alloc]init];
    [examPaperView addSubview:self.examPaperNameLab];
    self.examPaperNameLab.textColor = [UIColor colorCommonBlackColor];
    self.examPaperNameLab.font = BFont(23);
    self.examPaperNameLab.numberOfLines = 0;
    [self.examPaperNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(examPaperView).offset(KSIphonScreenW(23));
        make.top.equalTo(examPaperView).offset(KSIphonScreenH(17));
        make.right.equalTo(examPaperView).offset(-KSIphonScreenW(23));
    }];
    
    UIView *contentView = [[UIView alloc]init];
    [examPaperView addSubview:contentView];
    contentView.backgroundColor = [UIColor colorLineE3E3CommonGreyBlackColor];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.examPaperNameLab.mas_bottom).offset(KSIphonScreenH(30));
        make.left.equalTo(examPaperView).offset(KSIphonScreenW(12));
        make.right.equalTo(examPaperView).offset(-KSIphonScreenW(12));
        make.bottom.equalTo(examPaperView).offset(-KSIphonScreenH(12));
    }];

    UIView *questNumberView = [[UIView alloc]init];
    [contentView addSubview:questNumberView];
    questNumberView.backgroundColor = [UIColor colorTextWhiteColor];
    [questNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView);
        make.left.equalTo(contentView);
    }];

    UIView *numberView = [[UIView alloc]init];
    [questNumberView addSubview:numberView];
    
    self.examPaperNumberLab = [[UILabel alloc]init];
    [numberView addSubview:self.examPaperNumberLab];
    self.examPaperNumberLab.textColor = [UIColor colorCommonBlackColor];
    self.examPaperNumberLab.font = BFont(15);
    self.examPaperNumberLab.textAlignment = NSTextAlignmentCenter;
    [self.examPaperNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(numberView.mas_top);
        make.left.equalTo(numberView.mas_left);
        make.right.equalTo(numberView.mas_right);
    }];
    
    UILabel *showExamPaperNumberLab = [[UILabel alloc]init];
    [numberView addSubview:showExamPaperNumberLab];
    showExamPaperNumberLab.text = @"试题数目";
    showExamPaperNumberLab.textColor = [UIColor colorWithHexString:@"#999999"];
    showExamPaperNumberLab.font = Font(15);
    [showExamPaperNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.examPaperNumberLab.mas_bottom).offset(KSIphonScreenH(10));
        make.bottom.equalTo(numberView.mas_bottom);
        make.centerX.equalTo(weakSelf.examPaperNumberLab.mas_centerX);
    }];
    
    [numberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.examPaperNumberLab.mas_top);
        make.width.equalTo(questNumberView);
        make.bottom.equalTo(showExamPaperNumberLab.mas_bottom);
        make.centerX.equalTo(questNumberView.mas_centerX);
        make.centerY.equalTo(questNumberView.mas_centerY);
    }];
    
    UIView *examTimeView = [[UIView alloc]init];
    [contentView addSubview:examTimeView];
    
    examTimeView.backgroundColor = [UIColor colorTextWhiteColor];
    [examTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(questNumberView.mas_right).offset(1);
        make.right.equalTo(contentView.mas_right);
        make.height.width.equalTo(questNumberView);
        make.centerY.equalTo(questNumberView.mas_centerY);
    }];

    UIView *timeView = [[UIView alloc]init];
    [examTimeView addSubview:timeView];
    
    self.examTimerLab = [[UILabel alloc]init];
    [timeView addSubview:self.examTimerLab];
    self.examTimerLab.textColor = [UIColor colorCommonBlackColor];
    self.examTimerLab.font = BFont(15);
    self.examTimerLab.textAlignment = NSTextAlignmentCenter;
    [self.examTimerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeView.mas_top);
        make.left.equalTo(timeView.mas_left);
        make.right.equalTo(timeView.mas_right);
    }];
    
    UILabel *showExamTimerLab = [[UILabel alloc]init];
    [timeView addSubview:showExamTimerLab];
    showExamTimerLab.text = @"考试时长";
    showExamTimerLab.textColor = [UIColor colorWithHexString:@"#999999"];
    showExamTimerLab.font = Font(15);
    [showExamTimerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.examTimerLab.mas_bottom).offset(KSIphonScreenH(10));
        make.bottom.equalTo(timeView.mas_bottom);
        make.centerX.equalTo(weakSelf.examTimerLab.mas_centerX);
    }];
    
    [timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.examTimerLab.mas_top);
        make.width.equalTo(examTimeView);
        make.bottom.equalTo(showExamTimerLab.mas_bottom);
        make.centerX.equalTo(examTimeView.mas_centerX);
        make.centerY.equalTo(examTimeView.mas_centerY);
    }];
    

    UIView *totalScoreView = [[UIView alloc]init];
    [contentView addSubview:totalScoreView];
    totalScoreView.backgroundColor = [UIColor colorTextWhiteColor];
    [totalScoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(questNumberView.mas_left);
        make.top.equalTo(questNumberView.mas_bottom).offset(1);
        make.height.width.equalTo(questNumberView);
        make.bottom.equalTo(contentView.mas_bottom);
        make.centerX.equalTo(questNumberView.mas_centerX);
    }];
    
    UIView *totalView = [[UIView alloc]init];
    [totalScoreView addSubview:totalView];

    self.examPaperTotalScoreLab = [[UILabel alloc]init];
    [totalView addSubview:self.examPaperTotalScoreLab];
    self.examPaperTotalScoreLab.textColor = [UIColor colorCommonBlackColor];
    self.examPaperTotalScoreLab.font = BFont(15);
    self.examPaperTotalScoreLab.textAlignment = NSTextAlignmentCenter;
    [self.examPaperTotalScoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(totalView.mas_top);
        make.left.equalTo(totalView.mas_left);
        make.right.equalTo(totalView.mas_right);
    }];

    UILabel *showExamPaperTotalScoreLab = [[UILabel alloc]init];
    [totalView addSubview:showExamPaperTotalScoreLab];
    showExamPaperTotalScoreLab.text = @"试卷总分";
    showExamPaperTotalScoreLab.textColor = [UIColor colorWithHexString:@"#999999"];
    showExamPaperTotalScoreLab.font = Font(15);
    [showExamPaperTotalScoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.examPaperTotalScoreLab.mas_bottom).offset(KSIphonScreenH(10));
        make.bottom.equalTo(totalView.mas_bottom);
        make.centerX.equalTo(weakSelf.examPaperTotalScoreLab.mas_centerX);
    }];

    [totalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.examPaperTotalScoreLab.mas_top);
        make.width.equalTo(totalScoreView);
        make.bottom.equalTo(showExamPaperTotalScoreLab.mas_bottom);
        make.centerX.equalTo(totalScoreView.mas_centerX);
        make.centerY.equalTo(totalScoreView.mas_centerY);
    }];
    
    UIView *passScroeView = [[UIView alloc]init];
    [contentView addSubview:passScroeView];
    
    passScroeView.backgroundColor = [UIColor colorTextWhiteColor];
    [passScroeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(totalScoreView.mas_right).offset(1);
        make.right.equalTo(contentView);
        make.height.width.equalTo(totalScoreView);
        make.centerY.equalTo(totalScoreView.mas_centerY);
    }];
    
    UIView *passView = [[UIView alloc]init];
    [passScroeView addSubview:passView];

    self.passScoreLab = [[UILabel alloc]init];
    [passView addSubview:self.passScoreLab];
    self.passScoreLab.textColor = [UIColor colorCommonBlackColor];
    self.passScoreLab.font = BFont(15);
    self.passScoreLab.textAlignment = NSTextAlignmentCenter;
    [self.passScoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passView.mas_top);
        make.left.equalTo(passView.mas_left);
        make.right.equalTo(passView.mas_right);
    }];

    UILabel *showPassScoreLab = [[UILabel alloc]init];
    [passView addSubview:showPassScoreLab];
    showPassScoreLab.text = @"及格分数";
    showPassScoreLab.textColor = [UIColor colorWithHexString:@"#999999"];
    showPassScoreLab.font = Font(15);
    [showPassScoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.passScoreLab.mas_bottom).offset(KSIphonScreenH(10));
        make.bottom.equalTo(passView.mas_bottom);
        make.centerX.equalTo(weakSelf.passScoreLab.mas_centerX);
    }];

    [passView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.passScoreLab.mas_top);
        make.width.equalTo(passScroeView);
        make.bottom.equalTo(showPassScoreLab.mas_bottom);
        make.centerX.equalTo(passScroeView.mas_centerX);
        make.centerY.equalTo(passScroeView.mas_centerY);
    }];
}
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    // 试卷名称
   self.examPaperNameLab.text = [NSString stringWithFormat:@"%@",dict[@"title"]];
    // 题目数量
    self.examPaperNumberLab.text = [NSString stringWithFormat:@"%ld题",[dict[@"questionNum"]integerValue]];
    // 考试时长
    self.examTimerLab.text = [NSString stringWithFormat:@"%@",[self getMMSSFromExamTotalTime:[NSString stringWithFormat:@"%@",dict[@"examTotalTime"]]]];
    // 试卷总分
    self.examPaperTotalScoreLab.text = [NSString stringWithFormat:@"%ld分",[dict[@"totalScore"]integerValue]];
    // 及格分数
    self.passScoreLab.text = [NSString stringWithFormat:@"%ld分",[dict[@"passScore"]integerValue]];
}
//传入 秒  得到 xx:xx:xx
-(NSString *)getMMSSFromExamTotalTime:(NSString *)totalTime{
    NSInteger seconds = [totalTime integerValue];
    
    //format of hour
    //    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",seconds/60];
    //format of second
    //    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time;
    //    if ([str_hour isEqualToString:@"00"]) {
    //        format_time = [NSString stringWithFormat:@"%@分%@秒",str_minute,str_second];
    //    }else{
    format_time = [NSString stringWithFormat:@"%@分钟",str_minute];
    //    }
    return format_time;
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
