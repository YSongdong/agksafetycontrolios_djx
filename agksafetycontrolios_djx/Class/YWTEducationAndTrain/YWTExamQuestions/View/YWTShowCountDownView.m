//
//  ShowCountDownView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/21.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTShowCountDownView.h"

@implementation YWTShowCountDownView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createCountDownView];
       
    }
    return self;
}

-(void) createCountDownView{
    __weak typeof(self) weakSelf = self;
    
    UIView *backGrounpView = [[UIView alloc]init];
    [self addSubview:backGrounpView];
    backGrounpView.backgroundColor = [UIColor blackColor];
    backGrounpView.alpha = 0.35;
    [backGrounpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeView)];
    [backGrounpView addGestureRecognizer:tap];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorCommonGreyColor];
    
    UIView *titleView = [[UIView alloc]init];
    [bgView addSubview:titleView];
    titleView.backgroundColor = [UIColor colorTextWhiteColor];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(bgView);
        make.height.equalTo(@(KSIphonScreenH(45)));
    }];
    
    UILabel *titleLab = [[UILabel alloc]init];
    [titleView addSubview:titleLab];
    titleLab.text = @"提示";
    titleLab.textColor = [UIColor colorCommonBlackColor];
    titleLab.font = BFont(17);
    titleLab.textAlignment = NSTextAlignmentCenter;
    [titleLab  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(titleView.mas_centerX);
        make.centerY.equalTo(titleView.mas_centerY);
    }];
    
    UIView *contentView = [[UIView alloc]init];
    [bgView addSubview:contentView];
    contentView.backgroundColor = [UIColor colorTextWhiteColor];
    
    UIImageView *imageV = [[UIImageView alloc]init];
    [contentView addSubview:imageV];
    imageV.image = [UIImage imageNamed:@"ico_tips"];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(KSIphonScreenH(19));
        make.centerX.equalTo(contentView.mas_centerX);
    }];
    
    self.contentLab = [[UILabel alloc]init];
    [contentView addSubview:self.contentLab];
    self.contentLab.font = Font(15);
    self.contentLab.textColor = [UIColor colorCommonBlackColor];
    self.contentLab.numberOfLines = 0;
    self.contentLab.text = @"练习时间只剩3分钟了";
    self.contentLab.textAlignment = NSTextAlignmentCenter;
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageV.mas_bottom).offset(KSIphonScreenH(14));
        make.left.equalTo(contentView).offset(KSIphonScreenW(30));
        make.right.equalTo(contentView).offset(-KSIphonScreenW(15));
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView.mas_bottom).offset(1);
        make.left.right.equalTo(titleView);
        make.bottom.equalTo(weakSelf.contentLab.mas_bottom).offset(KSIphonScreenH(10));
    }];
    
    UIView *bottomBtnView = [[UIView alloc]init];
    [bgView addSubview:bottomBtnView];
    bottomBtnView.backgroundColor = [UIColor colorTextWhiteColor];
    
    self.countDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomBtnView addSubview:self.countDownBtn];
    [self.countDownBtn setTitle:@"我知道了" forState:UIControlStateNormal];
    [self.countDownBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    self.countDownBtn.titleLabel.font = BFont(16);
    self.countDownBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [self.countDownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(bottomBtnView);
    }];
    [self.countDownBtn addTarget:self action:@selector(selectRemoveBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [bottomBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_bottom).offset(1);
        make.left.right.equalTo(contentView);
        make.height.equalTo(@(KSIphonScreenH(45)));
    }];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(45));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(45));
        make.bottom.equalTo(bottomBtnView.mas_bottom);
    }];
    bgView.layer.cornerRadius = 8;
    bgView.layer.masksToBounds = YES;

    // 延时3秒结束弹框
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!self.isOffTime) {
          [self removeView];
        }
    });
}
// 取消
-(void)selectRemoveBtn:(UIButton *) sender{
    [self removeFromSuperview];
}
-(void)removeView{
    [self selectRemoveBtn:nil];
}
-(void)setIsOffTime:(BOOL)isOffTime{
    _isOffTime = isOffTime;
}

@end
