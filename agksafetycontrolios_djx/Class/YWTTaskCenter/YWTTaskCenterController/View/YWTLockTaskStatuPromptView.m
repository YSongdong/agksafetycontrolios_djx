//
//  LockTaskStatuPromptView.m
//  PartyBuildingStar
//
//  Created by mac on 2019/4/19.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import "YWTLockTaskStatuPromptView.h"

@implementation YWTLockTaskStatuPromptView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createPromptView];
    }
    return self;
}
-(void) createPromptView{
    __weak typeof(self) weakSelf = self;
    
    UIView *bigBgView = [[UIView alloc]init];
    [self addSubview:bigBgView];
    bigBgView.backgroundColor = [UIColor blackColor];
    bigBgView.alpha = 0.35;
    [bigBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    UITapGestureRecognizer *bigBgTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectBigBgTap)];
    [bigBgView addGestureRecognizer:bigBgTap];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor  = [UIColor colorTextWhiteColor];
    
    UIImageView *imageV = [[UIImageView alloc]init];
    [bgView addSubview:imageV];
    imageV.image = [UIImage imageNamed:@"taskCenter_task_locking"];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(KSIphonScreenH(30));
        make.centerX.equalTo(bgView.mas_centerX);
    }];
    
    // 任务名称
    self.taskNameLab = [[UILabel alloc]init];
    [bgView addSubview:self.taskNameLab];
    self.taskNameLab.text = @"";
    self.taskNameLab.textColor = [UIColor colorCommonBlackColor];
    self.taskNameLab.font = BFont(15);
    self.taskNameLab.numberOfLines = 2;
    self.taskNameLab.textAlignment = NSTextAlignmentCenter;
    [self.taskNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageV.mas_bottom).offset(KSIphonScreenH(16));
        make.left.equalTo(bgView).offset(KSIphonScreenW(10));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(10));
        make.centerX.equalTo(bgView.mas_centerX);
    }];
    
    // 任务要求
    self.taskRequirLab = [[UILabel alloc]init];
    [bgView addSubview:self.taskRequirLab];
    self.taskRequirLab.text = @"";
    self.taskRequirLab.textColor = [UIColor colorCommonBlackColor];
    self.taskRequirLab.font = Font(12);
    self.taskRequirLab.numberOfLines = 2;
    [self.taskRequirLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.taskNameLab.mas_bottom).offset(KSIphonScreenH(20));
        make.left.equalTo(bgView).offset(KSIphonScreenW(10));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(10));
        make.centerX.equalTo(bgView.mas_centerX);
    }];
    self.taskRequirLab.userInteractionEnabled = YES;
    UITapGestureRecognizer *taskRequTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectTaskRequirLab)];
    [self.taskRequirLab addGestureRecognizer:taskRequTap];
    

    UIButton *detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:detailBtn];
    [detailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
    [detailBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    detailBtn.titleLabel.font = Font(14);
    [detailBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorLineCommonBlueColor]] forState:UIControlStateNormal];
    [detailBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorWithHexString:@"#4285f5" alpha:0.8]] forState:UIControlStateHighlighted];
    [detailBtn addTarget:self action:@selector(selectLookDetail:) forControlEvents:UIControlEventTouchUpInside];
    [detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.taskRequirLab.mas_bottom).offset(KSIphonScreenH(25));
        make.left.equalTo(bgView).offset(KSIphonScreenW(38));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(38));
        make.height.equalTo(@(KSIphonScreenH(33)));
        make.centerX.equalTo(bgView.mas_centerX);
    }];
    detailBtn.layer.cornerRadius = KSIphonScreenH(33)/2;
    detailBtn.layer.masksToBounds = YES;

    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(65));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(65));
        make.top.equalTo(imageV.mas_top).offset(-KSIphonScreenH(30));
        make.bottom.equalTo(detailBtn.mas_bottom).offset(KSIphonScreenH(25));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    bgView.layer.cornerRadius = 8;
    bgView.layer.masksToBounds = YES;
    
    // 取消按钮
    UIButton  * showCancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:showCancelBtn];
    [showCancelBtn setImage:[UIImage imageNamed:@"taskCenter_propmt_close"] forState:UIControlStateNormal];
    [showCancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_bottom).offset(KSIphonScreenH(25));
        make.centerX.equalTo(bgView.mas_centerX);
    }];
    [showCancelBtn addTarget:self action:@selector(selectCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)selectBigBgTap{
    [self removeFromSuperview];
}

-(void) selectCancelBtn:(UIButton*)sender{
    [self selectBigBgTap];
}
// 前置任务详情
-(void) selectTaskRequirLab{
    self.selectTaskRequir();
}
-(void) selectLookDetail:(UIButton *) sender{
    self.selectLookDetail();
}



@end
