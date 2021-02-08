//
//  LibayExerStartLearnPromptView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/2/26.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTLibayExerStartLearnPromptView.h"

@implementation YWTLibayExerStartLearnPromptView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createStartLearnView];
    }
    return self;
}
-(void) createStartLearnView{
    __weak typeof(self) weakSelf= self;

    UIView *bigBgView = [[UIView alloc]init];
    [self addSubview:bigBgView];
    bigBgView.backgroundColor = [UIColor blackColor];
    bigBgView.alpha = 0.6;
    [bigBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    UITapGestureRecognizer *bigBgTag = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectBigBgTag)];
    [bigBgView addGestureRecognizer:bigBgTag];
    
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    
    //顺序练习
    UIButton *beginLearnBtn = [[UIButton alloc]init];
    [bgView addSubview:beginLearnBtn];
    beginLearnBtn.backgroundColor = [UIColor colorWithHexString:@"#e9f1ff"];
    [beginLearnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(KSIphonScreenH(100)));
        make.left.equalTo(bgView).offset(KSIphonScreenW(36));
        make.centerY.equalTo(bgView.mas_centerY);
    }];
    beginLearnBtn.layer.cornerRadius = KSIphonScreenH(100)/2;
    beginLearnBtn.layer.masksToBounds = YES;
    [beginLearnBtn addTarget:self action:@selector(selectBeginLearnBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *beginLearnView = [[UIView alloc]init];
    [bgView addSubview:beginLearnView];
    beginLearnView.userInteractionEnabled = NO;
    
    UIImageView *beginLearnImageV = [[UIImageView alloc]init];
    [beginLearnView addSubview:beginLearnImageV];
    beginLearnImageV.image = [UIImage imageNamed:@"ico_sxlx"];
    beginLearnImageV.contentMode = UIViewContentModeScaleAspectFit;
    [beginLearnImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(beginLearnView);
        make.centerX.equalTo(beginLearnView.mas_centerX);
    }];
    
    UILabel *beginLearnLab = [[UILabel alloc]init];
    [beginLearnView addSubview:beginLearnLab];
    beginLearnLab.text = @"顺序练习";
    beginLearnLab.textColor = [UIColor colorCommonBlackColor];
    beginLearnLab.font = Font(15);
    [beginLearnLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(beginLearnImageV.mas_bottom).offset(KSIphonScreenH(15));
        make.centerX.equalTo(beginLearnView.mas_centerX);
    }];
    
    [beginLearnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(beginLearnImageV.mas_top);
        make.left.equalTo(beginLearnLab.mas_left);
        make.right.equalTo(beginLearnLab.mas_right);
        make.bottom.equalTo(beginLearnLab.mas_bottom);
        make.centerX.equalTo(beginLearnBtn.mas_centerX);
        make.centerY.equalTo(beginLearnBtn.mas_centerY);
    }];
    
    //专项练习
    UIButton *specialPracticeBtn = [[UIButton alloc]init];
    [bgView addSubview:specialPracticeBtn];
    specialPracticeBtn.backgroundColor = [UIColor colorWithHexString:@"#ffedd7"];
    [specialPracticeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(beginLearnBtn.mas_right).offset(KSIphonScreenW(47));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(36));
        make.width.height.equalTo(beginLearnBtn);
        make.centerY.equalTo(beginLearnBtn.mas_centerY);
    }];
    specialPracticeBtn.layer.cornerRadius = KSIphonScreenH(100)/2;
    specialPracticeBtn.layer.masksToBounds = YES;
    [specialPracticeBtn addTarget:self action:@selector(selectSpecPracBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *speciPracView = [[UIView alloc]init];
    [bgView addSubview:speciPracView];
    speciPracView.userInteractionEnabled = NO;
    
    UIImageView *specPracImageV = [[UIImageView alloc]init];
    [speciPracView addSubview:specPracImageV];
    specPracImageV.image = [UIImage imageNamed:@"ico_zxxl"];
    specPracImageV.contentMode = UIViewContentModeScaleAspectFit;
    [specPracImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(speciPracView);
        make.centerX.equalTo(speciPracView.mas_centerX);
    }];

    UILabel *specPracLab = [[UILabel alloc]init];
    [speciPracView addSubview:specPracLab];
    specPracLab.text = @"专项练习";
    specPracLab.textColor = [UIColor colorCommonBlackColor];
    specPracLab.font = Font(15);
    [specPracLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(specPracImageV.mas_bottom).offset(KSIphonScreenH(15));
        make.centerX.equalTo(speciPracView.mas_centerX);
    }];

    [speciPracView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(specPracImageV.mas_top);
        make.left.equalTo(specPracLab.mas_left);
        make.right.equalTo(specPracLab.mas_right);
        make.bottom.equalTo(specPracLab.mas_bottom);
        make.centerX.equalTo(specialPracticeBtn.mas_centerX);
        make.centerY.equalTo(specialPracticeBtn.mas_centerY);
    }];
   
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(beginLearnBtn.mas_top).offset(-KSIphonScreenH(31));
        make.bottom.equalTo(beginLearnBtn.mas_bottom).offset(KSIphonScreenH(31));
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(25));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(25));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    bgView.layer.cornerRadius = KSIphonScreenH(7);
    bgView.layer.masksToBounds = YES;
}
-(void)selectBigBgTag{
    [self removeFromSuperview];
}
// 顺序练习
-(void)selectBeginLearnBtn:(UIButton *) sender{
    self.selectSequenPrac();
}
// 专项练习
-(void)selectSpecPracBtn:(UIButton *) sender{
    self.selectSpecialPrac();
}




@end
