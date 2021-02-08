//
//  BaseBottomToolView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/19.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTBaseBottomToolView.h"

#import "UIButton+Gradient.h"

@interface YWTBaseBottomToolView ()

@property (nonatomic,strong) UIView *saveDrafBgView;

@end


@implementation YWTBaseBottomToolView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createToolView];
    }
    return self;
}
-(void) createToolView{
    __weak typeof(self) weakSelf = self;
    weakSelf.backgroundColor = [UIColor colorTextWhiteColor];
    
    self.bgView = [[UIView alloc]init];
    [self addSubview:self.bgView];
    [weakSelf.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    [self.bgView addSubview:lineView];
    lineView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf.bgView);
        make.height.equalTo(@0.5);
    }];
  
    // 存入草稿
    self.saveDraftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.saveDraftBtn];
    self.saveDraftBtn.backgroundColor = [UIColor colorWithHexString:@"#f3f3f3"];
    self.saveDraftBtn.titleLabel.font = Font(14);
    [self.saveDraftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bgView).offset(KSIphonScreenH(13));
        make.bottom.equalTo(weakSelf.bgView).offset(-KSIphonScreenH(13));
        make.left.equalTo(weakSelf.bgView).offset(KSIphonScreenW(12));
    }];
    self.saveDraftBtn.layer.cornerRadius = 4;
    self.saveDraftBtn.layer.masksToBounds = YES;
    self.saveDraftBtn.layer.borderWidth = 0.2;
    self.saveDraftBtn.layer.borderColor = [UIColor colorLineCommonGreyBlackColor].CGColor;
    [self.saveDraftBtn addTarget:self action:@selector(selectSaveDraftBtn:) forControlEvents:UIControlEventTouchUpInside];
   
    
    // view
    self.saveDrafBgView = [[UIView alloc]init];
    [self.bgView addSubview:self.saveDrafBgView];
    self.saveDrafBgView.userInteractionEnabled = NO;
    
    UIImageView *saveImageV = [[UIImageView alloc]init];
    [self.saveDrafBgView addSubview:saveImageV];
    saveImageV.image = [UIImage imageNamed:@"base_saveDraf"];
    saveImageV.contentMode = UIViewContentModeScaleAspectFit ;
    [saveImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.saveDrafBgView);
        make.centerY.equalTo(weakSelf.saveDrafBgView);
    }];
    
    UILabel *saveLab = [[UILabel alloc]init];
    [self.saveDrafBgView addSubview:saveLab];
    saveLab.text = @"存入草稿";
    saveLab.textColor = [UIColor colorWithHexString:@"#999999"];
    saveLab.font = Font(13);
    [saveLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(saveImageV.mas_right).offset(KSIphonScreenW(8));
        make.centerY.equalTo(saveImageV.mas_centerY);
    }];
    
    [self.saveDrafBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(saveLab.mas_top);
        make.bottom.equalTo(saveLab.mas_bottom);
        make.right.equalTo(saveLab.mas_right);
        make.left.equalTo(saveImageV.mas_left);
        make.centerX.equalTo(weakSelf.saveDraftBtn.mas_centerX);
        make.centerY.equalTo(weakSelf.saveDraftBtn.mas_centerY);
    }];
    
    self.submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.submitBtn];
    [self.submitBtn setBackgroundImage:[UIImage imageChangeName:@"base_btnBgNormal"] forState:UIControlStateNormal];
    [self.submitBtn setBackgroundImage:[UIImage imageChangeName:@"base_btnBgSelect"] forState:UIControlStateHighlighted];
    self.submitBtn.titleLabel.font = Font(14);
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.saveDraftBtn.mas_right).offset(KSIphonScreenW(7));
        make.width.height.equalTo(weakSelf.saveDraftBtn);
        make.right.equalTo(weakSelf.bgView).offset(-KSIphonScreenW(12));
        make.centerY.equalTo(weakSelf.saveDraftBtn.mas_centerY);
    }];
    self.submitBtn.layer.cornerRadius = 4;
    self.submitBtn.layer.masksToBounds = YES;
    [self.submitBtn addTarget:self action:@selector(selectSubmitBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *submitBgView = [[UIView alloc]init];
    [self.bgView addSubview:submitBgView];
    submitBgView.userInteractionEnabled = NO;

    UIImageView *submitImageV = [[UIImageView alloc]init];
    [submitBgView addSubview:submitImageV];
    submitImageV.image = [UIImage imageNamed:@"base_submit"];
    submitImageV.contentMode = UIViewContentModeScaleAspectFit ;
    [submitImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(submitBgView);
        make.centerY.equalTo(submitBgView);
    }];

    UILabel *submitLab = [[UILabel alloc]init];
    [submitBgView addSubview:submitLab];
    submitLab.text = @"提交";
    submitLab.textColor = [UIColor colorTextWhiteColor];
    submitLab.font = Font(13);
    [submitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(submitImageV.mas_right).offset(KSIphonScreenW(8));
        make.centerY.equalTo(submitImageV.mas_centerY);
    }];

    [submitBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(submitLab.mas_top);
        make.bottom.equalTo(submitLab.mas_bottom);
        make.right.equalTo(submitLab.mas_right);
        make.left.equalTo(submitImageV.mas_left);
        make.centerX.equalTo(weakSelf.submitBtn.mas_centerX);
        make.centerY.equalTo(weakSelf.submitBtn.mas_centerY);
    }];

}
// 提交
-(void) selectSubmitBtn:(UIButton *) sender{
    self.selectSubmitBtn();
}
// 存入草稿
-(void) selectSaveDraftBtn:(UIButton *) sender{
    sender.backgroundColor =[UIColor colorLineCommonGreyBlackColor];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        sender.backgroundColor = [UIColor colorWithHexString:@"#f3f3f3"];
    });
    self.selectSaveDraftBtn();
}

// 更新提交按钮
-(void) updateSubmitBtnUI{
     __weak typeof(self) weakSelf = self;
    
    self.saveDraftBtn.hidden = YES;
    self.saveDrafBgView.hidden = YES;
    
    [weakSelf.submitBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bgView).offset(KSIphonScreenH(14));
        make.bottom.equalTo(weakSelf.bgView).offset(-KSIphonScreenH(14));
        make.left.equalTo(weakSelf.bgView).offset(KSIphonScreenW(12));
        make.right.equalTo(weakSelf.bgView).offset(-KSIphonScreenW(12));
    }];
}


@end
