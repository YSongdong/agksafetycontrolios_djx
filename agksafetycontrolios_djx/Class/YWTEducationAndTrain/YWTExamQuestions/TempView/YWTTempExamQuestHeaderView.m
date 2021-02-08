//
//  TempExamQuestHeaderView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/18.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTTempExamQuestHeaderView.h"

@interface YWTTempExamQuestHeaderView ()

// 标题
@property (nonatomic,strong) UILabel *submitLab;
// 当前题号
@property (nonatomic,strong) UILabel *nowQuestNumberLab;
// 总共多少题
@property (nonatomic,strong) UILabel *totalQuestNumberLab;
// 题目
@property (nonatomic,strong) UILabel *titleQuestLab;
// 图片
@property (nonatomic,strong) UIImageView *titleQuestImageV;
// 考试详情view
@property (nonatomic,strong) UIView *examDetailBgView;
// 考试详情总共数
@property (nonatomic,strong) UILabel *examDetailTotalLab;
// 详情开始时间
@property (nonatomic,strong) UILabel *detailBeginTimeLab;
// 练习耗时
@property (nonatomic,strong) UILabel *detailExerTimerLab;
// 练习得分
@property (nonatomic,strong) UILabel *detailExerScoreLab;
// 练习结果
@property (nonatomic,strong) UILabel *detailExerReaultLab;
// 答案状态
@property (nonatomic,strong) UIImageView *answerStatuImageV;

@property (nonatomic,strong) UIView *headerBgView;

@end


