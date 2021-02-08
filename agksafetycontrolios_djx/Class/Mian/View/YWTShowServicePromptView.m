//
//  ShowServicePromptView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/16.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTShowServicePromptView.h"

@implementation YWTShowServicePromptView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createSeviceView];
    }
    return self;
}
-(void) createSeviceView{
    __weak typeof(self) weakSelf = self;
    
    UIView *bigBgView =[[UIView alloc]init];
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
    self.showContentLab.text = @"登录信息过期，请重新登录";
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
    
    self.tureBtn = [[UIButton alloc]init];
    [bgView addSubview:self.tureBtn];
    [self.tureBtn setTitle:@"知道了" forState:UIControlStateNormal];
    [self.tureBtn setTitleColor:[UIColor colorCommonGreyBlackColor] forState:UIControlStateNormal];
    self.tureBtn.titleLabel.font = Font(15);
    self.tureBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [self.tureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_bottom).offset(1);
        make.left.right.bottom.equalTo(bgView);
        make.height.equalTo(@(KSIphonScreenH(45)));
    }];
    [self.tureBtn addTarget:self action:@selector(selectTureBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView.mas_top);
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(65));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(65));
        make.bottom.equalTo(weakSelf.tureBtn.mas_bottom);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    bgView.layer.cornerRadius = KSIphonScreenH(14)/2;
    bgView.layer.masksToBounds = YES;
}
// 点击确定
-(void )selectTureBtn:(UIButton *)sender{
    self.selectTureBtn();
}


@end
