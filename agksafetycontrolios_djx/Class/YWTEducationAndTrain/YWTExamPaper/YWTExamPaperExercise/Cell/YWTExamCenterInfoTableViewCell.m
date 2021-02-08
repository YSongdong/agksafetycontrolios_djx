//
//  ExamCenterInfoTableViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/22.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTExamCenterInfoTableViewCell.h"

@interface YWTExamCenterInfoTableViewCell ()
// 考试名称
@property (nonatomic,strong) UILabel *examCenterNameLab;
// 考试名称
@property (nonatomic,strong) UILabel *examRoomNameLab;
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
// 考试类型
@property (nonatomic,strong) UILabel *examTypeLab;
//考试说明
@property (nonatomic,strong) UILabel *examMarkLab;
//考试时段
@property (nonatomic,strong) UILabel *examTimerSlotLab;



@end


@implementation YWTExamCenterInfoTableViewCell
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
    UIView *examCenterView = [[UIView alloc]init];
    [bgView addSubview:examCenterView];
    examCenterView.backgroundColor = [UIColor colorTextWhiteColor];
    [examCenterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoView.mas_bottom);
        make.left.right.bottom.equalTo(bgView);
    }];
    
    self.examCenterNameLab = [[UILabel alloc]init];
    [examCenterView addSubview:self.examCenterNameLab];
    self.examCenterNameLab.textColor = [UIColor colorCommonBlackColor];
    self.examCenterNameLab.font = Font(22);
    self.examCenterNameLab.numberOfLines = 0;
    [self.examCenterNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(examCenterView).offset(KSIphonScreenW(23));
        make.top.equalTo(examCenterView).offset(KSIphonScreenH(10));
        make.right.equalTo(examCenterView).offset(-KSIphonScreenW(23));
    }];
    
    UIView *examMarkView = [[UIView alloc]init];
    [examCenterView addSubview:examMarkView];
    examMarkView.backgroundColor = [UIColor colorWithHexString:@"#f1f6fe"];

    self.examRoomNameLab = [[UILabel alloc]init];
    [examMarkView addSubview:self.examRoomNameLab];
    self.examRoomNameLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.examRoomNameLab.font = Font(14);
    self.examRoomNameLab.numberOfLines = 0;
    [self.examRoomNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(examMarkView).offset(KSIphonScreenH(7));
        make.left.equalTo(examMarkView).offset(KSIphonScreenW(12));
        make.right.equalTo(examMarkView).offset(-KSIphonScreenW(12));
    }];

    self.examPaperNameLab = [[UILabel alloc]init];
    [examMarkView addSubview:self.examPaperNameLab];
    self.examPaperNameLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.examPaperNameLab.font = Font(14);
    self.examPaperNameLab.numberOfLines = 0;
    [self.examPaperNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.examRoomNameLab.mas_bottom).offset(KSIphonScreenH(7));
        make.left.equalTo(weakSelf.examRoomNameLab.mas_left);
        make.right.equalTo(weakSelf.examRoomNameLab.mas_right);
    }];

    self.examTimerSlotLab = [[UILabel alloc]init];
    [examMarkView addSubview:self.examTimerSlotLab];
    self.examTimerSlotLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.examTimerSlotLab.font = Font(14);
    self.examTimerSlotLab.numberOfLines = 0;
    [self.examTimerSlotLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.examPaperNameLab.mas_bottom).offset(KSIphonScreenH(7));
        make.left.equalTo(weakSelf.examPaperNameLab.mas_left);
        make.right.equalTo(weakSelf.examPaperNameLab.mas_right);
    }];

    [examMarkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.examCenterNameLab.mas_bottom).offset(KSIphonScreenH(10));
        make.left.equalTo(examCenterView).offset(KSIphonScreenW(12));
        make.right.equalTo(examCenterView).offset(-KSIphonScreenW(12));
        make.bottom.equalTo(weakSelf.examTimerSlotLab.mas_bottom).offset(KSIphonScreenH(5));
        make.centerX.equalTo(examCenterView.mas_centerX);
    }];
    examMarkView.layer.cornerRadius = 7;
    examMarkView.layer.masksToBounds = YES;
    
    UIView *contentView = [[UIView alloc]init];
    [examCenterView addSubview:contentView];
    contentView.backgroundColor = [UIColor colorTextWhiteColor];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(examMarkView.mas_bottom);
        make.left.equalTo(examCenterView).offset(KSIphonScreenW(12));
        make.right.equalTo(examCenterView).offset(-KSIphonScreenW(12));
        make.bottom.equalTo(examCenterView).offset(-KSIphonScreenH(10));
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

    // 线条view
    UIView *timeLineView = [[UIView alloc]init];
    [contentView addSubview:timeLineView];
    timeLineView.backgroundColor = [UIColor colorLineE3E3CommonGreyBlackColor];
    [timeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(KSIphonScreenH(17));
        make.bottom.equalTo(contentView).offset(-KSIphonScreenH(17));
        make.left.equalTo(questNumberView.mas_right);
        make.width.equalTo(@1);
    }];
    
    UIView *examTimeView = [[UIView alloc]init];
    [contentView addSubview:examTimeView];
    examTimeView.backgroundColor = [UIColor colorTextWhiteColor];
    [examTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(questNumberView.mas_right).offset(1);
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

    // 线条view
    UIView *totalLineView = [[UIView alloc]init];
    [contentView addSubview:totalLineView];
    totalLineView.backgroundColor = [UIColor colorLineE3E3CommonGreyBlackColor];
    [totalLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(timeLineView.mas_centerY);
        make.left.equalTo(examTimeView.mas_right);
        make.width.height.equalTo(timeLineView);
    }];
    
    UIView *totalScoreView = [[UIView alloc]init];
    [contentView addSubview:totalScoreView];
    totalScoreView.backgroundColor = [UIColor colorTextWhiteColor];
    [totalScoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(examTimeView.mas_right).offset(1);
        make.right.equalTo(contentView);
        make.height.width.equalTo(examTimeView);
        make.centerY.equalTo(examTimeView.mas_centerY);
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
        make.top.equalTo(questNumberView.mas_bottom).offset(1);
        make.left.equalTo(questNumberView.mas_left);
        make.bottom.equalTo(contentView.mas_bottom);
        make.height.width.equalTo(questNumberView);
    }];
    
    // 线条view
    UIView *passLineView = [[UIView alloc]init];
    [contentView addSubview:passLineView];
    passLineView.backgroundColor = [UIColor colorLineE3E3CommonGreyBlackColor];
    [passLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(questNumberView.mas_bottom);
        make.left.equalTo(contentView);
        make.right.equalTo(contentView);
        make.height.equalTo(@1);
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
    
    UIView *examMrakView = [[UIView alloc]init];
    [contentView addSubview:examMrakView];
    examMrakView.backgroundColor = [UIColor colorTextWhiteColor];
    [examMrakView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passScroeView.mas_right).offset(1);
        make.top.equalTo(passScroeView.mas_top);
        make.height.width.equalTo(passScroeView);
        make.centerY.equalTo(passScroeView.mas_centerY);
    }];
    
    UIView *markView = [[UIView alloc]init];
    [examMrakView addSubview:markView];

    self.examMarkLab = [[UILabel alloc]init];
    [markView addSubview:self.examMarkLab];
    self.examMarkLab.textColor = [UIColor colorCommonBlackColor];
    self.examMarkLab.font = BFont(15);
    self.examMarkLab.textAlignment = NSTextAlignmentCenter;
    [self.examMarkLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(markView.mas_top);
        make.left.equalTo(markView.mas_left);
        make.right.equalTo(markView.mas_right);
    }];

    UILabel *showExamMarkLab = [[UILabel alloc]init];
    [markView addSubview:showExamMarkLab];
    showExamMarkLab.text = @"考试说明";
    showExamMarkLab.textColor = [UIColor colorWithHexString:@"#999999"];
    showExamMarkLab.font = Font(15);
    [showExamMarkLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.examMarkLab.mas_bottom).offset(KSIphonScreenH(10));
        make.bottom.equalTo(markView.mas_bottom);
        make.centerX.equalTo(weakSelf.examMarkLab.mas_centerX);
    }];

    [markView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.examMarkLab.mas_top);
        make.width.equalTo(examMrakView);
        make.bottom.equalTo(showExamMarkLab.mas_bottom);
        make.centerX.equalTo(examMrakView.mas_centerX);
        make.centerY.equalTo(examMrakView.mas_centerY);
    }];
    
    UIView *examTypeView = [[UIView alloc]init];
    [contentView addSubview:examTypeView];
    examTypeView.backgroundColor = [UIColor colorTextWhiteColor];
    [examTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(examMrakView.mas_right).offset(1);
        make.right.equalTo(contentView.mas_right);
        make.height.width.equalTo(passScroeView);
        make.centerY.equalTo(passScroeView.mas_centerY);
    }];
    
    UIView *typeView = [[UIView alloc]init];
    [examTypeView addSubview:typeView];

    self.examTypeLab = [[UILabel alloc]init];
    [typeView addSubview:self.examTypeLab];
    self.examTypeLab.textColor = [UIColor colorCommonBlackColor];
    self.examTypeLab.font = BFont(15);
    self.examTypeLab.textAlignment = NSTextAlignmentCenter;
    [self.examTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(typeView.mas_top);
        make.left.equalTo(typeView.mas_left);
        make.right.equalTo(typeView.mas_right);
    }];

    UILabel *showExamTypeLab = [[UILabel alloc]init];
    [typeView addSubview:showExamTypeLab];
    showExamTypeLab.text = @"考试类型";
    showExamTypeLab.textColor = [UIColor colorWithHexString:@"#999999"];
    showExamTypeLab.font = Font(15);
    [showExamTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.examTypeLab.mas_bottom).offset(KSIphonScreenH(10));
        make.bottom.equalTo(typeView.mas_bottom);
        make.centerX.equalTo(weakSelf.examTypeLab.mas_centerX);
    }];

    [typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.examTypeLab.mas_top);
        make.width.equalTo(examTypeView);
        make.bottom.equalTo(showExamTypeLab.mas_bottom);
        make.centerX.equalTo(examTypeView.mas_centerX);
        make.centerY.equalTo(examTypeView.mas_centerY);
    }];
}
-(void)setDict:(NSDictionary *)dict{
    _dict =dict;
    
    // 考试名称
    self.examCenterNameLab.text =[NSString stringWithFormat:@"%@",dict[@"examRoomName"]];
    // 考场名称
    self.examRoomNameLab.text = [NSString stringWithFormat:@"%@",dict[@"examName"]];
    //试卷名称
    self.examPaperNameLab.text = [NSString stringWithFormat:@"%@",dict[@"title"]];
    //试题数目
    self.examPaperNumberLab.text = [NSString stringWithFormat:@"%@题",dict[@"questionNum"]];
    //考试时长
    self.examTimerLab.text = [NSString stringWithFormat:@"%@",[self getMMSSFromSS:[NSString stringWithFormat:@"%@",dict[@"examTotalTime"]]]];
    //试卷总分
    self.examPaperTotalScoreLab.text = [NSString stringWithFormat:@"%@分",dict[@"totalScore"]];
    //合格分数
    self.passScoreLab.text = [NSString stringWithFormat:@"%@分",dict[@"passScore"]];
    
    // 考试类型
    NSString *examTypeStr = [NSString stringWithFormat:@"%@",dict[@"examType"]];
    if ([examTypeStr isEqualToString:@"1"]) {
         self.examTypeLab.text = @"常规";
    }else if ([examTypeStr isEqualToString:@"2"]){
         self.examTypeLab.text = @"补考";
    }else if ([examTypeStr isEqualToString:@"3"]){
         self.examTypeLab.text = @"模拟考试";
    }
    
    // 考试说明
    NSString *examMarkStr =[NSString stringWithFormat:@"%@",dict[@"description"]];
    if ([examMarkStr isEqualToString:@""]) {
        self.examMarkLab.text = @"--";
    }else{
        self.examMarkLab.text = examMarkStr;
    }
    //考试时段
    self.examTimerSlotLab.text = [NSString stringWithFormat:@"%@",dict[@"timeSlot"]];
}
//传入 秒  得到 xx:xx:xx
-(NSString *)getMMSSFromSS:(NSString *)totalTime{
    NSInteger seconds = [totalTime integerValue];
    
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",seconds/60];

    NSString *format_time = [NSString stringWithFormat:@"%@分钟",str_minute];

    return format_time;
}


