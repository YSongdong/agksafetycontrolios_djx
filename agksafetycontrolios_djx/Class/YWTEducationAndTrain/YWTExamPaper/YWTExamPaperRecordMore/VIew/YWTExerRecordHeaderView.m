//
//  ExerRecordHeaderView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/17.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTExerRecordHeaderView.h"

@implementation YWTExerRecordHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createRecordView];
    }
    return self;
}

-(void) createRecordView{
    __weak typeof(self) weakSelf = self;
    
    UIImageView *bgImageV = [[UIImageView alloc]init];
    [self addSubview:bgImageV];
    bgImageV.image = [UIImage imageChangeName:@"lxjl_nav_bg"];
    [bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.equalTo(weakSelf);
        make.height.equalTo(@(KSIphonScreenH(50)));
    }];
    
    // 序号
    UILabel  *serialNumberLab = [[UILabel alloc]init];
    [bgView addSubview:serialNumberLab];
    serialNumberLab.text = @"序号";
    serialNumberLab.textColor = [UIColor colorTextWhiteColor];
    serialNumberLab.font = Font(14);
    [serialNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(KSIphonScreenW(12));
        make.centerY.equalTo(bgView.mas_centerY);
    }];
    
    
    // 考试日期
    UILabel *exerDateLab = [[UILabel alloc]init];
    [bgView addSubview:exerDateLab];
    exerDateLab.text = @"练习时间";
    exerDateLab.textColor = [UIColor colorTextWhiteColor];
    exerDateLab.font = Font(14);
    [exerDateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(serialNumberLab.mas_right).offset(KSIphonScreenW(30));
        make.centerY.equalTo(serialNumberLab.mas_centerY);
    }];
    
    // 耗时
    UILabel *timeConsumLab = [[UILabel alloc]init];
    [bgView addSubview:timeConsumLab];
    timeConsumLab.text = @"耗时";
    timeConsumLab.textColor = [UIColor colorTextWhiteColor];
    timeConsumLab.font = Font(14);
    [timeConsumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(exerDateLab.mas_right).offset(KSIphonScreenW(45));
        make.centerY.equalTo(exerDateLab.mas_centerY);
    }];
    
    // 得分
     UILabel * examScoreLab = [[UILabel alloc]init];
    [bgView addSubview:examScoreLab];
    examScoreLab.text = @"得分";
    examScoreLab.textColor = [UIColor colorTextWhiteColor];
    examScoreLab.font = Font(14);
    [examScoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeConsumLab.mas_right).offset(KSIphonScreenW(30));
        make.centerY.equalTo(timeConsumLab.mas_centerY);
    }];
    
    // 结果
    UILabel  *showExamResultLab = [[UILabel alloc]init];
    [bgView addSubview:showExamResultLab];
    showExamResultLab.text = @"结果";
    showExamResultLab.textColor = [UIColor colorTextWhiteColor];
    showExamResultLab.font = Font(14);
    [showExamResultLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(examScoreLab.mas_right).offset(KSIphonScreenW(25));
        make.centerY.equalTo(examScoreLab.mas_centerY);
    }];
    
    // 操作
    UILabel  *showExamOperatLab = [[UILabel alloc]init];
    [bgView addSubview:showExamOperatLab];
    showExamOperatLab.text = @"操作";
    showExamOperatLab.textColor = [UIColor colorTextWhiteColor];
    showExamOperatLab.font = Font(14);
    [showExamOperatLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView).offset(-KSIphonScreenW(15));
        make.centerY.equalTo(showExamResultLab.mas_centerY);
    }];
    
}





@end
