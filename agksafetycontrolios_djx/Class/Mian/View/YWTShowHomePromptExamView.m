//
//  ShowHomePromptExamView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/30.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTShowHomePromptExamView.h"

@implementation YWTShowHomePromptExamView

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
    showTitleLab.font = Font(19);
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
    self.showContentLab.text = @"您的工程造价管理基础理论正式考试正在进行中，是否立即前往，继续考试。";
    self.showContentLab.textColor = [UIColor colorCommonBlackColor];
    self.showContentLab.font = Font(14);
    self.showContentLab.numberOfLines = 0;
    [self.showContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(KSIphonScreenH(15));
        make.left.equalTo(contentView).offset(KSIphonScreenW(15));
        make.right.equalTo(contentView).offset(-KSIphonScreenW(15));
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView.mas_bottom).offset(1);
        make.left.right.equalTo(titleView);
        make.bottom.equalTo(weakSelf.showContentLab.mas_bottom).offset(KSIphonScreenH(15));
    }];
    
    self.ignoreBtn = [[UIButton alloc]init];
    [bgView addSubview:self.ignoreBtn];
    [self.ignoreBtn setTitle:@"忽略" forState:UIControlStateNormal];
    [self.ignoreBtn setTitleColor:[UIColor colorCommonGreyBlackColor] forState:UIControlStateNormal];
    self.ignoreBtn.titleLabel.font = Font(14);
    self.ignoreBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [self.ignoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_bottom).offset(1);
        make.left.equalTo(bgView);
        make.height.equalTo(@(KSIphonScreenH(45)));
    }];
    [self.ignoreBtn addTarget:self action:@selector(selectIgnoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.continueExamBtn = [[UIButton alloc]init];
    [bgView addSubview:self.continueExamBtn];
    [self.continueExamBtn setTitle:@"继续考试" forState:UIControlStateNormal];
    [self.continueExamBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    self.continueExamBtn.titleLabel.font = Font(14);
    self.continueExamBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [self.continueExamBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.ignoreBtn.mas_right).offset(1);
        make.right.equalTo(bgView);
        make.width.height.equalTo(weakSelf.ignoreBtn);
        make.centerY.equalTo(weakSelf.ignoreBtn.mas_centerY);
    }];
    [self.continueExamBtn addTarget:self action:@selector(selectContinueExam:) forControlEvents:UIControlEventTouchUpInside];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView.mas_top);
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(65));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(65));
        make.bottom.equalTo(weakSelf.ignoreBtn.mas_bottom);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    bgView.layer.cornerRadius = KSIphonScreenH(14)/2;
    bgView.layer.masksToBounds = YES;
}
-(void)selectIgnoreBtn:(UIButton *) sender{
    self.cancelProptView();
}

-(void)selectContinueExam:(UIButton *) sender{
    self.continueExamBlock();
}



@end
