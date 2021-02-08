//
//  ShowVerifyIdentidyErrorView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/23.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTShowVerifyIdentidyErrorView.h"

@implementation YWTShowVerifyIdentidyErrorView

-(instancetype)initWithFrame:(CGRect)frame andType:(NSString *)typeStr{
    if (self = [super initWithFrame:frame]) {
        [self createVerifyIdentidyViewAndType:typeStr];
    }
    return self;
}
-(void) createVerifyIdentidyViewAndType:(NSString *)typeStr{
    __weak typeof(self) weakSelf = self;
    
    UIView *bigBgView = [[UIView alloc]init];
    [self addSubview:bigBgView];
    bigBgView.backgroundColor = [UIColor blackColor];
    bigBgView.alpha = 0.5;
    [bigBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    UITapGestureRecognizer *bigTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectBigTap)];
    [bigBgView addGestureRecognizer:bigTap];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    
    UILabel *titleLab = [[UILabel alloc]init];
    [bgView addSubview:titleLab];
    titleLab.text = @"身份验证";
    titleLab.textColor = [UIColor colorCommonBlackColor];
    titleLab.font = BFont(18);
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(KSIphonScreenH(20));
        make.centerX.equalTo(bgView.mas_centerX);
    }];
    
    UIImageView *errorImagV = [[UIImageView alloc]init];
    [bgView addSubview:errorImagV];
    errorImagV.image = [UIImage imageNamed:@"pic_sfyz"];
    [errorImagV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLab.mas_bottom).offset(KSIphonScreenH(25));
        make.centerX.equalTo(bgView.mas_centerX);
    }];
    
    UILabel *showPromptMsgLab = [[UILabel alloc]init];
    [bgView addSubview:showPromptMsgLab];
    showPromptMsgLab.text = @"身份验证失败，请重新验证";
    showPromptMsgLab.textColor = [UIColor colorCommonRedColor];
    showPromptMsgLab.font = Font(17);
    showPromptMsgLab.textAlignment =  NSTextAlignmentCenter;
    [showPromptMsgLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(errorImagV.mas_bottom).offset(KSIphonScreenH(27));
        make.centerX.equalTo(bgView.mas_centerX);
    }];
    
    UILabel *showPlaceLab = [[UILabel alloc]init];
    [bgView addSubview:showPlaceLab];
    showPlaceLab.text = @"请保持室内光线充足，检测动作不宜过大";
    showPlaceLab.textColor = [UIColor colorCommonAAAAGreyBlackColor];
    showPlaceLab.font = Font(13);
    [showPlaceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(showPromptMsgLab.mas_bottom).offset(KSIphonScreenH(4));
        make.centerX.equalTo(showPromptMsgLab.mas_centerX);
    }];
    
    self.againVerifyBtn = [[UIButton alloc]init];
    [bgView addSubview:self.againVerifyBtn];
    [self.againVerifyBtn setTitle:@"再次验证" forState:UIControlStateNormal];
    [self.againVerifyBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.againVerifyBtn.titleLabel.font = Font(14);
    [self.againVerifyBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorLineCommonBlueColor]] forState:UIControlStateNormal];
    [self.againVerifyBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorClickCommonBlueColor]] forState:UIControlStateHighlighted];
    [self.againVerifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(showPlaceLab.mas_bottom).offset(KSIphonScreenH(22));
        make.left.equalTo(bgView).offset(KSIphonScreenW(30));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(30));
        make.height.equalTo(@(KSIphonScreenH(33)));
    }];
    self.againVerifyBtn.layer.cornerRadius = KSIphonScreenH(5);
    self.againVerifyBtn.layer.masksToBounds = YES;
    [self.againVerifyBtn addTarget:self action:@selector(selectAgainBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.enterDirectlyBtn = [[UIButton alloc]init];
    [bgView addSubview:self.enterDirectlyBtn];
    [self.enterDirectlyBtn setTitle:@"直接进入" forState:UIControlStateNormal];
    [self.enterDirectlyBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    self.enterDirectlyBtn.titleLabel.font = Font(14);
    self.enterDirectlyBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [self.enterDirectlyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.againVerifyBtn.mas_bottom).offset(KSIphonScreenH(9));
        make.left.width.height.equalTo(weakSelf.againVerifyBtn);
        make.centerX.equalTo(weakSelf.againVerifyBtn.mas_centerX);
    }];
    self.enterDirectlyBtn.layer.cornerRadius = KSIphonScreenH(5);
    self.enterDirectlyBtn.layer.masksToBounds = YES;
    self.enterDirectlyBtn.layer.borderWidth = 1;
    self.enterDirectlyBtn.layer.borderColor = [UIColor colorLineCommonBlueColor].CGColor;
    [self.enterDirectlyBtn addTarget:self action:@selector(selectEnterBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.enterDirectlyBtn.hidden = YES;
    
    // 强制
    if ([typeStr isEqualToString:@"1"]) {
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLab.mas_top).offset(-KSIphonScreenH(20));
            make.left.equalTo(weakSelf).offset(KSIphonScreenW(43));
            make.right.equalTo(weakSelf).offset(-KSIphonScreenW(43));
            make.bottom.equalTo(weakSelf.againVerifyBtn.mas_bottom).offset(KSIphonScreenH(20));
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.centerY.equalTo(weakSelf.mas_centerY);
        }];
        bgView.layer.cornerRadius = KSIphonScreenH(7);
        bgView.layer.masksToBounds = YES;
    }else{
        self.enterDirectlyBtn.hidden = NO;
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLab.mas_top).offset(-KSIphonScreenH(20));
            make.left.equalTo(weakSelf).offset(KSIphonScreenW(43));
            make.right.equalTo(weakSelf).offset(-KSIphonScreenW(43));
            make.bottom.equalTo(weakSelf.againVerifyBtn.mas_bottom).offset(KSIphonScreenH(62));
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.centerY.equalTo(weakSelf.mas_centerY);
        }];
        bgView.layer.cornerRadius = KSIphonScreenH(7);
        bgView.layer.masksToBounds = YES;
    }
}

-(void)selectBigTap{
    if (!self.isColseBigBgView) {
        [self removeFromSuperview];
    }
}

-(void) selectAgainBtn:(UIButton *) sender{
    self.againBtnBlock();
}
-(void) selectEnterBtn:(UIButton *) sender{
    self.enterBtnBlcok();
}
-(void)setIsColseBigBgView:(BOOL)isColseBigBgView{
    _isColseBigBgView = isColseBigBgView;
}

@end
