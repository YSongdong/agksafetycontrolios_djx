//
//  ExamRoomListCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/28.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTExamRoomListCell.h"

@interface YWTExamRoomListCell ()
// 考场名称
@property (nonatomic,strong) UILabel *examRoomNameLab;
// 考场状态
@property (nonatomic,strong) UIImageView *examRoomStatuImageV;
//  绑定试卷
@property (nonatomic,strong) UILabel *bindPaperLab;
// 考试时段
@property (nonatomic,strong) UILabel *examTimerSlotLab;
// 试题数目
@property (nonatomic,strong) UILabel *examPaperNumberLab;
// 考试时长
@property (nonatomic,strong) UILabel *examRoomTimerLab;
// 试卷总分
@property (nonatomic,strong) UILabel *examTotalScoreLab;
// 合格分数
@property (nonatomic,strong) UILabel *examPassScoreLab;
//
@property (nonatomic,strong) UIButton *enterExamBtn;

@property (nonatomic,strong) UIView *enterExamView;

@property (nonatomic,strong) UIImageView *enterImageV;

@property (nonatomic,strong) UILabel *enterExamLab;

@end

@implementation YWTExamRoomListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createListView];
    }
    return self;
}
-(void) createListView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
        make.bottom.equalTo(weakSelf).offset(-KSIphonScreenH(12));
    }];
    bgView.layer.cornerRadius = KSIphonScreenH(8);
    bgView.layer.masksToBounds = YES;
    bgView.layer.borderWidth = 1;
    bgView.layer.borderColor = [UIColor colorWithHexString:@"#e3e3e3"].CGColor;
    
    self.examRoomStatuImageV = [[UIImageView alloc]init];
    [bgView addSubview:self.examRoomStatuImageV];
    self.examRoomStatuImageV.image = [UIImage imageNamed:@"pic_bq01"];
    [self.examRoomStatuImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(bgView);
    }];
    
    UIImageView *leftImageV = [[UIImageView alloc]init];
    [bgView addSubview:leftImageV];
    leftImageV.image = [UIImage imageNamed:@"ico_bdsj"];
    [leftImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(KSIphonScreenH(15));
        make.left.equalTo(bgView).offset(KSIphonScreenW(15));
        make.height.equalTo(@(KSIphonScreenH(18)));
        make.width.equalTo(@(KSIphonScreenW(45)));
    }];
    
    self.bindPaperLab = [[UILabel alloc]init];
    [bgView addSubview:self.bindPaperLab];
    self.bindPaperLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.bindPaperLab.font = Font(12);
    [self.bindPaperLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftImageV.mas_right).offset(KSIphonScreenW(5));
        make.centerY.equalTo(leftImageV.mas_centerY);
        make.right.equalTo(bgView).offset(-KSIphonScreenW(65));
    }];
    self.bindPaperLab.userInteractionEnabled = YES;
    UITapGestureRecognizer *bindTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectBindTap)];
    [self.bindPaperLab addGestureRecognizer:bindTap];
    
    //试卷名称
    self.examRoomNameLab = [[UILabel alloc]init];
    [bgView addSubview:self.examRoomNameLab];
    self.examRoomNameLab.text = @"工程造价";
    self.examRoomNameLab.textColor = [UIColor colorCommonBlackColor];
    self.examRoomNameLab.font = BFont(19);
    self.examRoomNameLab.numberOfLines = 0;
    [self.examRoomNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftImageV.mas_bottom).offset(KSIphonScreenH(20));
        make.left.equalTo(leftImageV.mas_left);
        make.right.equalTo(bgView).offset(-KSIphonScreenW(15));
    }];
    
    // 考试时段
    self.examTimerSlotLab = [[UILabel alloc]init];
    [bgView addSubview:self.examTimerSlotLab];
    self.examTimerSlotLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.examTimerSlotLab.font = Font(14);
    [self.examTimerSlotLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.examRoomNameLab.mas_bottom).offset(KSIphonScreenH(15));
        make.left.equalTo(weakSelf.examRoomNameLab.mas_left);
    }];
    
    // 试题数目
    self.examPaperNumberLab = [[UILabel alloc]init];
    [bgView addSubview:self.examPaperNumberLab];
    self.examPaperNumberLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.examPaperNumberLab.font = Font(14);
    [self.examPaperNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.examTimerSlotLab.mas_bottom).offset(KSIphonScreenH(7));
        make.left.equalTo(weakSelf.examTimerSlotLab.mas_left);
    }];
    
    // 考试时长
    self.examRoomTimerLab = [[UILabel alloc]init];
    [bgView addSubview:self.examRoomTimerLab];
    self.examRoomTimerLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.examRoomTimerLab.font = Font(14);
    self.examPaperNumberLab.textAlignment = NSTextAlignmentRight;
    [self.examRoomTimerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(KSIphonScreenW(210));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(15));
        make.centerY.equalTo(weakSelf.examPaperNumberLab.mas_centerY);
    }];
    
   // 试卷总分
    self.examTotalScoreLab = [[UILabel alloc]init];
    [bgView addSubview:self.examTotalScoreLab];
    self.examTotalScoreLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.examTotalScoreLab.font = Font(14);
    [self.examTotalScoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.examPaperNumberLab.mas_left);
        make.top.equalTo(weakSelf.examPaperNumberLab.mas_bottom).offset(KSIphonScreenH(7));
    }];
    
    // 合格分数
    self.examPassScoreLab = [[UILabel alloc]init];
    [bgView addSubview:self.examPassScoreLab];
    self.examPassScoreLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.examPassScoreLab.font = Font(14);
    self.examPassScoreLab.textAlignment = NSTextAlignmentRight;
    [self.examPassScoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.examRoomTimerLab.mas_left);
        make.centerY.equalTo(weakSelf.examTotalScoreLab.mas_centerY);
    }];
    
    self.enterExamBtn = [[UIButton alloc]init];
    [bgView addSubview:self.enterExamBtn];
    self.enterExamBtn.backgroundColor = [UIColor colorLineCommonBlueColor];
    [self.enterExamBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(KSIphonScreenW(65));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(65));
        make.bottom.equalTo(bgView).offset(-KSIphonScreenH(15));
        make.height.equalTo(@(KSIphonScreenH(35)));
    }];
    self.enterExamBtn.layer.cornerRadius = KSIphonScreenH(5);
    self.enterExamBtn.layer.masksToBounds = YES;
    self.enterExamBtn.layer.borderWidth =1;
    self.enterExamBtn.layer.borderColor = [UIColor colorLineCommonBlueColor].CGColor;
    self.enterExamBtn.enabled = NO;
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownNotification) name:OYCountDownNotification object:nil];
    
    self.enterExamView = [[UIView alloc]init];
    [bgView addSubview:self.enterExamView];
   
    self.enterExamLab = [[UILabel alloc]init];
    [self.enterExamView addSubview:self.enterExamLab];
    self.enterExamLab.text = @"进入考场";
    self.enterExamLab.textColor = [UIColor colorTextWhiteColor];
    self.enterExamLab.font = BFont(14);
    [self.enterExamLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.enterExamView);
        make.centerY.equalTo(weakSelf.enterExamView.mas_centerY);
    }];
    
    self.enterImageV = [[UIImageView alloc]init];
    [self.enterExamView addSubview:self.enterImageV];
    self.enterImageV.image = [UIImage imageChangeName:@"ico_time"];
    [self.enterImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.enterExamLab.mas_left).offset(-KSIphonScreenW(5));
        make.centerY.equalTo(weakSelf.enterExamLab.mas_centerY);
    }];
    // 默认
    self.enterImageV.hidden = YES;
    
    [self.enterExamView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.enterExamLab.mas_top);
        make.right.equalTo(weakSelf.enterExamLab.mas_right);
        make.bottom.equalTo(weakSelf.enterExamLab.mas_bottom);
        make.left.equalTo(weakSelf.enterExamLab.mas_left);
        make.centerY.equalTo(weakSelf.enterExamBtn.mas_centerY);
        make.centerX.equalTo(weakSelf.enterExamBtn.mas_centerX);
    }];
    
}
// 点击
-(void)selectBindTap{
//    self.pushExamPaperBlock(self.bindPaperLab.text);
}
-(void)setModel:(ExamCenterRoomListModel *)model{
    _model = model;
    
    // 1考试进行中 2考试未开始
    NSString *statuStr = [NSString stringWithFormat:@"%@",model.status];
    if ([statuStr isEqualToString:@"1"] || [statuStr isEqualToString:@"3"]) {
        self.examRoomStatuImageV.image = [UIImage imageNamed:@"pic_bq01"];
    }else{
        self.examRoomStatuImageV.image = [UIImage imageNamed:@"pic_bq02"];
    }
    
    NSString *paperTitleStr = [NSString stringWithFormat:@"%@",model.paperTitle];
    self.bindPaperLab.text = paperTitleStr;

    // 考场名称
    self.examRoomNameLab.text = [NSString stringWithFormat:@"%@",model.title];
    // 考试时段
    self.examTimerSlotLab.text = [NSString stringWithFormat:@"考试时段: %@",model.examTime];
    // 试题数目
    self.examPaperNumberLab.text = [NSString stringWithFormat:@"试题数目: %@题",model.questionNum];
    // 考试时长
    self.examRoomTimerLab.text = [NSString stringWithFormat:@"考试时长: %@",[self getMMSSFromExamTotalTime:model.examTotalTime]];
    // 试卷总分
    self.examTotalScoreLab.text = [NSString stringWithFormat:@"试卷总分: %@分",model.totalScore];
    // 合格分数
    self.examPassScoreLab.text = [NSString stringWithFormat:@"合格分数: %@分",model.passScore];
    
    // 1考试进行中 2考试未开始 3 考试次数已用完
    if ([model.status isEqualToString:@"1"]) {
        // 隐藏 时间计时器 图片
        self.enterImageV.hidden = YES;
        __weak typeof(self) weakSelf= self;
        [self.enterExamView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.enterExamLab.mas_top);
            make.right.equalTo(weakSelf.enterExamLab.mas_right);
            make.bottom.equalTo(weakSelf.enterExamLab.mas_bottom);
            make.left.equalTo(weakSelf.enterExamLab.mas_left);
            make.centerY.equalTo(weakSelf.enterExamBtn.mas_centerY);
            make.centerX.equalTo(weakSelf.enterExamBtn.mas_centerX);
        }];
        
        // 1开始考试 2继续考试 3禁止考试
        if ([model.examStatus  isEqualToString:@"1"]) {
            self.enterExamLab.text = @"进入考试";
            self.enterExamLab.textColor = [UIColor colorTextWhiteColor];
        }else if ([model.examStatus isEqualToString:@"2"]){
            self.enterExamLab.text = @"继续考试";
            self.enterExamLab.textColor = [UIColor colorTextWhiteColor];
        }
        self.enterExamBtn.backgroundColor = [UIColor colorLineCommonBlueColor];
        self.enterExamBtn.layer.borderWidth =1;
        self.enterExamBtn.layer.borderColor = [UIColor colorLineCommonBlueColor].CGColor;
    }else if ([model.status isEqualToString:@"2"]){
         // 2考试未开始
    }else if ([model.status isEqualToString:@"3"]){
        //  3 考试次数已用完
        self.enterExamLab.text = @"考试已完成";
        self.enterExamLab.textColor = [UIColor colorCommonGreyBlackColor];
        
        self.enterExamBtn.backgroundColor = [UIColor colorTextWhiteColor];
        self.enterExamBtn.layer.borderWidth =1;
        self.enterExamBtn.layer.borderColor = [UIColor colorWithHexString:@"#d7d7d7"].CGColor;
    }
    // 手动调用通知的回调
    [self countDownNotification];
}