//计算高度
+(CGFloat)getLabelHeightWithDict:(NSDictionary *)dict{
    CGFloat height = 0;
    
     // 考试名称
    UILabel *examNameLab = [[UILabel alloc]init];
    examNameLab.text = [NSString stringWithFormat:@"%@",dict[@"examName"]];
    CGFloat examNameHeight = [YWTTools getLabelHeightWithText:examNameLab.text width:KScreenW-KSIphonScreenW(115) font:15];
    height += examNameHeight+KSIphonScreenH(10);
    // 考场名称
    UILabel *examRoomNameLab = [[UILabel alloc]init];
    examRoomNameLab.text = [NSString stringWithFormat:@"%@",dict[@"examName"]];
    CGFloat examRoomNameHeight = [YWTTools getLabelHeightWithText:examRoomNameLab.text width:KScreenW-KSIphonScreenW(115) font:15];
    height += examRoomNameHeight+KSIphonScreenH(10);
    //试卷名称
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = [NSString stringWithFormat:@"%@",dict[@"title"]];
    CGFloat titleHeight = [YWTTools getLabelHeightWithText:titleLab.text width:KScreenW-KSIphonScreenW(115) font:15];
    height += titleHeight+KSIphonScreenH(10);
    
    height += KSIphonScreenH(300);
    
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
