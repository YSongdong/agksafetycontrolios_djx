//
//  SettingViewController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/9.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTSettingViewController.h"

#import "YWTSettingModuleView.h"
#import "YWTUpdateView.h"
@interface YWTSettingViewController ()
// 版本view
@property (nonatomic,strong) YWTSettingModuleView *versionView;
// 清除缓存view
@property (nonatomic,strong) YWTSettingModuleView *clearCacheView;
//名字
@property (nonatomic,strong) UILabel *versionNameLab;
// 退出按钮
@property (nonatomic,strong) UIButton *outBtn;
// 版本更新view
@property (nonatomic,strong) YWTUpdateView *updateView;

@end

@implementation YWTSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self setNavi];
    // 创建view
    [self createSettingView];
    // 检测版本更新
    [self requestDataIsShowUpdateView];
}
// 创建view
-(void) createSettingView{
    self.view.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    __weak typeof(self) weakSelf = self;
    UIImageView *logoImageV = [[UIImageView alloc]init];
    [self.view addSubview:logoImageV];
    logoImageV.image = [UIImage imageNamed:@"setting_logo"];
    [logoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(KSNaviTopHeight+KSIphonScreenH(44));
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.width.height.equalTo(@(KSIphonScreenH(68)));
    }];
    
    self.versionNameLab = [[UILabel alloc]init];
    [self.view addSubview:self.versionNameLab];
    //获取本地软件的版本号
    NSString *localVersion =  [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    self.versionNameLab.text =[NSString stringWithFormat:@"党建星系统%@版",localVersion];
    self.versionNameLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.versionNameLab.font = Font(15);
    [self.versionNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImageV.mas_bottom).offset(KSIphonScreenH(14));
        make.centerX.equalTo(weakSelf.view.mas_centerX);
    }];
 
    // 版本view
    self.versionView = [[YWTSettingModuleView alloc]init];
    self.versionView.titleStr = @"版本更新";
    self.versionView.subTitleStr = @"";
    self.versionView.backgroundColor = [UIColor colorTextWhiteColor];
    [self.view addSubview:self.versionView];
    [self.versionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(KSIphonScreenH(200)+KSNaviTopHeight);
        make.left.right.equalTo(weakSelf.view);
        make.height.equalTo(@(KSIphonScreenH(60)));
    }];
    //点击升级事件
    self.versionView.selectViewBlock = ^{
        weakSelf.versionView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             weakSelf.versionView.backgroundColor = [UIColor colorTextWhiteColor];
        });
        if ([weakSelf.clearCacheView.subTitleStr isEqualToString:@""]) {
            [weakSelf.view showRightWithTitle:@"已经是最新版本!" autoCloseTime:1];
        }else{
            [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.updateView];
        }
    };
    // 清除缓存view
    self.clearCacheView = [[YWTSettingModuleView alloc]init];
    [self.view addSubview:self.clearCacheView];
    self.clearCacheView.titleStr = @"清除缓存";
    self.clearCacheView.backgroundColor = [UIColor colorTextWhiteColor];
    self.clearCacheView.subTitleStr = @"";
    [self.clearCacheView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.versionView.mas_bottom);
        make.left.height.right.equalTo(weakSelf.versionView);
        make.centerX.equalTo(weakSelf.versionView);
    }];
    //点击事件
    self.clearCacheView.selectViewBlock = ^{
        weakSelf.clearCacheView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.clearCacheView.backgroundColor = [UIColor colorTextWhiteColor];
        });
        [[SDImageCache sharedImageCache]clearDiskOnCompletion:nil];
//        NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//        // 获取Documents路径
//        NSString *cwFolderPath = [NSString stringWithFormat:@"%@/audio",documentDir];
//        // 获取文件夹所有文件
//        NSArray *files = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:cwFolderPath error:nil];
//        for (NSString *filesStr in files) {
//            // 获取Documents路径
//            NSString *cwFolderPath = [NSString stringWithFormat:@"%@/audio",documentDir];
//            // 拼接成完整路径
//            NSString *fliePath = [NSString stringWithFormat:@"%@/%@",cwFolderPath,filesStr];
//            // 文件管理类
//            NSFileManager *fileManager = [NSFileManager defaultManager];
//            if ([[NSFileManager defaultManager]fileExistsAtPath:fliePath]) {
//                // 移除文件
//                [fileManager removeItemAtPath:fliePath error:nil];
//            }
//        }
        [weakSelf.view showRightWithTitle:@"清除成功!" autoCloseTime:1];
    };
    
    // 退出按钮
    self.outBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.outBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    self.outBtn.titleLabel.font = Font(14);
    [self.view addSubview:self.outBtn];
    [self.outBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.clearCacheView.mas_bottom).offset(KSIphonScreenH(25));
        make.left.equalTo(weakSelf.view).offset(KSIphonScreenW(25));
        make.right.equalTo(weakSelf.view).offset(-KSIphonScreenW(25));
        make.height.equalTo(@(KSIphonScreenH(44)));
    }];
    self.outBtn.layer.cornerRadius = KSIphonScreenH(44)/2;
    self.outBtn.layer.masksToBounds = YES;
    [self.outBtn addTarget:self action:@selector(selectOutBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.outBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    [self.outBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorLineCommonBlueColor]] forState:UIControlStateNormal];
    [self.outBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorClickCommonBlueColor]] forState:UIControlStateHighlighted];
    self.outBtn.layer.borderWidth = 0.5;
    self.outBtn.layer.borderColor = [UIColor colorLineCommonBlueColor].CGColor;
   
}
// 退出按钮
-(void)selectOutBtn:(UIButton *) sender{
    // 删除用户信息
    [YWTUserInfo delUserInfo];
    
    //退出的时候删除别名
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        if (iResCode == 0) {
            NSLog(@"删除别名成功");
        }
    } seq:1];
    
    // 跳转到登录页
    AppDelegate *appdel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    SDRootNavigationController *loginVC = [[SDRootNavigationController alloc]initWithRootViewController:[[YWTLoginViewController alloc]init]];
    appdel.window.rootViewController = loginVC;
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    self.customNavBar.title = @"设置";
    
    __weak typeof(self) weakSelf = self;
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}

//判断是否显示更新View
-(void) requestDataIsShowUpdateView{
    //获取本地软件的版本号
    NSString *localVersion =  [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"system"] =  @"1";
    param[@"version"] = localVersion;
    param[@"appId"] = @"lhagk_red";
    [[KRMainNetTool sharedKRMainNetTool]postRequstWith:HTTP_ATTENDANCESYSTEMUPGRADE_URL params:param withModel:nil waitView:nil complateHandle:^(id showdata, NSString *error) {
        if (error) {
            return ;
        }
        //判断是否需要更新  false 不需要更新  true  需要更新
        if (![showdata[@"update"] boolValue]) {
            self.clearCacheView.subTitleStr = @"";
            return;
        }
        
        //判断是否强制更新  1 强制更新 2 非强制更新
        NSString *forceStr = [NSString stringWithFormat:@"%@",showdata[@"force"]];
        self.updateView  =[[YWTUpdateView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
        if ([forceStr isEqualToString:@"1"]) {
            self.updateView.typeStatu = updateTypeForceStatu;
        }
        self.clearCacheView.subTitleStr = [NSString stringWithFormat:@"V%@版",showdata[@"version"]];
        self.updateView.contentLab.text = showdata[@"releaseNotes"];
        self.updateView.titleLab.text = [NSString stringWithFormat:@"发现新版本V%@版",showdata[@"version"]];
        [[UIApplication sharedApplication].keyWindow addSubview:self.updateView];
    }];
}

@end
