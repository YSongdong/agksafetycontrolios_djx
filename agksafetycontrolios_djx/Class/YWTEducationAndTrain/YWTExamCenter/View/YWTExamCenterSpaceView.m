//
//  ExamCenterSpaceView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/22.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTExamCenterSpaceView.h"

@implementation YWTExamCenterSpaceView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createSpaceView];
    }
    return self;
}
-(void) createSpaceView{
    __weak typeof(self) weakSelf = self;
    
    self.backgroundColor = [UIColor colorWithHexString:@"#eff6ff"];
    
    UIImageView *topImageV = [[UIImageView alloc]init];
    [self addSubview:topImageV];
    topImageV.image = [UIImage imageNamed:@"examCenter_pic"];
    [topImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(KSIphonScreenH(37));
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(KSIphonScreenH(262));
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
        make.height.equalTo(@(KSIphonScreenH(125)));
    }];
    bgView.layer.cornerRadius = KSIphonScreenH(5);
    bgView.layer.masksToBounds = YES;
    
    UIButton *showTitleBtn = [[UIButton alloc]init];
    [bgView addSubview:showTitleBtn];
    [showTitleBtn setTitle:@" 考前须知" forState:UIControlStateNormal];
    showTitleBtn.titleLabel.font = Font(16);
    [showTitleBtn setTitleColor:[UIColor colorConstantCommonBlueColor] forState:UIControlStateNormal];
    [showTitleBtn setImage:[UIImage imageNamed:@"ico_01"] forState:UIControlStateNormal];
    [showTitleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(KSIphonScreenH(12));
        make.centerX.equalTo(bgView);
    }];
    
    UILabel *showContentLab = [[UILabel alloc]init];
    [bgView addSubview:showContentLab];
    NSString *str = @"1、请保证手机电量充足，网络畅通 \n2、请携带本人身份证件 \n3、考试过程中随机身份认证，请于考前上传留底照片。";
    NSString *msg;
    msg = [NSString stringWithFormat:@"%@",
           [str stringByReplacingOccurrencesOfString:@"\\n" withString:@" \r\n" ]];
    showContentLab.text =msg;
    showContentLab.textColor = [UIColor colorCommonAAAAGreyBlackColor];
    showContentLab.font = Font(14);
    showContentLab.numberOfLines = 0;
    [showContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(KSIphonScreenW(22));
        make.top.equalTo(showTitleBtn.mas_bottom).offset(KSIphonScreenH(12));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(22));
    }];

    UIView *examInfoView = [[UIView alloc]init];
    [self addSubview:examInfoView];
    examInfoView.backgroundColor = [UIColor colorTextWhiteColor];
    
    UIButton *showExamBtn = [[UIButton alloc]init];
    [examInfoView addSubview:showExamBtn];
    [showExamBtn setTitle:@" 考场考试信息" forState:UIControlStateNormal];
    showExamBtn.titleLabel.font = Font(16);
    [showExamBtn setTitleColor:[UIColor colorConstantCommonBlueColor] forState:UIControlStateNormal];
    [showExamBtn setImage:[UIImage imageNamed:@"ico_01"] forState:UIControlStateNormal];
    [showExamBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(examInfoView).offset(KSIphonScreenH(12));
        make.centerX.equalTo(examInfoView);
    }];
    
    UILabel *showInfoLab = [[UILabel alloc]init];
    [examInfoView addSubview:showInfoLab];
    NSString *infoStr = @"现目前暂无考试安排，敬请多留意考试通知，如有需要参加的考试，请按考试规定的时间参加相应的考试！\n如有疑问请咨询相关管理人员！为避免影响考试，考试前请熟悉安管控相关功能！";
    NSString *markStr;
    markStr = [NSString stringWithFormat:@"%@",
           [infoStr stringByReplacingOccurrencesOfString:@"\\n" withString:@" \r\n" ]];
    showInfoLab.text =markStr;
    showInfoLab.textColor =[UIColor colorCommonAAAAGreyBlackColor];
    showInfoLab.font = Font(13);
    showInfoLab.numberOfLines = 0;
    [showInfoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(examInfoView).offset(KSIphonScreenW(22));
        make.top.equalTo(showExamBtn.mas_bottom).offset(KSIphonScreenH(12));
        make.right.equalTo(examInfoView).offset(-KSIphonScreenW(22));
    }];
    
    [examInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_bottom).offset(KSIphonScreenH(22));
        make.left.width.equalTo(bgView);
        make.bottom.equalTo(showInfoLab.mas_bottom).offset(KSIphonScreenH(12));
        make.centerX.equalTo(bgView.mas_centerX);
    }];
    examInfoView.layer.cornerRadius = KSIphonScreenH(5);
    examInfoView.layer.masksToBounds = YES;
}






@end
