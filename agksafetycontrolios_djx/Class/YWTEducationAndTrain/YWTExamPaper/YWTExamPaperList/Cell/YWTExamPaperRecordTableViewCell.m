//
//  ExamPaperRecordTableViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/16.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTExamPaperRecordTableViewCell.h"

@interface YWTExamPaperRecordTableViewCell ()
// title
@property (nonatomic,strong) UILabel *recordTitleLab;
// 开始考试
@property (nonatomic,strong) UIButton *beginExamBtn;
// 考试次数
@property (nonatomic,strong) UILabel *examNumberLab;
// 最好成绩
@property (nonatomic,strong) UILabel *theBestScoreLab;
// 合格率
@property (nonatomic,strong) UILabel *passRateLab;
// 练习记录
@property (nonatomic,strong) UILabel *exerRecordLab;
// 序号
@property (nonatomic,strong) UILabel *serialNumberLab;
// 考试日期
@property (nonatomic,strong) UILabel *examDateLab;
// 考试时间
@property (nonatomic,strong) UILabel *examTimerLab;
// 考试得分
@property (nonatomic,strong) UILabel *examScoreLab;
// 考试 状态
@property (nonatomic,strong) UILabel *examStatuLab;
// 查看详情
@property (nonatomic,strong) UIButton *seeDetailBtn;

@end

