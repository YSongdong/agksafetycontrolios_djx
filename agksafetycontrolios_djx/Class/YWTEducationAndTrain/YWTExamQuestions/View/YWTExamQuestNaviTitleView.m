//
//  ExamQuestNaviTitleView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/17.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTExamQuestNaviTitleView.h"

@interface YWTExamQuestNaviTitleView (){
    NSTimer *_timer;
}
@end

@implementation YWTExamQuestNaviTitleView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createNaviTitleView];
    }
    return self;
}
-(void) createNaviTitleView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorTextWhiteColor];
    self.layer.cornerRadius = CGRectGetHeight(self.frame)/2;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1;
    self.layer.borderColor  = [UIColor colorTextWhiteColor].CGColor;
    
    // 显示倒计时
    self.showTimerBtn = [[UIButton alloc]init];
    [self addSubview:self.showTimerBtn];
    [self.showTimerBtn setTitle:@"  00:00:00" forState:UIControlStateNormal];
    [self.showTimerBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    [self.showTimerBtn setImage:[UIImage imageNamed:@"sjlx_nav_ico_time-1"] forState:UIControlStateNormal];
    self.showTimerBtn.titleLabel.font = Font(13);
    self.showTimerBtn.backgroundColor = [UIColor colorLineCommonBlueColor];
    [self.showTimerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf);
    }];
    self.showTimerBtn.userInteractionEnabled = NO;

    //立即交卷
    UIButton *immedSubmitBtn = [[UIButton alloc]init];
    [self addSubview:immedSubmitBtn];
    [immedSubmitBtn setTitle:@"立即交卷" forState:UIControlStateNormal];
    [immedSubmitBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    immedSubmitBtn.titleLabel.font = Font(13);
    immedSubmitBtn.backgroundColor = [UIColor colorLineCommonBlueColor];
    [immedSubmitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.showTimerBtn.mas_right).offset(1);
        make.right.equalTo(weakSelf);
        make.width.height.equalTo(weakSelf.showTimerBtn);
        make.centerY.equalTo(weakSelf.showTimerBtn.mas_centerY);
    }];
    [immedSubmitBtn addTarget:self action:@selector(selectImmedSubmitBtn:) forControlEvents:UIControlEventTouchUpInside];
}
// 到时间立即交卷
-(void) selectImmedSubmitBtn:(UIButton *) sender{
    self.immedSubmitBlock();
}
#pragma mark - - - NSTimer --------
- (void)addTimer {
    [self removeTimer];
    
    _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(beginUpdateUI) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
- (void)removeTimer {
    [_timer invalidate];
    _timer = nil;
}
- (void)beginUpdateUI {
    if (_totalInterval == 0) {
        [self removeTimer];
        return;
    }
    _totalInterval -= 1;
    
    if (_totalInterval == 0) {
        [self.showTimerBtn setTitle:@"00:00:00" forState:UIControlStateNormal];
        // 移除定时器
        [self removeTimer];
        // 立即交卷
        self.timeToBlock();
    }else{
        NSString *timesTampStr = [NSString stringWithFormat:@"%f",_totalInterval];
        NSString *dateStr =[NSString stringWithFormat:@" %@",[self getMMSSFromSS:timesTampStr]];
        [self.showTimerBtn setTitle:dateStr forState:UIControlStateNormal];
        
        // 当前剩余时间是3分钟 弹提示框
        NSInteger seconds = [timesTampStr integerValue];
        if (seconds == 3*60) {
            self.bulletBoxBlock();
        }
    }
}
//传入 秒  得到 xx:xx:xx
-(NSString *)getMMSSFromSS:(NSString *)totalTime{
    
    NSInteger seconds = [totalTime integerValue];
    
    NSString *str_day = [NSString stringWithFormat:@"%02ld",seconds/(3600*24)];
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600-(seconds/(3600*24)*24)];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time;
    if ([str_day isEqualToString:@"00"]) {
        format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    }else{
        format_time = [NSString stringWithFormat:@"%@:%@:%@:%@",str_day,str_hour,str_minute,str_second];
    }
    return format_time;
}

-(void)setTotalInterval:(NSTimeInterval)totalInterval{
    _totalInterval = totalInterval;
    if (totalInterval) {
        [self addTimer];
    }
}



@end
