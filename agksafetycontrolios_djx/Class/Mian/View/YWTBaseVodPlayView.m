//
//  BaseVodPlayView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/27.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTBaseVodPlayView.h"

#import "CWAudioPlayer.h"

@interface YWTBaseVodPlayView (){
    NSTimer *_timer;
}

@property (nonatomic,strong) UILabel *timerLab;

@property (nonatomic,strong) UIButton *palyBtn;

@property (nonatomic,strong) UIButton *cancelBtn;

@property (nonatomic,assign) NSInteger index;



@end


@implementation YWTBaseVodPlayView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.index = 0;
        [self createVodPlayView];
    }
    return self;
}
-(void) createVodPlayView{
    __weak typeof(self) weakSelf = self;
    
    UIView *bigBgView = [[UIView alloc]init];
    [self addSubview:bigBgView];
    bigBgView.backgroundColor = [UIColor blackColor];
    bigBgView.alpha = 0.35;
    [bigBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectTap)];
    [bigBgView addGestureRecognizer:tap];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf);
        make.height.equalTo(@(KSIphonScreenH(230)));
    }];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:self.cancelBtn];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:[UIColor colorCommonBlackColor] forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font = Font(16);
    self.cancelBtn.backgroundColor  = [UIColor colorWithHexString:@"#f5f5f5"];
    [self.cancelBtn addTarget:self action:@selector(selectTap) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(bgView);
        make.height.equalTo(@(KSIphonScreenH(40)));
    }];
    
    self.palyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:self.palyBtn];
    [self.palyBtn setImage:[UIImage imageNamed:@"base_record_end"] forState:UIControlStateNormal];
    [self.palyBtn setImage:[UIImage imageNamed:@"bae_record_recording"] forState:UIControlStateSelected];
    [self.palyBtn addTarget:self action:@selector(selectPlayBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.palyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView.mas_centerX);
        make.centerY.equalTo(bgView.mas_centerY).offset(-KSIphonScreenH(10));
    }];
    
    self.timerLab = [[UILabel alloc]init];
    [bgView addSubview:self.timerLab];
    self.timerLab.text = @"00:00";
    self.timerLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.timerLab.font = Font(14);
    [self.timerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.palyBtn.mas_top).offset(-KSIphonScreenH(30));
        make.centerX.equalTo(bgView.mas_centerX);
    }];
}
- (void)addTimer{
    // 移除定时器
    [self removeTimer];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}
- (void)playerStart:(NSString *)filePath{
    if (!filePath || filePath.length <= 0) {
        NSLog(@"无效的文件");
        return;
    }
    // 移除监听器
    [self removeObserver];
    
    // 设置为扬声器播放
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    // 设置播放的url
    
    NSURL *url = [NSURL fileURLWithPath:filePath];
    if ([filePath hasPrefix:@"http://"] || [filePath hasPrefix:@"https://"]) {
//        NSString *urlStr = [filePath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSString *urlStr = [NSString byAddingAllCharactersStr:filePath];
        url = [NSURL URLWithString:urlStr];
    }
    // 设置播放的项目
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:url];
    if (self.player == nil) {
        self.player = [[AVPlayer alloc] init];
    }
    [self.player replaceCurrentItemWithPlayerItem:playerItem];
    
    if (@available(iOS 10.0, *)) {
        self.player.automaticallyWaitsToMinimizeStalling = NO;
    } else {
        
    }
    
    [self.player play];
    
    // 添加监听器
    [self addObserver];
}
// 更新时间
-(void) timerAction{
    self.index ++;
    self.timerLab.text = [self getMMSSFromExamTotalTime:self.index];
}
//传入 秒  得到 xx:xx:xx
-(NSString *)getMMSSFromExamTotalTime:(NSInteger )totalTime{
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",totalTime/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",totalTime%60];
    NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    return format_time;
}
// 点击播放
-(void) selectPlayBtn:(UIButton *) sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self playerStart:self.filePath];
    }else{
        [self removeTimer];
        [self.player pause];
    }
}
// 移除定时器
-(void) removeTimer{
    self.timerLab.text = @"00:00";
    self.index = 0;
    [_timer invalidate];
    _timer = nil;
}
// 关闭view
-(void)selectTap{
    [self playFinish];
    [self removeObserver];
    [self removeFromSuperview];
}
// 播放完成
- (void)playFinish{
    self.palyBtn.selected = NO;
    [self removeTimer];
    [self.player pause];
}
// 播放暂停
-(void)timeOutPlay{
    if (self.player.rate != 0){
        [self.player pause];
        // 定时器暂停
        [_timer setFireDate:[NSDate distantFuture]];
    }
}
// 继续播放
-(void)continuePlaye {
    if (self.player.rate == 0) {
        [self.player play];
        // 定时器继续
        [_timer setFireDate:[NSDate distantPast]];
    }
}

-(void)setFilePath:(NSString *)filePath{
    _filePath = filePath;
}
- (void)addObserver{
    // KVO
    // KVO来观察status属性的变化
    [self.player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    // KVO监测加载情况
    [self.player.currentItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
    // 通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playFinish) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        // 取出status的新值
        AVPlayerItemStatus status = [change[NSKeyValueChangeNewKey] intValue];
        switch (status) {
            case AVPlayerItemStatusFailed: {
               //item 有误
              [self showErrorWithTitle:@"播放失败！" autoCloseTime:0.5];
            } break;
            case AVPlayerItemStatusReadyToPlay: {
              //准好播放了
                // 添加定时器
                [self addTimer];
            } break;
            case AVPlayerItemStatusUnknown: {
                //视频资源出现未知错误
                [self showErrorWithTitle:@"播放失败！" autoCloseTime:0.5];
            } break;
            default: break;
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
//        NSArray *array = self.player.currentItem.loadedTimeRanges;
//        // 本次缓冲的时间范围
//        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];
//        // 缓冲总长度
//        NSTimeInterval totalBuffer = CMTimeGetSeconds(timeRange.start) + CMTimeGetSeconds(timeRange.duration);
//        // 音乐的总时间
//        NSTimeInterval duration = CMTimeGetSeconds(self.player.currentItem.duration);
//        // 计算缓冲百分比例
//        NSTimeInterval scale = totalBuffer / duration;
    }
}
// 移除监听
- (void)removeObserver{
    [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    [self.player.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}
@end