@implementation YWTExamPaperRecordTableViewCell

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
    
    self.recordTitleLab = [[UILabel alloc]init];
    [bgView addSubview:self.recordTitleLab];
    self.recordTitleLab.textColor = [UIColor colorCommonBlackColor];
    self.recordTitleLab.font = BFont(17);
    [self.recordTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(KSIphonScreenH(15));
        make.left.equalTo(bgView).offset(KSIphonScreenW(15));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(95));
    }];
    
    self.beginExamBtn = [[UIButton alloc]init];
    [bgView addSubview:self.beginExamBtn];
    [self.beginExamBtn setTitle:@"开始考试" forState:UIControlStateNormal];
    [self.beginExamBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    self.beginExamBtn.titleLabel.font= Font(15);
    [self.beginExamBtn setImage:[UIImage imageChangeName:@"btn_kaoshi"] forState:UIControlStateNormal];
    [self.beginExamBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView).offset(-KSIphonScreenW(15));
        make.centerY.equalTo(weakSelf.recordTitleLab.mas_centerY);
        make.width.equalTo(@(KSIphonScreenW(80)));
    }];
    
    //文字在左
    [self.beginExamBtn LZSetbuttonType:LZCategoryTypeLeft];
    [self.beginExamBtn addTarget:self action:@selector(selectBeginExamBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat viewW = (KScreenW-KSIphonScreenW(24))/3;
    for (int i=0; i<3; i++) {
        UIView *bankgView = [[UIView alloc]init];
        [bgView addSubview:bankgView];
        bankgView.tag = 100+i;
        [bankgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.recordTitleLab.mas_bottom);
            make.left.equalTo(bgView).offset(i*viewW);
            make.width.equalTo(@(viewW));
            make.height.equalTo(@(KSIphonScreenH(110)));
        }];
        
        UIImageView *leftImageV = [[UIImageView alloc]init];
        [bankgView addSubview:leftImageV];
        leftImageV.tag = 200+i;
        leftImageV.image = [UIImage imageNamed:@"lxjl_list_pic"];
        leftImageV.contentMode = UIViewContentModeScaleAspectFill;
        [leftImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(bankgView.mas_centerX);
            make.centerY.equalTo(bankgView.mas_centerY);
            make.width.height.equalTo(@(KSIphonScreenH(75)));
        }];
    }
    
    // 考试次数图片
    UIView *showExamNumberView = [self viewWithTag:100];
    UIImageView *showExamNumberImageV = [self viewWithTag:200];
    UILabel *showExamNumberLab = [[UILabel alloc]init];
    [showExamNumberView addSubview:showExamNumberLab];
    showExamNumberLab.text = @"考试次数";
    showExamNumberLab.textColor = [UIColor colorCommonAAAAGreyBlackColor];
    showExamNumberLab.font = Font(13);
    [showExamNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(showExamNumberImageV.mas_bottom).offset(KSIphonScreenH(5));
        make.centerX.equalTo(showExamNumberImageV.mas_centerX);
    }];
    
    //考试次数
    self.examNumberLab = [[UILabel alloc]init];
    [showExamNumberImageV addSubview:self.examNumberLab];
    self.examNumberLab.textColor = [UIColor colorCommonBlackColor];
    self.examNumberLab.font = Font(12);
    [self.examNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(showExamNumberImageV.mas_centerX);
        make.centerY.equalTo(showExamNumberImageV.mas_centerY);
    }];
    
    
    // 最好成绩 图片
    UIView *showTheBestScoreView = [self viewWithTag:101];
    UIImageView *showTheBestScoreImageV = [self viewWithTag:201];
    UILabel *showTheBestScoreLab = [[UILabel alloc]init];
    [showTheBestScoreView addSubview:showTheBestScoreLab];
    showTheBestScoreLab.text = @"最好成绩";
    showTheBestScoreLab.textColor = [UIColor colorCommonAAAAGreyBlackColor];
    showTheBestScoreLab.font = Font(13);
    [showTheBestScoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(showExamNumberLab.mas_centerY);
        make.centerX.equalTo(showTheBestScoreImageV.mas_centerX);
    }];
    
    //最好成绩
    self.theBestScoreLab = [[UILabel alloc]init];
    [showTheBestScoreImageV addSubview:self.theBestScoreLab];
    self.theBestScoreLab.textColor = [UIColor colorCommonBlackColor];
    self.theBestScoreLab.font = Font(11);
    [self.theBestScoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(showTheBestScoreImageV.mas_centerX);
        make.centerY.equalTo(showTheBestScoreImageV.mas_centerY);
    }];
    
    // 合格率 图片
    UIView *showPassRateView = [self viewWithTag:102];
    UIImageView *showPassRateImageV = [self viewWithTag:202];
    UILabel *showPassRateLab = [[UILabel alloc]init];
    [showPassRateView addSubview:showPassRateLab];
    showPassRateLab.text = @"合格率";
    showPassRateLab.textColor = [UIColor colorCommonAAAAGreyBlackColor];
    showPassRateLab.font = Font(13);
    [showPassRateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(showExamNumberLab.mas_centerY);
        make.centerX.equalTo(showPassRateImageV.mas_centerX);
    }];
    
    //合格率
    self.passRateLab = [[UILabel alloc]init];
    [showPassRateImageV addSubview:self.passRateLab];
    self.passRateLab.textColor = [UIColor colorCommonBlackColor];
    self.passRateLab.font = Font(11);
    [self.passRateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(showPassRateImageV.mas_centerX);
        make.centerY.equalTo(showPassRateImageV.mas_centerY);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    [bgView addSubview:lineView];
    lineView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(showExamNumberView.mas_bottom).offset(KSIphonScreenH(7));
        make.right.left.equalTo(bgView);
        make.height.equalTo(@1);
    }];
    
    UIImageView *leftImageV =[[UIImageView alloc]init];
    [bgView addSubview:leftImageV];
    leftImageV.image = [UIImage imageNamed:@"ico_xinxi"];
    [leftImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(KSIphonScreenH(15));
        make.left.equalTo(bgView).offset(KSIphonScreenW(15));
    }];
    
    // 练习记录
    self.exerRecordLab = [[UILabel alloc]init];
    [bgView addSubview:self.exerRecordLab];
    self.exerRecordLab.textColor = [UIColor colorCommonBlackColor];
    self.exerRecordLab.font = Font(14);
    [self.exerRecordLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftImageV.mas_right).offset(KSIphonScreenW(5));
        make.centerY.equalTo(leftImageV.mas_centerY);
    }];
    
    UIButton *recordMoreBtn = [[UIButton alloc]init];
    [bgView addSubview:recordMoreBtn];
    [recordMoreBtn setTitle:@"更多 >" forState:UIControlStateNormal];
    [recordMoreBtn setTitleColor:[UIColor colorWithHexString:@"#88a6d9"] forState:UIControlStateNormal];
    recordMoreBtn.titleLabel.font = Font(13);
    [recordMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView).offset(-KSIphonScreenW(15));
        make.centerY.equalTo(weakSelf.exerRecordLab.mas_centerY);
    }];
    [recordMoreBtn addTarget:self action:@selector(selectRecordMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    // 序号
    self.serialNumberLab = [[UILabel alloc]init];
    [bgView addSubview:self.serialNumberLab];
    self.serialNumberLab.text = @"1";
    self.serialNumberLab.textColor = [UIColor colorWithHexString:@"#88a6d9"];
    self.serialNumberLab.font = Font(13);
    [self.serialNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftImageV.mas_left);
        make.top.equalTo(leftImageV.mas_bottom).offset(KSIphonScreenH(16));
    }];
    // 考试日期
    self.examDateLab = [[UILabel alloc]init];
    [bgView addSubview:self.examDateLab];
    self.examDateLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.examDateLab.font = Font(13);
    [self.examDateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.serialNumberLab.mas_right).offset(KSIphonScreenW(6));
        make.centerY.equalTo(weakSelf.serialNumberLab.mas_centerY);
    }];
    
    // 考试时间
    self.examTimerLab = [[UILabel alloc]init];
    [bgView addSubview:self.examTimerLab];
    self.examTimerLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.examTimerLab.font = Font(13);
    [self.examTimerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.examDateLab.mas_right).offset(KSIphonScreenW(15));
        make.centerY.equalTo(weakSelf.examDateLab.mas_centerY);
    }];
    
    // 考试得分
    self.examScoreLab = [[UILabel alloc]init];
    [bgView addSubview:self.examScoreLab];
    self.examScoreLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.examScoreLab.font = Font(13);
    [self.examScoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.examTimerLab.mas_right).offset(KSIphonScreenW(15));
        make.centerY.equalTo(weakSelf.examTimerLab.mas_centerY);
    }];
    
    // 考试 状态
    self.examStatuLab = [[UILabel alloc]init];
    [bgView addSubview:self.examStatuLab];
    self.examStatuLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.examStatuLab.font = Font(12);
    [self.examStatuLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.examScoreLab.mas_right).offset(KSIphonScreenW(15));
        make.centerY.equalTo(weakSelf.examScoreLab.mas_centerY);
    }];
    
    // 查看详情
    self.seeDetailBtn = [[UIButton alloc]init];
    [bgView addSubview:self.seeDetailBtn];
    [self.seeDetailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
    [self.seeDetailBtn setTitleColor:[UIColor colorWithHexString:@"#88a6d9"] forState:UIControlStateNormal];
    self.seeDetailBtn.titleLabel.font = Font(13);
    [self.seeDetailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView).offset(-KSIphonScreenW(15));
        make.centerY.equalTo(weakSelf.examStatuLab.mas_centerY);
    }];
    [self.seeDetailBtn addTarget:self action:@selector(selectSeeDetailBtn:) forControlEvents:UIControlEventTouchUpInside];
    
}
// 点击查看更多事件
-(void) selectRecordMoreBtn:(UIButton *) sender{
    self.recordMoreBlock();
}
// 点击开始考试
-(void) selectBeginExamBtn:(UIButton *) sender{
    self.beginExamBlock();
}
// 查看详情
-(void) selectSeeDetailBtn:(UIButton *) sender{
    self.seeDetailBlock();
}
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    // 试卷名
    self.recordTitleLab.text = [NSString stringWithFormat:@"%@",dict[@"paperTitle"]];
    // 考试次数
    NSString *totalNum = [NSString stringWithFormat:@"%@",dict[@"totalNum"]];
    NSString *totalNumStr ;
    if ([totalNum integerValue] < 99) {
        totalNumStr = [NSString stringWithFormat:@"%@",dict[@"totalNum"]];
    }else{
        totalNumStr = @"99+";
    }
    self.examNumberLab.attributedText =[YWTTools getAttrbuteTotalStr:[NSString stringWithFormat:@"%@ 次",totalNumStr] andAlterTextStr:totalNumStr andTextColor:[UIColor colorCommonBlackColor] andTextFont:Font(19)];
    
    // 最好成绩
    NSString *higScoreStr = [NSString stringWithFormat:@"%@",dict[@"higScore"]];
    self.theBestScoreLab.attributedText =[YWTTools getAttrbuteTotalStr:[NSString stringWithFormat:@"%@ 分",higScoreStr] andAlterTextStr:higScoreStr andTextColor:[UIColor colorCommonBlackColor] andTextFont:Font(19)];
    
    // 合格率
    NSString *passRateStr = [NSString stringWithFormat:@"%@",dict[@"passRate"]];
    self.passRateLab.attributedText =[YWTTools getAttrbuteTotalStr:[NSString stringWithFormat:@"%@ %%",passRateStr] andAlterTextStr:passRateStr andTextColor:[UIColor colorCommonBlackColor] andTextFont:Font(19)];
    
    // 练习记录次数
    self.exerRecordLab.text = [NSString stringWithFormat:@"测验记录(%@)",dict[@"totalNum"]];
    
    // 考试日期
    self.examDateLab.text = [NSString stringWithFormat:@"%@",dict[@"recenTime"]];
    
    // 考试用时
    self.examTimerLab.text = [NSString stringWithFormat:@"%@",[self getMMSSFromSS:[NSString stringWithFormat:@"%@",dict[@"recenCost"]]]];
    
    // 考试得分
    self.examScoreLab.text = [NSString stringWithFormat:@"%@分",dict[@"recenScore"]];
    
    // 考试 状态
    self.examStatuLab.text = [NSString stringWithFormat:@"%@",dict[@"recenPass"]];
}

//传入 秒  得到 xx:xx:xx
-(NSString *)getMMSSFromSS:(NSString *)totalTime{
    NSInteger seconds = [totalTime integerValue];
    
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time;
    if ([str_hour isEqualToString:@"00"]) {
        format_time = [NSString stringWithFormat:@"%@'%@",str_minute,str_second];
    }else{
        format_time = [NSString stringWithFormat:@"%@h%@'%@",str_hour,str_minute,str_second];
    }
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