@implementation YWTTempExamQuestHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createHeaderView];
    }
    return self;
}
-(void) createHeaderView{
    __weak typeof(self) weakSelf = self;
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    // 标题
    self.submitLab = [[UILabel alloc]init];
    [bgView addSubview:self.submitLab];
    self.submitLab.text = @"工程造价管理基础理论";
    self.submitLab.textColor = [UIColor colorCommonBlackColor];
    self.submitLab.font = BFont(18);
    self.submitLab.textAlignment = NSTextAlignmentCenter;
    [self.submitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(KSIphonScreenW(12));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(12));
        make.top.equalTo(bgView).offset(KSIphonScreenH(20));
    }];
    
    self.examDetailBgView = [[UIView alloc]init];
    [bgView addSubview:self.examDetailBgView];
    self.examDetailBgView.backgroundColor = [UIColor colorWithHexString:@"#e4eefe"];

    self.examDetailTotalLab = [[UILabel alloc]init];
    [self.examDetailBgView addSubview:self.examDetailTotalLab];
    self.examDetailTotalLab.text =@"(共0题，正确0道，错误0道)";
    self.examDetailTotalLab.textColor = [UIColor colorConstantCommonBlueColor];
    self.examDetailTotalLab.font = Font(14);
    self.examDetailTotalLab.textAlignment = NSTextAlignmentCenter;
    [self.examDetailTotalLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.examDetailBgView).offset(KSIphonScreenH(13));
        make.centerX.equalTo(weakSelf.examDetailBgView.mas_centerX);
    }];

    self.detailBeginTimeLab = [[UILabel alloc]init];
    [self.examDetailBgView addSubview:self.detailBeginTimeLab];
    self.detailBeginTimeLab.font = Font(14);
    self.detailBeginTimeLab.textColor = [UIColor colorCommonBlackColor];
    self.detailBeginTimeLab.text = @"开始时间:";
    [self.detailBeginTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.examDetailTotalLab.mas_bottom).offset(KSIphonScreenH(12));
        make.left.equalTo(weakSelf.examDetailBgView).offset(KSIphonScreenW(12));
    }];

    self.detailExerTimerLab = [[UILabel alloc]init];
    [self.examDetailBgView addSubview:self.detailExerTimerLab];
    self.detailExerTimerLab.font = Font(14);
    self.detailExerTimerLab.textColor = [UIColor colorCommonBlackColor];
    self.detailExerTimerLab.text = @"练习耗时: ";
    [self.detailExerTimerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.examDetailBgView).offset(KSIphonScreenW(205));
        make.centerY.equalTo(weakSelf.detailBeginTimeLab.mas_centerY);
    }];

    // 练习得分
    self.detailExerScoreLab = [[UILabel alloc]init];
    [self.examDetailBgView addSubview:self.detailExerScoreLab];
    self.detailExerScoreLab.font = Font(14);
    self.detailExerScoreLab.textColor = [UIColor colorCommonBlackColor];
    self.detailExerScoreLab.text = @"练习得分: 0分";
    [self.detailExerScoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.detailBeginTimeLab.mas_bottom).offset(KSIphonScreenH(5));
        make.left.equalTo(weakSelf.detailBeginTimeLab.mas_left);
    }];

    // 练习结果
    self.detailExerReaultLab = [[UILabel alloc]init];
    [self.examDetailBgView addSubview:self.detailExerReaultLab];
    self.detailExerReaultLab.font = Font(14);
    self.detailExerReaultLab.textColor = [UIColor colorCommonBlackColor];
    self.detailExerReaultLab.text = @"练习结果: 合格";
    [self.detailExerReaultLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.detailExerScoreLab.mas_centerY);
        make.left.equalTo(weakSelf.detailExerTimerLab.mas_left);
    }];

    [self.examDetailBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.submitLab.mas_bottom).offset(KSIphonScreenH(10));
        make.left.equalTo(bgView).offset(KSIphonScreenW(15));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(15));
        make.bottom.equalTo(weakSelf.detailExerScoreLab.mas_bottom).offset(KSIphonScreenH(13));
        make.centerX.equalTo(bgView.mas_centerX);
    }];
    self.examDetailBgView.layer.cornerRadius = KSIphonScreenH(10)/2;
    self.examDetailBgView.layer.masksToBounds = YES;
    self.examDetailBgView.layer.borderWidth = 1;
    self.examDetailBgView.layer.borderColor = [UIColor colorWithHexString:@"#d3ddee"].CGColor;
    
    // 答案状态图片
    self.answerStatuImageV = [[UIImageView alloc]init];
    [self addSubview:self.answerStatuImageV];
    self.answerStatuImageV.image = [UIImage imageNamed:@"ico_zq01"];
    [self.answerStatuImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.submitLab.mas_top);
        make.right.equalTo(weakSelf.examDetailBgView.mas_right);
    }];
    
    self.nowQuestNumberLab = [[UILabel alloc]init];
    [bgView addSubview:self.nowQuestNumberLab];
    self.nowQuestNumberLab.text = @"第1题";
    self.nowQuestNumberLab.textColor = [UIColor colorCommonBlackColor];
    self.nowQuestNumberLab.font = BFont(16);
    [self.nowQuestNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.examDetailBgView.mas_bottom).offset(KSIphonScreenH(20));
        make.left.equalTo(bgView).offset(KSIphonScreenW(15));
    }];
   
    self.totalQuestNumberLab = [[UILabel alloc]init];
    [bgView addSubview:self.totalQuestNumberLab];
    self.totalQuestNumberLab.text = @"(共100题)";
    self.totalQuestNumberLab.font = Font(13);
    self.totalQuestNumberLab.textColor = [UIColor colorCommonAAAAGreyBlackColor];
    [self.totalQuestNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nowQuestNumberLab.mas_right).offset(KSIphonScreenW(9));
        make.centerY.equalTo(weakSelf.nowQuestNumberLab.mas_centerY);
    }];
    
    self.titleQuestLab = [[UILabel alloc]init];
    [bgView addSubview:self.titleQuestLab];
    self.titleQuestLab.textColor = [UIColor colorCommonBlackColor];
    self.titleQuestLab.font = Font(17);
    self.titleQuestLab.numberOfLines = 0;
    [self.titleQuestLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nowQuestNumberLab.mas_left);
        make.top.equalTo(weakSelf.nowQuestNumberLab.mas_bottom).offset(KSIphonScreenH(15));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(15));
    }];
    
    // header  view
    self.headerBgView = [[UIView alloc]init];
    [bgView addSubview:self.headerBgView];
    self.headerBgView.backgroundColor = [UIColor colorTextWhiteColor];
    [self.headerBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleQuestLab.mas_bottom).offset(KSIphonScreenH(10));
        make.left.right.equalTo(weakSelf.titleQuestLab);
        make.height.equalTo(@(KSIphonScreenH(140)));
    }];
    // 加阴影
    self.headerBgView.layer.shadowColor = [UIColor colorWithHexString:@"#000000"].CGColor;
    // 设置阴影偏移量
    self.headerBgView.layer.shadowOffset = CGSizeMake(0,0);
    // 设置阴影透明度
    self.headerBgView.layer.shadowOpacity =0.2;
    // 设置阴影半径
    self.headerBgView.layer.shadowRadius = 5;
    
    self.titleQuestImageV = [[UIImageView alloc]init];
    [self.headerBgView addSubview:self.titleQuestImageV];
    self.titleQuestImageV.image = [UIImage imageNamed:@"quest_ImageNomal"];
    self.titleQuestImageV.userInteractionEnabled = YES;
    self.titleQuestImageV.contentMode = UIViewContentModeScaleAspectFill;
    [self.titleQuestImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(weakSelf.headerBgView).offset(1.5);
        make.bottom.right.equalTo(weakSelf.headerBgView).offset(-1.5);
    }];
    [self.titleQuestImageV setClipsToBounds:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectBigImageTap)];
    [self.titleQuestImageV addGestureRecognizer:tap];
}
-(void)setQuestModel:(QuestionListModel *)questModel{
    _questModel = questModel;
    
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    // 标题
    NSInteger submitfontSize = [userD objectForKey:@"Font"] ? [[userD objectForKey:@"Font"][@"SubjectFont"]integerValue] : 18 ;
    self.submitLab.text = questModel.paperTitle;
    self.submitLab.font = BFont(submitfontSize);
    // 当前题号
    NSInteger nowQuestfontSize = [userD objectForKey:@"Font"] ? [[userD objectForKey:@"Font"][@"NowQuestFont"]integerValue] : 15 ;
    self.nowQuestNumberLab.text = [NSString stringWithFormat:@"第%ld题",[self.nowQuestNumberStr integerValue]+1];
    self.nowQuestNumberLab.font = Font(nowQuestfontSize);
    
    // 共多少q题
     NSInteger countQuestfontSize = [userD objectForKey:@"Font"] ? [[userD objectForKey:@"Font"][@"TotalQuestFont"]integerValue] : 15 ;
    self.totalQuestNumberLab.text = [NSString stringWithFormat:@"(共%@题)",questModel.total];
    self.totalQuestNumberLab.font = Font(countQuestfontSize);
    
    // 判断答题类型
    if ([questModel.layoutType isEqualToString:@"3"]) {
        //
        self.titleQuestLab.attributedText = [self getTitleQuestAttributStr:@""];
        
        // 显示 图片视图
        self.headerBgView.hidden = NO;
        
        [YWTTools sd_setImageView:self.titleQuestImageV WithURL:questModel.picture andPlaceholder:@"quest_ImageNomal"];
        
    }else if ([questModel.layoutType isEqualToString:@"2"]){
        // 图文混排
        self.titleQuestLab.attributedText = [self getTitleQuestAttributStr:questModel.title];
        
        // 显示 图片视图
        self.headerBgView.hidden = NO;
        [YWTTools sd_setImageView:self.titleQuestImageV WithURL:questModel.picture andPlaceholder:@"quest_ImageNomal"];
    }else {
        // 纯文字
        self.titleQuestLab.attributedText = [self getTitleQuestAttributStr:questModel.title];
        // 隐藏 图片视图
        self.headerBgView.hidden = YES;
    }
    
    // 判断答案对错  作对2 做错3 未知4
    if ([questModel.selected isEqualToString:@"2"]) {
        self.answerStatuImageV.hidden = NO;
        self.answerStatuImageV.image = [UIImage imageNamed:@"ico_zq01"];
    }else if ([questModel.selected isEqualToString:@"3"]) {
        self.answerStatuImageV.hidden = NO;
        self.answerStatuImageV.image = [UIImage imageNamed:@"ico_zq"];
    }else{
        self.answerStatuImageV.hidden = YES;
    }
}
// 查看大图
-(void)selectBigImageTap{
    [XWScanImage scanBigImageWithImageView:self.titleQuestImageV];
}

