//
//  TaskCenterDetailHeaderView.m
//  PartyBuildingStar
//
//  Created by mac on 2019/4/19.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import "YWTTaskCenterDetailHeaderView.h"

#import "STTagsView.h"
#import "STTagFrame.h"

@interface YWTTaskCenterDetailHeaderView ()

@property (nonatomic,strong) UIView *bgView;
// 封面图
@property (nonatomic,strong) UIImageView *coverImageV;
// 锁定状态
@property (nonatomic,strong) UIImageView *lockStatuImageV;
// 正常默认进度view
@property (nonatomic,strong) UIView *nomalProgressBgView;
// 进度条
@property (nonatomic,strong) UIProgressView *progressView;
// 进度lab
@property (nonatomic,strong) UILabel *showProgressLab;
// 未开始进度view
@property (nonatomic,strong) UIView *unStartProgressBgView;
// 未开始倒计时
@property (nonatomic,strong) UILabel *showUnStartCountdownLab;
// 任务标题
@property (nonatomic,strong) UILabel *showTaskTitleLab;
// 任务说明view
@property (nonatomic,strong) UIView *taskMarkView;
// 参与条件imageV
@property (nonatomic,strong) UIImageView *particConditionImageV;
// 参与条件lab
@property (nonatomic,strong) UILabel *particConditionLab;
// 完成条件ImageV
@property (nonatomic,strong) UIImageView *compleConditionImageV;
// 完成条件 Lab
@property (nonatomic,strong) UILabel * compleConditionLab;
// 任务时间ImageV
@property (nonatomic,strong) UIImageView *taskTimeImageV;
// 任务时间 lab
@property (nonatomic,strong) UILabel * taskTimeLab;
// 任务说明
@property (nonatomic,strong) UIImageView *taskMarkImageV;
// 任务说明Lab
@property (nonatomic,strong) UILabel *taskMarkLab;
// 任务状态imageV
@property (nonatomic,strong) UIImageView *taskStatuImageV;
// 任务说明更多按钮
@property (nonatomic,strong) UIButton *taskMarkBtn;
// 标签view
@property (nonatomic,strong) STTagsView *tagView;

/// 任务开始剩余秒数
@property (nonatomic,assign) NSInteger remTime;

@end

@implementation YWTTaskCenterDetailHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createHeaderView];
    }
    return self;
}
-(void) createHeaderView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor  = [UIColor colorViewBackGrounpWhiteColor];
    
    self.bgView = [[UIView alloc]init];
    [self addSubview:self.bgView];
    self.bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf).offset(-KSIphonScreenH(10));
    }];
    
    // 封面图
    self.coverImageV = [[UIImageView alloc]init];
    [self.bgView addSubview:self.coverImageV];
    self.coverImageV.image  = [UIImage imageNamed:@"taskCenter_header_bg"];
    [self.coverImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf.bgView);
        make.height.equalTo(@(KSIphonScreenH(225)));
    }];
    
    UIImageView *shodowTopImageV = [[UIImageView alloc]init];
    [self.bgView addSubview:shodowTopImageV];
    shodowTopImageV.image = [UIImage imageNamed:@"shadow_top"];
    [shodowTopImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf.bgView);
        make.height.equalTo(@KSNaviTopHeight);
    }];
    
    // 正常默认进度view
    self.nomalProgressBgView = [[UIView alloc]init];
    [self.bgView addSubview:self.nomalProgressBgView];
    [self.nomalProgressBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.bgView);
        make.height.equalTo(@(KSIphonScreenH(44)));
        make.bottom.equalTo(weakSelf.coverImageV.mas_bottom);
    }];
    
    UIImageView *progressMaskImageV = [[UIImageView alloc]init];
    [self.nomalProgressBgView addSubview:progressMaskImageV];
    progressMaskImageV.image = [UIImage imageNamed:@"libayExam_detail_bg"];
    [progressMaskImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.nomalProgressBgView);
    }];
    
    UILabel *showMarkLab = [[UILabel alloc]init];
    [self.nomalProgressBgView addSubview:showMarkLab];
    showMarkLab.text = @"任务进度";
    showMarkLab.textColor = [UIColor colorTextWhiteColor];
    showMarkLab.font = Font(13);
    [showMarkLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nomalProgressBgView).offset(KSIphonScreenW(13));
        make.centerY.equalTo(weakSelf.nomalProgressBgView.mas_centerY);
    }];
    
    // 进度lab
    self.showProgressLab = [[UILabel alloc]init];
    [self.nomalProgressBgView addSubview:self.showProgressLab];
    self.showProgressLab.text = @"0%";
    self.showProgressLab.textColor = [UIColor colorTextWhiteColor];
    self.showProgressLab.font = Font(13);
    [self.showProgressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.nomalProgressBgView).offset(-KSIphonScreenW(13));
        make.centerY.equalTo(showMarkLab.mas_centerY);
    }];
    
    // 进度条
    self.progressView = [[UIProgressView alloc]init];
    [self.nomalProgressBgView addSubview:self.progressView];
    // 设置进度条的颜色 (右边)
    self.progressView.trackTintColor = [UIColor colorWithHexString:@"#e9e9e9"];
    //设置进度条的颜色 (左边)
    self.progressView.progressTintColor = [UIColor colorWithHexString:@"#ffa303"];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(showMarkLab.mas_right).offset(KSIphonScreenW(10));
        make.right.equalTo(weakSelf.showProgressLab.mas_left).offset(-KSIphonScreenW(10));
        make.centerY.equalTo(showMarkLab.mas_centerY);
        make.height.equalTo(@4);
    }];
    self.progressView.layer.cornerRadius = 2;
    self.progressView.layer.masksToBounds = YES;
    
    // 未开始进度view
    self.unStartProgressBgView = [[UIView alloc]init];
    [self.bgView addSubview:self.unStartProgressBgView];
    [self.unStartProgressBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.bgView);
        make.height.equalTo(@(KSIphonScreenH(44)));
        make.bottom.equalTo(weakSelf.coverImageV.mas_bottom);
    }];
    
    UIImageView *unProgressMaskImageV = [[UIImageView alloc]init];
    [self.unStartProgressBgView addSubview:unProgressMaskImageV];
    unProgressMaskImageV.image = [UIImage imageNamed:@"libayExam_detail_bg"];
    [unProgressMaskImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.unStartProgressBgView);
    }];
    
    UIView *unContentView = [[UIView alloc]init];
    [self.unStartProgressBgView addSubview:unContentView];
    
    UIImageView *unImageV = [[UIImageView alloc]init];
    [unContentView addSubview:unImageV];
    unImageV.image  = [UIImage imageNamed:@"sjlx_nav_ico_time"];
    [unImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(unContentView);
        make.centerY.equalTo(unContentView.mas_centerY);
    }];
    
    // 未开始倒计时
    self.showUnStartCountdownLab = [[UILabel alloc]init];
    [unContentView addSubview:self.showUnStartCountdownLab];
    self.showUnStartCountdownLab.text  = @"距开始还剩";
    self.showUnStartCountdownLab.textColor  = [UIColor colorTextWhiteColor];
    self.showUnStartCountdownLab.font = Font(13);
    [self.showUnStartCountdownLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(unImageV.mas_right).offset(KSIphonScreenW(10));
        make.right.equalTo(unContentView);
    }];
    
    [unContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(unImageV.mas_left);
        make.right.top.bottom.equalTo(weakSelf.showUnStartCountdownLab);
        make.centerY.equalTo(weakSelf.unStartProgressBgView.mas_centerY);
        make.centerX.equalTo(weakSelf.unStartProgressBgView.mas_centerX);
    }];
    self.unStartProgressBgView.hidden = YES;
    
    // 任务标题
    self.showTaskTitleLab = [[UILabel alloc]init];
    [self.bgView addSubview:self.showTaskTitleLab];
    self.showTaskTitleLab.text = @"";
    self.showTaskTitleLab.textColor = [UIColor colorCommonBlackColor];
    self.showTaskTitleLab.font = BFont(16);
    self.showTaskTitleLab.numberOfLines  = 0 ;
    self.showTaskTitleLab.lineBreakMode = UILineBreakModeCharacterWrap;
    [self.showTaskTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.coverImageV.mas_bottom).offset(KSIphonScreenH(15));
        make.left.equalTo(weakSelf.bgView).offset(KSIphonScreenW(13));
        make.right.equalTo(weakSelf.bgView).offset(-KSIphonScreenW(13));
    }];
   
    // 标签view
    self.tagView = [STTagsView tagViewWithFrame:CGRectZero tagsArray:@[] textColor:[UIColor colorTextWhiteColor] textFont:Font(11) normalTagBackgroundColor:[UIColor colorTextWhiteColor] tagBorderColor:[UIColor colorTextWhiteColor] contentInsets:UIEdgeInsetsMake(2, 5, 2, 5) labelContentInsets:UIEdgeInsetsMake(2, 5, 2, 5) labelHorizontalSpacing:5 labelVerticalSpacing:5];
    self.tagView.isTaskCenter = YES;
    [self.bgView addSubview:self.tagView];
    
    [self.tagView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.showTaskTitleLab.mas_bottom).offset(KSIphonScreenH(10));
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(9));
        make.right.equalTo(weakSelf.bgView).offset(-KSIphonScreenW(9));
        make.height.equalTo(@(KSIphonScreenH(22)));
    }];
   
    // 任务说明view
    self.taskMarkView = [[UIView alloc]init];
    [self.bgView addSubview:self.taskMarkView];

    // 参与条件imageV
    self.particConditionImageV = [[UIImageView alloc]init];
    [self.taskMarkView addSubview:self.particConditionImageV];
    self.particConditionImageV.image =  [UIImage imageNamed:@"taskCenter_detail_cytj"];
    [self.particConditionImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.taskMarkView).offset(KSIphonScreenH(13));
        make.left.equalTo(weakSelf.taskMarkView).offset(KSIphonScreenW(15));
    }];
    
    //参与条件lab
    self.particConditionLab = [[UILabel alloc]init];
    [self.taskMarkView addSubview:self.particConditionLab];
    self.particConditionLab.text = @"";
    self.particConditionLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.particConditionLab.font = Font(13);
    [self.particConditionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.particConditionImageV.mas_centerY);
        make.left.equalTo(weakSelf.taskMarkView).offset(KSIphonScreenW(35));
        make.right.equalTo(weakSelf.taskMarkView).offset(-KSIphonScreenW(15));
    }];
    self.particConditionLab.userInteractionEnabled = YES;
    UITapGestureRecognizer *partiTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectPariConditTap)];
    [self.particConditionLab addGestureRecognizer:partiTap];
    
    // 完成条件ImageV
    self.compleConditionImageV = [[UIImageView alloc]init];
    [self.taskMarkView addSubview:self.compleConditionImageV];
    self.compleConditionImageV.image = [UIImage imageNamed:@"taskCenter_detail_compleCondition"];
    [self.compleConditionImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.particConditionLab.mas_bottom).offset(KSIphonScreenH(15));
        make.centerX.equalTo(weakSelf.particConditionImageV.mas_centerX);
    }];
    
    // 完成条件 Lab
    self.compleConditionLab = [[UILabel alloc]init];
    [self.taskMarkView addSubview:self.compleConditionLab];
    self.compleConditionLab.text = @"";
    self.compleConditionLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.compleConditionLab.font = Font(13);
    self.compleConditionLab.numberOfLines  = 0;
    [self.compleConditionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.particConditionLab.mas_left);
        make.top.equalTo(weakSelf.compleConditionImageV.mas_top);
        make.right.equalTo(weakSelf.particConditionLab.mas_right);
    }];
    
    // 任务时间ImageV
    self.taskTimeImageV = [[UIImageView alloc]init];
    [self.taskMarkView addSubview:self.taskTimeImageV];
    self.taskTimeImageV.image = [UIImage imageNamed:@"taskCenter_detail_time"];
    [self.taskTimeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.compleConditionLab.mas_bottom).offset(KSIphonScreenH(15));
        make.centerX.equalTo(weakSelf.compleConditionImageV.mas_centerX);
    }];
    

    // 任务时段 lab
    self.taskTimeLab = [[UILabel alloc]init];
    [self.taskMarkView addSubview:self.taskTimeLab];
    self.taskTimeLab.text = @"";
    self.taskTimeLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.taskTimeLab.font = Font(13);
    [self.taskTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.compleConditionLab.mas_left);
        make.centerY.equalTo(weakSelf.taskTimeImageV.mas_centerY);
        make.right.equalTo(weakSelf.compleConditionLab.mas_right);
    }];
    
    // 任务说明ImageV
    self.taskMarkImageV = [[UIImageView alloc]init];
    [self.taskMarkView addSubview:self.taskMarkImageV];
    self.taskMarkImageV.image = [UIImage imageNamed:@"taskCenter_detail_taskMark"];
    [self.taskMarkImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.taskTimeLab.mas_bottom).offset(KSIphonScreenH(15));
        make.centerX.equalTo(weakSelf.taskTimeImageV.mas_centerX);
    }];

    // 任务说明Lab
    self.taskMarkLab = [[UILabel alloc]init];
    [self.taskMarkView addSubview:self.taskMarkLab];
    self.taskMarkLab.text = @"";
    self.taskMarkLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.taskMarkLab.font = Font(13);
    self.taskMarkLab.numberOfLines = 0 ;
    [self.taskMarkLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.taskMarkImageV.mas_top);
        make.left.equalTo(weakSelf.taskTimeLab.mas_left);
        make.right.equalTo(weakSelf.taskTimeLab.mas_right);
    }];
    
    // 任务说明更多按钮
    self.taskMarkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.taskMarkView addSubview:self.taskMarkBtn];
    [self.taskMarkBtn setTitle:@"更多 >>" forState:UIControlStateNormal];
    [self.taskMarkBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    self.taskMarkBtn.titleLabel.font = Font(11);
    [self.taskMarkBtn addTarget:self action:@selector(selectMarkManyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.taskMarkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.taskMarkLab.mas_bottom).offset(KSIphonScreenH(13));
        make.centerX.equalTo(weakSelf.taskMarkView.mas_centerX);
        make.width.equalTo(@(KSIphonScreenW(70)));
    }];
    
    [self.taskMarkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.tagView.mas_bottom).offset(KSIphonScreenH(10));
        make.left.equalTo(weakSelf.bgView).offset(KSIphonScreenW(13));
        make.right.equalTo(weakSelf.bgView).offset(-KSIphonScreenW(13));
        make.bottom.equalTo(weakSelf.taskMarkBtn.mas_bottom).offset(KSIphonScreenH(15));
    }];
    self.taskMarkView.backgroundColor = [UIColor colorWithHexString:@"#f1f6fe"];
    self.taskMarkView.layer.cornerRadius = 8;
    self.taskMarkView.layer.masksToBounds = YES;
    
    // 任务状态imageV
    self.taskStatuImageV = [[UIImageView alloc]init];
    [self.bgView addSubview:self.taskStatuImageV];
    self.taskStatuImageV.image = [UIImage imageNamed:@"taskCenter_detail_tasking"];
    [self.taskStatuImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(weakSelf.taskMarkView);
    }];
    
    // 锁定状态
    self.lockStatuImageV = [[UIImageView alloc]init];
    [self.bgView addSubview:self.lockStatuImageV];
    self.lockStatuImageV.image = [UIImage imageNamed:@"taskCenter_frostGlass_cell"];
    self.lockStatuImageV.contentMode = UIViewContentModeScaleAspectFill;
    [self.lockStatuImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.coverImageV);
    }];
   
}
// 说明更多
-(void) selectMarkManyBtn:(UIButton *) sender{
    self.selectMarkMany();
}
// 点击前置任务
-(void) selectPariConditTap{
    NSString *relatedtaskStr = [NSString stringWithFormat:@"%@",self.dict[@"relatedtask"]];
    if ([relatedtaskStr isEqualToString:@"1"]) {
        self.selectPariTap();
    }
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;

    // 封面图
    NSString *iconStr = [NSString stringWithFormat:@"%@",dict[@"icon"]];
    // 字符串和UTF8编码转换
    NSString *urlUTF8Str = [iconStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [YWTTools sd_setImageView:self.coverImageV WithURL:urlUTF8Str andPlaceholder:@"taskCenter_header_bg"];
    
    // 进度条
    NSString *carryOutStr = [NSString stringWithFormat:@"%@",dict[@"carryOut"]];
    self.progressView.progress =  [carryOutStr floatValue]/100;
    
    // 显示进度lab
    self.showProgressLab.text = [NSString stringWithFormat:@"%@%%",carryOutStr];
    
    // 任务标题
    NSString *titleStr = [NSString stringWithFormat:@"%@",dict[@"title"]];
    self.showTaskTitleLab.text = titleStr;
    
    // 1有前置任务 2无前置任务 取消锁定状态
    NSString *relatedtaskStr = [NSString stringWithFormat:@"%@",dict[@"relatedtask"]];
    if ([relatedtaskStr isEqualToString:@"2"]) {
        self.lockStatuImageV.hidden = YES;
    }else{
        // 如果有前置任务 1是已经完成前置任务 2是未完成前置任务
        NSString *relatedtaskOutStr = [NSString stringWithFormat:@"%@",dict[@"relatedtaskOut"]];
        if ([relatedtaskOutStr isEqualToString:@"1"]) {
            self.lockStatuImageV.hidden = YES;
        }else if ([relatedtaskOutStr isEqualToString:@"2"]) {
            self.lockStatuImageV.hidden = NO;
            self.progressView.trackTintColor = [UIColor colorWithHexString:@"#a7a7a7"];
        }
    }
    // 1进行中2已完成3未完成4暂时完成5作废6未开始【4基本不会返回】
    NSString *statusStr = [NSString stringWithFormat:@"%@",dict[@"status"]];
    if ([statusStr isEqualToString:@"1"]) {
         self.taskStatuImageV.image = [UIImage imageNamed:@"taskCenter_detail_tasking"];
        // 正常正常背景view
        self.nomalProgressBgView.hidden = NO;
        // 隐藏未开始状态的view
        self.unStartProgressBgView.hidden = YES;
    }else if ([statusStr isEqualToString:@"2"]){
         self.taskStatuImageV.image = [UIImage imageNamed:@"taskCenter_detail_complete"];
        // 正常正常背景view
        self.nomalProgressBgView.hidden = NO;
        // 隐藏未开始状态的view
        self.unStartProgressBgView.hidden = YES;
    }else if ([statusStr isEqualToString:@"3"]){
         self.taskStatuImageV.image = [UIImage imageNamed:@"taskCenter_detail_undone"];
         self.progressView.trackTintColor = [UIColor colorWithHexString:@"#a7a7a7"];
        self.tagView.textColor = [UIColor colorWithHexString:@"#a7a7a7"];
        self.tagView.borderColor = [UIColor colorWithHexString:@"#a7a7a7"];
        // 正常正常背景view
        self.nomalProgressBgView.hidden = NO;
        // 隐藏未开始状态的view
        self.unStartProgressBgView.hidden = YES;
    }else if ([statusStr isEqualToString:@"5"]){
        self.taskStatuImageV.image = [UIImage imageNamed:@"taskCenter_detail_outDate"];
        self.progressView.trackTintColor = [UIColor colorWithHexString:@"#a7a7a7"];
        self.tagView.textColor = [UIColor colorWithHexString:@"#a7a7a7"];
        self.tagView.borderColor = [UIColor colorWithHexString:@"#a7a7a7"];
        // 正常正常背景view
        self.nomalProgressBgView.hidden = NO;
        // 隐藏未开始状态的view
        self.unStartProgressBgView.hidden = YES;
    }else if ([statusStr isEqualToString:@"6"]){
         self.taskStatuImageV.image = [UIImage imageNamed:@"taskCenter_detail_unBegin"];
        // 显示未开始状态的view
        self.unStartProgressBgView.hidden = NO;
         // 隐藏正常背景view
        self.nomalProgressBgView.hidden = YES;
        // 任务开始剩余秒数
        NSString *remTimeStr = [NSString stringWithFormat:@"%@",dict[@"remTime"]];
        self.remTime = [remTimeStr integerValue];
        // 添加定时器
        [self addUnStartStatuTimer];
    }

    __weak typeof(self) weakSelf = self;
    // 标签组
    NSArray *tagArr = (NSArray *) dict[@"tag"];
    // 赋值
    self.tagView.tagsList = [NSMutableArray arrayWithArray:tagArr];
    // 标签的高度
    STTagFrame * tagFrame = [STTagFrame tagFrameWithContentInsets:UIEdgeInsetsMake(0, 0, 0, 0) labelContentInsets:UIEdgeInsetsMake(2, 5, 2, 5) horizontalSpacing:10 verticalSpacing:10 textFont:[UIFont systemFontOfSize:12] tagArray:tagArr];
    tagFrame.width = KScreenW-KSIphonScreenW(16);
    tagFrame.tagsArray = tagArr.mutableCopy;
    // 如果标签view 的高度大于 默认 24  ，就从新布局
    if (tagFrame.height > KSIphonScreenH(22)) {
        [self.tagView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(tagFrame.height));
        }];
    }
  
   // 1有前置任务 2无前置任务
    if ([relatedtaskStr isEqualToString:@"1"]) {
        // 参与条件
        NSString *relatedtaskNameStr = [NSString stringWithFormat:@"%@",dict[@"relatedtaskName"]];
        NSAttributedString *attrStr = [[NSAttributedString alloc]initWithData:[relatedtaskNameStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:[UIFont boldSystemFontOfSize:12]} documentAttributes:nil error:nil];
        self.particConditionLab.attributedText =attrStr;
       
        // 完成条件
        NSString *comletStr = [NSString stringWithFormat:@"%@",dict[@"completionRemark"]];
        NSString *completionRemarkStr = [NSString stringWithFormat:@"<font color = '#656565'>完成条件:</font>%@",comletStr];
        NSAttributedString *compleAttrStr = [[NSAttributedString alloc]initWithData:[completionRemarkStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:[UIFont boldSystemFontOfSize:12]} documentAttributes:nil error:nil];
        self.compleConditionLab.attributedText = compleAttrStr;
       
        // 任务时段
        self.taskTimeLab.text = [NSString stringWithFormat:@"任务时段:%@",dict[@"period"]];
        // 任务说明
        NSString *descriptionStr = [NSString stringWithFormat:@"%@",dict[@"description"]];
        NSAttributedString *descAttrStr = [[NSAttributedString alloc]initWithData:[descriptionStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:[UIFont boldSystemFontOfSize:12]} documentAttributes:nil error:nil];
        self.taskMarkLab.attributedText =descAttrStr;
        
        // 完成条件
        self.compleConditionLab.hidden = [comletStr isEqualToString:@""] ? YES : NO;
        // 如果完成条件没有隐藏
        if ([comletStr isEqualToString:@""]) {
            // 隐藏 完成条件
            self.compleConditionImageV.hidden = YES;
            self.compleConditionLab.hidden = YES;
            // 更新UI
            [self.taskTimeImageV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.particConditionLab.mas_bottom).offset(KSIphonScreenH(15));
                make.centerX.equalTo(weakSelf.particConditionImageV.mas_centerX);
            }];
        }
        // 任务说明
        if ([descriptionStr isEqualToString:@""]) {
            // 没有说明 隐藏
            self.taskMarkLab.hidden = YES;
            self.self.taskMarkLab.hidden = YES;
            // 隐藏更多按钮
            self.taskMarkBtn.hidden = YES;
            // 更新高度约束
            [self.taskMarkView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.tagView.mas_bottom).offset(KSIphonScreenH(10));
                make.left.equalTo(weakSelf.bgView).offset(KSIphonScreenW(13));
                make.right.equalTo(weakSelf.bgView).offset(-KSIphonScreenW(13));
                make.bottom.equalTo(weakSelf.taskTimeLab.mas_bottom).offset(KSIphonScreenH(13));
            }];
            return ;
        }
    
        CGFloat descHeight = [self.taskMarkLab.attributedText boundingRectWithSize:CGSizeMake(KScreenW-76, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
        if (descHeight > 60) {
            // 显示更多按钮
            self.taskMarkBtn.hidden = NO;
            // 更新高度约束
            [self.taskMarkView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.tagView.mas_bottom).offset(KSIphonScreenH(10));
                make.left.equalTo(weakSelf.bgView).offset(KSIphonScreenW(13));
                make.right.equalTo(weakSelf.bgView).offset(-KSIphonScreenW(13));
                make.bottom.equalTo(weakSelf.taskMarkBtn.mas_bottom).offset(KSIphonScreenH(13));
            }];
            return ;
        }
        // 隐藏更多按钮
        self.taskMarkBtn.hidden = YES;
        // 更新高度约束
        [self.taskMarkView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.tagView.mas_bottom).offset(KSIphonScreenH(10));
            make.left.equalTo(weakSelf.bgView).offset(KSIphonScreenW(13));
            make.right.equalTo(weakSelf.bgView).offset(-KSIphonScreenW(13));
            make.bottom.equalTo(weakSelf.taskMarkLab.mas_bottom).offset(KSIphonScreenH(13));
        }];
    }else{
        // 任务时段
        self.particConditionLab.text = [NSString stringWithFormat:@"任务时段:%@",dict[@"period"]];
        // 任务说明
        NSString *descriptionStr = [NSString stringWithFormat:@"%@",dict[@"description"]];
        NSString *descrStr = [NSString stringWithFormat:@"<font color = '#656565'>%@</font>",descriptionStr];
        NSAttributedString *attrStr = [[NSAttributedString alloc]initWithData:[descrStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:[UIFont boldSystemFontOfSize:12]} documentAttributes:nil error:nil];
        self.compleConditionLab.attributedText =attrStr;
        // 贴换图片
        self.particConditionImageV.image = [UIImage imageNamed:@"taskCenter_detail_time"];
        
        self.compleConditionImageV.image = [UIImage imageNamed:@"taskCenter_detail_taskMark"];
        
        // 隐藏 任务时段 和 任务说明
        self.taskTimeLab.hidden = YES;
        self.taskMarkLab.hidden = YES;
        
        self.taskMarkImageV.hidden = YES;
        self.taskTimeImageV.hidden = YES;
        
        // 任务说明
        if ([descriptionStr isEqualToString:@""]) {
            // 没有说明 隐藏
            self.compleConditionLab.hidden = YES;
            self.self.compleConditionImageV.hidden = YES;
            // 隐藏更多按钮
            self.taskMarkBtn.hidden = YES;
            // 更新高度约束
            [self.taskMarkView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.tagView.mas_bottom).offset(KSIphonScreenH(10));
                make.left.equalTo(weakSelf.bgView).offset(KSIphonScreenW(13));
                make.right.equalTo(weakSelf.bgView).offset(-KSIphonScreenW(13));
                make.bottom.equalTo(weakSelf.particConditionLab.mas_bottom).offset(KSIphonScreenH(13));
            }];
            return ;
        }
        CGFloat descHeight = [self.compleConditionLab.attributedText boundingRectWithSize:CGSizeMake(KScreenW-76, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
        if (descHeight > 60) {
            // 显示更多按钮
            self.taskMarkBtn.hidden = NO;
            // 更新高度约束
            [self.taskMarkView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.tagView.mas_bottom).offset(KSIphonScreenH(10));
                make.left.equalTo(weakSelf.bgView).offset(KSIphonScreenW(13));
                make.right.equalTo(weakSelf.bgView).offset(-KSIphonScreenW(13));
                make.bottom.equalTo(weakSelf.taskMarkBtn.mas_bottom).offset(KSIphonScreenH(13));
            }];
            return ;
        }
        // 隐藏更多按钮
        self.taskMarkBtn.hidden = YES;
        // 更新高度约束
        [self.taskMarkView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.tagView.mas_bottom).offset(KSIphonScreenH(10));
            make.left.equalTo(weakSelf.bgView).offset(KSIphonScreenW(13));
            make.right.equalTo(weakSelf.bgView).offset(-KSIphonScreenW(13));
            make.bottom.equalTo(weakSelf.compleConditionLab.mas_bottom).offset(KSIphonScreenH(15));
        }];
    }
}
// 计算高度
+(CGFloat) getWithTaskDetailHeaderHeight:(NSDictionary *) dict{
    CGFloat height = KSIphonScreenH(225);
   
    // 任务标题
    NSString *titleStr = [NSString stringWithFormat:@"%@",dict[@"title"]];
    CGFloat titleHight = [YWTTools getSpaceLabelHeight:titleStr withFont:15 withWidth:KScreenW-KSIphonScreenW(26) withSpace:2];
    height += titleHight;
    height += KSIphonScreenH(12);
    // 标签组
    NSArray *tagArr = (NSArray *) dict[@"tag"];
  
    // 标签的高度
    STTagFrame * tagFrame = [STTagFrame tagFrameWithContentInsets:UIEdgeInsetsMake(0, 0, 0, 0) labelContentInsets:UIEdgeInsetsMake(2, 5, 2, 5) horizontalSpacing:5 verticalSpacing:5 textFont:[UIFont systemFontOfSize:11] tagArray:tagArr];
    tagFrame.width = KScreenW-KSIphonScreenW(24) ;
    tagFrame.tagsArray = tagArr.mutableCopy;
    height += tagFrame.height;
    height += KSIphonScreenH(15);
    
    // 1有前置任务 2无前置任务
    NSString *relatedtaskStr = [NSString stringWithFormat:@"%@",dict[@"relatedtask"]];
    if ([relatedtaskStr isEqualToString:@"1"]) {
        // 参与条件
        NSString *relatedtaskNameStr = [NSString stringWithFormat:@"%@",dict[@"relatedtaskName"]];
        UILabel *relatLab = [[UILabel alloc]init];
        NSAttributedString *relatAttrStr = [[NSAttributedString alloc]initWithData:[relatedtaskNameStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:[UIFont boldSystemFontOfSize:13]} documentAttributes:nil error:nil];
        relatLab.attributedText = relatAttrStr;
        CGFloat relatedtaskNameHight =[relatLab.attributedText boundingRectWithSize:CGSizeMake(KScreenW-KSIphonScreenW(76), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
        height += relatedtaskNameHight;
        height += KSIphonScreenH(15);
        
        // 完成条件
        NSString *completionRemarkStr = [NSString stringWithFormat:@"%@",dict[@"completionRemark"]];
        if (![completionRemarkStr isEqualToString:@""]) {
            UILabel *compleLab = [[UILabel alloc]init];
            NSAttributedString *compleAttrStr = [[NSAttributedString alloc]initWithData:[completionRemarkStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:[UIFont boldSystemFontOfSize:13]} documentAttributes:nil error:nil];
            compleLab.attributedText = compleAttrStr;
            CGFloat completionRemarkHight = [compleLab.attributedText boundingRectWithSize:CGSizeMake(KScreenW-KSIphonScreenW(76), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
            height += completionRemarkHight;
            height += KSIphonScreenH(15);
        }
       
        // 任务时段
        NSString *periodStr = [NSString stringWithFormat:@"%@",dict[@"period"]];
        CGFloat periodHight = [YWTTools getSpaceLabelHeight:periodStr withFont:13 withWidth:KScreenW-KSIphonScreenW(76) withSpace:2];
        height += periodHight;
        height += KSIphonScreenH(15);
        
        // 任务说明
        NSString *descriptionStr = [NSString stringWithFormat:@"%@",dict[@"description"]];
        if ([descriptionStr isEqualToString:@""]) {
            height += KSIphonScreenH(25);
            height += KSIphonScreenH(30);
            
            return height;
        }
        UILabel *lab = [[UILabel alloc]init];
        NSAttributedString *attrStr = [[NSAttributedString alloc]initWithData:[descriptionStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:[UIFont boldSystemFontOfSize:13]} documentAttributes:nil error:nil];
        lab.attributedText = attrStr;
        CGFloat descHeight = [lab.attributedText boundingRectWithSize:CGSizeMake(KScreenW-KSIphonScreenW(76), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
        if (descHeight > 65) {
            // 说明高度+ 按钮的高度
            height += KSIphonScreenH(110);
            height += KSIphonScreenH(15);
        }else{
            height += descHeight;
            height += KSIphonScreenH(30);
        }
        return  height;
    }
    
    // 任务时段
    NSString *periodStr = [NSString stringWithFormat:@"%@",dict[@"period"]];
    CGFloat periodHight = [YWTTools getSpaceLabelHeight:periodStr withFont:13 withWidth:KScreenW-KSIphonScreenW(76) withSpace:2];
    height += periodHight;
    height += KSIphonScreenH(15);
    
    // 任务说明
    NSString *descriptionStr = [NSString stringWithFormat:@"%@",dict[@"description"]];
    if ([descriptionStr isEqualToString:@""]) {
        height += KSIphonScreenH(30);
        height += KSIphonScreenH(30);
        return height;
    }
    UILabel *lab = [[UILabel alloc]init];
    NSAttributedString *attrStr = [[NSAttributedString alloc]initWithData:[descriptionStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:[UIFont boldSystemFontOfSize:12]} documentAttributes:nil error:nil];
    lab.attributedText = attrStr;
    CGFloat descHeight = [lab.attributedText boundingRectWithSize:CGSizeMake(KScreenW-KSIphonScreenW(76), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    if (descHeight > 65) {
        // 说明高度+ 按钮的高度
        height += KSIphonScreenH(110);
        height += KSIphonScreenH(15);
    }else{
        height += descHeight;
        height += KSIphonScreenH(30);
    }
    height += KSIphonScreenH(30);
    return height;
}

// 添加定时器
-(void) addUnStartStatuTimer{
     self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(addSeconed) userInfo:nil repeats:YES];
}
-(void)addSeconed{
    if (self.remTime == 0) {
        return;
    }
    self.remTime -= 1;
    
    // 未开始倒计时
    self.showUnStartCountdownLab.text  = [NSString stringWithFormat:@"距开始还剩 %@",[self getMMSSFromSS:[NSString stringWithFormat:@"%ld",(long)self.remTime]]];
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

@end
