//
//  ExamCenterRecordTableViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/23.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTExamCenterRecordTableViewCell.h"

@interface YWTExamCenterRecordTableViewCell ()
// 成绩状态
@property (nonatomic,strong) UIImageView *scroeImageV;
// 考场名称
@property (nonatomic,strong) UILabel *examRoomNameLab;
// 考试名称
@property (nonatomic,strong) UILabel *examNameLab;
// 试卷名称
@property (nonatomic,strong) UILabel *examPaperNameLab;
// 开始考试时间
@property (nonatomic,strong) UILabel *beginExamTimerLab;
// 考试耗时
@property (nonatomic,strong) UILabel *examTimeConsumLab;
// 考试得分
@property (nonatomic,strong) UILabel *examScroeLab;
// 考试结果
@property (nonatomic,strong) UILabel *examResultLab;
// 考试类型
@property (nonatomic,strong) UILabel *examTypeLab;

@end


@implementation YWTExamCenterRecordTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createExamCenterRecordView];
    }
    return self;
}
-(void) createExamCenterRecordView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
        make.height.equalTo(weakSelf).offset(-KSIphonScreenH(12));
    }];
    bgView.layer.cornerRadius = KSIphonScreenH(7);
    bgView.layer.masksToBounds = YES;
    bgView.layer.borderWidth =1;
    bgView.layer.borderColor = [UIColor colorWithHexString:@"#e3e3e3"].CGColor;
    
    self.scroeImageV = [[UIImageView alloc]init];
    [bgView addSubview:self.scroeImageV];
    [self.scroeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(bgView);
    }];
    
    self.examRoomNameLab = [[UILabel alloc]init];
    [bgView addSubview:self.examRoomNameLab];
    self.examRoomNameLab.textColor = [UIColor colorCommonBlackColor];
    self.examRoomNameLab.font = BFont(17);
    self.examRoomNameLab.numberOfLines = 0;
    [self.examRoomNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(KSIphonScreenH(15));
        make.left.equalTo(bgView).offset(KSIphonScreenW(15));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(55));
    }];
    
    self.examNameLab = [[UILabel alloc]init];
    [bgView addSubview:self.examNameLab];
    self.examNameLab.textColor = [UIColor colorConstantCommonBlueColor];
    self.examNameLab.font = Font(14);
    [self.examNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.examRoomNameLab.mas_bottom).offset(KSIphonScreenH(20));
        make.left.equalTo(weakSelf.examRoomNameLab.mas_left);
        make.right.equalTo(bgView).offset(-KSIphonScreenW(15));
    }];
    
    // 试卷名称
    self.examPaperNameLab = [[UILabel alloc]init];
    [bgView addSubview:self.examPaperNameLab];
    self.examPaperNameLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.examPaperNameLab.font = Font(14);
    self.examPaperNameLab.numberOfLines = 2;
    [self.examPaperNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.examNameLab.mas_bottom).offset(KSIphonScreenH(6));
        make.left.equalTo(weakSelf.examNameLab.mas_left);
        make.right.equalTo(bgView).offset(-KSIphonScreenW(15));
    }];
    
    // 显示开考时间
    self.beginExamTimerLab = [[UILabel alloc]init];
    [bgView addSubview:self.beginExamTimerLab];
    self.beginExamTimerLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.beginExamTimerLab.font = Font(14);
    [self.beginExamTimerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.examPaperNameLab.mas_bottom).offset(KSIphonScreenH(15));
        make.left.equalTo(weakSelf.examPaperNameLab.mas_left);
    }];
    
    // 考试耗时
    self.examTimeConsumLab = [[UILabel alloc]init];
    [bgView addSubview:self.examTimeConsumLab];
    self.examTimeConsumLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.examTimeConsumLab.font = Font(14);
    [self.examTimeConsumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(KSIphonScreenW(225));
        make.centerY.equalTo(weakSelf.beginExamTimerLab.mas_centerY);
    }];
    
    // 考试得分
    self.examScroeLab = [[UILabel alloc]init];
    [bgView addSubview:self.examScroeLab];
    self.examScroeLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.examScroeLab.font = Font(14);
    [self.examScroeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.beginExamTimerLab.mas_left);
        make.top.equalTo(weakSelf.beginExamTimerLab.mas_bottom).offset(KSIphonScreenH(7));
    }];
    
    // 考试结果
    self.examResultLab = [[UILabel alloc]init];
    [bgView addSubview:self.examResultLab];
    self.examResultLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.examResultLab.font = Font(14);
    [self.examResultLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.examTimeConsumLab.mas_left);
        make.centerY.equalTo(weakSelf.examScroeLab.mas_centerY);
    }];
    
    // 考试类型
    self.examTypeLab = [[UILabel alloc]init];
    [bgView addSubview:self.examTypeLab];
    self.examTypeLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.examTypeLab.font = Font(14);
    [self.examTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.examScroeLab.mas_left);
        make.top.equalTo(weakSelf.examScroeLab.mas_bottom).offset(KSIphonScreenH(7));
    }];
}

/**
   改变字体和颜色

 @param totalStr 总文字
 @param textStr 改变的文字
 @param textColor 改变文字颜色
 @return    UIlabel  富文本
 */
