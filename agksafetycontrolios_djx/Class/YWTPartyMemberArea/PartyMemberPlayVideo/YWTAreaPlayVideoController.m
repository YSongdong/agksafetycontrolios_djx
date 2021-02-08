//
//  YWTAreaPlayVideoController.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/10.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTAreaPlayVideoController.h"

#import "YWTCustomControlView.h"

@interface YWTAreaPlayVideoController ()
// 视频播放
@property (nonatomic,strong) ZFPlayerController *player;
// 控制层
@property (nonatomic,strong) YWTCustomControlView *customControlView;
// 封面
@property (nonatomic,strong) UIImageView  *headerImageV;
// 播放按钮
@property (nonatomic,strong) UIButton *playBtn;

@end

@implementation YWTAreaPlayVideoController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.player.viewControllerDisappear = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.player.viewControllerDisappear = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorTextWhiteColor];
    // 添加封面
    [self.view addSubview:self.headerImageV];
    WS(weakSelf);
    // 添加播放按钮
    [self.headerImageV addSubview:self.playBtn];
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.headerImageV.mas_centerX);
        make.centerY.equalTo(weakSelf.headerImageV.mas_centerY);
    }];
    // 设置导航栏
    [self setNavi];
    // 创建播放器
    [self createPalyer];
    // 设置封面
    self.headerImageV.image = self.addModel.photoImege;
    // 设置标题
    [self.customControlView showTitle:self.addModel.fileName coverURLString:@"patry_list_video_default" fullScreenMode:ZFFullScreenModeAutomatic];
}
-(void) selectPlayBtnAction:(UIButton *)sender{
    [self playUrlStr];
}
-(void)playUrlStr{
    NSString *URLString = [NSString byAddingAllCharactersStr:self.addModel.urlStr];
    self.player.assetURL = [NSURL URLWithString:URLString];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.player.isFullScreen) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    /// 如果只是支持iOS9+ 那直接return NO即可，这里为了适配iOS8
    return NO;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

- (BOOL)shouldAutorotate {
    return self.player.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.player.isFullScreen) {
        return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskPortrait;
}
#pragma mark --- 创建播放器 --------
-(void) createPalyer{
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    // 播放器相关
    self.player = [ZFPlayerController playerWithPlayerManager:playerManager containerView:self.headerImageV];
    self.player.controlView = self.customControlView;
    // 设置退到后台继续播放
    self.player.pauseWhenAppResignActive = NO;
    
    @weakify(self)
    self.player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
        @strongify(self)
        [self setNeedsStatusBarAppearanceUpdate];
    };
    
    // 播放完成
    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
        @strongify(self)
        [self.player stop];
    };
}
#pragma mark --- 设置导航栏 --------
-(void) setNavi{
    [self.customNavBar wr_setBackgroundAlpha:1];
    
    self.customNavBar.title = @"播放视频";
    
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"rgzx_nav_ico_back"]];
    __weak typeof(self) weakSelf = self;
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}
#pragma mark --  -get  --------
-(void)setAddModel:(YWTAddModel *)addModel{
    _addModel = addModel;
}
-(YWTCustomControlView *)customControlView{
    if (!_customControlView) {
        _customControlView = [YWTCustomControlView new];
    }
    return _customControlView;
}

-(UIImageView *)headerImageV{
    if (!_headerImageV) {
        _headerImageV = [[UIImageView alloc]init];
        _headerImageV.frame = CGRectMake(0, (KScreenH-KSNaviTopHeight-(KScreenW*9)/16)/2, KScreenW, (KScreenW*9)/16);
        _headerImageV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playUrlStr)];
        [_headerImageV addGestureRecognizer:tap];
    }
    return _headerImageV;
}

-(UIButton *)playBtn{
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn setImage:[UIImage imageNamed:@"base_wjxq_pullUpNews"] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(selectPlayBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}


@end
