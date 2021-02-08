//
//  DetaCancelPropmtVie.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/19.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTDetaCancelPropmtView.h"

@implementation YWTDetaCancelPropmtView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createPropmtView];
    }
    return self;
}
-(void)createPropmtView{
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
    showTitleLab.font = BFont(18);
    showTitleLab.textColor = [UIColor colorCommonBlackColor];
    [showTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(titleView.mas_centerX);
        make.centerY.equalTo(titleView.mas_centerY);
    }];
    
    UIView *contentView = [[UIView alloc]init];
    [bgView addSubview:contentView];
    contentView.backgroundColor = [UIColor colorTextWhiteColor];
    
    UILabel * showContentLab = [[UILabel alloc]init];
    [contentView addSubview:showContentLab];
    showContentLab.text = @"是否撤销该记录?";
    showContentLab.textColor = [UIColor colorCommon65GreyBlackColor];
    showContentLab.font = Font(15);
    showContentLab.numberOfLines = 0;
    showContentLab.textAlignment = NSTextAlignmentCenter;
    [showContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(KSIphonScreenH(25));
        make.left.equalTo(contentView).offset(KSIphonScreenW(15));
        make.right.equalTo(contentView).offset(-KSIphonScreenW(15));
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView.mas_bottom).offset(1);
        make.left.right.equalTo(titleView);
        make.bottom.equalTo(showContentLab.mas_bottom).offset(KSIphonScreenH(25));
    }];
    
    UIView *btnView = [[UIView alloc]init];
    [bgView addSubview:btnView];
    btnView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_bottom).offset(1);
        make.left.right.equalTo(bgView);
        make.height.equalTo(@(KSIphonScreenH(45)));
    }];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnView addSubview:cancelBtn];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorCommonGreyBlackColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = BFont(14);
    cancelBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(btnView);
    }];
    [cancelBtn addTarget:self action:@selector(selectCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.tureCancelBtn = [[UIButton alloc]init];
    [btnView addSubview:self.tureCancelBtn];
    [self.tureCancelBtn setTitle:@"撤销" forState:UIControlStateNormal];
    [self.tureCancelBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    self.tureCancelBtn.titleLabel.font = BFont(14);
    self.tureCancelBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [self.tureCancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cancelBtn.mas_right).offset(1);
        make.right.equalTo(btnView);
        make.width.height.equalTo(cancelBtn);
        make.centerY.equalTo(cancelBtn.mas_centerY);
    }];
    [self.tureCancelBtn addTarget:self action:@selector(selectTureBtn:) forControlEvents:UIControlEventTouchUpInside];
    
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
-(void)selectTureBtn:(UIButton *) sender{
    self.selectTureCancel();
}
-(void) selectCancelBtn:(UIButton *) sender{
    [self removeFromSuperview];
}








@end
