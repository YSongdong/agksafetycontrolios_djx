//
//  BaseZFPlayerView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/4/11.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTBaseZFPlayerView.h"

#import <UIImageView+ZFCache.h>
#import <ZFPlayerControlView.h>
#import "YWTBaseZFPlayControlView.h"

@interface YWTBaseZFPlayerView ()
// 控制层
@property (nonatomic,strong) YWTBaseZFPlayControlView *controlView;
// 返回按钮
@property (nonatomic,strong) UIButton *backBtn;
//  标题
@property (nonatomic,strong) UILabel *titleLab;
// 封面图
@property (nonatomic,strong) UIImageView *coverImageV;
// 音频展示图标
@property (nonatomic,strong) UIImageView *audioImageV;
//播放按钮
@property (nonatomic,strong) UIButton *playBtn;

@end

@implementation YWTBaseZFPlayerView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createPlayerView];
    }
    return self;
}
-(void) createPlayerView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorTextWhiteColor];
    
    // 封面图
    _coverImageV = [[UIImageView alloc]init];
    [self addSubview:_coverImageV];
    _coverImageV.image = [UIImage imageNamed:@"base_detail_nomal"];
    [_coverImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    UITapGestureRecognizer *coverTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectTap)];
    [self.coverImageV addGestureRecognizer:coverTap];
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.backBtn];
    [self.backBtn setImage:[UIImage imageNamed:@"rgzx_nav_ico_back"] forState:UIControlStateNormal];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(KSStatusHeight);
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(10));
        make.width.height.equalTo(@40);
    }];
    [self.backBtn addTarget:self action:@selector(selectBackAction:) forControlEvents:UIControlEventTouchUpInside];

    self.titleLab = [[UILabel alloc]init];
    [self addSubview:self.titleLab];
    self.titleLab.textColor = [UIColor colorTextWhiteColor];
    self.titleLab.font = BFont(16);
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.backBtn.mas_right).offset(5);
        make.right.equalTo(weakSelf).offset(-15);
        make.centerY.equalTo(weakSelf.backBtn.mas_centerY);
    }];

    // 音频展示图标
    self.audioImageV = [[UIImageView alloc]init];
    [self.coverImageV addSubview:self.audioImageV];
    self.audioImageV.image = [UIImage imageNamed:@"base_wjxq_yp"];
    [self.audioImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@80);
        make.centerX.equalTo(weakSelf.coverImageV.mas_centerX);
        make.centerY.equalTo(weakSelf.coverImageV.mas_centerY);
    }];

    [self.coverImageV addSubview:self.playBtn];
    [_playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.coverImageV.mas_centerX);
        make.centerY.equalTo(weakSelf.coverImageV.mas_centerY);
    }];

    // 顶部阴影
    UIImageView *shodowTopImageV = [[UIImageView alloc]init];
    [self.coverImageV addSubview:shodowTopImageV];
    shodowTopImageV.image = [UIImage imageNamed:@"shadow_top"];
    [shodowTopImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf.coverImageV);
        make.height.equalTo(@(KSNaviTopHeight));
    }];

    // 底部阴影
    UIImageView *shodowBottomImageV = [[UIImageView alloc]init];
    [self.coverImageV addSubview:shodowBottomImageV];
    shodowBottomImageV.image = [UIImage imageNamed:@"shadow_bottom"];
    [shodowBottomImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.coverImageV);
        make.height.equalTo(@(KSIphonScreenH(44)));
        make.bottom.equalTo(weakSelf.coverImageV.mas_bottom);
    }];
    
    // UI控制层
    self.controlView = [[YWTBaseZFPlayControlView alloc]init];
    self.controlView.isVideoType = self.isVideoType;
    
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    playerManager.scalingMode = ZFPlayerScalingModeAspectFill;
    /// 播放器相关
    self.player = [[ZFPlayerController alloc]initWithPlayerManager:playerManager containerView:self.coverImageV];
    self.player.controlView = self.controlView;
    
    /// 设置退到后台继续播放
    self.player.pauseWhenAppResignActive = NO;

    // 当前播放时间进度回调
    self.controlView.videoPlayerCurrentTime = ^(NSDictionary * _Nonnull currentTimeDict) {
        weakSelf.videoPlayerCurrentTime(currentTimeDict);
    };
    // 点击返回按钮
    self.controlView.selectBackBtn = ^{
        weakSelf.selectBackBtn();
    };
}
#pragma mark ----- 按钮点击事件 -----
// 点击播放
-(void) selelctPlayClick:(UIButton *) sender{
    NSURL *url =  [NSURL URLWithString:self.playerUrl];
    self.player.assetURL = url;
    // 隐藏
    self.backBtn.hidden = YES;
    self.titleLab.hidden = YES;
    // 当封面上点击播放
    self.selecCoverPlayBtn();
}
-(void) selectTap{
    [self selelctPlayClick:self.playBtn];
}
-(void)setPlayerUrl:(NSString *)playerUrl{
    _playerUrl = playerUrl;
}
-(void)setIsVideoType:(BOOL)isVideoType{
    _isVideoType = isVideoType;
    if (isVideoType) {
       self.audioImageV.hidden =YES;
    }else{
       self.audioImageV.hidden =NO;
    }
}
-(void)setFileNameStr:(NSString *)fileNameStr{
    _fileNameStr = fileNameStr;
    self.titleLab.text = fileNameStr;
    self.controlView.fileNameStr =fileNameStr;
}
#pragma mark ---
-(UIButton *)playBtn{
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn setImage:[UIImage imageNamed:@"base_wjxq_pullUpNews"] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(selelctPlayClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

-(void)setIsShowCoverImageV:(BOOL)isShowCoverImageV{
    _isShowCoverImageV = isShowCoverImageV;
    self.controlView.isShowCoverImageV = isShowCoverImageV;
}

-(void)selectBackAction:(UIButton *) sneder{
    self.selectBackBtn();
}



@end
