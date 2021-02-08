//
//  ExamPaperScoreTableViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/21.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTExamPaperScoreTableViewCell.h"
#import "TBCycleView.h"

@interface YWTExamPaperScoreTableViewCell ()
// 动画
@property (nonatomic,strong) TBCycleView *graduaView;
// 总分
@property (nonatomic,strong) UILabel *totalScoreLab;
// 及格分
@property (nonatomic,strong) UILabel *passScoreLab;
// 试卷名称
@property (nonatomic,strong) UILabel *examNameLab;
// 显示用时
@property (nonatomic,strong) UILabel *examTimerLab;

// 重新练习
@property (nonatomic,strong) UIButton *againExerBtn;

//查看详情
@property (nonatomic,strong) UIButton *seeDetailBtn;


@end


@implementation YWTExamPaperScoreTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createExamPaperView];
    }
    return self;
}
-(void) createExamPaperView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf).offset(-KSIphonScreenH(11));
    }];
    
    UIImageView *bgImageV = [[UIImageView alloc]init];
    [bgView addSubview:bgImageV];
    bgImageV.image = [UIImage imageChangeName:@"sjlx_pic_bg"];
    [bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bgView);
    }];

    self.graduaView = [[TBCycleView alloc]init];
    [bgView addSubview:self.graduaView];
    self.graduaView.backgroundColor = [UIColor clearColor];
    [self.graduaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(KSNaviTopHeight+KSIphonScreenH(10));
        make.centerX.equalTo(bgView.mas_centerX);
        make.height.width.equalTo(@(KSIphonScreenH(155)));
    }];
    
    UIView *scoreView = [[UIView alloc]init];
    [bgView addSubview:scoreView];
    
    self.totalScoreLab = [[UILabel alloc]init];
    [scoreView addSubview:self.totalScoreLab];
    self.totalScoreLab.font = BFont(15);
    [self.totalScoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scoreView);
        make.centerX.equalTo(scoreView.mas_centerX);
    }];
    
    self.passScoreLab = [[UILabel alloc]init];
    [scoreView addSubview:self.passScoreLab];
    self.passScoreLab.font = Font(14);
    self.passScoreLab.numberOfLines = 0;
    self.passScoreLab.textAlignment = NSTextAlignmentCenter;
    [self.passScoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.totalScoreLab.mas_bottom).offset(KSIphonScreenH(10));
        make.centerX.equalTo(weakSelf.totalScoreLab.mas_centerX);
        make.left.equalTo(weakSelf.graduaView).offset(KSIphonScreenW(18));
        make.right.equalTo(weakSelf.graduaView).offset(-KSIphonScreenW(18));
    }];
    
    [scoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.totalScoreLab.mas_top);
        make.left.equalTo(weakSelf.graduaView).offset(KSIphonScreenW(10));
        make.right.equalTo(weakSelf.graduaView).offset(-KSIphonScreenW(10));
        make.bottom.equalTo(weakSelf.passScoreLab.mas_bottom);
        make.centerX.equalTo(weakSelf.graduaView.mas_centerX);
        make.centerY.equalTo(weakSelf.graduaView.mas_centerY);
    }];
    
    self.examNameLab = [[UILabel alloc]init];
    [bgView addSubview:self.examNameLab];
    self.examNameLab.textColor = [UIColor colorTextWhiteColor];
    self.examNameLab.font = Font(18);
    self.examNameLab.textAlignment = NSTextAlignmentCenter;
    [self.examNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.graduaView.mas_bottom).offset(KSIphonScreenH(10));
        make.left.equalTo(bgView).offset(KSIphonScreenW(15));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(15));
    }];
    
    self.examTimerLab = [[UILabel alloc]init];
    [bgView addSubview:self.examTimerLab];
    self.examTimerLab.textColor = [UIColor colorTextWhiteColor];
    self.examTimerLab.font = BFont(30);
    self.examTimerLab.textAlignment = NSTextAlignmentCenter;
    [self.examTimerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.examNameLab.mas_bottom).offset(KSIphonScreenH(13));
        make.left.width.equalTo(weakSelf.examNameLab);
        make.centerX.equalTo(weakSelf.examNameLab.mas_centerX);
    }];
    
    UILabel *showExamTimerLab = [[UILabel alloc]init];
    [bgView addSubview:showExamTimerLab];
    showExamTimerLab.text = @"用时";
    showExamTimerLab.textColor = [UIColor colorTextWhiteColor];
    showExamTimerLab.font = BFont(12);
    showExamTimerLab.textAlignment = NSTextAlignmentCenter;
    [showExamTimerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.examTimerLab.mas_bottom).offset(KSIphonScreenH(5));
        make.left.width.equalTo(weakSelf.examTimerLab);
        make.centerX.equalTo(weakSelf.examTimerLab.mas_centerX);
    }];
    
    self.againExerBtn = [[UIButton alloc]init];
    [bgView addSubview:self.againExerBtn];
    [self.againExerBtn setTitle:@"重新练习" forState:UIControlStateNormal];
    [self.againExerBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.againExerBtn.titleLabel.font = Font(15);
    [self.againExerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(showExamTimerLab.mas_bottom).offset(KSIphonScreenH(15));
        make.left.equalTo(bgView).offset(KSIphonScreenW(44));
        make.height.equalTo(@(KSIphonScreenH(35)));
    }];
    self.againExerBtn.layer.cornerRadius = KSIphonScreenH(35)/2;
    self.againExerBtn.layer.masksToBounds = YES;
    self.againExerBtn.layer.borderWidth = 1;
    self.againExerBtn.layer.borderColor = [UIColor colorTextWhiteColor].CGColor;
    [self.againExerBtn addTarget:self action:@selector(selectAgainExamAciton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.seeDetailBtn = [[UIButton alloc]init];
    [bgView addSubview:self.seeDetailBtn];
    [self.seeDetailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
    self.seeDetailBtn.titleLabel.font = Font(15);
    [self.seeDetailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.againExerBtn.mas_right).offset(KSIphonScreenW(47));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(44));
        make.width.height.equalTo(weakSelf.againExerBtn);
        make.centerY.equalTo(weakSelf.againExerBtn.mas_centerY);
    }];
    self.seeDetailBtn.layer.cornerRadius = KSIphonScreenH(35)/2;
    self.seeDetailBtn.layer.masksToBounds = YES;
    [self.seeDetailBtn addTarget:self action:@selector(selectDetaBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.seeDetailBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.seeDetailBtn.layer.borderWidth = 1;
    self.seeDetailBtn.layer.borderColor = [UIColor colorTextWhiteColor].CGColor;
    
}

-(void)selectDetaBtn:(UIButton *)sender{
    self.detailBlock();
}
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    //
    NSString *isPassStr = [NSString stringWithFormat:@"%@",dict[@"isPass"]];
    if ([isPassStr isEqualToString:@"1"]) {
         self.totalScoreLab.text = @"--";
        self.totalScoreLab.textColor = [UIColor colorTextWhiteColor];

        self.passScoreLab.text = @"包含填空/主观题,请自行查阅";
        self.passScoreLab.textColor = [UIColor colorTextWhiteColor];
    }else if ([isPassStr isEqualToString:@"2"]){
        // 分数
        NSString *scoreStr = [NSString stringWithFormat:@"%@",dict[@"score"]];
        self.totalScoreLab.textColor = [UIColor colorTextWhiteColor];
        self.totalScoreLab.attributedText =[YWTTools getAttrbuteTotalStr:[NSString stringWithFormat:@"%@分",scoreStr] andAlterTextStr:scoreStr andTextColor:[UIColor colorTextWhiteColor] andTextFont:Font(38)];

        self.passScoreLab.text = @"合格";
        self.passScoreLab.textColor = [UIColor colorTextWhiteColor];
    }else if ([isPassStr isEqualToString:@"3"]){
        // 分数
        NSString *scoreStr = [NSString stringWithFormat:@"%@",dict[@"score"]];
        self.totalScoreLab.textColor = [UIColor colorTextWhiteColor];
        self.totalScoreLab.attributedText =[YWTTools getAttrbuteTotalStr:[NSString stringWithFormat:@"%@分",scoreStr] andAlterTextStr:scoreStr andTextColor:[UIColor colorTextWhiteColor] andTextFont:Font(38)];
        self.passScoreLab.text = @"不合格";
        self.passScoreLab.textColor = [UIColor colorTextWhiteColor];
        
    }
    self.examNameLab.text =[NSString stringWithFormat:@"%@",dict[@"examTitle"]];

    self.examTimerLab.text = [NSString stringWithFormat:@"%@",[self getMMSSFromSS:[NSString stringWithFormat:@"%@",dict[@"examUserTotalTime"]]]];
    
    // 画圆
    NSString *percentStr = [NSString stringWithFormat:@"%.2f",[dict[@"percent"]floatValue]];
    [self.graduaView setPercet:[percentStr floatValue] withTimer:1];

}
// 点击重新练习
-(void)selectAgainExamAciton:(UIButton *) sender{
    self.selectAgainExamBlock();
}

#pragma mark --- get 方法 --------
-(void)setCellScoreType:(showCellExamScoreType)cellScoreType{
    _cellScoreType = cellScoreType;
    if (cellScoreType == showCellExamScoreExerType) {
        self.againExerBtn.hidden = NO;
        self.seeDetailBtn.hidden = NO;
    }else{
        self.againExerBtn.hidden = YES;
        self.seeDetailBtn.hidden = YES;
    }
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
        format_time = [NSString stringWithFormat:@"%@ : %@",str_minute,str_second];
    }else{
        format_time = [NSString stringWithFormat:@"%@ : %@ : %@",str_hour,str_minute,str_second];
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
