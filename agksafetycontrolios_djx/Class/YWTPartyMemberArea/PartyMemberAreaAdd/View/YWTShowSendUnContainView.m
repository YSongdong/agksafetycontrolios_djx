//
//  YWTShowSendUnContainView.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/10.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTShowSendUnContainView.h"

@implementation YWTShowSendUnContainView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createPromptView];
    }
    return self;
}
-(void) createPromptView{
    UIView *bigBgView = [[UIView alloc]initWithFrame:self.frame];
    [self addSubview:bigBgView];
    bigBgView.backgroundColor = [UIColor blackColor];
    bigBgView.alpha = 0.6;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectCancelTap)];
    [bigBgView addGestureRecognizer:tap];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    
    UIView *titleView =[[UIView alloc]init];
    [bgView addSubview:titleView];
    titleView.backgroundColor = [UIColor colorTextWhiteColor];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(bgView);
        make.height.equalTo(@43);
    }];
    
    UILabel *titleLab = [[UILabel alloc]init];
    [titleView addSubview:titleLab];
    titleLab.text = @"提示";
    titleLab.textColor = [UIColor colorCommonBlackColor];
    titleLab.font = BFont(17);
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(titleView.mas_centerX);
        make.centerY.equalTo(titleView.mas_centerY);
    }];
    
    UIView *contentView = [[UIView alloc]init];
    [bgView addSubview:contentView];
    contentView.backgroundColor = [UIColor colorTextWhiteColor];
    
    UIImageView *warningImageV = [[UIImageView alloc]init];
    [contentView addSubview:warningImageV];
    warningImageV.image = [UIImage imageNamed:@"Party_Add_warning"];
    [warningImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(10);
        make.centerX.equalTo(contentView.mas_centerX);
    }];
    
    UILabel *contentLab = [[UILabel alloc]init];
    [contentView addSubview:contentLab];
    contentLab.textColor = [UIColor colorCommonBlackColor];
    contentLab.font = Font(14);
    contentLab.numberOfLines = 0;
    [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(warningImageV.mas_bottom).offset(KSIphonScreenH(10));
        make.left.equalTo(contentView).offset(KSIphonScreenW(15));
        make.right.equalTo(contentView).offset(-KSIphonScreenW(15));
    }];
    NSString *str = @"发布内容不允许包含以下词汇:“反党、反社会”,请修改后再发布";
    contentLab.attributedText = [YWTTools getAttrbuteTextStr:str andAlterColorStr:@"“反党、反社会”" andColor:[UIColor colorLineCommonBlueColor] andFont:Font(14)];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView.mas_bottom).offset(1);
        make.left.right.equalTo(titleView);
        make.bottom.equalTo(contentLab.mas_bottom).offset(KSIphonScreenH(15));
    }];
    
    UIButton *tureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:tureBtn];
    [tureBtn setTitle:@"我知道了" forState:UIControlStateNormal];
    [tureBtn setTitleColor:[UIColor colorCommonBlackColor] forState:UIControlStateNormal];
    tureBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [tureBtn addTarget:self action:@selector(selectTureAction:) forControlEvents:UIControlEventTouchUpInside];
    [tureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_bottom).offset(1);
        make.left.right.bottom.equalTo(bgView);
        make.height.equalTo(@(KSIphonScreenH(45)));
    }];
    
    WS(weakSelf);
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView.mas_top);
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(65));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(65));
        make.bottom.equalTo(tureBtn.mas_bottom);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    bgView.layer.cornerRadius = KSIphonScreenH(14)/2;
    bgView.layer.masksToBounds = YES;
}
-(void)selectCancelTap{
    [self removeFromSuperview];
}
-(void) selectTureAction:(UIButton *)sender{
    [self selectCancelTap];
}

@end
