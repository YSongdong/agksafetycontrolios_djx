//
//  BaseZFPlayControlView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/4/12.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTBaseZFPlayControlView.h"

#import "UIView+ZFFrame.h"
#import <ZFSliderView.h>
#import <ZFUtilities.h>
#import <ZFSmallFloatControlView.h>
#import <ZFVolumeBrightnessView.h>
#import <ZFSpeedLoadingView.h>

@interface YWTBaseZFPlayControlView ()
// 顶部工具背景view
@property (nonatomic,strong) UIView *topToolView;
// 顶部工具背景imageV
@property (nonatomic,strong) UIImageView *topBgImageV;
// 返回按钮
@property (nonatomic,strong) UIButton *backBtn;
//  标题
@property (nonatomic,strong) UILabel *titleLab;
// 中心播放按钮
@property (nonatomic,strong) UIButton *centerPlayBtn;


@property (nonatomic,strong) UIView *landScapeContentView;
// 底部工具view
@property (nonatomic,strong) UIView *bottomToolView;
// 底部工具播放按钮
@property (nonatomic,strong) UIButton *bottomToolPlayBtn;
//  底部工具横竖屏切换按钮
@property (nonatomic,strong) UIButton *bottomToolHPBtn;
// 底部工具显示结束时间
@property (nonatomic,strong) UILabel *bottomToolTimeLab;
// 底部工具背景imagev
@property (nonatomic,strong) UIImageView *bottomBgImageV;

// 滑杆
@property (nonatomic,strong) ZFSliderView *sliderView;
/// 控制层显示或者隐藏
@property (nonatomic, assign) BOOL baseControlViewAppeared;

@property (nonatomic, strong) dispatch_block_t afterBlock;

@property (nonatomic, assign) NSTimeInterval sumTime;

@property (nonatomic, strong) ZFSmallFloatControlView *floatControlView;

@property (nonatomic, strong) ZFVolumeBrightnessView *volumeBrightnessView;
/// 加载失败按钮
@property (nonatomic, strong) UIButton *failBtn;
/// 加载loading
@property (nonatomic, strong) ZFSpeedLoadingView *activity;

// 音频展示图标
@property (nonatomic,strong) UIImageView *audioImageV;



@end

@implementation YWTBaseZFPlayControlView

