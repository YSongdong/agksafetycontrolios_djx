//
//  MyCreditsScoreView.m
//  PartyBuildingStar
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import "MyCreditsScoreView.h"

@interface MyCreditsScoreView ()

// 显示副标题
@property (nonatomic,strong) UILabel *showSubmitTitleLab;

@end

@implementation MyCreditsScoreView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
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
        make.top.equalTo(weakSelf).offset(KSIphonScreenH(12));
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
        make.bottom.equalTo(weakSelf).offset(-KSIphonScreenH(6));
    }];
    bgView.layer.cornerRadius = 8;
    bgView.layer.masksToBounds = YES;
    
    
    UIImageView *imageV = [[UIImageView alloc]init];
    [bgView addSubview:imageV];
    imageV.image  = [UIImage imageNamed:@"myCredit_score_nomal"];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(KSIphonScreenW(12));
        make.centerY.equalTo(bgView.mas_centerY);
        make.width.height.equalTo(@(KSIphonScreenH(55)));
    }];
    
    UIView *contentView = [[UIView alloc]init];
    [bgView addSubview:contentView];

    // 显示得分lab
    self.showScoreLab = [[UILabel alloc]init];
    [contentView addSubview:self.showScoreLab];
    self.showScoreLab.text  = @"0";
    self.showScoreLab.textColor  = [UIColor colorCommonBlackColor];
    self.showScoreLab.font = BFont(28);
    [self.showScoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(contentView);
    }];

    // 显示副标题
    self.showSubmitTitleLab = [[UILabel alloc]init];
    [contentView addSubview:self.showSubmitTitleLab];
    self.showSubmitTitleLab.text  =@"非常棒！来吧，直接奖励我吧";
    self.showSubmitTitleLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.showSubmitTitleLab.font = Font(12);
    self.showSubmitTitleLab.numberOfLines = 0;
    [self.showSubmitTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.showScoreLab.mas_bottom).offset(KSIphonScreenH(8));
        make.left.equalTo(weakSelf.showScoreLab.mas_left);
    }];

    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.showScoreLab.mas_top);
        make.left.equalTo(imageV.mas_right).offset(KSIphonScreenW(12));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(24));
        make.bottom.equalTo(weakSelf.showSubmitTitleLab.mas_bottom);
        make.centerY.equalTo(bgView.mas_centerY);
    }];
    
}



@end