/**
   题目  图文混排
 @param questStr 传入的文字
 @return  NSMutableAttributedString 类型
 */
-(NSMutableAttributedString *)getTitleQuestAttributStr:(NSString*)questStr {
    NSString *textStr =[NSString stringWithFormat:@"  %@",questStr];
    // 字体
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSInteger fontSize = [userD objectForKey:@"Font"] ? [[userD objectForKey:@"Font"][@"TitleQuestFont"]integerValue] : 17 ;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:textStr];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(0, textStr.length)];
    //设置图片源
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    if (self.questHeaderType ==tempExamQuestHeaderSingleSelectType ) {
        textAttachment.image = [UIImage imageNamed:@"exam_type_singleSelect"];
    }else if (self.questHeaderType ==tempExamQuestHeaderMultipleSelectType ){
        textAttachment.image = [UIImage imageNamed:@"exam_type_MultipleSelect"];
    }else if (self.questHeaderType ==tempExamQuestHeaderJudgmentType ){
        textAttachment.image = [UIImage imageNamed:@"exam_type_judge"];
    }else if (self.questHeaderType ==tempExamQuestHeaderFillingType ){
        textAttachment.image = [UIImage imageNamed:@"exam_type_Filling"];
    }else if (self.questHeaderType ==tempExamQuestHeaderThemeType ){
        textAttachment.image = [UIImage imageNamed:@"exam_type_Theme"];
    }
    textAttachment.bounds = CGRectMake(0, -4, 45, 20);
    
    //NSTextAttachment占用一个字符长度，插入后原字符串长度增加1
    NSAttributedString *attrString = [NSAttributedString attributedStringWithAttachment: textAttachment];
    [attrStr insertAttributedString: attrString atIndex: 0];
    
    //设置行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [textStr length])];

    return  attrStr;
}

