//
//  AttendanceRecordCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/12.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTCheckRecordTableViewCell.h"

@interface YWTCheckRecordTableViewCell ()
//内容view
@property (nonatomic,strong) UIView *contentChenkView;
// 类型图片
@property (nonatomic,strong) UIImageView *typeImageV;
// 备注按钮
@property (nonatomic,strong) UIButton *markBtn;
//签到时间
@property (nonatomic,strong) UILabel *checkTimerLab;
// 签到地点
@property (nonatomic,strong) UILabel *checkAddressLab;
// 身份验证
@property (nonatomic,strong) UILabel *authenticationLab;

@end

@implementation YWTCheckRecordTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createBaseRecordView];
    }
    return self;
}
-(void) createBaseRecordView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf).offset(-KSIphonScreenH(12));
    }];

    self.typeImageV = [[UIImageView alloc]init];
    [bgView addSubview:self.typeImageV];
    self.typeImageV.image = [UIImage imageNamed:@"base_record_kqqd"];
    [self.typeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(KSIphonScreenW(12));
        make.centerY.equalTo(bgView.mas_centerY);
    }];
    
    self.contentChenkView = [[UIView alloc]init];
    [bgView addSubview:self.contentChenkView];
    
    self.markBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentChenkView addSubview:self.markBtn];
    [self.markBtn setTitle:@"添加备注 >" forState:UIControlStateNormal];
    [self.markBtn setTitleColor:[UIColor colorConstantCommonBlueColor] forState:UIControlStateNormal];
    self.markBtn.titleLabel.font = Font(13);
    self.markBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [self.markBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(weakSelf.contentChenkView);
        make.width.equalTo(@(KSIphonScreenW(70)));
    }];
    [self.markBtn addTarget:self action:@selector(selectAddMarkBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //签到时间
    self.checkTimerLab = [[UILabel alloc]init];
    [self.contentChenkView addSubview:self.checkTimerLab];
    self.checkTimerLab.text = @"签到时间:";
    self.checkTimerLab.textColor = [UIColor colorCommonBlackColor];
    self.checkTimerLab.font = Font(17);
    [self.checkTimerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentChenkView);
        make.right.equalTo(weakSelf.markBtn.mas_left).offset(-KSIphonScreenW(10));
        make.centerY.equalTo(weakSelf.markBtn.mas_centerY);
    }];
    
    // 签到地点
    self.checkAddressLab = [[UILabel alloc]init];
    [self.contentChenkView addSubview:self.checkAddressLab];
    self.checkAddressLab.text = @"签到地点:";
    self.checkAddressLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.checkAddressLab.font = Font(13);
    [self.checkAddressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.checkTimerLab.mas_left);
        make.top.equalTo(weakSelf.checkTimerLab.mas_bottom).offset(KSIphonScreenH(10));
        make.right.equalTo(weakSelf.contentChenkView);
    }];
    
    // 身份验证
    self.authenticationLab = [[UILabel alloc]init];
    [self.contentChenkView addSubview:self.authenticationLab];
    self.authenticationLab.text = @"身份验证:";
    self.authenticationLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.authenticationLab.font = Font(13);
    [self.authenticationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.checkAddressLab.mas_left);
        make.top.equalTo(weakSelf.checkAddressLab.mas_bottom).offset(KSIphonScreenH(5));
    }];
    
    [self.contentChenkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(KSIphonScreenW(65));
        make.top.equalTo(weakSelf.markBtn.mas_top);
        make.bottom.equalTo(weakSelf.authenticationLab.mas_bottom);
        make.right.equalTo(bgView).offset(-KSIphonScreenW(12));
        make.centerY.equalTo(weakSelf.typeImageV.mas_centerY);
    }];
}
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    //签到时间
    self.checkTimerLab.text = [NSString stringWithFormat:@"签到时间: %@",dict[@"time"]];
    // 签到地点
    self.checkAddressLab.text =[NSString stringWithFormat:@"签到地点: %@",dict[@"signAddress"]];
    //
    NSString *faceIsStr = [NSString stringWithFormat:@"%@",dict[@"faceIs"]];
    // 1人脸正常 2人脸异常 3未检查人脸
    if ([faceIsStr isEqualToString:@"3"]) {
        // 隐藏 身份验证
        self.authenticationLab.hidden = YES;
        __weak typeof(self) weakSelf = self;
        [self.contentChenkView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset(KSIphonScreenW(65));
            make.top.equalTo(weakSelf.markBtn.mas_top);
            make.bottom.equalTo(weakSelf.checkAddressLab.mas_bottom);
            make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
            make.centerY.equalTo(weakSelf.typeImageV.mas_centerY);
        }];
    }else if ([faceIsStr isEqualToString:@"1"]){
         // 身份验证
        NSString *authenticationStr = @"身份验证: 已通过";
        self.authenticationLab.attributedText = [YWTTools getAttrbuteTotalStr:authenticationStr andAlterTextStr:@"已通过" andTextColor:[UIColor colorWithHexString:@"#32c500"] andTextFont:Font(13)];
    }else if ([faceIsStr isEqualToString:@"2"]){
        // 身份验证
        NSString *authenticationStr = @"身份验证: 未通过";
        self.authenticationLab.attributedText = [YWTTools getAttrbuteTotalStr:authenticationStr andAlterTextStr:@"未通过" andTextColor:[UIColor colorWithHexString:@"#ff3030"] andTextFont:Font(13)];
    }
    // 添加备注 1 添加备注 2查看备注
    NSString *isRemarkStr = [NSString stringWithFormat:@"%@",dict[@"isRemark"]];
    if ([isRemarkStr isEqualToString:@"1"]) {
        [self.markBtn setTitle:@"添加备注 >" forState:UIControlStateNormal];
    }else{
        [self.markBtn setTitle:@"查看备注 >" forState:UIControlStateNormal];
    }
}
// 添加/查看备注
-(void) selectAddMarkBtn:(UIButton *) sender{
    self.addMark();
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
