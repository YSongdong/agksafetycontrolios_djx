//
//  LeftView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/8.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTLeftView.h"

@implementation YWTLeftView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createLeftView];
    }
    return self;
}
-(void) createLeftView{
    
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorTextWhiteColor];
    
    UIImageView *naviImageV = [[UIImageView alloc]init];
    [self addSubview:naviImageV];
    naviImageV.image = [UIImage imageNamed:@"grzx_cbl_pic_2"];
    naviImageV.contentMode = UIViewContentModeScaleAspectFill;
    [naviImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf);
        make.height.equalTo(@(KSNaviTopHeight+KSIphonScreenH(79)));
    }];

    UIView *headerView = [[UIView alloc]init];
    [self addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(KSNaviTopHeight+KSIphonScreenH(20));
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(15));
        make.width.equalTo(@(KSIphonScreenW(230)));
        make.height.equalTo(@(KSIphonScreenH(240)));
    }];
    UITapGestureRecognizer *headerTag = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectHeaderTag:)];
    [headerView addGestureRecognizer:headerTag];
    
    self.headerImageV = [[UIImageView alloc]init];
    [headerView addSubview:self.headerImageV];
    self.headerImageV.contentMode = UIViewContentModeScaleAspectFill;
    [self.headerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView).offset(KSIphonScreenH(20));
        make.centerX.equalTo(headerView.mas_centerX);
        make.width.height.equalTo(@(KSIphonScreenH(90)));
    }];
    [YWTTools sd_setImageView:self.headerImageV WithURL:[YWTUserInfo obtainWithPhoto] andPlaceholder:@"cbl_pic_user"];
    self.headerImageV.layer.masksToBounds = YES;
    self.headerImageV.layer.cornerRadius = KSIphonScreenH(90)/2;
    self.headerImageV.layer.borderWidth = 1;
    self.headerImageV.layer.borderColor = [UIColor colorHeaderImageVDBDBColor].CGColor;
    
    self.headerStatuImageV = [[UIImageView alloc]init];
    [headerView addSubview:self.headerStatuImageV];
    [self.headerStatuImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.headerImageV.mas_centerX);
        make.centerY.equalTo(weakSelf.headerImageV.mas_bottom);
    }];
    NSString *vFaceStr = [NSString stringWithFormat:@"%@",[YWTUserInfo obtainWithVFace]];
    if ([vFaceStr isEqualToString:@"1"]) {
        // 认证
        self.headerStatuImageV.image = [UIImage imageNamed:@"grzx_ico_ytg"];
    }else if ([vFaceStr isEqualToString:@"2"]){
        // 未认证
         self.headerStatuImageV.image = [UIImage imageNamed:@"grzx_pic_wcj"];
    }else if ([vFaceStr isEqualToString:@"3"]){
        // 是认证不通过
        self.headerStatuImageV.image = [UIImage imageNamed:@"grzx_ico_wtg"];
    }else if ([vFaceStr isEqualToString:@"4"]){
        // 审核中
        self.headerStatuImageV.image = [UIImage imageNamed:@"grzx_ico_shz"];
    }
    
    UIView *nameView = [[UIView alloc]init];
    [headerView addSubview:nameView];
    
    //性别
    self.sexImageV = [[UIImageView alloc]init];
    [nameView addSubview:self.sexImageV];
    NSString *sexStr = [NSString stringWithFormat:@"%@",[YWTUserInfo obtainWithSex]];
    if ([sexStr isEqualToString:@"1"]) {
        // 男
        self.sexImageV.hidden = NO;
        self.sexImageV.image = [UIImage imageNamed:@"grzx_pic_nh"];
    }else if ([sexStr isEqualToString:@"2"]){
        // 女
        self.sexImageV.hidden = NO;
        self.sexImageV.image = [UIImage imageNamed:@"grzx_pic_ns"];
    }else{
        self.sexImageV.hidden = YES;
    }
    [self.sexImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameView);
        make.centerY.equalTo(nameView.mas_centerY);
    }];
    
    //姓名
    self.nameLab = [[UILabel alloc]init];
    [nameView addSubview:self.nameLab];
    self.nameLab.text = [YWTUserInfo obtainWithRealName];
    self.nameLab.font = BFont(15);
    self.nameLab.textColor = [UIColor colorCommonBlackColor];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.sexImageV.mas_right).offset(KSIphonScreenH(8));
        make.right.equalTo(nameView.mas_right);
        make.centerY.equalTo(weakSelf.sexImageV.mas_centerY);
    }];
    [nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headerStatuImageV.mas_bottom).offset(KSIphonScreenH(10));
        make.centerX.equalTo(weakSelf.headerStatuImageV.mas_centerX);
        make.left.equalTo(weakSelf.sexImageV.mas_left);
        make.right.equalTo(weakSelf.nameLab.mas_right);
        make.height.equalTo(@(KSIphonScreenH(25)));
    }];
    
    //部门
    self.departNameLab = [[UILabel alloc]init];
    [headerView addSubview:self.departNameLab];
    self.departNameLab.text = [YWTUserInfo obtainWithCompany];
    self.departNameLab.font = Font(15);
    self.departNameLab.textAlignment = NSTextAlignmentCenter;
    self.departNameLab.textColor = [UIColor colorCommonBlackColor];
    [self.departNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameView.mas_bottom).offset(KSIphonScreenH(30));
        make.centerX.equalTo(headerView.mas_centerX);
        make.width.equalTo(@(KSIphonScreenW(170)));
    }];
    
    //编号
    self.numberLab = [[UILabel alloc]init];
    [headerView addSubview:self.numberLab];
    self.numberLab.text = [YWTUserInfo obtainWithSN];
    self.numberLab.font = Font(15);
    self.numberLab.textColor = [UIColor colorCommonGreyBlackColor];
    [self.numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.departNameLab.mas_bottom).offset(KSIphonScreenH(15));
        make.centerX.equalTo(weakSelf.departNameLab.mas_centerX);
    }];
    
    NSMutableArray *imageArr;
    NSMutableArray *titleArr;
    imageArr = [NSMutableArray arrayWithObjects:@"left_myStudits",@"clb_ico_kscj",@"clb_ico_zskscj",@"clb_ico_sz", nil];
    titleArr = [NSMutableArray arrayWithObjects:@"我的学分",@"我的文章",@"考试成绩",@"设置", nil];
   
    for (int i = 0; i<imageArr.count; i++) {
        UIView *baseView = [[UIView alloc]init];
        [self addSubview:baseView];
        [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headerView.mas_bottom).offset(KSIphonScreenH(10)+i*KSIphonScreenH(60));
            make.left.width.equalTo(weakSelf);
            make.height.equalTo(@(KSIphonScreenH(60)));
            make.centerX.equalTo(weakSelf);
        }];
        baseView.tag = 100+i;
        UIImageView *baseImageV = [[UIImageView alloc]init];
        [baseView addSubview:baseImageV];
        baseImageV.image = [UIImage imageNamed:imageArr[i]];
        [baseImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(baseView).offset(KSIphonScreenW(16));
            make.centerY.equalTo(baseView.mas_centerY);
        }];
        
        UILabel *baseLab = [[UILabel alloc]init];
        [baseView addSubview:baseLab];
        baseLab.text = titleArr[i];
        baseLab.font = Font(15);
        baseLab.textColor = [UIColor colorCommonBlackColor];
        [baseLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(baseImageV.mas_right).offset(KSIphonScreenW(7));
            make.centerY.equalTo(baseImageV.mas_centerY);
        }];
        
        UIImageView *rightImageV = [[UIImageView alloc]init];
        [baseView addSubview:rightImageV];
        rightImageV.image = [UIImage imageNamed:@"cbl_ico_enter"];
        [rightImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(baseView.mas_right).offset(-KSIphonScreenW(130));
            make.centerY.equalTo(baseView.mas_centerY);
        }];
        
        if (i == 0) {
            self.myCreditsLab = [[UILabel alloc]init];
            [baseView addSubview:self.myCreditsLab];
            self.myCreditsLab.text = @"0";
            self.myCreditsLab.font = Font(15);
            self.myCreditsLab.textColor = [UIColor colorTextCommonOrangeColor];
            [self.myCreditsLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(rightImageV.mas_left).offset(-KSIphonScreenW(8));
                make.centerY.equalTo(rightImageV.mas_centerY);
            }];

            UIImageView *myCredImageV = [[UIImageView alloc]init];
            [baseView addSubview:myCredImageV];
            myCredImageV.image = [UIImage imageNamed:@"myCredit_score_nomalLeft"];
            [myCredImageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(weakSelf.myCreditsLab.mas_left).offset(-KSIphonScreenW(5));
                make.centerY.equalTo(rightImageV.mas_centerY);
            }];
        }
        
        //线条view
        if (i < imageArr.count -1 ) {
            UIView *lineView = [[UIView alloc]init];
            [baseView addSubview:lineView];
            lineView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(baseView).offset(KSIphonScreenW(16));
                make.bottom.equalTo(baseView);
                make.right.equalTo(baseView.mas_right).offset(-KSIphonScreenW(130));
                make.height.equalTo(@1);
            }];
        }
        baseView.backgroundColor = [UIColor colorTextWhiteColor];
        UITapGestureRecognizer *baseTag = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectBaseView:)];
        [baseView addGestureRecognizer:baseTag];
        
    }
}