-(NSMutableAttributedString *) getAttrbuteTotalStr:(NSString *)totalStr  andAlterTextStr:(NSString *)textStr andTextColor:(UIColor *)textColor{
    NSMutableAttributedString  *attributStr = [[NSMutableAttributedString alloc]initWithString:totalStr];
    NSRange range;
    range = [totalStr rangeOfString:textStr];
    if (range.location != NSNotFound) {
        // 设置颜色
        [attributStr addAttribute:NSForegroundColorAttributeName value:textColor range:range];
        // 设置字体
        [attributStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:range];
    }
    return attributStr;
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    // 试卷名称
    self.examRoomNameLab.text = dict[@"examRoomTitle"];
    // 所属考试
    self.examNameLab.text = [NSString stringWithFormat:@"所属考试：%@",dict[@"examTitle"]];
    // 试卷名称
    self.examPaperNameLab.text =  dict[@"paperTitle"];
    // 开考时间
    NSString *examStartTimeStr = [NSString stringWithFormat:@"开考时间  %@",dict[@"examStartTime"]];
    NSString *startTimeStr = [NSString stringWithFormat:@"%@",dict[@"examTitle"]];
    self.beginExamTimerLab.attributedText =[YWTTools getAttrbuteTotalStr:examStartTimeStr andAlterTextStr:startTimeStr andTextColor:[UIColor colorCommon65GreyBlackColor] andTextFont:Font(12)];
    // 考试时间
    NSString *totalTimeStr =  [NSString stringWithFormat:@"考试耗时  %@",[self getMMSSFromExamTotalTime:[NSString stringWithFormat:@"%@",dict[@"examUserTotalTime"]]]];
    NSString *timeStr = [self getMMSSFromExamTotalTime:[NSString stringWithFormat:@"%@",dict[@"examUserTotalTime"]]];
    self.examTimeConsumLab.attributedText = [YWTTools getAttrbuteTotalStr:totalTimeStr andAlterTextStr:timeStr andTextColor:[UIColor colorCommon65GreyBlackColor] andTextFont:Font(12)];
    // 考试得分
    NSString *scoreStr = [NSString stringWithFormat:@"考试得分  %@分",dict[@"score"]];
    NSString *sStr =  [NSString stringWithFormat:@"%@",dict[@"score"]];
    self.examScroeLab.attributedText =[YWTTools getAttrbuteTotalStr:scoreStr andAlterTextStr:sStr andTextColor:[UIColor colorCommon65GreyBlackColor] andTextFont:Font(14)];
    // 考试结果
    NSString *isPassStr = dict[@"isPass"];
    self.examResultLab.text =[NSString stringWithFormat:@"考试结果  %@",isPassStr];
    if ([isPassStr isEqualToString:@"不合格"]) {
        self.examResultLab.attributedText = [YWTTools getAttrbuteTotalStr:self.examResultLab.text andAlterTextStr:isPassStr andTextColor:[UIColor colorCommonRedColor] andTextFont:Font(12)];
    }else if ([isPassStr isEqualToString:@"合格"]){
        self.examResultLab.attributedText = [YWTTools getAttrbuteTotalStr:self.examResultLab.text andAlterTextStr:isPassStr andTextColor:[UIColor colorWithHexString:@"#33c500"] andTextFont:Font(12)];
    }
    // 考试类型
    NSString *examTypeStr = [NSString stringWithFormat:@"考试类型  %@",dict[@"examType"]];
    NSString *typeStr =  [NSString stringWithFormat:@"%@",dict[@"examType"]];
    self.examTypeLab.attributedText =[YWTTools getAttrbuteTotalStr:examTypeStr andAlterTextStr:typeStr andTextColor:[UIColor colorCommon65GreyBlackColor] andTextFont:Font(12)];
    
    NSString *isValidStr = [NSString stringWithFormat:@"%@",dict[@"isValid"]];
    // 1:正常 2：成绩无效 作废 3缺考
    if ([isValidStr isEqualToString:@"2"]) {
        self.scroeImageV.image = [UIImage imageNamed:@"pic_bq03-1"];
    }else if ([isValidStr isEqualToString:@"3"]){
        self.scroeImageV.image = [UIImage imageNamed:@"pic_bq04"];
    }else if ([isValidStr isEqualToString:@"1"]){
        if ([isPassStr isEqualToString:@"不合格"]) {
            self.scroeImageV.image = [UIImage imageNamed:@"pic_bhg"];
        }else if ([isPassStr isEqualToString:@"合格"]){
            self.scroeImageV.image = [UIImage imageNamed:@"pic_hg"];
        }
    }
}
//传入 秒  得到 xx:xx:xx
-(NSString *)getMMSSFromExamTotalTime:(NSString *)totalTime{
    
    NSInteger seconds = [totalTime integerValue];
    
    //    NSString *str_day = [NSString stringWithFormat:@"%02ld",seconds/(3600*24)];
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600-(seconds/(3600*24)*24)];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time;
    if ([str_hour isEqualToString:@"00"]) {
        format_time = [NSString stringWithFormat:@"%@‘%@“",str_minute,str_second];
    }else{
        format_time = [NSString stringWithFormat:@"%@h%@’%@“",str_hour,str_minute,str_second];
    }
    return format_time;
}
// 计算高度
+(CGFloat) getWithRecordCellHeight:(NSDictionary *)dict{
    CGFloat height = 190;
    
    NSString *titleStr = [NSString stringWithFormat:@"%@",dict[@"examRoomTitle"]];
    CGFloat titleHeight = [YWTTools getSpaceLabelHeight:titleStr withFont:18 withWidth:KScreenW-KSIphonScreenW(70) withSpace:2];
    height += titleHeight;
   
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