#pragma mark - 倒计时通知回调
- (void)countDownNotification {
    
    ExamCenterRoomListModel *model = self.model;
    /// 判断是否需要倒计时 -- 可能有的cell不需要倒计时,根据真实需求来进行判断
    //是开始考试还是倒计时
    if ([model.status isEqualToString:@"1"]) {
        return;
    }
    /// 计算倒计时
    NSInteger timeInterval=kCountDownManager.timeInterval;
    
    NSInteger countDown = [model.remainingTime integerValue] - timeInterval;
    /// 当倒计时到了进行回调
    if (countDown <= 0) {
        if ([model.status isEqualToString:@"1"]) {
            self.enterExamLab.text = @"进入考试";
            self.enterExamLab.textColor = [UIColor colorTextWhiteColor];
            self.enterExamBtn.backgroundColor = [UIColor colorLineCommonBlueColor];
        }else if ([model.status isEqualToString:@"3"]){
            self.enterExamLab.text = @"考试已完成";
            self.enterExamLab.textColor = [UIColor colorCommonGreyBlackColor];
            self.enterExamBtn.backgroundColor = [UIColor colorTextWhiteColor];
            self.enterExamBtn.layer.borderWidth =1;
            self.enterExamBtn.layer.borderColor = [UIColor colorWithHexString:@"#d7d7d7"].CGColor;
        }else if([model.status isEqualToString:@"2"]){
            // 回调给控制器
            if (self.countDownZero) {
                model.status = @"1";
                self.countDownZero(model);
            }
        }
        return;
    }
    // 显示时间计时器的图片
    self.enterImageV.hidden = NO;
    
    NSString *timeStr =  [NSString stringWithFormat:@"%ld",(long)countDown];
    self.enterExamLab.text = [NSString stringWithFormat:@" 距开始剩 %@", [self getMMSSFromSS:timeStr]];
    self.enterExamLab.textColor = [UIColor colorLineCommonBlueColor];
    
    self.enterExamBtn.backgroundColor = [UIColor colorTextWhiteColor];
    self.enterExamBtn.layer.borderWidth =0.5;
    self.enterExamBtn.layer.borderColor  = [UIColor colorLineCommonBlueColor].CGColor;
    
    __weak typeof(self) weakSelf= self;
    [self.enterExamView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.enterExamLab.mas_top);
        make.right.equalTo(weakSelf.enterExamLab.mas_right);
        make.bottom.equalTo(weakSelf.enterExamLab.mas_bottom);
        make.left.equalTo(weakSelf.enterImageV.mas_left);
        make.centerY.equalTo(weakSelf.enterExamBtn.mas_centerY);
        make.centerX.equalTo(weakSelf.enterExamBtn.mas_centerX);
    }];
}
//传入 秒  得到 xx:xx:xx
-(NSString *)getMMSSFromSS:(NSString *)totalTime{
    
    NSInteger seconds = [totalTime integerValue];
    
    NSString *str_day = [NSString stringWithFormat:@"%02ld",seconds/(3600*24)];
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600-(seconds/(3600*24)*24)];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time;
    if ([str_day isEqualToString:@"00"]) {
        format_time = [NSString stringWithFormat:@"%@时%@分%@秒",str_hour,str_minute,str_second];
    }else{
        format_time = [NSString stringWithFormat:@"%@天%@时%@分%@秒",str_day,str_hour,str_minute,str_second];
    }
    return format_time;
}

//传入 秒  得到 xx:xx:xx
-(NSString *)getMMSSFromExamTotalTime:(NSString *)totalTime{
    
    NSInteger seconds = [totalTime integerValue];

    NSString *str_minute = [NSString stringWithFormat:@"%02ld",seconds/60];
    
    NSString *format_time = [NSString stringWithFormat:@"%@分钟",str_minute];
    
    return format_time;
}
// 计算高度
+(CGFloat) getWithExamRoomCellHeight:(ExamCenterRoomListModel*) model{
    CGFloat height = KSIphonScreenH(10);
    
    NSString *titleStr = [NSString stringWithFormat:@"%@",model.title];
    CGFloat titleHeight = [YWTTools getSpaceLabelHeight:titleStr withFont:20 withWidth:KScreenW-54 withSpace:2];
    height += titleHeight;
    height +=KSIphonScreenH(15);
    
    height +=KSIphonScreenH(180);
    
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
