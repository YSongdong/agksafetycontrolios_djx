//
//  TaskCenterUnStartedCell.m
//  PartyBuildingStar
//
//  Created by mac on 2019/4/17.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import "YWTTaskCenterUnStartedCell.h"

#import "STTagsView.h"
#import "STTagFrame.h"

@interface YWTTaskCenterUnStartedCell ()
// 背景view
@property (nonatomic,strong) UIView *bgView;
// 倒计时背景view
@property (nonatomic,strong) UIView *countDownView;
// 任务标题
@property (nonatomic,strong) UILabel *taskTitleLab;
// 时段
@property (nonatomic,strong) UILabel *timeSlotLab;
// 说明
@property (nonatomic,strong) UILabel *taskMarkLab;
// 显示倒计时
@property (nonatomic,strong) UILabel *showCountDownLab;
// 标签view
@property (nonatomic,strong) STTagsView *tagView;
// 锁定状态
@property (nonatomic,strong) UIView *lockStatuView;

@end


@implementation YWTTaskCenterUnStartedCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUnStartView];
    }
    return self;
}
-(void) createUnStartView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    self.bgView = [[UIView alloc]init];
    [self addSubview:self.bgView];
    self.bgView.backgroundColor  = [UIColor colorTextWhiteColor];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(KSIphonScreenH(6));
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
        make.bottom.equalTo(weakSelf).offset(-KSIphonScreenH(6));
    }];
    self.bgView.layer.cornerRadius = 8;
    self.bgView.layer.masksToBounds = YES;
   
    // 任务标题
    self.taskTitleLab = [[UILabel alloc]init];
    [self.bgView addSubview:self.taskTitleLab];
    self.taskTitleLab.text = @"我我问佛问问哦我服务网";
    self.taskTitleLab.textColor = [UIColor colorCommonBlackColor];
    self.taskTitleLab.font = BFont(20);
    self.taskTitleLab.numberOfLines = 0;
    self.taskTitleLab.lineBreakMode = UILineBreakModeCharacterWrap;
    
    // 状态图片
    UIImageView *statuImageV = [[UIImageView alloc]init];
    [self.bgView addSubview:statuImageV];
    statuImageV.image = [UIImage imageNamed:@"taskCenter_cell_unStart"];
    [statuImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(weakSelf.bgView);
    }];
    
    
    // 时段
    self.timeSlotLab = [[UILabel alloc]init];
    [self.bgView addSubview:self.timeSlotLab];
    self.timeSlotLab.text = @"时段:";
    self.timeSlotLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.timeSlotLab.font = Font(14);
    [self.timeSlotLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.taskTitleLab.mas_bottom).offset(KSIphonScreenH(10));
        make.left.equalTo(weakSelf.taskTitleLab.mas_left);
        make.right.equalTo(weakSelf.bgView).offset(-KSIphonScreenW(12));
    }];
  
    // 说明
    self.taskMarkLab = [[UILabel alloc]init];
    [self.bgView addSubview:self.taskMarkLab];
    self.taskMarkLab.text = @"说明:";
    self.taskMarkLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.taskMarkLab.font = Font(14);
    [self.taskMarkLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.timeSlotLab.mas_bottom).offset(KSIphonScreenH(10));
        make.left.equalTo(weakSelf.timeSlotLab);
        make.right.equalTo(weakSelf.bgView).offset(-KSIphonScreenW(12));
    }];
    
    self.countDownView = [[UIView alloc]init];
    [self.bgView addSubview:self.countDownView];
    [self.countDownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.taskMarkLab.mas_bottom).offset(KSIphonScreenH(16));
        make.left.equalTo(weakSelf.bgView).offset(KSIphonScreenW(73));
        make.right.equalTo(weakSelf.bgView).offset(-KSIphonScreenW(73));
        make.height.equalTo(@(KSIphonScreenH(33)));
    }];
    self.countDownView.layer.cornerRadius = 5;
    self.countDownView.layer.masksToBounds = YES;
    self.countDownView.layer.borderWidth = 1;
    self.countDownView.layer.borderColor = [UIColor colorLineCommonBlueColor].CGColor;
    
    UIView *conutdownCententView = [[UIView alloc]init];
    [self.countDownView addSubview:conutdownCententView];
    
    self.showCountDownLab = [[UILabel alloc]init];
    [conutdownCententView addSubview:self.showCountDownLab];
    self.showCountDownLab.text = @"开始还剩1天0时0分0秒";
    self.showCountDownLab.textColor = [UIColor colorLineCommonBlueColor];
    self.showCountDownLab.font = Font(13);
    [self.showCountDownLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(conutdownCententView);
        make.centerY.equalTo(conutdownCententView.mas_centerY);
    }];
    
    UIImageView *countdownImageV = [[UIImageView alloc]init];
    [conutdownCententView addSubview:countdownImageV];
    countdownImageV.image = [UIImage imageNamed:@"ico_time"];
    countdownImageV.contentMode = UIViewContentModeScaleAspectFit;
    [countdownImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.showCountDownLab.mas_left).offset(-KSIphonScreenW(5));
        make.centerY.equalTo(weakSelf.showCountDownLab.mas_centerY);
    }];
    
    [conutdownCententView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(countdownImageV.mas_left);
        make.right.equalTo(weakSelf.showCountDownLab.mas_right);
        make.bottom.top.equalTo(weakSelf.showCountDownLab);
        make.centerY.equalTo(weakSelf.countDownView.mas_centerY);
        make.centerX.equalTo(weakSelf.countDownView.mas_centerX);
    }];
    
    // 锁定图片
    self.lockStatuView = [[UIView alloc]init];
    [self addSubview:self.lockStatuView];
    [self.lockStatuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.bgView);
    }];
    
    UIImageView  *lockStatuImageV = [[UIImageView alloc]init];
    [self.lockStatuView addSubview:lockStatuImageV];
    lockStatuImageV.image = [UIImage imageNamed:@"taskCenter_frostGlass_cellBg"];
    lockStatuImageV.contentMode = UIViewContentModeRedraw;
    [lockStatuImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.lockStatuView);
    }];
    
    UIImageView *lockImageV = [[UIImageView alloc]init];
    [self.lockStatuView addSubview:lockImageV];
    lockImageV.image = [UIImage imageNamed:@"task_lockImageV"];
    lockImageV.contentMode = UIViewContentModeScaleAspectFit;
    [lockImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.lockStatuView.mas_centerX);
        make.centerY.equalTo(weakSelf.lockStatuView.mas_centerY);
    }];
    
    // 监听通知
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownNotification) name:OYCountDownNotification object:nil];
}
-(void)setModel:(TaskCenterListModel *)model{
    _model = model;
 
    // 任务标题
    NSString *titleStr = [NSString stringWithFormat:@"%@",model.title];
    self.taskTitleLab.text = titleStr;
    // 时段
    self.timeSlotLab.text =[NSString stringWithFormat:@"时段: %@",model.period];
    // 说明 没有说明，就隐藏
    NSString *descrStr = [NSString stringWithFormat:@"%@",model.descr];
    __weak typeof(self) weakSelf = self;
    if ([descrStr isEqualToString:@""]) {
        self.taskMarkLab.hidden = YES;
        // 重新更新倒计时view的约束
        [self.countDownView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.timeSlotLab.mas_bottom).offset(KSIphonScreenH(16));
            make.left.equalTo(weakSelf.bgView).offset(KSIphonScreenW(73));
            make.right.equalTo(weakSelf.bgView).offset(-KSIphonScreenW(73));
            make.height.equalTo(@(KSIphonScreenH(33)));
        }];
    }else{
        self.taskMarkLab.hidden = NO;
        NSString *desceStr = [NSString stringWithFormat:@"说明: %@",model.descr];
        self.taskMarkLab.text = desceStr;
    }
    
    // 更新UI
    CGFloat titleHight = [YWTTools getSpaceLabelHeight:titleStr withFont:20 withWidth:KScreenW-KSIphonScreenW(50) withSpace:2];
    self.taskTitleLab.frame = CGRectMake(KSIphonScreenW(12), 23, KScreenW-KSIphonScreenW(24)-KSIphonScreenW(65), titleHight);
    
    // 移除 之前的标签view
    [self.tagView removeFromSuperview];
    
    // 重新加载标签view
    self.tagView = [STTagsView tagViewWithFrame:CGRectMake(KSIphonScreenW(8), CGRectGetMaxY(self.taskTitleLab.frame)+KSIphonScreenH(10), KScreenW-KSIphonScreenW(20)-KSIphonScreenW(37), 0) tagsArray:@[] textColor:[UIColor colorTextWhiteColor] textFont:Font(11) normalTagBackgroundColor:[UIColor colorTextWhiteColor] tagBorderColor:[UIColor colorTextWhiteColor] contentInsets:UIEdgeInsetsMake(2, 5, 2, 5) labelContentInsets:UIEdgeInsetsMake(2, 5, 2, 5) labelHorizontalSpacing:5 labelVerticalSpacing:5];
    self.tagView.isTaskCenter = YES;
    [self.bgView addSubview:self.tagView];
     
    // 标签组
    NSArray *tagArr = model.tag;
    // 赋值
    self.tagView.tagsList = [NSMutableArray arrayWithArray:tagArr];
    // 重新赋标题颜色
    [self.tagView getWithAgainTiTleColor];
    
    // 更新UI
    [self.timeSlotLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.tagView.mas_bottom).offset(KSIphonScreenH(10));
        make.left.equalTo(weakSelf.taskTitleLab.mas_left);
        make.right.equalTo(weakSelf.bgView).offset(-KSIphonScreenW(12));
    }];
    
    // 取消锁定状态 1有前置任务 2无前置任务
    NSString *relatedtaskStr = [NSString stringWithFormat:@"%@",model.relatedtask];
    if ([relatedtaskStr isEqualToString:@"2"]) {
        self.lockStatuView.hidden = YES;
    }else{
        self.lockStatuView.hidden = NO;
    }
    // 手动调用通知的回调
    [self countDownNotification];
 
}
#pragma mark - 倒计时通知回调
- (void)countDownNotification {
    
    TaskCenterListModel *model = self.model;
    
    /// 计算倒计时
    NSInteger timeInterval=kCountDownManager.timeInterval;
    
    NSInteger countDown = [model.remTime integerValue] - timeInterval;
    /// 当倒计时到了进行回调
    if (countDown <= 0) {

        return;
    }

    NSString *timeStr =  [NSString stringWithFormat:@"%ld",(long)countDown];
    self.showCountDownLab.text = [NSString stringWithFormat:@"距开始剩 %@", [self getMMSSFromSS:timeStr]];
    self.showCountDownLab.textColor = [UIColor colorLineCommonBlueColor];
    
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
        format_time = [NSString stringWithFormat:@"%@时%@分%@秒",str_hour,str_minute,str_second];
    }else{
        format_time = [NSString stringWithFormat:@"%@天%@时%@分%@秒",str_day,str_hour,str_minute,str_second];
    }
    return format_time;
}

