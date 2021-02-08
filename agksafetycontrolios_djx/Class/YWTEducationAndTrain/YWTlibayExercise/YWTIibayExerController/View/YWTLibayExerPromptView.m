//
//  LibayExerPromptView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/2/14.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTLibayExerPromptView.h"

@implementation YWTLibayExerPromptView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createHomePromptPhotoView];
    }
    return self;
}
-(void) createHomePromptPhotoView{
    __weak typeof(self) weakSelf = self;
    
    UIView *bigBgView = [[UIView alloc]init];
    [self addSubview:bigBgView];
    bigBgView.backgroundColor = [UIColor blackColor];
    bigBgView.alpha = 0.35;
    [bigBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeBigBgView)];
    [bigBgView addGestureRecognizer:tap];
    
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    
    
    UIView *titleView = [[UIView alloc]init];
    [bgView addSubview:titleView];
    titleView.backgroundColor = [UIColor colorTextWhiteColor];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(bgView);
        make.height.equalTo(@(KSIphonScreenH(43)));
    }];
    
    UILabel *showTitleLab = [[UILabel alloc]init];
    [titleView addSubview:showTitleLab];
    showTitleLab.text =@"提示弹窗";
    showTitleLab.font = BFont(19);
    showTitleLab.textColor = [UIColor colorCommonBlackColor];
    [showTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(titleView.mas_centerX);
        make.centerY.equalTo(titleView.mas_centerY);
    }];
    
    UIView *contentView = [[UIView alloc]init];
    [bgView addSubview:contentView];
    contentView.backgroundColor = [UIColor colorTextWhiteColor];
    
    self.showContentLab = [[UILabel alloc]init];
    [contentView addSubview:self.showContentLab];
    self.showContentLab.text = @"您已完整学习该题库，正确0题，错误0题，您是否需要清空做题再次练习?";
    self.showContentLab.textColor = [UIColor colorCommonBlackColor];
    self.showContentLab.font = Font(14);
    self.showContentLab.numberOfLines = 0;
    [self.showContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(KSIphonScreenH(10));
        make.left.equalTo(contentView).offset(KSIphonScreenW(15));
        make.right.equalTo(contentView).offset(-KSIphonScreenW(15));
    }];
    [UILabel changeLineSpaceForLabel:self.showContentLab WithSpace:3];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView.mas_bottom).offset(1);
        make.left.right.equalTo(titleView);
        make.bottom.equalTo(weakSelf.showContentLab.mas_bottom).offset(KSIphonScreenH(10));
    }];
    
    UIButton *ignoreBtn = [[UIButton alloc]init];
    [bgView addSubview:ignoreBtn];
    [ignoreBtn setTitle:@"清空重做" forState:UIControlStateNormal];
    [ignoreBtn setTitleColor:[UIColor colorCommonGreyBlackColor] forState:UIControlStateNormal];
    ignoreBtn.titleLabel.font = BFont(14);
    ignoreBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [ignoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_bottom).offset(1);
        make.left.equalTo(bgView);
        make.height.equalTo(@(KSIphonScreenH(45)));
    }];
    [ignoreBtn addTarget:self action:@selector(selectAgainBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *continueExamBtn = [[UIButton alloc]init];
    [bgView addSubview:continueExamBtn];
    [continueExamBtn setTitle:@"直接进入" forState:UIControlStateNormal];
    [continueExamBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    continueExamBtn.titleLabel.font = BFont(14);
    continueExamBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [continueExamBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ignoreBtn.mas_right).offset(1);
        make.right.equalTo(bgView);
        make.width.height.equalTo(ignoreBtn);
        make.centerY.equalTo(ignoreBtn.mas_centerY);
    }];
    [continueExamBtn addTarget:self action:@selector(selectContinueLibayExam:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView.mas_top);
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(65));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(65));
        make.bottom.equalTo(ignoreBtn.mas_bottom);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    bgView.layer.cornerRadius = KSIphonScreenH(14)/2;
    bgView.layer.masksToBounds = YES;
}
-(void)removeBigBgView{
    [self removeFromSuperview];
}

-(void) selectAgainBtn:(UIButton*) sender{
    self.againExer();
}
-(void) selectContinueLibayExam:(UIButton *) sender{
    self.enterExam();
}


@end
