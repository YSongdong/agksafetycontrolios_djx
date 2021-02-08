//
//  ShowQuestTypeSwitchView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/4/1.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTShowQuestTypeSwitchView.h"

@implementation YWTShowQuestTypeSwitchView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}
-(void) createView{
    __weak typeof(self) weakSelf = self;
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#ff8309"];
    bgView.alpha = 0.95;
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    UIView *contentView = [[UIView alloc]init];
    [self addSubview:contentView];
    
    UIImageView *imageV = [[UIImageView alloc]init];
    [contentView addSubview:imageV];
    imageV.image = [UIImage imageNamed:@"ico_xx_tips"];
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView);
        make.centerY.equalTo(contentView.mas_centerY);
        make.height.width.equalTo(@15);
    }];
    
    self.showContentLab = [[UILabel alloc]init];
    [contentView addSubview:self.showContentLab];
    self.showContentLab.text = @"您已进入多选题!";
    self.showContentLab.textColor = [UIColor colorTextWhiteColor];
    self.showContentLab.font = Font(14);
    [self.showContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageV.mas_right).offset(KSIphonScreenW(6));
        make.centerY.equalTo(imageV.mas_centerY);
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.showContentLab.mas_top);
        make.left.equalTo(imageV.mas_left);
        make.right.equalTo(weakSelf.showContentLab.mas_right);
        make.bottom.equalTo(weakSelf.showContentLab.mas_bottom);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
}




@end