//点击头像跳转到个人中心
-(void)selectHeaderTag:(UITapGestureRecognizer *) tap{
    UIView *headerView = (UIView *)tap.view;
    headerView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        headerView.backgroundColor = [UIColor clearColor];
    });
    self.headerBlock();
}
// 点击 设置或者考试成绩
-(void)selectBaseView:(UITapGestureRecognizer *) sender{
    UIView *view = (UIView *)sender.view;
    switch (view.tag-100) {
        case 0:
        {  // 我的学分
            view.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                view.backgroundColor = [UIColor colorTextWhiteColor];
            });
            self.selectMyCrdits();
            break;
        }
        case 1:
        { // 我的文章
            view.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                view.backgroundColor = [UIColor colorTextWhiteColor];
            });
            self.selectMyArticle();
            break;
        }
        case 2:
        { // 正式考试成绩
            view.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                view.backgroundColor = [UIColor colorTextWhiteColor];
            });
            self.examinationBlock();
            break;
        }
        case 3:
        { // 设置
            view.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                view.backgroundColor = [UIColor colorTextWhiteColor];
            });
            self.settingBlock();
            break;
        }
        default:
            break;
    }
}
// 更新用户信息
-(void) updateUserInfoData{
    // 更新用户头像
     [YWTTools sd_setImageView:self.headerImageV WithURL:[YWTUserInfo obtainWithPhoto] andPlaceholder:@"cbl_pic_user"];
    // 更新头像状态
    NSString *vFaceStr = [NSString stringWithFormat:@"%@",[YWTUserInfo obtainWithVFace]];
    if ([vFaceStr isEqualToString:@"1"]) {
        // 认证
        self.headerStatuImageV.image = [UIImage imageNamed:@"grzx_ico_ytg"];
    }else if ([vFaceStr isEqualToString:@"2"]){
        // 未认证
        self.headerStatuImageV.image = [UIImage imageNamed:@"grzx_pic_wcj"];
    }else if ([vFaceStr isEqualToString:@"3"]){
        // 是认证不通过
        self.headerStatuImageV.image = [UIImage imageNamed:@"grzx_ico_wtg"];
    }else if ([vFaceStr isEqualToString:@"4"]){
        // 审核中
        self.headerStatuImageV.image = [UIImage imageNamed:@"grzx_ico_shz"];
    }
    // 更新用户性别信息
    NSString *sexStr = [NSString stringWithFormat:@"%@",[YWTUserInfo obtainWithSex]];
    if ([sexStr isEqualToString:@"1"]) {
        // 男
        self.sexImageV.hidden = NO;
        self.sexImageV.image = [UIImage imageNamed:@"grzx_pic_nh"];
    }else if ([sexStr isEqualToString:@"2"]){
        // 女
        self.sexImageV.hidden = NO;
        self.sexImageV.image = [UIImage imageNamed:@"grzx_pic_ns"];
    }else{
        self.sexImageV.hidden = YES;
    }
    
    //姓名
    self.nameLab.text = [YWTUserInfo obtainWithRealName];
    
    //部门
    self.departNameLab.text = [YWTUserInfo obtainWithCompany];
    
    //编号
    self.numberLab.text = [YWTUserInfo obtainWithSN];
    
    // 我的学分
    NSString *creditStr = [NSString stringWithFormat:@"%.2f",[[YWTUserInfo obtainWithCredit]doubleValue]];
    self.myCreditsLab.text = creditStr;
}






@end
