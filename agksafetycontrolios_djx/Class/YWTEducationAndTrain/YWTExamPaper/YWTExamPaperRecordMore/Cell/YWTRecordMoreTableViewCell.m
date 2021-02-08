//
//  RecordMoreTableViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/17.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTRecordMoreTableViewCell.h"

@interface YWTRecordMoreTableViewCell ()
// 背景View
@property (nonatomic,strong) UIView *bgView;
// 序号
@property (nonatomic,strong) UILabel *serialNumberLab;
 // 练习日期
@property (nonatomic,strong) UILabel *exerDateLab;
// 耗时
@property (nonatomic,strong) UILabel *timeConsumLab;
// 得分
@property (nonatomic,strong) UILabel *examScoreLab;
// 结果
@property (nonatomic,strong) UILabel *examResultLab;
// 操作
@property (nonatomic,strong) UIButton *examOperatBtn;

@end


@implementation YWTRecordMoreTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createRecordMoreView];
    }
    return self;
}
-(void) createRecordMoreView{
    __weak typeof(self) weakSelf = self;
    
    self.bgView = [[UIView alloc]init];
    [self addSubview:self.bgView];
    self.bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    // 序号
    self.serialNumberLab = [[UILabel alloc]init];
    [self.bgView addSubview:self.serialNumberLab];
    self.serialNumberLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.serialNumberLab.font = Font(13);
    [self.serialNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView).offset(KSIphonScreenW(17));
        make.centerY.equalTo(weakSelf.bgView.mas_centerY);
    }];
    
     // 练习日期
    self.timeConsumLab = [[UILabel alloc]init];
    [self.bgView addSubview:self.timeConsumLab];
    self.timeConsumLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.timeConsumLab.font = Font(13);
    [self.timeConsumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.serialNumberLab.mas_right).offset(KSIphonScreenW(20));
        make.centerY.equalTo(weakSelf.serialNumberLab.mas_centerY);
    }];
    
    // 耗时
    self.exerDateLab = [[UILabel alloc]init];
    [self.bgView addSubview:self.exerDateLab];
    self.exerDateLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.exerDateLab.font = Font(13);
    [self.exerDateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.timeConsumLab.mas_right).offset(KSIphonScreenW(15));
        make.centerY.equalTo(weakSelf.timeConsumLab.mas_centerY);
    }];
    
    // 操作
    self.examOperatBtn = [[UIButton alloc]init];
    [self.bgView addSubview:self.examOperatBtn];
    [self.examOperatBtn setTitle:@"详情" forState:UIControlStateNormal];
    [self.examOperatBtn setTitleColor:[UIColor colorCommonGreyBlackColor] forState:UIControlStateNormal];
    [self.examOperatBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateHighlighted];
    self.examOperatBtn.titleLabel.font = Font(12);
    [self.examOperatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView).offset(-KSIphonScreenW(8));
        make.centerY.equalTo(weakSelf.exerDateLab.mas_centerY);
    }];
    [self.examOperatBtn addTarget:self action:@selector(selectDetailBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    // 结果
    self.examResultLab = [[UILabel alloc]init];
    [self.bgView addSubview:self.examResultLab];
    self.examResultLab.textColor = [UIColor colorWithHexString:@"#33c500"];
    self.examResultLab.font = Font(13);
    self.examResultLab.textAlignment = NSTextAlignmentLeft;
    [self.examResultLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.examOperatBtn.mas_left).offset(-KSIphonScreenW(20));
        make.centerY.equalTo(weakSelf.exerDateLab.mas_centerY);
    }];
    
    // 得分
    self.examScoreLab = [[UILabel alloc]init];
    [self.bgView addSubview:self.examScoreLab];
    self.examScoreLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.examScoreLab.font = Font(13);
    [self.examScoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.examResultLab.mas_left).offset(-KSIphonScreenW(15));
        make.centerY.equalTo(weakSelf.exerDateLab.mas_centerY);
    }];

}

-(void)selectDetailBtn:(UIButton *) sender{
    self.detailBlock();
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    if (self.indexPath.row % 2 != 0) {
        self.bgView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    }else{
        self.bgView.backgroundColor = [UIColor colorTextWhiteColor];
    }
    // 序号
    self.serialNumberLab.text =[NSString stringWithFormat:@"%@",dict[@"number"]];
    // 练习日期
    self.timeConsumLab.text = [NSString stringWithFormat:@"%@",dict[@"startTime"]];
    // 耗时
    self.exerDateLab.text = [NSString stringWithFormat:@"%@",[self getMMSSFromSS:[NSString stringWithFormat:@"%@",dict[@"examTotalTime"]]]];
    // 得分
    self.examScoreLab.text = [NSString stringWithFormat:@"%.1f分",[dict[@"score"]floatValue]];
    // 结果
    NSString *passStr = [NSString stringWithFormat:@"%@",dict[@"pass"]];
    if ([passStr isEqualToString:@"1"]) {
        self.examResultLab.text = @"未知";
        self.examResultLab.textColor = [UIColor colorWithHexString:@"#ffb400"];
    }else if ([passStr isEqualToString:@"3"]){
        self.examResultLab.text = @"不合格";
        self.examResultLab.textColor = [UIColor colorWithHexString:@"#ff3030"];
    }else if ([passStr isEqualToString:@"2"]){
        self.examResultLab.text = @"合格";
        self.examResultLab.textColor = [UIColor colorWithHexString:@"#33c500"];
    }
}
-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
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
        format_time = [NSString stringWithFormat:@"%@‘%@“",str_minute,str_second];
    }else{
        format_time = [NSString stringWithFormat:@"%@h%@’%@”",str_hour,str_minute,str_second];
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
