//
//  YWTAnnualStandingHeaderView.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/20.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTAnnualStandingHeaderView.h"

@interface YWTAnnualStandingHeaderView ()
// 第一名 头像
@property (nonatomic,strong)UIImageView *firstHeaderImageV;
// 第一名 名称
@property (nonatomic,strong)UILabel *firstNameLab;
// 第一名 得分
@property (nonatomic,strong)UILabel *firstScoreLab;

// 第二名 头像
@property (nonatomic,strong)UIImageView *secondHeaderImageV;
// 第二名 名称
@property (nonatomic,strong)UILabel *secondNameLab;
// 第二名 得分
@property (nonatomic,strong)UILabel *secondScoreLab;

// 第三名 头像
@property (nonatomic,strong)UIImageView *thirdHeaderImageV;
// 第三名 名称
@property (nonatomic,strong)UILabel *thirdNameLab;
// 第三名 得分
@property (nonatomic,strong)UILabel *thirdScoreLab;

@end

@implementation YWTAnnualStandingHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createHeaderView];
    }
    return self;
}
-(void) createHeaderView{
    WS(weakSelf);
    // 背景view
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(KSIphonScreenW(12), KSIphonScreenH(40), KScreenW-KSIphonScreenW(24), self.height-KSIphonScreenH(40))];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [self addSubview:bgView];
    
    // 切角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = bgView.bounds;
    maskLayer.path = maskPath.CGPath;
    bgView.layer.mask = maskLayer;
    
    // 中间背景image
    UIImageView *centerBgImageV = [[UIImageView alloc]init];
    [self addSubview:centerBgImageV];
    centerBgImageV.image =  [UIImage imageNamed:@"annualStanding_bg_Image"];
    [centerBgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(KSIphonScreenH(18));
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
    
    // 第一名 头像
    self.firstHeaderImageV = [[UIImageView alloc]init];
    [self addSubview:self.firstHeaderImageV];
    self.firstHeaderImageV.image = [UIImage imageNamed:@"suggetion_select_normal"];
    [self.firstHeaderImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerBgImageV.mas_top).offset(KSIphonScreenH(20));
        make.centerX.equalTo(centerBgImageV.mas_centerX);
        make.width.height.equalTo(@72);
    }];
    self.firstHeaderImageV.layer.cornerRadius = 72/2;
    self.firstHeaderImageV.layer.masksToBounds = YES;
    self.firstHeaderImageV.layer.borderWidth = 3;
    self.firstHeaderImageV.layer.borderColor = [UIColor colorWithHexString:@"#ffd43a"].CGColor;
    
    UIImageView *firstImageV = [[UIImageView alloc]init];
    [self addSubview:firstImageV];
    firstImageV.image = [UIImage imageNamed:@"annualStanding_image_first"];
    [firstImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.firstHeaderImageV.mas_top).offset(KSIphonScreenH(5));
        make.centerX.equalTo(centerBgImageV.mas_centerX);
    }];
    
    // 第一名 名称
    self.firstNameLab = [[UILabel alloc]init];
    [self addSubview:self.firstNameLab];
    self.firstNameLab.text  =@"";
    self.firstNameLab.textColor = [UIColor colorCommonBlackColor];
    self.firstNameLab.font = BFont(14);
    self.firstNameLab.textAlignment = NSTextAlignmentCenter;
    [self.firstNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.firstHeaderImageV.mas_bottom).offset(KSIphonScreenH(5));
        make.centerX.equalTo(weakSelf.firstHeaderImageV.mas_centerX);
        make.width.lessThanOrEqualTo(@120);
    }];
    
    UILabel *firstLab = [[UILabel alloc]init];
    [self addSubview:firstLab];
    firstLab.text = @"累计得分";
    firstLab.textColor = [UIColor colorCommonAAAAGreyBlackColor];
    firstLab.font = Font(10);
    firstLab.textAlignment = NSTextAlignmentCenter;
    [firstLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.firstNameLab.mas_bottom).offset(KSIphonScreenH(5));
        make.centerX.equalTo(weakSelf.firstNameLab.mas_centerX);
    }];
    
    // 得分
    self.firstScoreLab = [[UILabel alloc]init];
    [self addSubview:self.firstScoreLab];
    self.firstScoreLab.text  =@"";
    self.firstScoreLab.textColor = [UIColor colorWithHexString:@"#fa8605"];
    self.firstScoreLab.font = BFont(18);
    self.firstScoreLab.textAlignment = NSTextAlignmentCenter;
    [self.firstScoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstLab.mas_bottom).offset(KSIphonScreenH(5));
        make.centerX.equalTo(firstLab.mas_centerX);
        make.width.lessThanOrEqualTo(@90);
    }];
    
    
    // 第二名头像
    self.secondHeaderImageV = [[UIImageView alloc]init];
    [bgView addSubview:self.secondHeaderImageV];
    self.secondHeaderImageV.image = [UIImage imageNamed:@"suggetion_select_normal"];
    [self.secondHeaderImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(KSIphonScreenH(20));
        make.left.equalTo(bgView).offset(KSIphonScreenW(26));
        make.width.height.equalTo(@52);
    }];
    self.secondHeaderImageV.layer.cornerRadius = 52/2;
    self.secondHeaderImageV.layer.masksToBounds = YES;
    
    UIImageView *secondImageV = [[UIImageView alloc]init];
    [bgView addSubview:secondImageV];
    secondImageV.image = [UIImage imageNamed:@"annualStanding_image_second"];
    [secondImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.secondHeaderImageV.mas_top).offset(KSIphonScreenH(5));
        make.centerX.equalTo(weakSelf.secondHeaderImageV.mas_centerX);
    }];
    
    // 第二名 名称
    self.secondNameLab = [[UILabel alloc]init];
    [bgView addSubview:self.secondNameLab];
    self.secondNameLab.text  =@"";
    self.secondNameLab.textColor = [UIColor colorCommonBlackColor];
    self.secondNameLab.font = BFont(14);
    self.secondNameLab.textAlignment = NSTextAlignmentCenter;
    [self.secondNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.secondHeaderImageV.mas_bottom).offset(KSIphonScreenH(5));
        make.centerX.equalTo(weakSelf.secondHeaderImageV.mas_centerX);
        make.width.lessThanOrEqualTo(@120);
    }];
    
    UILabel *secondLab = [[UILabel alloc]init];
    [bgView addSubview:secondLab];
    secondLab.text = @"累计得分";
    secondLab.textColor = [UIColor colorCommonAAAAGreyBlackColor];
    secondLab.font = Font(10);
    secondLab.textAlignment = NSTextAlignmentCenter;
    [secondLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.secondNameLab.mas_bottom).offset(KSIphonScreenH(5));
        make.centerX.equalTo(weakSelf.secondNameLab.mas_centerX);
    }];
    
    // 得分
    self.secondScoreLab = [[UILabel alloc]init];
    [bgView addSubview:self.secondScoreLab];
    self.secondScoreLab.text  =@"";
    self.secondScoreLab.textColor = [UIColor colorWithHexString:@"#fa8605"];
    self.secondScoreLab.font = BFont(18);
    self.secondScoreLab.textAlignment = NSTextAlignmentCenter;
    [self.secondScoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondLab.mas_bottom).offset(KSIphonScreenH(5));
        make.centerX.equalTo(secondLab.mas_centerX);
        make.width.lessThanOrEqualTo(@90);
    }];
    
    // 第三名头像
    self.thirdHeaderImageV = [[UIImageView alloc]init];
    [bgView addSubview:self.thirdHeaderImageV];
    self.thirdHeaderImageV.image = [UIImage imageNamed:@"suggetion_select_normal"];
    [self.thirdHeaderImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_top).offset(KSIphonScreenH(20));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(26));
        make.width.height.equalTo(@52);
    }];
    self.thirdHeaderImageV.layer.cornerRadius = 52/2;
    self.thirdHeaderImageV.layer.masksToBounds = YES;
    
    UIImageView *thirdImageV = [[UIImageView alloc]init];
    [bgView addSubview:thirdImageV];
    thirdImageV.image = [UIImage imageNamed:@"annualStanding_image_third"];
    [thirdImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.thirdHeaderImageV.mas_top).offset(KSIphonScreenH(5));
        make.centerX.equalTo(weakSelf.thirdHeaderImageV.mas_centerX);
    }];
    
    
    // 第三名 名称
    self.thirdNameLab = [[UILabel alloc]init];
    [bgView addSubview:self.thirdNameLab];
    self.thirdNameLab.text  =@"";
    self.thirdNameLab.textColor = [UIColor colorCommonBlackColor];
    self.thirdNameLab.font = BFont(14);
    self.thirdNameLab.textAlignment = NSTextAlignmentCenter;
    [self.thirdNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.thirdHeaderImageV.mas_bottom).offset(KSIphonScreenH(5));
        make.centerX.equalTo(weakSelf.thirdHeaderImageV.mas_centerX);
        make.width.lessThanOrEqualTo(@120);
    }];
    
    UILabel *thirdLab = [[UILabel alloc]init];
    [bgView addSubview:thirdLab];
    thirdLab.text = @"累计得分";
    thirdLab.textColor = [UIColor colorCommonAAAAGreyBlackColor];
    thirdLab.font = Font(10);
    thirdLab.textAlignment = NSTextAlignmentCenter;
    [thirdLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.thirdNameLab.mas_bottom).offset(KSIphonScreenH(5));
        make.centerX.equalTo(weakSelf.thirdNameLab.mas_centerX);
    }];
    
    // 得分
    self.thirdScoreLab = [[UILabel alloc]init];
    [bgView addSubview:self.thirdScoreLab];
    self.thirdScoreLab.text  =@"";
    self.thirdScoreLab.textColor = [UIColor colorWithHexString:@"#fa8605"];
    self.thirdScoreLab.font = BFont(18);
    self.thirdScoreLab.textAlignment = NSTextAlignmentCenter;
    [self.thirdScoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(thirdLab.mas_bottom).offset(KSIphonScreenH(5));
        make.centerX.equalTo(thirdLab.mas_centerX);
        make.width.lessThanOrEqualTo(@90);
    }];
}

