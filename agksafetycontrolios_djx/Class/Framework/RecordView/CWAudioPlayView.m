//
//  CWAudioPlayView.m
//  QQVoiceDemo
//
//  Created by 陈旺 on 2017/10/4.
//  Copyright © 2017年 陈旺. All rights reserved.
//

#import "CWAudioPlayView.h"
#import "UIView+CWChat.h"
#import "CWRecordStateView.h"
#import "CWAudioPlayer.h"
#import "CWRecordModel.h"
#import "CWRecorder.h"
#import "YWTCWVoiceView.h"

@interface CWAudioPlayView ()

@property (nonatomic, weak) CWRecordStateView *stateView;

@property (nonatomic, weak) UIButton *playButton;   // 播放按钮
@property (nonatomic, weak) UIButton *cancelButton; // 取消按钮
@property (nonatomic, weak) UIButton *sendButton;   // 发送按钮
// 播放音频工具view
@property (nonatomic,strong) UIView *playerToolView;

@end



@implementation CWAudioPlayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        _progressValue = 0.8;
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    
    self.backgroundColor = [UIColor whiteColor];
    [self stateView];
    [self playButton];
    [self setupSendButtonAndCancelButton];
    [self listenProgress]; // 监听进度
}

#pragma mark - subviews
- (UIButton *)playButton {
    if (_playButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"base_record_end"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"bae_record_recording"] forState:UIControlStateHighlighted];
        [btn setImage:[UIImage imageNamed:@"bae_record_recording"] forState:UIControlStateSelected];
        UIImage *image = [UIImage imageNamed:@"base_record_begin"];
        btn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        btn.center = CGPointMake(self.center.x, self.stateView.cw_bottom + image.size.width / 2);
        [btn addTarget:self action:@selector(playRecord) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _playButton = btn;
    }
    return _playButton;
}

- (CWRecordStateView *)stateView {
    if (_stateView == nil) {
        CWRecordStateView *stateView = [[CWRecordStateView alloc] initWithFrame:CGRectMake(0, 10, KScreenW, 50)];
        [self addSubview:stateView];
        stateView.recordState = CWRecordStatePreparePlay;
        _stateView = stateView;
    }
    return  _stateView;
}

- (void)setupSendButtonAndCancelButton {
    __weak typeof(self) weakSelf = self;
    // 播放音频工具view
    self.playerToolView = [[UIView alloc]init];
    [self addSubview:self.playerToolView];
    self.playerToolView.backgroundColor = [UIColor colorWithHexString:@"#e2e2e2"];
    [self.playerToolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf);
        make.height.equalTo(@(KSIphonScreenH(44)));
    }];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.playerToolView addSubview:cancelBtn];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorCommonBlackColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = Font(16);
    cancelBtn.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(weakSelf.playerToolView);
    }];
    [cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.cancelButton = cancelBtn;
    
    UIButton *trueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.playerToolView addSubview:trueBtn];
    [trueBtn setTitle:@"确认" forState:UIControlStateNormal];
    [trueBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    trueBtn.titleLabel.font = Font(16);
    trueBtn.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    [trueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cancelBtn.mas_right).offset(1);
        make.right.equalTo(weakSelf.playerToolView);
        make.width.height.equalTo(cancelBtn);
        make.centerY.equalTo(cancelBtn.mas_centerY);
    }];
    [trueBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.sendButton = trueBtn;

}