@synthesize player = _player;

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createControlView];
    }
    return self;
}
-(void) createControlView{
    self.floatControlView.hidden = YES;
    
    self.coverImageV = [[UIImageView alloc]init];
    [self addSubview:self.coverImageV];

    // 音频展示图标
    self.audioImageV = [[UIImageView alloc]init];
    [self.coverImageV addSubview:self.audioImageV];
    
    self.topToolView = [[UIView alloc]init];
    [self addSubview:self.topToolView];
    
    self.topBgImageV = [[UIImageView alloc]init];
    [self.topToolView addSubview:self.topBgImageV];
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.topToolView addSubview:self.backBtn];

    self.titleLab = [[UILabel alloc]init];
    [self.topToolView addSubview:self.titleLab];

    self.bottomToolView = [[UIView alloc]init];
    [self addSubview:self.bottomToolView];
    
    self.bottomBgImageV = [[UIImageView alloc]init];
    [self.bottomToolView addSubview:self.bottomBgImageV];
    
    // 播放按钮
    self.bottomToolPlayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bottomToolView addSubview:self.bottomToolPlayBtn];
    [self.bottomToolPlayBtn setImage:[UIImage imageNamed:@"base_audio_protariPaly"] forState:UIControlStateNormal];
    [self.bottomToolPlayBtn setImage:[UIImage imageNamed:@"base_audio_protairOut"] forState:UIControlStateSelected];

    // 横竖屏切换按钮
    self.bottomToolHPBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bottomToolView addSubview:self.bottomToolHPBtn];

    // 底部工具显示结束时间
    self.bottomToolTimeLab = [[UILabel alloc]init];
    [self.bottomToolView addSubview:self.bottomToolTimeLab];

    // 进度条
    self.sliderView = [[ZFSliderView alloc]init];
    [self.bottomToolView addSubview:self.sliderView];

    // 中心播放按钮
    self.centerPlayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.centerPlayBtn];
    [self.centerPlayBtn setImage:[UIImage imageNamed:@"base_wjxq_pullUpNews"] forState:UIControlStateSelected];
    [self.centerPlayBtn setImage:[UIImage imageNamed:@"base_wjxq_pullonNews"] forState:UIControlStateNormal];
    [self.centerPlayBtn addTarget:self action:@selector(selectCenterPlayBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //加载view、
    _activity = [[ZFSpeedLoadingView alloc] init];
    [self addSubview:_activity];

    self.failBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.failBtn];
    [self.failBtn setTitle:@"加载失败,点击重试" forState:UIControlStateNormal];
    [self.failBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.failBtn.titleLabel.font = Font(14);
    [self.failBtn addTarget:self action:@selector(selectFailBtn:) forControlEvents:UIControlEventTouchUpInside];
    
}
//返回按钮
-(void) selectBackBtn :(UIButton *) sender{
    if (self.player.isFullScreen) {
        self.bottomToolHPBtn.selected = YES;
        [self selectToolHPBtn:self.bottomToolHPBtn];
    }else{
        self.selectBackBtn();
    }
}
// 中心播放按钮
-(void) selectCenterPlayBtn:(UIButton *) sender{
    sender.selected = !sender.selected;
    // 如果播放出错了，就返回
    if ((self.player.currentPlayerManager.playState == ZFPlayerPlayStatePlayFailed)) {
        return;
    }
    if (sender.selected) {
        [self.player.currentPlayerManager pause];
    }else{
        if (self.player.currentPlayerManager.playState == ZFPlayerPlayStatePlayStopped) {
            // 播放完成
            [self.player.currentPlayerManager replay];
        }else{
            [self.player.currentPlayerManager play];
        }
    }
}
//  底部工具播放按钮
-(void) selectToolPlayBtn:(UIButton *) sender{
    // 如果播放出错了，就返回
    if ((self.player.currentPlayerManager.playState == ZFPlayerPlayStatePlayFailed)) {
        return;
    }
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.player.currentPlayerManager pause];
    }else{
        [self.player.currentPlayerManager play];
    }
}
// 底部工具横竖屏切换按钮
-(void) selectToolHPBtn:(UIButton *) sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.bottomToolPlayBtn setImage:[UIImage imageNamed:@"base_audio_paly"] forState:UIControlStateNormal];
        [self.bottomToolPlayBtn setImage:[UIImage imageNamed:@"base_audio_timeOut"] forState:UIControlStateSelected];
        [self.player enterFullScreen:YES animated:YES];

            // 隐藏顶部视图
           self.topToolView.hidden = YES;

    }else{
        [self.bottomToolPlayBtn setImage:[UIImage imageNamed:@"base_audio_protariPaly"] forState:UIControlStateNormal];
        [self.bottomToolPlayBtn setImage:[UIImage imageNamed:@"base_audio_protairOut"] forState:UIControlStateSelected];
        [self.player enterFullScreen:NO animated:YES];
        // 隐藏顶部视图
        self.topToolView.hidden = YES;
    }
}
// 加载失败
-(void) selectFailBtn:(UIButton *) sender{
    [self.player.currentPlayerManager reloadPlayer];
}
/// 隐藏控制层
- (void)hideControlViewWithAnimated:(BOOL)animated {
    self.baseControlViewAppeared = NO;
    [UIView animateWithDuration:0.25 animations:^{
        if (self.player.isFullScreen) {
            self.bottomToolView.hidden = YES;
            self.topToolView.hidden = YES;
            // 如果在播放状态下 隐藏播放按钮
            if (self.player.currentPlayerManager.isPlaying) {
                self.centerPlayBtn.hidden  = YES;
            }else{
                self.centerPlayBtn.hidden  = NO;
            }
        }else{
            self.bottomToolView.hidden = YES;
            self.topToolView.hidden = YES;
            // 如果在播放状态下 隐藏播放按钮
            if (self.player.currentPlayerManager.isPlaying) {
                self.centerPlayBtn.hidden  = YES;
            }else{
                self.centerPlayBtn.hidden  = NO;
            }
        }
    }];
}
/// 显示控制层
- (void)showControlViewWithAnimated:(BOOL)animated {
    self.baseControlViewAppeared = YES;
    [self autoFadeOutControlView];
    [UIView animateWithDuration:0.25 animations:^{
        if (self.player.isFullScreen) {
            self.bottomToolView.hidden = NO;
            self.topToolView.hidden = NO;
        }else{
            self.bottomToolView.hidden = NO;
            self.topToolView.hidden = NO;
        }
    }];
}
- (void)autoFadeOutControlView {
    [self cancelAutoFadeOutControlView];
    @weakify(self)
    self.afterBlock = dispatch_block_create(0, ^{
        @strongify(self)
        [self hideControlViewWithAnimated:YES];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(),self.afterBlock);
}
/// 取消延时隐藏controlView的方法
- (void)cancelAutoFadeOutControlView {
    if (self.afterBlock) {
        dispatch_block_cancel(self.afterBlock);
        self.afterBlock = nil;
    }
}
#pragma mark -------
/// 加载状态改变
- (void)videoPlayer:(ZFPlayerController *)videoPlayer loadStateChanged:(ZFPlayerLoadState)state {
    if (state == ZFPlayerLoadStatePrepare) {
         [self.activity startAnimating];
    } else if (state == ZFPlayerLoadStatePlaythroughOK || state == ZFPlayerLoadStatePlayable) {
        [self.activity stopAnimating];
    }
    if (state == ZFPlayerLoadStateStalled && videoPlayer.currentPlayerManager.isPlaying) {
        [self.activity startAnimating];
    } else if ((state == ZFPlayerLoadStateStalled || state == ZFPlayerLoadStatePrepare) && videoPlayer.currentPlayerManager.isPlaying) {
        [self.activity startAnimating];
    } else {
        [self.activity stopAnimating];
    }
}
// 播放状态
- (void)videoPlayer:(ZFPlayerController *)videoPlayer playStateChanged:(ZFPlayerPlaybackState)state{
    if (state == ZFPlayerPlayStatePlaying) {
        self.bottomToolPlayBtn.selected = NO;
        self.centerPlayBtn.selected = NO;
        // 隐藏加载失败按钮
        self.failBtn.hidden = YES;
        //隐藏播放按钮
        self.centerPlayBtn.hidden = YES;
        
        // 隐藏封面图
        if (!self.isShowCoverImageV) {
            self.coverImageV.hidden = YES;
        }
        // 音频展示图标
        if (self.isVideoType) {
            self.audioImageV.hidden =YES;
        }else{
             self.audioImageV.hidden =NO;
        }
    }else if (state == ZFPlayerPlayStatePaused){
        self.bottomToolPlayBtn.selected = YES;
        self.centerPlayBtn.selected = YES;
        // 隐藏加载失败按钮
        self.failBtn.hidden = YES;
        // 隐藏封面图
        if (!self.isShowCoverImageV) {
            self.coverImageV.hidden = YES;
        }
        // 音频展示图标
        if (self.isVideoType) {
            self.audioImageV.hidden =YES;
        }else{
            self.audioImageV.hidden =NO;
        }
        // 暂停的时候隐藏loading
        [self.activity stopAnimating];
    }else if (state == ZFPlayerPlayStatePlayFailed){
        //  播放出错！
        // 显示加载失败按钮
        self.failBtn.hidden = NO;
        // 隐藏封面图
        if (!self.isShowCoverImageV) {
            self.coverImageV.hidden = YES;
        }
        // 音频展示图标
        if (self.isVideoType) {
            self.audioImageV.hidden =YES;
        }else{
            self.audioImageV.hidden =NO;
        }
        [self.activity stopAnimating];
        //
        self.bottomToolPlayBtn.selected = YES;
        
        self.centerPlayBtn.selected = YES;
        
    }else if (state == ZFPlayerPlayStatePlayStopped){
        // 播放结束
        self.centerPlayBtn.selected = YES;
        self.bottomToolPlayBtn.selected =  YES;
        // 隐藏封面图
        if (!self.isShowCoverImageV) {
            self.coverImageV.hidden = YES;
        }
        // 音频展示图标
        if (self.isVideoType) {
            self.audioImageV.hidden =YES;
        }else{
            self.audioImageV.hidden =NO;
        }
    }
}
/// 播放进度改变回调
-(void)videoPlayer:(ZFPlayerController *)videoPlayer currentTime:(NSTimeInterval)currentTime totalTime:(NSTimeInterval)totalTime{
    NSString *currentTimeString = [ZFUtilities convertTimeSecond:currentTime];
    NSString *totalTimeString = [ZFUtilities convertTimeSecond:totalTime];
    self.bottomToolTimeLab.text = [NSString stringWithFormat:@"%@/%@",currentTimeString,totalTimeString];
    // 当前进度
    self.sliderView.value = videoPlayer.progress;
    
    // 当前播放时间进度回调
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"currentTime"] = [NSNumber numberWithInteger:currentTime];
    param[@"totalTime"] = [NSNumber numberWithInteger:totalTime];
    self.videoPlayerCurrentTime(param.copy);
}
/// 缓冲改变回调
- (void)videoPlayer:(ZFPlayerController *)videoPlayer bufferTime:(NSTimeInterval)bufferTime {
    self.sliderView.bufferValue = videoPlayer.bufferProgress;
}
// 单击手势事件
-(void)gestureSingleTapped:(ZFPlayerGestureControl *)gestureControl{
    if (!self.player) return;
    self.centerPlayBtn.hidden = NO;
    if (self.baseControlViewAppeared) {
        [self hideControlViewWithAnimated:YES];
        //隐藏播放按钮
        self.centerPlayBtn.hidden = YES;
    }else{
        [self showControlViewWithAnimated:YES];
        //显示播放按钮
        self.centerPlayBtn.hidden = NO;
    }
}
/// 双击手势事件
- (void)gestureDoubleTapped:(ZFPlayerGestureControl *)gestureControl {
    if ((self.player.currentPlayerManager.playState == ZFPlayerPlayStatePlayFailed)) {
        return;
    }
    if (self.player.isFullScreen) {
        self.bottomToolPlayBtn.selected = !self.bottomToolPlayBtn.selected;
        self.centerPlayBtn.selected = !self.centerPlayBtn.selected;
        self.bottomToolPlayBtn.selected? [self.player.currentPlayerManager pause] :[self.player.currentPlayerManager play];
    } else {
        self.bottomToolPlayBtn.selected = !self.bottomToolPlayBtn.selected;
        self.centerPlayBtn.selected = !self.centerPlayBtn.selected;
        self.bottomToolPlayBtn.selected? [self.player.currentPlayerManager pause] :[self.player.currentPlayerManager play];
    }
}
/// 开始滑动手势事件
- (void)gestureBeganPan:(ZFPlayerGestureControl *)gestureControl panDirection:(ZFPanDirection)direction panLocation:(ZFPanLocation)location {
    if (direction == ZFPanDirectionH) {
        self.sumTime = self.player.currentTime;
    }
}
/// 滑动中手势事件
- (void)gestureChangedPan:(ZFPlayerGestureControl *)gestureControl panDirection:(ZFPanDirection)direction panLocation:(ZFPanLocation)location withVelocity:(CGPoint)velocity {
    if (direction == ZFPanDirectionH) {
        // 每次滑动需要叠加时间
        self.sumTime += velocity.x / 200;
        // 需要限定sumTime的范围
        NSTimeInterval totalMovieDuration = self.player.totalTime;
        if (totalMovieDuration == 0) return;
        if (self.sumTime > totalMovieDuration) self.sumTime = totalMovieDuration;
        if (self.sumTime < 0) self.sumTime = 0;
        BOOL style = NO;
        if (velocity.x > 0) style = YES;
        if (velocity.x < 0) style = NO;
        if (velocity.x == 0) return;
        // 更新滑杆
        self.sliderView.value = self.sumTime/totalMovieDuration;
        // 更新显示时间
        NSString *draggedTime = [ZFUtilities convertTimeSecond:self.player.totalTime*(self.sumTime/totalMovieDuration)];
        NSString *totalTimer = [ZFUtilities convertTimeSecond:self.player.totalTime];
        self.bottomToolTimeLab.text = [NSString stringWithFormat:@"%@/%@",draggedTime,totalTimer];
        
    } else if (direction == ZFPanDirectionV) {
        if (location == ZFPanLocationLeft) { /// 调节亮度
            self.player.brightness -= (velocity.y) / 10000;
//            [self.volumeBrightnessView updateProgress:self.player.brightness withVolumeBrightnessType:ZFVolumeBrightnessTypeumeBrightness];
        } else if (location == ZFPanLocationRight) { /// 调节声音
            self.player.volume -= (velocity.y) / 10000;
            if (self.player.isFullScreen) {
//                [self.volumeBrightnessView updateProgress:self.player.volume withVolumeBrightnessType:ZFVolumeBrightnessTypeVolume];
            }
        }
    }
}
/// 滑动结束手势事件
- (void)gestureEndedPan:(ZFPlayerGestureControl *)gestureControl panDirection:(ZFPanDirection)direction panLocation:(ZFPanLocation)location {
    @weakify(self)
    if (direction == ZFPanDirectionH && self.sumTime >= 0 && self.player.totalTime > 0) {
        [self.player seekToTime:self.sumTime completionHandler:^(BOOL finished) {
            @strongify(self)
            /// 左右滑动调节播放进度
//            [self.portraitControlView sliderChangeEnded];
//            [self.landScapeControlView sliderChangeEnded];
            [self autoFadeOutControlView];
        }];
        if (self.player.isProxy) {
            [self.player.currentPlayerManager play];
        }
        self.sumTime = 0;
    }
}
/// 准备播放
- (void)videoPlayer:(ZFPlayerController *)videoPlayer prepareToPlay:(NSURL *)assetURL {
    [self hideControlViewWithAnimated:NO];
}
/// 视频view即将旋转
- (void)videoPlayer:(ZFPlayerController *)videoPlayer orientationWillChange:(ZFOrientationObserver *)observer {
//    self.topToolView.hidden = observer.isFullScreen;
//    self.bottomToolView.hidden = observer.isFullScreen;
    if (self.baseControlViewAppeared) {
        [self showControlViewWithAnimated:NO];
    } else {
        [self hideControlViewWithAnimated:NO];
    }
    if (observer.isFullScreen) {
        [self.volumeBrightnessView removeSystemVolumeView];
        // 横屏
        self.bottomToolHPBtn.selected = YES;
        [self.bottomToolPlayBtn setImage:[UIImage imageNamed:@"base_audio_paly"] forState:UIControlStateNormal];
        [self.bottomToolPlayBtn setImage:[UIImage imageNamed:@"base_audio_timeOut"] forState:UIControlStateSelected];
        if (self.centerPlayBtn.selected) {
            self.bottomToolPlayBtn.selected = YES;
        }else{
            self.bottomToolPlayBtn.selected = NO;
        }
    } else {
        [self.volumeBrightnessView addSystemVolumeView];
         // 竖屏
        self.bottomToolHPBtn.selected = NO;
        [self.bottomToolPlayBtn setImage:[UIImage imageNamed:@"base_audio_protariPaly"] forState:UIControlStateNormal];
        [self.bottomToolPlayBtn setImage:[UIImage imageNamed:@"base_audio_protairOut"] forState:UIControlStateSelected];
        if (self.centerPlayBtn.selected) {
            self.bottomToolPlayBtn.selected = YES;
        }else{
            self.bottomToolPlayBtn.selected = NO;
        }
    }
}
-(void)setIsShowCoverImageV:(BOOL)isShowCoverImageV{
    _isShowCoverImageV = isShowCoverImageV;
}
-(void)setIsVideoType:(BOOL)isVideoType{
    _isVideoType = isVideoType;
}
-(void)setFileNameStr:(NSString *)fileNameStr{
    _fileNameStr = fileNameStr;
    self.titleLab.text = fileNameStr;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat min_x = 0;
    CGFloat min_y = 0;
    CGFloat min_w = 0;
    CGFloat min_h = 0;
    CGFloat min_view_w = self.bounds.size.width;
    CGFloat min_view_h = self.bounds.size.height;
    // 封面图
    self.coverImageV.image = [UIImage imageNamed:@"base_detail_nomal"];
    self.coverImageV.frame = CGRectMake(0, 0, self.zf_width, self.zf_height);
    // 音频展示图标
    self.audioImageV.image = [UIImage imageNamed:@"base_wjxq_yp"];
    self.audioImageV.userInteractionEnabled = NO;
    self.audioImageV.frame = CGRectMake((self.zf_width-80)/2, (self.zf_height-80)/2, 80, 80);
    
    min_x = (iPhoneX && self.player.orientationObserver.fullScreenMode == ZFFullScreenModeLandscape) ? 44: 15;
    min_h = iPhoneX ? 75 : 45;
    self.topToolView.frame = CGRectMake(0, 0, min_view_w, min_h);
    
    self.topBgImageV.image = [UIImage imageNamed:@"shadow_top"];
    self.topBgImageV.frame =  CGRectMake(self.topToolView.zf_x, 0, self.topToolView.zf_width, self.topToolView.zf_height);
    
    [self.backBtn setImage:[UIImage imageNamed:@"rgzx_nav_ico_back"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(selectBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    min_x = (iPhoneX && self.player.orientationObserver.fullScreenMode == ZFFullScreenModeLandscape) ? 44: 10;
    min_y = (iPhoneX && self.player.orientationObserver.fullScreenMode == ZFFullScreenModeLandscape) ? 10: (iPhoneX ? 40 : 20);
    min_w = 30;
    min_h = 30;
    self.backBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_x = self.backBtn.zf_right + 5;
    min_y = 0;
    min_w = min_view_w - min_x - 15 ;
    min_h = 30;
    self.titleLab.text =  self.fileNameStr;
    self.titleLab.textColor = [UIColor colorTextWhiteColor];
    self.titleLab.font = BFont(16);
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.frame = CGRectMake(min_x, min_y, min_w, min_h);
    self.titleLab.zf_centerY = self.backBtn.zf_centerY;
    
    min_h = 45;
    min_h = iPhoneX ? 75 : 45;
    min_x = 0;
    min_y = min_view_h - min_h-KSTabbarH;
    min_w = min_view_w;
    self.bottomToolView.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    self.bottomBgImageV.image = [UIImage imageNamed:@"shadow_bottom"];
    self.bottomBgImageV.frame = CGRectMake(self.bottomToolView.zf_x, 0, self.bottomToolView.zf_width, self.bottomToolView.zf_height);
    
    min_x = (iPhoneX && self.player.orientationObserver.fullScreenMode == ZFFullScreenModeLandscape) ? 44: 10;
    min_y = 10;
    min_w = 30;
    min_h = 30;
    [self.bottomToolPlayBtn addTarget:self action:@selector(selectToolPlayBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.bottomToolPlayBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);

    min_x = self.bottomToolView.zf_width-30-10;
    min_y = 10;
    min_w = 30;
    min_h = 30;
    [self.bottomToolHPBtn setImage:[UIImage imageNamed:@"base_wjxq_protari"] forState:UIControlStateNormal];
    [self.bottomToolHPBtn setImage:[UIImage imageNamed:@"base_audio_veriScreen"] forState:UIControlStateSelected];
    [self.bottomToolHPBtn addTarget:self action:@selector(selectToolHPBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.bottomToolHPBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_w = 80;
    min_x = self.bottomToolView.zf_width-30-10-80;
    min_y = 0;
    min_h = 30;
    self.bottomToolTimeLab.text = @"00:00/00:00";
    self.bottomToolTimeLab.textColor = [UIColor colorTextWhiteColor];
    self.bottomToolTimeLab.font = Font(12);
    self.bottomToolTimeLab.frame = CGRectMake(min_x, min_y, min_w, min_h);
    self.bottomToolTimeLab.zf_centerY = self.bottomToolHPBtn.zf_centerY;
    
    min_x = 30+20;
    min_y = 0;
    min_w = self.bottomToolView.zf_width-min_w-10-30-70;
    min_h = 30;
    self.sliderView.minimumTrackTintColor = [UIColor colorWithHexString:@"#ff7c00"];
    self.sliderView.maximumTrackTintColor = [UIColor colorTextWhiteColor];
    self.sliderView.bufferTrackTintColor = [UIColor colorWithHexString:@"#ffa205"];
    [self.sliderView setThumbImage: [YWTTools imageWithColor:[UIColor colorWithHexString:@"#ff7c00"] andCGRect:CGRectMake(0, 0, 12, 12) andCornersSize:6] forState:UIControlStateNormal];
    self.sliderView.frame = CGRectMake(min_x, min_y, min_w, min_h);
    self.sliderView.zf_centerY = self.bottomToolPlayBtn.zf_centerY;
    
    //加载view、
    min_x = (self.zf_width-80)/2;
    min_y =(self.zf_height-80)/2;
    min_w = 80;
    min_h = 80;
    self.activity.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    // 加载失败提示框
    min_x = (self.zf_width-150)/2;
    min_y =(self.zf_height-30)/2;
    min_w = 150;
    min_h = 30;
    self.failBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    // 中心播放按钮
    min_x = (self.zf_width-80)/2;
    min_y =(self.zf_height-80)/2;
    min_w = 80;
    min_h = 80;
    self.centerPlayBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    if (self.player.isLockedScreen) {
        self.topToolView.zf_y = -self.topToolView.zf_height;
        self.bottomToolView.zf_y = self.zf_height;
    } else {
        self.topToolView.zf_y = 0;
        self.bottomToolView.zf_y = self.zf_height - self.bottomToolView.zf_height;
    }
}

@end
