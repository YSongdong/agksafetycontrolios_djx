//
//  AttendanceCheckHeaderView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/14.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTAttendanceCheckHeaderView.h"

@interface YWTAttendanceCheckHeaderView ()<UITextViewDelegate>

@property (nonatomic,strong) UILabel *addressLab;


@end

@implementation YWTAttendanceCheckHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createHeaderView];
    }
    return self;
}
-(void) createHeaderView {
    __weak typeof(self) weakSelf = self;
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#e9e9e9"];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectBgTap)];
    [bgView addGestureRecognizer:bgTap];
    
    
    UIView *titleView = [[UIView alloc]init];
    [bgView addSubview:titleView];
    titleView.backgroundColor = [UIColor colorTextWhiteColor];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(bgView);
        make.height.equalTo(@(KSIphonScreenH(50)));
    }];
    titleView.userInteractionEnabled = NO;
    
    UILabel *showTitleLab = [[UILabel alloc]init];
    [titleView addSubview:showTitleLab];
    showTitleLab.text =@"确认签到信息";
    showTitleLab.textColor = [UIColor colorCommonBlackColor];
    showTitleLab.font = BFont(17);
    [showTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(titleView.mas_centerX);
        make.centerY.equalTo(titleView.mas_centerY);
    }];
    
    UIView *addressView = [[UIView alloc]init];
    [bgView addSubview:addressView];
    addressView.backgroundColor = [UIColor colorTextWhiteColor];
//    addressView.userInteractionEnabled = NO;
    
    UIImageView *timeImageV = [[UIImageView alloc]init];
    [addressView addSubview:timeImageV];
    timeImageV.image = [UIImage imageNamed:@"base_attendance_time"];
    [timeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressView).offset(KSIphonScreenH(23));
        make.left.equalTo(addressView).offset(KSIphonScreenW(15));
    }];
    
    UILabel *showTimeLab = [[UILabel alloc]init];
    [addressView addSubview:showTimeLab];
    showTimeLab.text = [NSString stringWithFormat:@"签到时间: %@",[self getWithNowTimer]];
    showTimeLab.textColor = [UIColor colorCommon65GreyBlackColor];
    showTimeLab.font = Font(12);
    [showTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addressView).offset(KSIphonScreenW(33));
        make.centerY.equalTo(timeImageV.mas_centerY);
    }];
    
    UIImageView *addressImageV = [[UIImageView alloc]init];
    [addressView addSubview:addressImageV];
    addressImageV.image = [UIImage imageNamed:@"base_attendance_address"];
    [addressImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(showTimeLab.mas_bottom).offset(KSIphonScreenH(12));
        make.left.equalTo(timeImageV.mas_left);
    }];
    
    self.addressLab = [[UILabel alloc]init];
    [addressView addSubview:self.addressLab];
    self.addressLab.text = @"签到地址:";
    self.addressLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.addressLab.font = Font(12);
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addressView).offset(KSIphonScreenW(33));
        make.centerY.equalTo(addressImageV.mas_centerY);
        make.right.equalTo(addressView).offset(-KSIphonScreenW(11));
    }];
    
    UIImageView *verifImageV = [[UIImageView alloc]init];
    [addressView addSubview:verifImageV];
    verifImageV.image = [UIImage imageNamed:@"base_attendance_verif"];
    [verifImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.addressLab.mas_bottom).offset(KSIphonScreenH(12));
        make.left.equalTo(timeImageV.mas_left);
    }];
    
    self.faceVerifRultLab = [[UILabel alloc]init];
    [addressView addSubview:self.faceVerifRultLab];
    self.faceVerifRultLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.faceVerifRultLab.font = Font(12);
    [self.faceVerifRultLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addressView).offset(KSIphonScreenW(33));
        make.centerY.equalTo(verifImageV.mas_centerY);
    }];
    self.faceVerifRultLab.attributedText = [YWTTools getAttrbuteTotalStr:@"身份验证: 未通过" andAlterTextStr:@"未通过" andTextColor:[UIColor colorCommonRedColor] andTextFont:Font(12)];
    
    self.againVeriBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addressView addSubview:self.againVeriBtn];
    [self.againVeriBtn setTitle:@"重新验证 >" forState:UIControlStateNormal];
    [self.againVeriBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    self.againVeriBtn.titleLabel.font = Font(12);
    [self.againVeriBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addressView).offset(KSIphonScreenW(152));
        make.centerY.equalTo(weakSelf.faceVerifRultLab.mas_centerY);
    }];
    [self.againVeriBtn addTarget:self action:@selector(selecgAgainBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView.mas_bottom).offset(1);
        make.left.right.equalTo(bgView);
        make.bottom.equalTo(weakSelf.faceVerifRultLab.mas_bottom).offset(KSIphonScreenH(20));
    }];
    
    UIView *markView = [[UIView alloc]init];
    [bgView addSubview:markView];
    markView.backgroundColor = [UIColor colorTextWhiteColor];
    [markView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressView.mas_bottom).offset(1);
        make.left.right.bottom.equalTo(bgView);
    }];
   
    self.fsTextView = [[FSTextView alloc]init];
    [markView addSubview:self.fsTextView];
    self.fsTextView.placeholder = @"请输入签到备注信息 (选填)";
    self.fsTextView.placeholderColor = [UIColor colorCommonAAAAGreyBlackColor];
    self.fsTextView.placeholderFont = Font(12);
    self.fsTextView.textColor = [UIColor colorCommonBlackColor];
    self.fsTextView.font = Font(12);
    self.fsTextView.returnKeyType = UIReturnKeyDone;
    self.fsTextView.borderWidth = 0.01;
    self.fsTextView.delegate = self;
    self.fsTextView.borderColor = [UIColor colorTextWhiteColor];
    [self.fsTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(markView).offset(KSIphonScreenW(6));
        make.top.equalTo(markView).offset(KSIphonScreenH(10));
        make.bottom.equalTo(markView).offset(-KSIphonScreenH(8));
        make.right.equalTo(markView).offset(-KSIphonScreenW(10));
    }];
}
#pragma mark --- UITextViewDelegate -----
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
        [self endEditing:YES];
        return NO;
    }
    return YES;
}
// 重新验证
-(void) selecgAgainBtn:(UIButton *) sender{
    self.selectAgainVerif();
}
// 获取当前时间
-(NSString *) getWithNowTimer{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"HH:mm"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间
    NSString *timerStr = [formatter stringFromDate:datenow];
    return timerStr;
}
-(void)selectBgTap{
    [self.fsTextView resignFirstResponder];
}
-(void)setAddressStr:(NSString *)addressStr{
    _addressStr = addressStr;
    self.addressLab.text = [NSString stringWithFormat:@"签到地点: %@",addressStr];
}
@end
