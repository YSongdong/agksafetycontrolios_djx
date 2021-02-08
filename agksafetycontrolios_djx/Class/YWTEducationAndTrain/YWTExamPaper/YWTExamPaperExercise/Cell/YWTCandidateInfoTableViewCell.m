//
//  CandidateInfoTableViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/16.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTCandidateInfoTableViewCell.h"

@interface YWTCandidateInfoTableViewCell ()
// 考生姓名
@property (nonatomic,strong) UILabel *candidateNameLab;
// 考生编号
@property (nonatomic,strong) UILabel *candidateNumberLab;
// 单位名称
@property (nonatomic,strong) UILabel *companyNameLab;
// 头像
@property (nonatomic,strong) UIImageView *headerImageV;
// 头像状态
@property (nonatomic,strong) UIImageView *headerChenkStatuImageV;

@end

@implementation YWTCandidateInfoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createInfoView];
    }
    return self;
}
-(void)createInfoView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor  =[UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(KSIphonScreenH(12));
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
        make.bottom.equalTo(weakSelf);
    }];
    bgView.layer.cornerRadius = KSIphonScreenH(7);
    bgView.layer.masksToBounds = YES;
    bgView.layer.borderWidth = 1;
    bgView.layer.borderColor =  [UIColor colorLineCommonGreyBlackColor].CGColor;
    
    UIView *infoView = [[UIView alloc]init];
    [bgView addSubview:infoView];
    infoView.backgroundColor = [UIColor colorTextWhiteColor];
    
    UIView *leftLineView = [[UIView alloc]init];
    [infoView addSubview:leftLineView];
    leftLineView.backgroundColor = [UIColor colorConstantCommonBlueColor];
    [leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infoView).offset(KSIphonScreenW(12));
        make.width.equalTo(@2);
        make.centerY.equalTo(infoView.mas_centerY);
        make.height.equalTo(@(KSIphonScreenH(11)));
    }];
    
    UILabel *showCandidateInfoLab = [[UILabel alloc]init];
    [infoView addSubview:showCandidateInfoLab];
    showCandidateInfoLab.text = @"考生信息";
    showCandidateInfoLab.textColor = [UIColor colorCommonBlackColor];
    showCandidateInfoLab.font = BFont(14);
    [showCandidateInfoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftLineView.mas_right).offset(KSIphonScreenW(5));
        make.centerY.equalTo(leftLineView.mas_centerY);
    }];
    
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(bgView);
        make.height.equalTo(@(KSIphonScreenH(42)));
    }];
    
    UIView *infoLineView = [[UIView alloc]init];
    [infoView addSubview:infoLineView];
    infoLineView.backgroundColor = [UIColor colorLineE3E3CommonGreyBlackColor];
    [infoLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infoView).offset(KSIphonScreenW(12));
        make.right.equalTo(infoView).offset(-KSIphonScreenW(12));
        make.bottom.equalTo(infoView);
        make.height.equalTo(@1);
    }];
    
    UIView *userInfoView = [[UIView alloc]init];
    [bgView addSubview:userInfoView];
    userInfoView.backgroundColor = [UIColor colorTextWhiteColor];
    [userInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoView.mas_bottom);
        make.left.right.bottom.equalTo(bgView);
    }];
    
    self.headerImageV = [[UIImageView alloc]init];
    [userInfoView addSubview:self.headerImageV];
    self.headerImageV.image = [UIImage imageNamed:@"pic_user01"];
    self.headerImageV.contentMode = UIViewContentModeScaleAspectFill;
    [self.headerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userInfoView).offset(KSIphonScreenW(12));
        make.centerY.equalTo(userInfoView.mas_centerY);
        make.width.height.equalTo(@(KSIphonScreenH(80)));
    }];
    self.headerImageV.layer.cornerRadius = KSIphonScreenH(80)/2;
    self.headerImageV.layer.masksToBounds = YES;
    self.headerImageV.layer.borderWidth = 1;
    self.headerImageV.layer.borderColor = [UIColor colorHeaderImageVDBDBColor].CGColor;
    
    self.headerChenkStatuImageV = [[UIImageView alloc]init];
    [userInfoView addSubview:self.headerChenkStatuImageV];
    self.headerChenkStatuImageV.image = [UIImage imageNamed:@"grzx_pic_ytg"];
    [self.headerChenkStatuImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.headerImageV.mas_bottom);
        make.centerX.equalTo(weakSelf.headerImageV.mas_centerX);
    }];
    
    UIView *userView = [[UIView alloc]init];
    [userInfoView addSubview:userView];
    
    // 姓名
    self.candidateNameLab = [[UILabel alloc]init];
    [userView addSubview:self.candidateNameLab];
    self.candidateNameLab.textColor = [UIColor colorCommonBlackColor];
    self.candidateNameLab.font = Font(23);
    self.candidateNameLab.textAlignment = NSTextAlignmentLeft;
    [self.candidateNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(userView);
    }];
    
    UIImageView *userCandNumberImageV = [[UIImageView alloc]init];
    [userView addSubview:userCandNumberImageV];
    userCandNumberImageV.image = [UIImage imageNamed:@"ico_bh"];
    userCandNumberImageV.contentMode = UIViewContentModeScaleAspectFit;
    [userCandNumberImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userView);
        make.top.equalTo(weakSelf.candidateNameLab.mas_bottom).offset(KSIphonScreenH(10));
    }];
    
    self.candidateNumberLab  =[[UILabel alloc]init];
    [userView addSubview:self.candidateNumberLab];
    self.candidateNumberLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.candidateNumberLab.font = Font(14);
    [self.candidateNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userView).offset(KSIphonScreenW(19));
        make.centerY.equalTo(userCandNumberImageV.mas_centerY);
    }];
    
    UIImageView *userCompanyImageV = [[UIImageView alloc]init];
    [userView addSubview:userCompanyImageV];
    userCompanyImageV.image = [UIImage imageNamed:@"ico_bm"];
    userCompanyImageV.contentMode = UIViewContentModeScaleAspectFit;
    [userCompanyImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userCandNumberImageV.mas_bottom).offset(KSIphonScreenH(7));
        make.left.equalTo(userView);
    }];
    
    self.companyNameLab = [[UILabel alloc]init];
    [userView addSubview:self.companyNameLab];
    self.companyNameLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.companyNameLab.font = Font(14);
    [self.companyNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.candidateNumberLab.mas_left);
        make.right.equalTo(userView);
        make.centerY.equalTo(userCompanyImageV.mas_centerY);
    }];
    
    [userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.candidateNameLab.mas_top);
        make.left.equalTo(userInfoView).offset(KSIphonScreenW(105));
        make.bottom.equalTo(weakSelf.companyNameLab.mas_bottom);
        make.right.equalTo(bgView);
        make.centerY.equalTo(userInfoView.mas_centerY);
    }];
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
   //考生名字
   self.candidateNameLab.text = [NSString stringWithFormat:@"%@",dict[@"realName"]];
   // 考生编号
    self.candidateNumberLab.text =[NSString stringWithFormat:@"编号 : %@",dict[@"sn"]];
    //单位名称
    self.companyNameLab.text = [NSString stringWithFormat:@"部门 : %@",dict[@"unitName"]];
    
    // 头像状态Str  1认证 2未认证 3是认证不通过 4审核中
    NSString *vFaceStr = [NSString stringWithFormat:@"%@",dict[@"vFace"]];
    if ([vFaceStr isEqualToString:@"1"]) {
        self.headerChenkStatuImageV.image = [UIImage imageNamed:@"grzx_ico_ytg"];
    }else if ([vFaceStr isEqualToString:@"2"]){
        self.headerChenkStatuImageV.image = [UIImage imageNamed:@"grzx_pic_wcj"];
    }else if ([vFaceStr isEqualToString:@"3"]){
        self.headerChenkStatuImageV.image = [UIImage imageNamed:@"grzx_ico_wtg"];
    }else if ([vFaceStr isEqualToString:@"4"]){
        self.headerChenkStatuImageV.image = [UIImage imageNamed:@"grzx_ico_shz"];
    }
    
    //头像
    [YWTTools sd_setImageView:self.headerImageV WithURL:dict[@"photo"] andPlaceholder:@"pic_user01"];

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
