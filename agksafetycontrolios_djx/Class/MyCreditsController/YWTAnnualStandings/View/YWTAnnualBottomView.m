//
//  YWTAnnualBottomView.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/20.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTAnnualBottomView.h"

@implementation YWTAnnualBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createBottomView];
    }
    return self;
}
-(void) createBottomView{
    WS(weakSelf);
    self.backgroundColor = [UIColor clearColor];
    
    self.bgView = [[UIView alloc]init];
    [self addSubview:self.bgView];
    self.bgView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakSelf);
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenH(12));
    }];
    
    // 头像
    self.headerImageV = [[UIImageView alloc]init];
    [self.bgView addSubview:self.headerImageV];
    self.headerImageV.image = [UIImage imageNamed:@"suggetion_select_normal"];
    [self.headerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView).offset(KSIphonScreenW(53));
        make.centerY.equalTo(weakSelf.bgView.mas_centerY);
        make.width.height.equalTo(@32);
    }];
    self.headerImageV.layer.cornerRadius = 32/2;
    self.headerImageV.layer.masksToBounds = YES;
    
    // 名称
    self.nameLab = [[UILabel alloc]init];
    [self.bgView addSubview:self.nameLab];
    self.nameLab.text = @"";
    self.nameLab.textColor = [UIColor colorCommonBlackColor];
    self.nameLab.font = BFont(14);
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headerImageV.mas_right).offset(KSIphonScreenW(17));
        make.centerY.equalTo(weakSelf.headerImageV.mas_centerY);
        make.width.lessThanOrEqualTo(@120);
    }];
    
    UILabel *lab = [[UILabel alloc]init];
    [self.bgView addSubview:lab];
    lab.text  =@"分";
    lab.textColor = [UIColor colorCommon65GreyBlackColor];
    lab.font = Font(12);
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView).offset(-KSIphonScreenW(38));
        make.centerY.equalTo(weakSelf.nameLab.mas_centerY);
    }];
    
    self.scoreLab = [[UILabel alloc]init];
    [self.bgView addSubview:self.scoreLab];
    self.scoreLab.text = @"";
    self.scoreLab.textColor = [UIColor colorWithHexString:@"#0088ff"];
    self.scoreLab.font = BFont(18);
    self.scoreLab.textAlignment = NSTextAlignmentRight;
    [self.scoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lab.mas_left).offset(-KSIphonScreenW(12));
        make.centerY.equalTo(lab.mas_centerY);
        make.width.lessThanOrEqualTo(@100);
    }];
    
    self.serialNumberLab = [[UILabel alloc]init];
    [self.bgView addSubview:self.serialNumberLab];
    self.serialNumberLab.text = @"0";
    self.serialNumberLab.textColor =  [UIColor colorWithHexString:@"#0088ff"];
    self.serialNumberLab.font = Font(15);
    [self.serialNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView).offset(KSIphonScreenW(25));
        make.centerY.equalTo(weakSelf.bgView.mas_centerY);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    [self.bgView addSubview:lineView];
    lineView.backgroundColor = [UIColor colorLineE3E3CommonGreyBlackColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView).offset(KSIphonScreenW(25));
        make.right.equalTo(weakSelf.bgView).offset(-KSIphonScreenW(25));
        make.height.equalTo(@0.5);
        make.bottom.equalTo(weakSelf.bgView.mas_bottom);
    }];
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    // 头像
    NSString *photoStr = [NSString stringWithFormat:@"%@",dict[@"photo"]];
    [YWTTools sd_setImageView:self.headerImageV WithURL:photoStr andPlaceholder:@"suggetion_select_normal"];
    
    // 名次
    self.serialNumberLab.text = [NSString stringWithFormat:@"%@",dict[@"ranKing"]];
    
    // 名称
    self.nameLab.text = [NSString stringWithFormat:@"%@",dict[@"realName"]];
    
    //得分
    self.scoreLab.text =[NSString stringWithFormat:@"%@",dict[@"credit"]];
}



@end