- (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font backImageNor:(NSString *)backImageNor backImageHighled:(NSString *)backImageHighled sel:(SEL)sel{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    btn.titleLabel.font = font;
    UIImage *newImageNor = [[UIImage imageNamed:backImageNor] stretchableImageWithLeftCapWidth:2 topCapHeight:2];
    UIImage *newImageHighled = [[UIImage imageNamed:backImageHighled] stretchableImageWithLeftCapWidth:2 topCapHeight:2];
    [btn setBackgroundImage:newImageNor forState:UIControlStateNormal];
    [btn setBackgroundImage:newImageHighled forState:UIControlStateHighlighted];
    [btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

#pragma mark - play/stop
- (void)playRecord {
    self.playButton.selected = !self.playButton.selected;
    if (self.playButton.selected) {
        self.stateView.recordState = CWRecordStatePlay;
        if (self.isListPlay) {
            [[CWAudioPlayer shareInstance] playAudioWith:self.listFliePath];
        }else{
           [[CWAudioPlayer shareInstance] playAudioWith:[CWRecordModel shareInstance].path];
        }
    }else {
        [self stopPlay];
    }
}

- (void)stopPlay {
    self.playButton.selected = NO;
    self.stateView.recordState = CWRecordStatePreparePlay;
    [[CWAudioPlayer shareInstance] stopCurrentAudio];
    _progressValue = 0;
    [self setNeedsDisplay];
    [self layoutIfNeeded];
}

- (void)btnClick:(UIButton *)btn {
    [self stopPlay];
    // 让屏幕自动锁屏
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    
    if (btn == self.sendButton) { // 发送
//        NSLog(@"发送...path: %@",[CWRecordModel shareInstance].path);
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        NSString *filePath =[NSString stringWithFormat:@"%@",[CWRecordModel shareInstance].path];
        NSData *fileData = [NSData dataWithContentsOfFile:filePath];
        NSArray *arr = [filePath componentsSeparatedByString:@"/"];
        NSString *fileName = [NSString stringWithFormat:@"%@/%@",arr[arr.count-2],[arr lastObject]];
        NSString *name = [NSString stringWithFormat:@"%@",[arr lastObject]];
        dict[@"typeName"]= [arr lastObject];
        dict[@"audio"] = [CWRecordModel shareInstance].path;
        dict[@"filePath"] = fileData;
        dict[@"objectKey"] = fileName;
        dict[@"name"] = name;
        dict[@"type"] = @"audio";
        dict[@"size"] = [NSNumber numberWithInteger:fileData.length];
        self.selectTureBtn(dict);
    }else {
//        NSLog(@"取消发送并删除录音");
//        NSLog(@"发送...path: %@",[CWRecordModel shareInstance].path);
        [[CWRecorder shareInstance] deleteRecord];
    }
    [self removeFromSuperview];
}

-(void)setIsListPlay:(BOOL)isListPlay{
    _isListPlay = isListPlay;
}
-(void)setListFliePath:(NSString *)listFliePath{
    _listFliePath = listFliePath;
}

#pragma mark 监听环形进度条更新
- (void)listenProgress {
    __weak typeof(self) weakSelf = self;
    self.stateView.playProgress = ^(CGFloat progress) {
        if (progress == 1) {
            progress = 0;
            [weakSelf stopPlay];
        }
        self->_progressValue = progress;
        [weakSelf setNeedsDisplay];
        [weakSelf layoutIfNeeded];
    };
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    UIImage *image = [UIImage imageNamed:@"aio_voice_button_nor"];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(ctx, 2.0f);
    
    CGContextSetStrokeColorWithColor(ctx, [UIColorFromRGBA(214, 219, 222, 1.0) CGColor]);
    CGContextAddArc(ctx, self.center.x, self.stateView.cw_bottom + image.size.width / 2, image.size.width / 2, 0, M_PI * 2, 0);
    CGContextStrokePath(ctx);
    
    CGContextSetStrokeColorWithColor(ctx, [kSelectBackGroudColor CGColor]);
    CGFloat startAngle = -M_PI_2;
    CGFloat angle = self.progressValue * M_PI * 2;
    CGFloat endAngle = startAngle + angle;
    CGContextAddArc(ctx, self.center.x, self.stateView.cw_bottom + image.size.width / 2, image.size.width / 2, startAngle, endAngle, 0);
    CGContextStrokePath(ctx);
    
}



@end