// 计算高度
+(CGFloat) getWithCompleteCellHeight:(TaskCenterListModel *) model;{
    CGFloat heiht = KSIphonScreenH(17);
    // 标题
    NSString *titleStr = [NSString stringWithFormat:@"%@",model.title];
    CGFloat titleHight = [YWTTools getSpaceLabelHeight:titleStr withFont:20 withWidth:KScreenW-KSIphonScreenW(70) withSpace:2];
    heiht += titleHight;

    // 标签组
    NSArray *tagArr = model.tag;
    // 标签的高度
    STTagFrame * tagFrame = [STTagFrame tagFrameWithContentInsets:UIEdgeInsetsMake(0, 0, 0, 0) labelContentInsets:UIEdgeInsetsMake(2, 5, 2, 5) horizontalSpacing:5 verticalSpacing:5 textFont:[UIFont systemFontOfSize:11] tagArray:tagArr];
    tagFrame.width = KScreenW-KSIphonScreenW(55) ;
    tagFrame.tagsArray = tagArr.mutableCopy;
    heiht += tagFrame.height;
    heiht += KSIphonScreenH(10);
    // 进度条
    heiht += KSIphonScreenH(22);
    // 时段
    heiht += KSIphonScreenH(10);
    // 说明
    NSString *descrStr = [NSString stringWithFormat:@"%@",model.descr];
    if (![descrStr isEqualToString:@""]) {
        heiht += KSIphonScreenH(17);
    }
    heiht += KSIphonScreenH(35);

    heiht += KSIphonScreenH(33);

    heiht += KSIphonScreenH(10);
    
    return heiht;
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
