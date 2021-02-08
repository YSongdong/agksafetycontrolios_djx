//
//  TaskCenterReultPromptView.m
//  PartyBuildingStar
//
//  Created by mac on 2019/4/16.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import "YWTTaskCenterReultPromptView.h"

@interface YWTTaskCenterReultPromptView ()
//背景view
@property (nonatomic,strong) UIView *bgView;
// 显示分数
@property (nonatomic,strong) UILabel *showScoreLab;
// 任务标题
@property (nonatomic,strong) UILabel *showTaskCenterTitleLab;
// 任务说明
@property (nonatomic,strong) UILabel *showTaskCenterMarkLab;
// 继续按钮
@property (nonatomic,strong) UIButton *showContinueBtn;
// 跳转按钮
@property (nonatomic,strong) UIButton *showPushBtn;
// 取消按钮
@property (nonatomic,strong) UIButton *showCancelBtn;

@end

@implementation YWTTaskCenterReultPromptView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self inintView];
    }
    return self;
}
-(void)inintView{
    __weak typeof(self) weakSelf = self;
  
    UIView *bigBgView = [[UIView alloc]init];
    [self addSubview:bigBgView];
    bigBgView.backgroundColor = [UIColor blackColor];
    bigBgView.alpha = 0.35;
    [bigBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    UITapGestureRecognizer *cancelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectCancelTap)];
    [bigBgView addGestureRecognizer:cancelTap];
    
    self.bgView = [[UIView alloc]init];
    [self addSubview:self.bgView];
    self.bgView.backgroundColor = [UIColor colorTextWhiteColor];
    
    // 显示分数
    self.showScoreLab = [[UILabel alloc]init];
    [self.bgView addSubview:self.showScoreLab];
    self.showScoreLab.textColor = [UIColor colorWithHexString:@"#f83144"];
    self.showScoreLab.font = BFont(12);
    [self.showScoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bgView).offset(KSIphonScreenH(78));
        make.centerX.equalTo(weakSelf.bgView.mas_centerX);
    }];
   
    // 任务标题
    self.showTaskCenterTitleLab = [[UILabel alloc]init];
    [self.bgView addSubview:self.showTaskCenterTitleLab];
    self.showTaskCenterTitleLab.text = @"";
    self.showTaskCenterTitleLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.showTaskCenterTitleLab.font = BFont(14);
    self.showTaskCenterTitleLab.numberOfLines = 0;
    self.showTaskCenterTitleLab.textAlignment = NSTextAlignmentCenter;
    [self.showTaskCenterTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.showScoreLab.mas_bottom).offset(KSIphonScreenH(10));
        make.left.equalTo(weakSelf.bgView).offset(KSIphonScreenW(10));
        make.right.equalTo(weakSelf.bgView).offset(-KSIphonScreenW(10));
        make.centerX.equalTo(weakSelf.bgView.mas_centerX);
    }];
    
    // 任务说明
    self.showTaskCenterMarkLab = [[UILabel alloc]init];
    [self.bgView addSubview:self.showTaskCenterMarkLab];
    self.showTaskCenterMarkLab.text = @"";
    self.showTaskCenterMarkLab.textColor = [UIColor colorCommonAAAAGreyBlackColor];
    self.showTaskCenterMarkLab.font = Font(12);
    self.showTaskCenterMarkLab.numberOfLines = 0;
    self.showTaskCenterMarkLab.textAlignment = NSTextAlignmentCenter;
    [self.showTaskCenterMarkLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.showTaskCenterTitleLab.mas_bottom).offset(KSIphonScreenH(3));
        make.left.equalTo(weakSelf.bgView).offset(KSIphonScreenW(10));
        make.right.equalTo(weakSelf.bgView).offset(-KSIphonScreenW(10));
        make.centerX.equalTo(weakSelf.bgView.mas_centerX);
    }];
    
    // 继续按钮
    self.showContinueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.showContinueBtn];
    [self.showContinueBtn setTitle:@"继续练习" forState:UIControlStateNormal];
    [self.showContinueBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.showContinueBtn.titleLabel.font = BFont(14);
    self.showContinueBtn.backgroundColor  = [UIColor colorWithHexString:@"#f83144"];
    [self.showContinueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.showTaskCenterMarkLab.mas_bottom).offset(KSIphonScreenH(38));
        make.left.equalTo(weakSelf.bgView).offset(KSIphonScreenW(20));
        make.right.equalTo(weakSelf.bgView).offset(-KSIphonScreenW(20));
        make.height.equalTo(@(KSIphonScreenH(35)));
    }];
    self.showContinueBtn.layer.borderWidth = 1;
    self.showContinueBtn.layer.borderColor = [UIColor colorWithHexString:@"#ff3246"].CGColor;
    self.showContinueBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    self.showContinueBtn.layer.shadowOffset = CGSizeMake(0, 0);
    self.showContinueBtn.layer.shadowOpacity = 0.2;
    self.showContinueBtn.layer.cornerRadius = KSIphonScreenH(35)/2;
    [self.showContinueBtn addTarget:self action:@selector(selectContinueBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    // 跳转按钮
    self.showPushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.showPushBtn];
    [self.showPushBtn setTitle:@"任务中心" forState:UIControlStateNormal];
    [self.showPushBtn setTitleColor:[UIColor colorWithHexString:@"#f83144"] forState:UIControlStateNormal];
    self.showPushBtn.titleLabel.font = BFont(14);
    self.showPushBtn.backgroundColor  = [UIColor colorTextWhiteColor];
    [self.showPushBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.showContinueBtn.mas_bottom).offset(KSIphonScreenH(12));
        make.width.height.equalTo(weakSelf.showContinueBtn);
        make.height.equalTo(weakSelf.showContinueBtn.mas_height);
        make.centerX.equalTo(weakSelf.showContinueBtn.mas_centerX);
    }];
    self.showPushBtn.layer.borderWidth = 1;
    self.showPushBtn.layer.borderColor = [UIColor colorWithHexString:@"#ff3246"].CGColor;
    self.showPushBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    self.showPushBtn.layer.shadowOffset = CGSizeMake(0, 0);
    self.showPushBtn.layer.shadowOpacity = 0.2;
    self.showPushBtn.layer.cornerRadius = KSIphonScreenH(35)/2;
    [self.showPushBtn addTarget:self action:@selector(selectPushBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.showScoreLab.mas_top).offset(-KSIphonScreenW(78));
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(50));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(50));
        make.bottom.equalTo(weakSelf.showPushBtn.mas_bottom).offset(KSIphonScreenH(26));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    self.bgView.layer.cornerRadius = 7;
    self.bgView.layer.masksToBounds = YES;
    
    //
    UIImageView *topImageV = [[UIImageView alloc]init];
    [self addSubview:topImageV];
    topImageV.image = [UIImage imageNamed:@"taskCenter_propmt_image"];
    topImageV.contentMode = UIViewContentModeScaleAspectFit ;
    [topImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.bgView.mas_top);
        make.centerX.equalTo(weakSelf.bgView.mas_centerX);
    }];
    
    // 取消按钮
    self.showCancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.showCancelBtn];
    [self.showCancelBtn setImage:[UIImage imageNamed:@"taskCenter_propmt_close"] forState:UIControlStateNormal];
    [self.showCancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bgView.mas_bottom).offset(KSIphonScreenH(25));
        make.centerX.equalTo(weakSelf.bgView.mas_centerX);
    }];
    [self.showCancelBtn addTarget:self action:@selector(selectCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
}
-(void) selectCancelTap{
    [self removeFromSuperview];
}
// 取消按钮
-(void) selectCancelBtn:(UIButton *) sender{
    [self removeFromSuperview];
}
// 继续
-(void) selectContinueBtn:(UIButton *) sender{
    [self selectCancelTap];
//    self.selectModeName(self.dict);
}
// 任务中心
-(void) selectPushBtn:(UIButton *) sender{
    self.selectTaskCenter(self.dict);
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    // 分数
    NSString *creditS = [NSString stringWithFormat:@"%@",dict[@"credit"]];
    NSString *creditStr = [NSString stringWithFormat:@"%.2f",[creditS doubleValue]];
    if (![creditStr isEqualToString:@""] || ![creditStr isEqualToString:@"0"] ) {
        NSString *newCreditStr = [NSString stringWithFormat:@"+%@",dict[@"credit"]];
        self.showScoreLab.attributedText = [YWTTools getAttrbuteTotalStr:[NSString stringWithFormat:@"%@学分",newCreditStr] andAlterTextStr:newCreditStr andTextColor:[UIColor colorWithHexString:@"#f83144"] andTextFont:BFont(30)];
    }
    
    // 任务标题
    self.showTaskCenterTitleLab.text = [NSString stringWithFormat:@"%@",dict[@"title"]];
    
    // 任务说明
    self.showTaskCenterMarkLab.text = [NSString stringWithFormat:@"%@",dict[@"contents"]];
    
    // 任务需要跳得模块名称
    NSString *modeNameStr = [NSString stringWithFormat:@"%@",dict[@"modeName"]];
    if ([modeNameStr isEqualToString:@"libayExercise"]) {
        // 题库练习
         // 继续按钮
        [self.showContinueBtn setTitle:@"继续练习" forState:UIControlStateNormal];
    }else if ([modeNameStr isEqualToString:@"examPaper"]){
        // 模拟考试
        // 继续按钮
        [self.showContinueBtn setTitle:@"继续考试" forState:UIControlStateNormal];
    }else if ([modeNameStr isEqualToString:@"examCenter"]){
        // 正式考试
        // 继续按钮
        [self.showContinueBtn setTitle:@"继续考试" forState:UIControlStateNormal];
    }else if ([modeNameStr isEqualToString:@"myStudies"]){
        // 我的学习
        // 继续按钮
        [self.showContinueBtn setTitle:@"继续学习" forState:UIControlStateNormal];
    }else if ([modeNameStr isEqualToString:@"riskDisplay"] ){
        // 风险展示
        // 继续按钮
        [self.showContinueBtn setTitle:@"继续学习" forState:UIControlStateNormal];
    }else if ([modeNameStr isEqualToString:@"exposureStation"]){
        // 曝光台
        // 继续按钮
        [self.showContinueBtn setTitle:@"继续学习" forState:UIControlStateNormal];
    }else if ([modeNameStr isEqualToString:@"securityCheck"]){
        // 安全检查
        // 继续按钮
        [self.showContinueBtn setTitle:@"继续上传" forState:UIControlStateNormal];
    }else if ([modeNameStr isEqualToString:@"classRecord"] ){
        // 班会记录
        // 继续按钮
        [self.showContinueBtn setTitle:@"继续上传" forState:UIControlStateNormal];
    }else if ([modeNameStr isEqualToString:@"technicalDisclosure"] ){
        // 技术交底
        // 继续按钮
        [self.showContinueBtn setTitle:@"继续上传" forState:UIControlStateNormal];
    }else if ([modeNameStr isEqualToString:@"violationHan"]){
        // 违章处理
        // 继续按钮
        [self.showContinueBtn setTitle:@"继续上传" forState:UIControlStateNormal];
    } else if ([modeNameStr isEqualToString:@"attendanceAtte"]){
        // 考勤签到
        // 继续按钮
        [self.showContinueBtn setTitle:@"继续签到" forState:UIControlStateNormal];
    }
}


@end