//计算高度
+(CGFloat)getLabelHeightWithDict:(QuestionListModel *)questModel andHeaderModo:(tempExamQuestHeaderMode)headerMode{
    CGFloat height =0 ;
    
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    // 标题
    height += 25+30;
    //当前题的高度
    height += 25+30;
    // 题目 字体大小
    NSInteger fontSize = [userD objectForKey:@"Font"] ? [[userD objectForKey:@"Font"][@"TitleQuestFont"]integerValue] : 17 ;
    // 判断答题类型
    if ([questModel.layoutType isEqualToString:@"1"]) {
        // 纯文字
        UILabel *titleLab = [[UILabel alloc]init];
        titleLab.text = questModel.title;
        titleLab.attributedText = [YWTTempExamQuestHeaderView getTitleQuestAttributStr:titleLab.text andModel:questModel];
        
        CGFloat textHeight = [YWTTools getSpaceLabelHeight:titleLab.text withFont:fontSize withWidth:KScreenW-30 withSpace:3];
        
        height += 15+textHeight;
        
    }else if ([questModel.layoutType isEqualToString:@"2"]){
        // 图文混排'
        UILabel *titleLab = [[UILabel alloc]init];
        titleLab.text = questModel.title;
        titleLab.attributedText = [YWTTempExamQuestHeaderView getTitleQuestAttributStr:titleLab.text andModel:questModel];
        
        CGFloat textHeight = [YWTTools getSpaceLabelHeight:titleLab.text withFont:fontSize withWidth:KScreenW-30 withSpace:6];
        
        // 在添加图片的高度
        height += 15+textHeight+KSIphonScreenH(140);
        
    }else if ([questModel.layoutType isEqualToString:@"3"]){
        // 3'=>'纯图片
        height += KSIphonScreenH(25)+KSIphonScreenH(140);
    }
    
    if (headerMode == tempExamQuestHeaderDetailMode ) {
        height += 83;
    }
    // 在添加与答案的间距
    return height+KSIphonScreenH(20);
}

/**
 类方法

 @param questStr <#questStr description#>
 @return <#return value description#>
 */
