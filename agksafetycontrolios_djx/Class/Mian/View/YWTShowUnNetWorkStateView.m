//
//  ShowUnNetWorkStateView.m
//  AgkSafetyControl
//
//  Created by tiao on 2019/2/15.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTShowUnNetWorkStatuView.h"

@implementation YWTShowUnNetWorkStatuView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUnNetWorkStatuView];
    }
    return self;
}
-(void) createUnNetWorkStatuView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    self.bgImageV = [[UIImageView alloc]init];
    [self addSubview:self.bgImageV];
    self.bgImageV.image = [UIImage  imageNamed:@"pic_zwwl"];
    [self.bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(KSIphonScreenH(97));
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
    
    self.titleLab = [[UILabel alloc]init];
    [self addSubview:self.titleLab];
    self.titleLab.text = @"网络连接失败，请点击重试~";
    self.titleLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.titleLab.font = Font(14);
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bgImageV.mas_bottom).offset(KSIphonScreenH(20));
        make.centerX.equalTo(weakSelf.bgImageV.mas_centerX);
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
    }];
    
    self.retryBtn = [[UIButton alloc]init];
    [self addSubview:self.retryBtn];
    [self.retryBtn setTitle:@"点击重试" forState:UIControlStateNormal];
    [self.retryBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.retryBtn.backgroundColor  = [UIColor colorLineCommonBlueColor];
    self.retryBtn.titleLabel.font = Font(14);
    [self.retryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLab.mas_bottom).offset(KSIphonScreenH(30));
        make.centerX.equalTo(weakSelf.titleLab.mas_centerX);
        make.height.equalTo(@(KSIphonScreenH(32)));
        make.width.equalTo(@(KSIphonScreenW(140)));
    }];
    self.retryBtn.layer.cornerRadius = KSIphonScreenH(32)/2;
    self.retryBtn.layer.masksToBounds = YES;
    [self.retryBtn addTarget:self action:@selector(selectRetryBtn:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)selectRetryBtn:(UIButton *) sender{
    self.selectRetryBlock();
}

@end
