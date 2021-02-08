//
//  TaskCenterDetailTableCell.m
//  PartyBuildingStar
//
//  Created by mac on 2019/4/19.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import "YWTTaskCenterDetailTableCell.h"

@interface YWTTaskCenterDetailTableCell ()
//
@property (nonatomic,strong) UIView *bgView;
// 内容view
@property (nonatomic,strong) UIView *taskContentView;
// 序号
@property (nonatomic,strong) UILabel *serialNumberLab;
// 任务名称
@property (nonatomic,strong) UILabel *taskNameLab;
// 任务说明
@property (nonatomic,strong) UILabel *taskMarkLab;
// 任务条件
@property (nonatomic,strong) UILabel *taskConditionLab;
// 任务得分
@property (nonatomic,strong) UILabel *taskScoreLab;
// 任务学习按钮
@property (nonatomic,strong) UIButton *taskLearnBtn;
// 任务完成图片
@property (nonatomic,strong) UIImageView *taskCompleteImageV;

@end

@implementation YWTTaskCenterDetailTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createDetailView];
    }
    return self;
}
-(void) createDetailView{
    __weak typeof(self) weakSelf = self;
    
    self.bgView = [[UIView alloc]init];
    [self addSubview:self.bgView];
    self.bgView.backgroundColor  = [UIColor colorTextWhiteColor];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    // 内容view
    self.taskContentView  = [[UIView alloc]init];
    [self.bgView addSubview:self.taskContentView];
    
    // 任务名称
    self.taskNameLab = [[UILabel alloc]init];
    [self.taskContentView addSubview:self.taskNameLab];
    self.taskNameLab.text = @"";
    self.taskNameLab.textColor  = [UIColor colorCommonBlackColor];
    self.taskNameLab.font = BFont(16);
    self.taskNameLab.numberOfLines = 0;
    [self.taskNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.taskContentView.mas_top);
        make.left.right.equalTo(weakSelf.taskContentView);
    }];
    
    // 任务说明
    self.taskMarkLab = [[UILabel alloc]init];
    [self.taskContentView addSubview:self.taskMarkLab];
    self.taskMarkLab.text = @"";
    self.taskMarkLab.textColor = [UIColor colorWithHexString:@"#999999"];
    self.taskMarkLab.font = Font(13);
    self.taskMarkLab.numberOfLines = 0;
    [self.taskMarkLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.taskNameLab.mas_bottom).offset(KSIphonScreenH(13));
        make.left.right.equalTo(weakSelf.taskContentView);
    }];
    
    // 任务条件
    self.taskConditionLab = [[UILabel alloc]init];
    [self.taskContentView addSubview:self.taskConditionLab];
    self.taskConditionLab.text = @"";
    self.taskConditionLab.textColor = [UIColor colorWithHexString:@"#999999"];
    self.taskConditionLab.font = Font(13);
    self.taskConditionLab.numberOfLines = 0;
    [self.taskConditionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.taskMarkLab.mas_bottom).offset(KSIphonScreenH(13));
        make.left.equalTo(weakSelf.taskMarkLab.mas_left);
        make.right.equalTo(weakSelf.taskContentView);
    }];
    
    // 任务得分
    self.taskScoreLab = [[UILabel alloc]init];
    [self.taskContentView addSubview:self.taskScoreLab];
    self.taskScoreLab.text = @"";
    self.taskScoreLab.textColor = [UIColor colorWithHexString:@"#ffa303"];
    self.taskScoreLab.font = BFont(14);
    [self.taskScoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.taskConditionLab.mas_bottom).offset(KSIphonScreenH(13));
        make.left.equalTo(weakSelf.taskConditionLab.mas_left);
    }];
    
    // 任务学习按钮
    self.taskLearnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.taskContentView addSubview:self.taskLearnBtn];
    [self.taskLearnBtn setTitle:@"去完成" forState:UIControlStateNormal];
    [self.taskLearnBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    self.taskLearnBtn.titleLabel.font = BFont(12);
    self.taskLearnBtn.backgroundColor  = [UIColor colorTextWhiteColor];
    [self.taskLearnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.taskContentView.mas_right);
        make.bottom.equalTo(weakSelf.taskScoreLab.mas_bottom);
        make.height.equalTo(@(KSIphonScreenH(22)));
        make.width.equalTo(@(KSIphonScreenW(60)));
    }];
    self.taskLearnBtn.layer.cornerRadius = KSIphonScreenH(22)/2;
    self.taskLearnBtn.layer.masksToBounds = YES;
    self.taskLearnBtn.layer.borderWidth = 1;
    self.taskLearnBtn.layer.borderColor  = [UIColor colorLineCommonBlueColor].CGColor;
    // 完成按钮不可用
    self.taskLearnBtn.enabled = NO;
    
    // 任务完成图片
    self.taskCompleteImageV = [[UIImageView alloc]init];
    [self.taskContentView addSubview:self.taskCompleteImageV];
    self.taskCompleteImageV.image = [UIImage imageNamed:@"taskCenter_detail_wc"];
    [self.taskCompleteImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.taskContentView.mas_right);
        make.bottom.equalTo(weakSelf.taskScoreLab.mas_bottom);
    }];
    self.taskCompleteImageV.hidden = YES;
    
    [self.taskContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bgView).offset(KSIphonScreenH(15));
        make.left.equalTo(weakSelf.bgView).offset(KSIphonScreenW(35));
        make.right.equalTo(weakSelf.bgView).offset(-KSIphonScreenW(15));
        make.bottom.equalTo(weakSelf.bgView.mas_bottom);
    }];
    
    // 序号
    self.serialNumberLab = [[UILabel alloc]init];
    [self.bgView addSubview:self.serialNumberLab];
    self.serialNumberLab.text = @"";
    self.serialNumberLab.textColor = [UIColor colorCommonBlackColor];
    self.serialNumberLab.font = BFont(15);
    [self.serialNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView).offset(KSIphonScreenW(15));
        make.top.equalTo(weakSelf.taskNameLab.mas_top);
        make.width.equalTo(@20);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    [weakSelf.bgView addSubview:lineView];
    lineView.backgroundColor  = [UIColor colorViewBackGrounpWhiteColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView).offset(KSIphonScreenW(13));
        make.right.equalTo(weakSelf.bgView).offset(-KSIphonScreenW(13));
        make.bottom.equalTo(weakSelf.bgView);
        make.height.equalTo(@1);
    }];
}
-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    // 序号
    self.serialNumberLab.text = [NSString stringWithFormat:@"%ld.",(long)self.indexPath.row+1];
   
    // 任务名称
    self.taskNameLab.text = [NSString stringWithFormat:@"%@",dict[@"title"]];
    
    // 任务说明  前置任务类容
    NSString  *descrStr = [NSString stringWithFormat:@"%@",dict[@"description"]];
    __weak typeof(self) weakSelf = self;
    if ([descrStr isEqualToString:@""]) {
        self.taskMarkLab.hidden = YES;
        [self.taskConditionLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.taskNameLab.mas_bottom).offset(KSIphonScreenH(13));
            make.left.equalTo(weakSelf.taskNameLab.mas_left);
            make.right.equalTo(weakSelf.taskContentView).offset(-KSIphonScreenW(12));
        }];
    }else{
        self.taskMarkLab.hidden = NO;
        self.taskMarkLab.text = descrStr;
        [self.taskConditionLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.taskMarkLab.mas_bottom).offset(KSIphonScreenH(13));
            make.left.equalTo(weakSelf.taskMarkLab.mas_left);
            make.right.equalTo(weakSelf.taskContentView).offset(-KSIphonScreenW(12));
        }];
    }

    // 任务条件
    self.taskConditionLab.text = [NSString stringWithFormat:@"%@",dict[@"completionRemarks"]];
    [UILabel changeLineSpaceForLabel:self.taskConditionLab WithSpace:2];
    
    // 任务得分
    self.taskScoreLab.text = [NSString stringWithFormat:@"%@",dict[@"scoreRemarks"]];
    [UILabel changeLineSpaceForLabel:self.taskScoreLab WithSpace:2];
    
    // 任务需要跳得模块名称
    NSString *modeNameStr = [NSString stringWithFormat:@"%@",dict[@"modeName"]];
    if ([modeNameStr isEqualToString:@"libayExercise"]) {
        // 题库练习
        [self.taskLearnBtn setTitle:@"去练习" forState:UIControlStateNormal];
    }else if ([modeNameStr isEqualToString:@"examPaper"]){
        // 模拟考试
        [self.taskLearnBtn setTitle:@"去考试" forState:UIControlStateNormal];
    }else if ([modeNameStr isEqualToString:@"examCenter"]){
        // 模拟考试
        [self.taskLearnBtn setTitle:@"去考试" forState:UIControlStateNormal];
    }else if ([modeNameStr isEqualToString:@"myStudies"]){
        // 我的学分
        [self.taskLearnBtn setTitle:@"去学习" forState:UIControlStateNormal];
    }else if ([modeNameStr isEqualToString:@"riskDisplay"] || [modeNameStr isEqualToString:@"exposureStation"] ){
        // 风险展示  曝光台
        [self.taskLearnBtn setTitle:@"去学习" forState:UIControlStateNormal];
    }else if ([modeNameStr isEqualToString:@"securityCheck"] || [modeNameStr isEqualToString:@"classRecord"] ||
              [modeNameStr isEqualToString:@"technicalDisclosure"] || [modeNameStr isEqualToString:@"violationHan"]
              ){
        // 安全检查 班会记录 技术交底 违章处理
        [self.taskLearnBtn setTitle:@"去完成" forState:UIControlStateNormal];
    }else if ([modeNameStr isEqualToString:@"attendanceAtte"]){
        // 考勤签到
        [self.taskLearnBtn setTitle:@"去签到" forState:UIControlStateNormal];
    }
    
    //子任务状态  1进行中2已完成3未完成5作废6未开始
    NSString *taskChilStatusStr = [NSString stringWithFormat:@"%@",dict[@"taskChilStatus"]];
    if ([taskChilStatusStr isEqualToString:@"2"]) {
        //2已完成
        // 任务完成图片
        self.taskCompleteImageV.hidden = NO;
        self.taskCompleteImageV.image = [UIImage imageNamed:@"taskCenter_detail_wc"];
        // 隐藏完成按钮
        self.taskLearnBtn.hidden = YES;
        
        // 任务得分lab 文字正常
        self.taskScoreLab.textColor = [UIColor colorWithHexString:@"#ffa303"];
        
    }else if ([taskChilStatusStr isEqualToString:@"3"] || [taskChilStatusStr isEqualToString:@"5"] || [taskChilStatusStr isEqualToString:@"4"]){
        // 3未完成  5作废
        // 任务完成图片
        self.taskCompleteImageV.hidden = NO;
        self.taskCompleteImageV.image = [UIImage imageNamed:@"taskCenter_detail_wwc"];
        // 隐藏完成按钮
        self.taskLearnBtn.hidden = YES;
        
        // 任务得分lab 文字变灰
        self.taskScoreLab.textColor = [UIColor colorWithHexString:@"#a7a7a7"];
        self.taskNameLab.textColor = [UIColor colorWithHexString:@"#a7a7a7"];
        self.serialNumberLab.textColor = [UIColor colorWithHexString:@"#a7a7a7"];
        
    }else if ([taskChilStatusStr isEqualToString:@"6"]){
       // 6未开始
         // 隐藏完成图片
        self.taskCompleteImageV.hidden = YES;
        // 显示完成按钮
        self.taskLearnBtn.hidden = NO;

        // 任务得分lab 文字正常
        self.taskScoreLab.textColor = [UIColor colorWithHexString:@"#ffa303"];
        
    } else if ([taskChilStatusStr isEqualToString:@"1"]){
       // 1进行中
        // 隐藏完成图片
        self.taskCompleteImageV.hidden = YES;
        // 显示完成按钮
        self.taskLearnBtn.hidden = NO;
    
        // 任务得分lab 文字正常
        self.taskScoreLab.textColor = [UIColor colorWithHexString:@"#ffa303"];
    }
    // canDo  1是可以做 2是不可做任务
    // 1可做 2不可做
    NSString *carryOutStr = [NSString stringWithFormat:@"%@",dict[@"carryOut"]];
    // 锁定任务和未开始任务内容不可跳转 // 1可做 2不可做
    if ([self.canDoStr isEqualToString:@"1"] && [carryOutStr isEqualToString:@"1"]) {
        [self.taskLearnBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
        self.taskLearnBtn.layer.borderColor = [UIColor colorLineCommonBlueColor].CGColor;
    }else{
        [self.taskLearnBtn setTitleColor:[UIColor colorWithHexString:@"#bebebe"] forState:UIControlStateNormal];
        self.taskLearnBtn.layer.borderColor = [UIColor colorWithHexString:@"#bebebe"].CGColor;
    }
}
-(void)setCanDoStr:(NSString *)canDoStr{
    _canDoStr = canDoStr;
}
// 计算高度
+(CGFloat) getWithDetailHeightCellDict:(NSDictionary *)dict{
    CGFloat height = KSIphonScreenH(17);
    // 任务名称
    NSString *titleStr = [NSString stringWithFormat:@"%@",dict[@"title"]];
    CGFloat titleHeight = [YWTTools getSpaceLabelHeight:titleStr withFont:15 withWidth:KScreenW-KSIphonScreenW(50) withSpace:2];
    height += titleHeight;
    height += KSIphonScreenH(13);
    
    // 前置任务类容
    NSString  *descrStr = [NSString stringWithFormat:@"%@",dict[@"description"]];
    // 去掉字符串头尾空格
    if (![descrStr isEqualToString:@""]) {
        CGFloat precondRemaHeight = [YWTTools getSpaceLabelHeight:descrStr withFont:13 withWidth:KScreenW-KSIphonScreenW(50) withSpace:2];
        height += precondRemaHeight;
        height += KSIphonScreenH(13);
    }
    
    // 任务完成说明
    NSString *completionRemarksStr = [NSString stringWithFormat:@"%@",dict[@"completionRemarks"]];
    CGFloat compleRemaHeight = [YWTTools getSpaceLabelHeight:completionRemarksStr withFont:13 withWidth:KScreenW-KSIphonScreenW(50) withSpace:2];
    height += compleRemaHeight;
    height += KSIphonScreenH(13);
    
    // 获得学分说明
    NSString *scoreRemarksStr = [NSString stringWithFormat:@"%@",dict[@"scoreRemarks"]];
    CGFloat scoreRemarkHeight = [YWTTools getSpaceLabelHeight:scoreRemarksStr withFont:13 withWidth:KScreenW-KSIphonScreenW(50) withSpace:2];
    height += scoreRemarkHeight;
    height += KSIphonScreenH(13);
    
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
