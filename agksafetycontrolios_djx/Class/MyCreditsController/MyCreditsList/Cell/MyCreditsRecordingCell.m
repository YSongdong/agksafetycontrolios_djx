//
//  MyCreditsScoreCell.m
//  PartyBuildingStar
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import "MyCreditsRecordingCell.h"

@interface MyCreditsRecordingCell ()
// 任务标题
@property (nonatomic,strong) UILabel *taskTitleLab;
// 任务时间
@property (nonatomic,strong) UILabel *taskTimeLab;
// 任务得分
@property (nonatomic,strong) UILabel *taskScoreLab;

@end

@implementation MyCreditsRecordingCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createScoreView];
    }
    return self;
}
-(void) createScoreView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor  = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    UIView *contentView = [[UIView alloc]init];
    [bgView addSubview:contentView];
    
    // 任务标题
    self.taskTitleLab  = [[UILabel alloc]init];
    [contentView addSubview:self.taskTitleLab];
    self.taskTitleLab.text = @"";
    self.taskTitleLab.textColor = [UIColor colorCommonBlackColor];
    self.taskTitleLab.font = BFont(15);
    self.taskTitleLab.numberOfLines = 0;
    [self.taskTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(contentView);
    }];
    
    // 任务时间
    self.taskTimeLab = [[UILabel alloc]init];
    [contentView addSubview:self.taskTimeLab];
    self.taskTimeLab.text = @"";
    self.taskTimeLab.textColor = [UIColor colorWithHexString:@"#999999"];
    self.taskTimeLab.font = Font(13);
    [self.taskTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.taskTitleLab.mas_left);
        make.top.equalTo(weakSelf.taskTitleLab.mas_bottom).offset(KSIphonScreenH(8));
    }];
   
    // 任务得分
    self.taskScoreLab = [[UILabel alloc]init];
    [contentView addSubview:self.taskScoreLab];
    self.taskScoreLab.text = @"";
    self.taskScoreLab.textColor = [UIColor colorConstantCommonBlueColor];
    self.taskScoreLab.font = BFont(16);
    [self.taskScoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView);
        make.centerY.equalTo(contentView.mas_centerY);
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.taskTitleLab.mas_top);
        make.left.equalTo(bgView).offset(KSIphonScreenW(19));
        make.bottom.equalTo(weakSelf.taskTimeLab.mas_bottom);
        make.right.equalTo(bgView).offset(-KSIphonScreenW(15));
        make.centerY.equalTo(bgView.mas_centerY);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    [bgView addSubview:lineView];
    lineView.backgroundColor = [UIColor colorLineE3E3CommonGreyBlackColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(KSIphonScreenW(15));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(15));
        make.bottom.equalTo(bgView);
        make.height.equalTo(@1);
    }];
    
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    // 任务标题
    self.taskTitleLab.text = [NSString stringWithFormat:@"%@",dict[@"taskTitle"]];
    // 任务时间
    NSString *createTimerStr = [NSString stringWithFormat:@"%@",dict[@"createTime"]];
    self.taskTimeLab.text =[YWTTools timestampSwitchTime:[createTimerStr integerValue] andFormatter:@"YYYY-MM-dd HH:mm"];
    // 任务得分
    NSString *creditStr = [NSString stringWithFormat:@"%@",dict[@"credit"]];
    if ([creditStr floatValue] >= 0) {
        self.taskScoreLab.text = [NSString stringWithFormat:@"+%@",dict[@"credit"]];
    }else{
        self.taskScoreLab.text = [NSString stringWithFormat:@"%@",dict[@"credit"]];
        self.taskScoreLab.textColor = [UIColor colorCommonRedColor];
    }
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
