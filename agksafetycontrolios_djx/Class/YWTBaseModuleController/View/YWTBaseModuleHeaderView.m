//
//  BaseModuleHeaderView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/5.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTBaseModuleHeaderView.h"

@implementation YWTBaseModuleHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createModuleView];
    }
    return self;
}
-(void) createModuleView{
    __weak typeof(self) weakSelf = self;
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    UIImageView *bgImageV = [[UIImageView alloc]init];
    [bgView addSubview:bgImageV];
    bgImageV.image = [UIImage imageChangeName:@"bg_navi_safe"];
    [bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(bgView);
    }];
    
    self.contentLab = [[UILabel alloc]init];
    [bgView addSubview:self.contentLab];
    self.contentLab.text = @"做好5件事";
    self.contentLab.textColor= [UIColor colorCommonGreyBlackColor];
    self.contentLab.font = Font(14);
    self.contentLab.textAlignment = NSTextAlignmentCenter;
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(KSIphonScreenH(62));
        make.centerX.equalTo(bgView.mas_centerX);
    }];
    
    UIImageView *imageV = [[UIImageView alloc]init];
    [bgView addSubview:imageV];
    imageV.image = [UIImage imageNamed:@"pic"];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentLab.mas_bottom).offset(KSIphonScreenH(10));
        make.centerX.equalTo(weakSelf.contentLab.mas_centerX);
    }];
}



@end
