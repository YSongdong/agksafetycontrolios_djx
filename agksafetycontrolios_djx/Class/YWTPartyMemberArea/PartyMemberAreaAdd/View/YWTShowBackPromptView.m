//
//  YWTShowBackPromptView.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/10.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTShowBackPromptView.h"

@implementation YWTShowBackPromptView

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
    
    UILabel *contentLab = [[UILabel alloc]init];
    [contentView addSubview:contentLab];
    contentLab.text = @"取消文章发布,已编辑内容将丢失,是否确认继续返回?";
    contentLab.textColor = [UIColor colorCommonBlackColor];
    contentLab.font = BFont(14);
    contentLab.numberOfLines = 0;
    [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(KSIphonScreenH(15));
        make.left.equalTo(contentView).offset(KSIphonScreenW(15));
        make.right.equalTo(contentView).offset(-KSIphonScreenW(15));
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView.mas_bottom).offset(1);
        make.left.right.equalTo(titleView);
        make.bottom.equalTo(contentLab.mas_bottom).offset(KSIphonScreenH(15));
    }];
    
    UIView *btnView = [[UIView alloc]init];
    [bgView addSubview:btnView];
    btnView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_bottom).offset(1);
        make.left.right.bottom.equalTo(bgView);
        make.height.equalTo(@(KSIphonScreenH(45)));
    }];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnView addSubview:cancelBtn];
    [cancelBtn setTitle:@"继续编辑" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorCommonGreyBlackColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = BFont(15);
    cancelBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [cancelBtn addTarget:self action:@selector(clickCancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(btnView);
    }];
    
    UIButton *tureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnView addSubview:tureBtn];
    [tureBtn setTitle:@"确认返回" forState:UIControlStateNormal];
    [tureBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    tureBtn.titleLabel.font = BFont(15);
    tureBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [tureBtn addTarget:self action:@selector(clickTrueAction:) forControlEvents:UIControlEventTouchUpInside];
    [tureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cancelBtn.mas_right).offset(1);
        make.right.equalTo(btnView);
        make.width.height.equalTo(cancelBtn);
        make.centerY.equalTo(cancelBtn.mas_centerY);
    }];
    
    WS(weakSelf);
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView.mas_top);
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(65));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(65));
        make.bottom.equalTo(btnView.mas_bottom);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    bgView.layer.cornerRadius = KSIphonScreenH(14)/2;
    bgView.layer.masksToBounds = YES;
}

-(void)selectCancelTap{
    [self removeFromSuperview];
}
-(void) clickCancelAction:(UIButton*)sender{
    [self selectCancelTap];
}
-(void) clickTrueAction:(UIButton*)sender{
    self.selectBackBtn();
}


@end