+(NSMutableAttributedString *)getTitleQuestAttributStr:(NSString*)questStr andModel:(QuestionListModel *) model{
    NSString *textStr =[NSString stringWithFormat:@"  %@",questStr];
    // 字体
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSInteger fontSize = [userD objectForKey:@"Font"] ? [[userD objectForKey:@"Font"][@"TitleQuestFont"]integerValue] : 17 ;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:textStr];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(0, textStr.length)];
    //设置图片源
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    if ([model.typeId isEqualToString:@"1"]) {
        textAttachment.image = [UIImage imageNamed:@"exam_type_singleSelect"];
    }else if ([model.typeId isEqualToString:@"2"] ){
        textAttachment.image = [UIImage imageNamed:@"exam_type_MultipleSelect"];
    }else if ([model.typeId isEqualToString:@"3"] ){
        textAttachment.image = [UIImage imageNamed:@"exam_type_judge"];
    }else if ([model.typeId isEqualToString:@"5"] ){
        textAttachment.image = [UIImage imageNamed:@"exam_type_Filling"];
    }else if ([model.typeId isEqualToString:@"6"] ){
        textAttachment.image = [UIImage imageNamed:@"exam_type_Theme"];
    }
    textAttachment.bounds = CGRectMake(0, -5, 45, 20);
    
    //NSTextAttachment占用一个字符长度，插入后原字符串长度增加1
    NSAttributedString *attrString = [NSAttributedString attributedStringWithAttachment: textAttachment];
    [attrStr insertAttributedString: attrString atIndex: 0];
    
    //设置行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [textStr length])];
    
    return  attrStr;
}
#pragma mark -----get 方法------
-(void)setQuestHeaderType:(tempExamQuestHeaderType)questHeaderType{
    _questHeaderType = questHeaderType;
}
-(void)setNowQuestNumberStr:(NSString *)nowQuestNumberStr{
    _nowQuestNumberStr = nowQuestNumberStr;
}
-(void)setDataHeaderModel:(TempDetailQuestionModel *)dataHeaderModel{
    _dataHeaderModel = dataHeaderModel;
    // 做题
    NSString *totalQuestStr = [NSString stringWithFormat:@"(共%@题，正确%@道，错误%@道)",dataHeaderModel.questionNum,dataHeaderModel.corrNumber,dataHeaderModel.errNumber];
    self.examDetailTotalLab.text = totalQuestStr;
    
    //开始时间
    NSString *startTimeStr = [NSString stringWithFormat:@"开始时间: %@",dataHeaderModel.startTime];
    self.detailBeginTimeLab.text = startTimeStr;
    
    // 练习耗时
    NSString *timeConsStr = [NSString stringWithFormat:@"练习耗时: %@",[self getMMSSFromSS:dataHeaderModel.timeCons]];
    self.detailExerTimerLab.text = timeConsStr;
    
    // 练习得分
    NSString *scoreStr = [NSString stringWithFormat:@"练习得分: %@分",dataHeaderModel.score];
    self.detailExerScoreLab.text = scoreStr;
    
    // 练习结果
    NSString *isPassStr = [NSString stringWithFormat:@"%@",dataHeaderModel.isPass];
    NSString *isPass = [isPassStr isEqualToString:@"1"] ? @"合格" :@"不合格";
    self.detailExerReaultLab.text = [NSString stringWithFormat:@"练习结果: %@",isPass];
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
-(void)setQuestHeaderMode:(tempExamQuestHeaderMode)questHeaderMode{
    _questHeaderMode = questHeaderMode;
    if (questHeaderMode == tempExamQuestHeaderAnswerMode) {
        self.examDetailBgView.hidden = YES;
       
        __weak typeof(self) weakSelf = self;
        [self.nowQuestNumberLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.submitLab.mas_bottom).offset(KSIphonScreenH(25));
            make.left.equalTo(weakSelf).offset(KSIphonScreenW(15));
        }];

    }else{
        self.examDetailBgView.hidden = NO;
        __weak typeof(self) weakSelf = self;
        [self.nowQuestNumberLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.examDetailBgView.mas_bottom).offset(KSIphonScreenH(15));
            make.left.equalTo(weakSelf).offset(KSIphonScreenW(15));
        }];
    }
}


@end
