//
//  BeginBindWeChatController.m
//  PartyBuildingStar
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import "YWTBeginBindWeChatController.h"

@interface YWTBeginBindWeChatController ()
// 未绑定 背景view
@property (nonatomic,strong) UIView *unBindBgView;
// 绑定成功背景view
@property (nonatomic,strong) UIView *bindSuccessBgView;
// 绑定用户头像
@property (nonatomic,strong) UIImageView *bindUserHeadImageV;
// 绑定昵称
@property (nonatomic,strong) UILabel *nameLab;
// 绑定账号
@property (nonatomic,strong) UILabel *accountLab;

// 绑定按钮
@property (nonatomic,strong) UIButton *bindBtn;


@end

@implementation YWTBeginBindWeChatController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [self setNavi];
    // 创建绑定UI
    [self createBindUI];
}
#pragma mark --- 创建绑定UI --------
-(void) createBindUI{
    __weak typeof(self) weakSelf = self;
    self.view.backgroundColor  = [UIColor colorTextWhiteColor];
    
    // 未绑定 背景view
    self.unBindBgView = [[UIView alloc]init];
    [self.view addSubview:self.unBindBgView];
    
    UIView *photoView = [[UIView alloc]init];
    [self.unBindBgView addSubview:photoView];
    
    UIImageView *weChatImageV = [[UIImageView alloc]init];
    [photoView addSubview:weChatImageV];
    weChatImageV.image = [UIImage imageNamed:@"bind_weChat_logo"];
    [weChatImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(photoView);
    }];
    
    UIImageView *imageV = [[UIImageView alloc]init];
    [photoView addSubview:imageV];
    imageV.image = [UIImage imageNamed:@"bind_agkSafety_hp"];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weChatImageV.mas_right).offset(KSIphonScreenW(22));
        make.centerY.equalTo(weChatImageV.mas_centerY);
    }];
    
    UIImageView *agkSafetyImageV = [[UIImageView alloc]init];
    [photoView addSubview:agkSafetyImageV];
    agkSafetyImageV.image = [UIImage imageNamed:@"bind_agkSafety_logo"];
    [agkSafetyImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageV.mas_right).offset(KSIphonScreenW(22));
        make.centerY.equalTo(imageV.mas_centerY);
    }];
    
    [photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(weChatImageV);
        make.right.equalTo(agkSafetyImageV.mas_right);
        make.top.equalTo(weakSelf.view).offset(KSIphonScreenH(KSNaviTopHeight+KSIphonScreenH(100)));
        make.centerX.equalTo(weakSelf.view.mas_centerX);
    }];
    
    //
    UIView *contentView = [[UIView alloc]init];
    [self.unBindBgView addSubview:contentView];
    
    UIImageView *contentImageV = [[UIImageView alloc]init];
    [contentView addSubview:contentImageV];
    contentImageV.image = [UIImage imageNamed:@"bind_agkSafety_tips"];
    [contentImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView);
        make.centerY.equalTo(contentView.mas_centerY);
    }];
    
    UILabel *showLab = [[UILabel alloc]init];
    [contentView addSubview:showLab];
    showLab.text = @"成功绑定微信，即可接受微信通知!";
    showLab.textColor = [UIColor colorWithHexString:@"#222222"];
    showLab.font = Font(14);
    [showLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentImageV.mas_right).offset(KSIphonScreenW(5));
        make.centerY.equalTo(contentView.mas_centerY);
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentImageV.mas_left);
        make.right.equalTo(showLab.mas_right);
        make.bottom.equalTo(showLab.mas_bottom);
        make.top.equalTo(photoView.mas_bottom).offset(KSIphonScreenH(45));
        make.centerX.equalTo(photoView.mas_centerX);
    }];
    
    [self.unBindBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(KSNaviTopHeight);
        make.left.right.equalTo(weakSelf.view);
        make.bottom.equalTo(contentView.mas_bottom).offset(KSIphonScreenH(20));
        make.centerX.equalTo(weakSelf.view.mas_centerX);
    }];

    
    // 绑定成功背景view
    self.bindSuccessBgView = [[UIView alloc]init];
    [self.view addSubview:self.bindSuccessBgView];
    
    // 绑定用户头像
    self.bindUserHeadImageV = [[UIImageView alloc]init];
    [self.bindSuccessBgView addSubview:self.bindUserHeadImageV];
    self.bindUserHeadImageV.image  = [UIImage imageNamed:@"bindWeChat_success_headNomal"];
    [self.bindUserHeadImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(KSIphonScreenH(100)));
        make.top.equalTo(weakSelf.bindSuccessBgView).offset(KSIphonScreenH(45));
        make.centerX.equalTo(weakSelf.bindSuccessBgView.mas_centerX);
    }];
    self.bindUserHeadImageV.layer.cornerRadius = KSIphonScreenH(100)/2;
    self.bindUserHeadImageV.layer.masksToBounds = YES;
    self.bindUserHeadImageV.layer.borderWidth = 1 ;
    self.bindUserHeadImageV.layer.borderColor  = [UIColor colorLineCommonGreyBlackColor].CGColor;
    
    UIImageView *weChatLogoImageV = [[UIImageView alloc]init];
    [self.bindSuccessBgView addSubview:weChatLogoImageV];
    weChatLogoImageV.image = [UIImage imageNamed:@"bindWeChat_success_logo"];
    [weChatLogoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(weakSelf.bindUserHeadImageV);
    }];
    
    UILabel *bindNomalLab = [[UILabel alloc]init];
    [self.bindSuccessBgView addSubview:bindNomalLab];
    bindNomalLab.text = @"微信头像";
    bindNomalLab.textColor = [UIColor colorCommonBlackColor];
    bindNomalLab.font = BFont(14);
    [bindNomalLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bindUserHeadImageV.mas_bottom).offset(KSIphonScreenH(17));
        make.centerX.equalTo(weakSelf.bindUserHeadImageV.mas_centerX);
    }];
    
    UILabel *showNameLab = [[UILabel alloc]init];
    [self.bindSuccessBgView addSubview:showNameLab];
    showNameLab.text = @"昵称";
    showNameLab.textColor = [UIColor colorCommonBlackColor];
    showNameLab.font = BFont(14);
    [showNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bindSuccessBgView).offset(KSIphonScreenW(12));
        make.top.equalTo(bindNomalLab.mas_bottom).offset(KSIphonScreenH(45));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    [self.bindSuccessBgView addSubview:self.nameLab];
    self.nameLab.text = @"";
    self.nameLab.textColor = [UIColor colorCommonBlackColor];
    self.nameLab.font = BFont(14);
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bindSuccessBgView).offset(-KSIphonScreenW(12));
        make.centerY.equalTo(showNameLab.mas_centerY);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    [self.bindSuccessBgView addSubview:lineView];
    lineView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(showNameLab.mas_bottom).offset(KSIphonScreenH(24));
        make.left.right.equalTo(weakSelf.bindSuccessBgView);
        make.height.equalTo(@1);
    }];
    
    UILabel *showAccountLab = [[UILabel alloc]init];
    [self.bindSuccessBgView addSubview:showAccountLab];
    showAccountLab.text = @"账号";
    showAccountLab.textColor = [UIColor colorCommonBlackColor];
    showAccountLab.font = BFont(14);
    [showAccountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(showNameLab.mas_left);
        make.top.equalTo(lineView.mas_bottom).offset(KSIphonScreenH(24));
    }];
    
    // 绑定账号
    self.accountLab = [[UILabel alloc]init];
    [self.bindSuccessBgView addSubview:self.accountLab];
    self.accountLab.text = @"";
    self.accountLab.textColor = [UIColor colorCommonBlackColor];
    self.accountLab.font = BFont(14);
    [self.accountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bindSuccessBgView).offset(-KSIphonScreenW(12));
        make.centerY.equalTo(showAccountLab.mas_centerY);
    }];
    
    [self.bindSuccessBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(KSNaviTopHeight);
        make.left.right.equalTo(weakSelf.view);
        make.bottom.equalTo(showAccountLab.mas_bottom).offset(KSIphonScreenH(20));
        make.centerX.equalTo(weakSelf.view.mas_centerX);
    }];
    
    // 绑定按钮
    self.bindBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.bindBtn];
    [self.bindBtn setTitle:@"立即绑定" forState:UIControlStateNormal];
    [self.bindBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.bindBtn.titleLabel.font = Font(16);
    self.bindBtn.backgroundColor  = [UIColor colorLineCommonBlueColor];
    [self.bindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(KSIphonScreenH(44)));
        make.left.equalTo(weakSelf.view).offset(KSIphonScreenW(25));
        make.right.equalTo(weakSelf.view).offset(-KSIphonScreenW(25));
        make.bottom.equalTo(weakSelf.view).offset(-(KSIphonScreenH(KSIphonScreenH(22)+KSTabbarH)));
    }];
    self.bindBtn.layer.cornerRadius = KSIphonScreenH(44)/2;
    self.bindBtn.layer.masksToBounds = YES;
    
    
    if (self.bindStatu == showWeChatUnBindStatu) {
        // 未绑定
        self.unBindBgView.hidden = NO;
        self.bindSuccessBgView.hidden = YES;
        self.bindBtn.backgroundColor  = [UIColor colorLineCommonBlueColor];
    }else{
        self.unBindBgView.hidden = YES;
        self.bindSuccessBgView.hidden = NO;
        self.bindBtn.backgroundColor  = [UIColor colorWithHexString:@"fd5747"];
    }
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    self.customNavBar.title = @"绑定微信";
    
    __weak typeof(self) weakSelf = self;
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}

-(void)setBindStatu:(showWeChatBindStatu)bindStatu{
    _bindStatu = bindStatu;
}





@end
