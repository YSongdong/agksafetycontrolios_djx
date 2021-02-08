//
//  SettingModuleView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/9.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTSettingModuleView.h"

@interface YWTSettingModuleView ()

@property (nonatomic,strong) UILabel *titleLab;

@property (nonatomic,strong) UILabel *subTitleLab;

@end

@implementation YWTSettingModuleView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createSettingViw];
    }
    return self;
}
-(void) createSettingViw{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorTextWhiteColor];
    
    self.titleLab  = [[UILabel alloc]init];
    [self addSubview:self.titleLab];
    self.titleLab.text =@"";
    self.titleLab.font =  Font(16);
    self.titleLab.textColor = [UIColor colorCommonBlackColor];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
    self.subTitleLab = [[UILabel alloc]init];
    [self addSubview:self.subTitleLab];
    self.subTitleLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.subTitleLab.font = Font(13);
    self.subTitleLab.text = @"";
    [self.subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(35));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
    UIImageView *rightImageV = [[UIImageView alloc]init];
    [self addSubview:rightImageV];
    rightImageV.image = [UIImage imageNamed:@"cbl_ico_enter"];
    [rightImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectTap)];
    [self addGestureRecognizer:tap];
    
    UIView *lineView = [[UIView alloc]init];
    [self addSubview:lineView];
    lineView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf);
        make.height.equalTo(@1);
    }];
    
}
-(void)selectTap{
    self.selectViewBlock();
}

-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    self.titleLab.text = titleStr;
}
-(void)setSubTitleStr:(NSString *)subTitleStr{
    _subTitleStr = subTitleStr;
    self.subTitleLab.text = subTitleStr;
}



@end
