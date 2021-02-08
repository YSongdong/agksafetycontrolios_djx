//
//  AnnexTypeFooterView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/11.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTAnnexTypeFooterView.h"

@implementation YWTAnnexTypeFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createFooterView];
    }
    return self;
}
-(void) createFooterView{
    __weak typeof(self) weakSelf = self;
    
    UIButton *bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:bgBtn];
    bgBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [bgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    [bgBtn addTarget:self action:@selector(selectBgBtn:) forControlEvents:UIControlEventTouchUpInside];

    UIView *cententView = [[UIView alloc]init];
    [self addSubview:cententView];
    cententView.userInteractionEnabled = NO;
    
    UIView *view = [[UIView alloc]init];
    [self addSubview:view];
    view.userInteractionEnabled = NO;
    
    UIImageView *imageV = [[UIImageView alloc]init];
    [view addSubview:imageV];
    imageV.image = [UIImage imageNamed:@"base_Footer_add"];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(view);
    }];
    
    UILabel *showLab = [[UILabel alloc]init];
    [view addSubview:showLab];
    showLab.text =@"添加附件";
    showLab.textColor = [UIColor colorCommonBlackColor];
    showLab.font = BFont(15);
    [showLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageV.mas_right).offset(KSIphonScreenW(5));
        make.centerY.equalTo(imageV.mas_centerY);
    }];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(imageV);
        make.bottom.equalTo(showLab.mas_bottom);
        make.right.equalTo(showLab.mas_right);
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];

    
    UILabel *showTypeLab = [[UILabel alloc]init];
    [cententView addSubview:showTypeLab];
    showTypeLab.text = @"图片/文档/音频,支持多类型附件哦!";
    showTypeLab.textColor = [UIColor colorCommonGreyBlackColor];
    showTypeLab.font = Font(12);
    showTypeLab.textAlignment =  NSTextAlignmentCenter;
    [showTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom).offset(KSIphonScreenH(10));
        make.centerX.equalTo(view.mas_centerX);
    }];
    
    [cententView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(showLab.mas_top);
        make.left.right.equalTo(weakSelf);
        make.bottom.equalTo(showTypeLab.mas_bottom);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
}
// 添加附件
-(void)selectBgBtn:(UIButton *) sender{
    self.addAnnex();
}


@end