-(void)setNowArr:(NSArray *)nowArr{
    _nowArr = nowArr;
    if (nowArr.count<3) {
        return;
    }
    /*  ---- 第一名 ---------------*/
    NSDictionary *firstDict = [nowArr firstObject];
    // 头像
    NSString *firstPhotoStr = [NSString stringWithFormat:@"%@",firstDict[@"photo"]];
    [YWTTools sd_setImageView:self.firstHeaderImageV WithURL:firstPhotoStr andPlaceholder:@"suggetion_select_normal"];
    // 第一名 名称
    self.firstNameLab.text  = [NSString stringWithFormat:@"%@",firstDict[@"realName"]];
    // 得分
    self.firstScoreLab.text  = [NSString stringWithFormat:@"%@",firstDict[@"credit"]];
    
     /*  ---- 第二名 ---------------*/
     NSDictionary *secondDict = nowArr[1];
    // 头像
    NSString *secoundPhotoStr = [NSString stringWithFormat:@"%@",secondDict[@"photo"]];
    [YWTTools sd_setImageView:self.secondHeaderImageV WithURL:secoundPhotoStr andPlaceholder:@"suggetion_select_normal"];
    // 第二名 名称
    self.secondNameLab.text = [NSString stringWithFormat:@"%@",secondDict[@"realName"]];;
    // 得分
    self.secondScoreLab.text  = [NSString stringWithFormat:@"%@",secondDict[@"credit"]];
    
     /*  ---- 第三名 ---------------*/
    NSDictionary *thirdDict = [nowArr lastObject];
    // 头像
    NSString *thirdPhotoStr = [NSString stringWithFormat:@"%@",thirdDict[@"photo"]];
    [YWTTools sd_setImageView:self.thirdHeaderImageV WithURL:thirdPhotoStr andPlaceholder:@"suggetion_select_normal"];
    // 第三名 名称
    self.thirdNameLab.text  = [NSString stringWithFormat:@"%@",thirdDict[@"realName"]];;
    // 得分
    self.thirdScoreLab.text  = [NSString stringWithFormat:@"%@",thirdDict[@"credit"]];
}




@end
