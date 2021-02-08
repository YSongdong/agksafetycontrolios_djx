//
//  TempExamGapFillingFootView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/2/14.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTTempExamGapFillingFootView.h"

@interface YWTTempExamGapFillingFootView ()
// 你的答案
@property (nonatomic,strong) UILabel *referAnswerLab;
//显示 专业解析
@property (nonatomic,strong) UILabel *showProfAnalLab;
// 专业解析
@property (nonatomic,strong) UILabel *profAnalLab;

@end


@implementation YWTTempExamGapFillingFootView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createBaseFooterView];
    }
    return self;
}
-(void) createBaseFooterView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorTextWhiteColor];
    
    UIView *answerView = [[UIView alloc]init];
    [self addSubview:answerView];
    answerView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    
    self.referAnswerLab = [[UILabel alloc]init];
    [answerView addSubview:self.referAnswerLab];
    self.referAnswerLab.text = @"参考答案：";
    self.referAnswerLab.textColor = [UIColor colorCommonBlackColor];
    self.referAnswerLab.font = Font(15);
    self.referAnswerLab.numberOfLines = 0;
    [self.referAnswerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(answerView).offset(KSIphonScreenW(25));
        make.right.equalTo(answerView).offset(-KSIphonScreenW(25));
        make.centerY.equalTo(answerView.mas_centerY);
    }];
    
    [answerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(KSIphonScreenH(15));
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(15));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(15));
        make.bottom.equalTo(weakSelf.referAnswerLab.mas_bottom).offset(KSIphonScreenH(15));
    }];
    answerView.layer.cornerRadius = KSIphonScreenH(10)/2;
    answerView.layer.masksToBounds = YES;
    answerView.layer.borderWidth = 1;
    answerView.layer.borderColor = [UIColor colorWithHexString:@"#e3e3e3"].CGColor;
    
    // 显示专业解析
    self.showProfAnalLab = [[UILabel alloc]init];
    [self addSubview:self.showProfAnalLab];
    self.showProfAnalLab.text = @"专业解析";
    self.showProfAnalLab.textColor = [UIColor colorConstantCommonBlueColor];
    self.showProfAnalLab.font = Font(16);
    [self.showProfAnalLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(answerView.mas_bottom).offset(KSIphonScreenH(25));
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(15));
    }];
    
    // 专业解析
    self.profAnalLab = [[UILabel alloc]init];
    [self addSubview:self.profAnalLab];
    self.profAnalLab.text = @"作业人员";
    self.profAnalLab.textColor = [UIColor colorCommonBlackColor];
    self.profAnalLab.font = Font(16);
    self.profAnalLab.numberOfLines = 0;
    [self.profAnalLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.showProfAnalLab.mas_bottom).offset(KSIphonScreenH(15));
        make.left.equalTo(weakSelf.showProfAnalLab.mas_left);
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(15));
    }];
    // 间距
    [UILabel changeLineSpaceForLabel:self.profAnalLab WithSpace:3];
}

-(void)setFootModel:(QuestionListModel *)footModel{
    _footModel = footModel;
    
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSInteger footerSize = [userD objectForKey:@"Font"] ? [[userD objectForKey:@"Font"][@"Footer"]integerValue] : 16 ;
    // 参考答案:
    NSString *referAnswerStr = [NSString stringWithFormat:@"参考答案：%@",footModel.answer];
    self.referAnswerLab.text = referAnswerStr;
    self.referAnswerLab.font = Font(footerSize);
    
    // 解析
    NSString *analyzeStr = [NSString stringWithFormat:@"%@",footModel.analyze];
    self.profAnalLab.font = Font(footerSize);
    self.showProfAnalLab.font = Font(footerSize);
    if (![analyzeStr isEqualToString:@""]) {
        self.profAnalLab.hidden = NO;
        self.showProfAnalLab.hidden  = NO;
        
        self.profAnalLab.text =analyzeStr;
    }else{
        self.profAnalLab.hidden = YES;
        self.showProfAnalLab.hidden  = YES;
    }
}
//计算高度
+(CGFloat)getLabelHeightWithDict:(QuestionListModel *)footModel{
    CGFloat height =0 ;
    
    height += 100;
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSInteger analyzeSize = [userD objectForKey:@"Font"] ? [[userD objectForKey:@"Font"][@"Footer"]integerValue] : 16 ;
    NSString *analyzeStr = [NSString stringWithFormat:@"%@",footModel.analyze];
    if (![analyzeStr isEqualToString:@""]) {
        UILabel *lab = [[UILabel alloc]init];
        lab.text = footModel.analyze;
        
        height += [YWTTools getSpaceLabelHeight:lab.text withFont:analyzeSize withWidth:KScreenW-30 withSpace:3]+30;
    }
    
    // 参考答案
    NSString *answerStr = [NSString stringWithFormat:@"%@",footModel.answer];
    if (![answerStr isEqualToString:@""]) {
        UILabel *lab = [[UILabel alloc]init];
        lab.text = footModel.answer;
        height += [YWTTools getSpaceLabelHeight:lab.text withFont:analyzeSize withWidth:KScreenW-30 withSpace:3]+30;
    }
    
    return height ;
}

@end
