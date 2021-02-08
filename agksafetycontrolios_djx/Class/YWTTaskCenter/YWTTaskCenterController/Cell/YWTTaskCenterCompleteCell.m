//
//  TaskCenterCompleteCell.m
//  PartyBuildingStar
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import "YWTTaskCenterCompleteCell.h"

#import "STTagsView.h"
#import "STTagFrame.h"

@interface YWTTaskCenterCompleteCell ()
// 背景view
@property (nonatomic,strong) UIView *bgView;
// 任务标题
@property (nonatomic,strong) UILabel *taskTitleLab;
// 任务状态ImageV
@property (nonatomic,strong) UIImageView *taskStatuImageV;
// 进度条
@property (nonatomic,strong) UIProgressView *progressView;
// 显示进度lab
@property (nonatomic,strong) UILabel *showPressLab;
// 时段
@property (nonatomic,strong) UILabel *timeSlotLab;
// 说明
@property (nonatomic,strong) UILabel *taskMarkLab;
// 标签view
@property (nonatomic,strong) STTagsView *tagView;
// 锁定状态
@property (nonatomic,strong) UIView *lockStatuView;

@end

@implementation YWTTaskCenterCompleteCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCompleteView];
    }
    return self;
}
-(void) createCompleteView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    self.bgView = [[UIView alloc]init];
    [self addSubview:self.bgView];
    self.bgView.backgroundColor  = [UIColor colorTextWhiteColor];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(6);
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
        make.bottom.equalTo(weakSelf).offset(-KSIphonScreenH(6));
    }];
    self.bgView.layer.cornerRadius = 8;
    self.bgView.layer.masksToBounds = YES;
    
    // 任务标题
    self.taskTitleLab = [[UILabel alloc]init];
    [self.bgView addSubview:self.taskTitleLab];
    self.taskTitleLab.text = @"";
    self.taskTitleLab.textColor = [UIColor colorCommonBlackColor];
    self.taskTitleLab.font = BFont(20);
    self.taskTitleLab.numberOfLines = 0;
    self.taskTitleLab.lineBreakMode = UILineBreakModeCharacterWrap;

    // 任务状态图片
    self.taskStatuImageV  = [[UIImageView alloc]init];
    [self.bgView addSubview:self.taskStatuImageV];
    self.taskStatuImageV.image = [UIImage imageNamed:@"taskCenter_listCell_Complete"];
    [self.taskStatuImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(weakSelf.bgView);
    }];
   
    // 显示进度lab
    self.showPressLab = [[UILabel alloc]init];
    [self.bgView addSubview:self.showPressLab];
    self.showPressLab.text  =@"0%";
    self.showPressLab.textColor  = [UIColor colorCommonBlackColor];
    self.showPressLab.font = BFont(14);
    [self.showPressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.taskTitleLab.mas_bottom).offset(KSIphonScreenH(10));
        make.right.equalTo(weakSelf.bgView).offset(-KSIphonScreenW(12));
    }];
    
    // 进度条
    self.progressView = [[UIProgressView alloc]init];
    [self.bgView addSubview:self.progressView];
    // 设置进度条的颜色
    self.progressView.trackTintColor = [UIColor colorWithHexString:@"#e9e9e9"];
    //设置进度条的颜色
    self.progressView.progressTintColor = [UIColor colorWithHexString:@"#ffa303"];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView).offset(KSIphonScreenW(12));
        make.right.equalTo(weakSelf.showPressLab.mas_left).offset(-KSIphonScreenW(10));
        make.height.equalTo(@6);
        make.centerY.equalTo(weakSelf.showPressLab.mas_centerY);
    }];
    self.progressView.progress = 0.5;
    self.progressView.layer.cornerRadius = 3;
    self.progressView.layer.masksToBounds = YES;
    
    // 时段
    self.timeSlotLab = [[UILabel alloc]init];
    [self.bgView addSubview:self.timeSlotLab];
    self.timeSlotLab.text = @"时段:";
    self.timeSlotLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.timeSlotLab.font = Font(14);
    [self.timeSlotLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.progressView.mas_bottom).offset(KSIphonScreenH(15));
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
    
}
-(void)setModel:(TaskCenterListModel *)model{
    _model = model;
   
    // 任务标题
    NSString *titleStr = [NSString stringWithFormat:@"%@",model.title];
    self.taskTitleLab.text = titleStr;
    // 进度条
    NSString *carryOutStr = [NSString stringWithFormat:@"%@",model.carryOut];
    self.progressView.progress = [carryOutStr floatValue]/100;
    // 显示进度lab
    self.showPressLab.text = [NSString stringWithFormat:@"%@%%",carryOutStr];
    // 时段
    self.timeSlotLab.text =[NSString stringWithFormat:@"时段: %@",model.period];
    // 说明 没有说明，就隐藏
    NSString *descrStr = [NSString stringWithFormat:@"%@",model.descr];
    if ([descrStr isEqualToString:@""]) {
        self.taskMarkLab.hidden = YES;
    }else{
        self.taskMarkLab.hidden = NO;
        NSString *desceStr = [NSString stringWithFormat:@"说明: %@",model.descr];
        self.taskMarkLab.text = desceStr;
    }
    
    WS(weakSelf);
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
    [self.showPressLab mas_remakeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(weakSelf.tagView.mas_bottom).offset(KSIphonScreenH(10));
           make.right.equalTo(weakSelf.bgView).offset(-KSIphonScreenW(12));
    }];
    
    // 任务状态ImageV
    NSString *statusStr = [NSString stringWithFormat:@"%@",model.status];
    if ([statusStr isEqualToString:@"1"]) {
        // 进行中
        self.taskStatuImageV.image = [UIImage imageNamed:@"taskCenter_listCell_tasking"];
        self.taskTitleLab.textColor = [UIColor colorCommonBlackColor];
        self.progressView.progressTintColor = [UIColor colorWithHexString:@"#ffa303"];
        self.timeSlotLab.textColor = [UIColor colorCommonGreyBlackColor];
        self.taskMarkLab.textColor = [UIColor colorCommonGreyBlackColor];
    }else if ([statusStr isEqualToString:@"2"]){
        // 已完成
        self.taskStatuImageV.image = [UIImage imageNamed:@"taskCenter_listCell_Complete"];
        self.taskTitleLab.textColor = [UIColor colorCommonBlackColor];
        self.progressView.progressTintColor = [UIColor colorWithHexString:@"#ffa303"];
        self.timeSlotLab.textColor = [UIColor colorCommonGreyBlackColor];
        self.taskMarkLab.textColor = [UIColor colorCommonGreyBlackColor];
    }else if ([statusStr isEqualToString:@"3"]){
        // 未完成
        self.taskStatuImageV.image = [UIImage imageNamed:@"taskCenter_listCell_unComplete"];
        self.taskTitleLab.textColor = [UIColor colorWithHexString:@"#a7a7a7"];
        self.progressView.progressTintColor = [UIColor colorWithHexString:@"#a7a7a7"];
        self.tagView.textColor = [UIColor colorWithHexString:@"#a7a7a7"];
        self.tagView.borderColor = [UIColor colorWithHexString:@"#a7a7a7"];
        self.timeSlotLab.textColor = [UIColor colorWithHexString:@"#a7a7a7"];
        self.taskMarkLab.textColor = [UIColor colorWithHexString:@"#a7a7a7"];
    }else if ([statusStr isEqualToString:@"5"]){
        // 作废
        self.taskStatuImageV.image = [UIImage imageNamed:@"taskCenter_listCell_out"];
        self.taskTitleLab.textColor = [UIColor colorWithHexString:@"#a7a7a7"];
        self.progressView.progressTintColor = [UIColor colorWithHexString:@"#a7a7a7"];
        self.tagView.textColor = [UIColor colorWithHexString:@"#a7a7a7"];
        self.tagView.borderColor = [UIColor colorWithHexString:@"#a7a7a7"];
        self.timeSlotLab.textColor = [UIColor colorWithHexString:@"#a7a7a7"];
        self.taskMarkLab.textColor = [UIColor colorWithHexString:@"#a7a7a7"];
    }
    
    // 取消锁定状态 1有前置任务 2无前置任务
    NSString *relatedtaskStr = [NSString stringWithFormat:@"%@",model.relatedtask];
    if ([relatedtaskStr isEqualToString:@"2"]) {
        self.lockStatuView.hidden = YES;
    }else{
        self.lockStatuView.hidden = NO;
    }
}
// 计算高度
+(CGFloat) getWithCompleteCellHeight:(TaskCenterListModel *) model;{
    CGFloat heiht = KSIphonScreenH(17);
    // 标题
    NSString *titleStr = [NSString stringWithFormat:@"%@",model.title];
    CGFloat titleHight = [YWTTools getSpaceLabelHeight:titleStr withFont:20 withWidth:KScreenW-KSIphonScreenW(70) withSpace:2];
    heiht += titleHight;
    heiht += KSIphonScreenH(15);
    // 标签组
    NSArray *tagArr = model.tag;
    // 标签的高度
    STTagFrame * tagFrame = [STTagFrame tagFrameWithContentInsets:UIEdgeInsetsMake(0, 0, 0, 0) labelContentInsets:UIEdgeInsetsMake(2, 5, 2, 5) horizontalSpacing:5 verticalSpacing:5 textFont:[UIFont systemFontOfSize:11] tagArray:tagArr];
    tagFrame.width = KScreenW-KSIphonScreenW(55);
    tagFrame.tagsArray = tagArr.mutableCopy;
    heiht += tagFrame.height;
    heiht += KSIphonScreenH(17);
    // 进度条
    heiht += KSIphonScreenH(22);
    // 时段
    heiht += KSIphonScreenH(15);
    // 说明
    NSString *descrStr = [NSString stringWithFormat:@"%@",model.descr];
    if (![descrStr isEqualToString:@""]) {
        heiht += KSIphonScreenH(20);
    }
    heiht += KSIphonScreenH(25);
  
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
