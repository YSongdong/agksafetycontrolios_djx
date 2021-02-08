//
//  YWTDetailContentCell.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/19.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTDetailContentCell.h"

@interface YWTDetailContentCell ()

// 发起时间lab
@property (nonatomic,strong) UILabel *initiateTimeLab;
// 发起内容
@property (nonatomic,strong) UILabel *initiateContentLab;
//
@property (nonatomic,strong) UIView *replyBgView;
// 回复时间
@property (nonatomic,strong) UILabel *replyTimeLab;
// 回复内容
@property (nonatomic,strong) UILabel *replyContentLab;

@end


@implementation YWTDetailContentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createDetailCell];
    }
    return self;
}
-(void) createDetailCell{
    WS(weakSelf);
    self.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    // 发起时间lab
    self.initiateTimeLab = [[UILabel alloc]init];
    [self addSubview:self.initiateTimeLab];
    self.initiateTimeLab.text = @"发起时间:";
    self.initiateTimeLab.textColor = [UIColor colorWithHexString:@"#999999"];
    self.initiateTimeLab.font = Font(12);
    [self.initiateTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(KSIphonScreenH(30));
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(70));
    }];
    // 发起小背景view
    UIView *initiateBgView = [[UIView alloc]init];
    [self addSubview:initiateBgView];
    initiateBgView.backgroundColor = [UIColor colorWithHexString:@"#5c779f"];
    [initiateBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.initiateTimeLab.mas_left).offset(-KSIphonScreenW(12));
        make.top.equalTo(weakSelf.initiateTimeLab.mas_top);
        make.width.height.equalTo(@9);
    }];
    initiateBgView.layer.cornerRadius = 9/2;
    initiateBgView.layer.masksToBounds = YES;
    
    // 发起内容
    self.initiateContentLab = [[UILabel alloc]init];
    [self addSubview:self.initiateContentLab];
    self.initiateContentLab.text = @"";
    self.initiateContentLab.textColor = [UIColor colorCommonBlackColor];
    self.initiateContentLab.font = BFont(16);
    self.initiateContentLab.numberOfLines  =0;
    [self.initiateContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.initiateTimeLab.mas_bottom).offset(KSIphonScreenH(10));
        make.left.equalTo(weakSelf.initiateTimeLab.mas_left);
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(40));
    }];
    
    //
    self.replyBgView = [[UIView alloc]init];
    [self addSubview:self.replyBgView];
    self.replyBgView.backgroundColor = [UIColor colorWithHexString:@"#b1b1b1"];
    [self.replyBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.initiateContentLab.mas_bottom).offset(KSIphonScreenH(30));
        make.centerX.equalTo(initiateBgView.mas_centerX);
        make.width.height.equalTo(initiateBgView);
    }];
    self.replyBgView.layer.cornerRadius = 9/2;
    self.replyBgView.layer.masksToBounds = YES;
    
    // 回复时间
    self.replyTimeLab = [[UILabel alloc]init];
    [self addSubview:self.replyTimeLab];
    self.replyTimeLab.text = @"";
    self.replyTimeLab.textColor = [UIColor colorWithHexString:@"#999999"];
    self.replyTimeLab.font = Font(12);
    [self.replyTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.replyBgView.mas_top);
        make.left.equalTo(weakSelf.initiateTimeLab.mas_left);
    }];

    // 发起内容
    self.replyContentLab = [[UILabel alloc]init];
    [self addSubview:self.replyContentLab];
    self.replyContentLab.text = @"";
    self.replyContentLab.textColor = [UIColor colorCommonBlackColor];
    self.replyContentLab.font = BFont(16);
    self.replyContentLab.numberOfLines  =0;
    [self.replyContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.replyTimeLab.mas_bottom).offset(KSIphonScreenH(10));
        make.left.equalTo(weakSelf.replyTimeLab.mas_left);
        make.right.equalTo(weakSelf.initiateContentLab.mas_right);
    }];

    UIView *lineView = [[UIView alloc]init];
    [self addSubview:lineView];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#dddddd"];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(initiateBgView.mas_bottom);
        make.bottom.equalTo(weakSelf.replyBgView.mas_top);
        make.width.equalTo(@1.5);
        make.centerX.equalTo(initiateBgView.mas_centerX);
    }];
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
#pragma mark -----  发起 --------------
    NSString *startTimeStr = [NSString stringWithFormat:@"发起时间: %@",dict[@"starttime"]];
    self.initiateTimeLab.text = startTimeStr;
    // 意见内容
    self.initiateContentLab.text = [NSString stringWithFormat:@"%@",dict[@"content"]];
    WS(weakSelf);
 #pragma mark ----- 回复  --------------
    NSString *replyscontentStr = [NSString stringWithFormat:@"%@",dict[@"replyscontent"]];
    if ([replyscontentStr isEqualToString:@""]) {
        /*- ------------ 暂无回复 -------------------*/
        // 隐藏
        self.replyTimeLab.hidden = YES;
        // 暂无回复
        self.replyContentLab.text = @"暂无回复";
        self.replyContentLab.textColor = [UIColor colorWithHexString:@"#999999"];
        [self.replyContentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
               make.centerY.equalTo(weakSelf.replyBgView.mas_centerY);
               make.left.equalTo(weakSelf.initiateTimeLab.mas_left);
        }];
        self.replyBgView.backgroundColor = [UIColor colorWithHexString:@"#b1b1b1"];
    }else{
        // 显示
        self.replyTimeLab.hidden = NO;
        self.replyTimeLab.text = [NSString stringWithFormat:@"回复时间: %@",dict[@"replystime"]];
        [self.replyTimeLab mas_remakeConstraints:^(MASConstraintMaker *make) {
               make.top.equalTo(weakSelf.replyBgView.mas_top);
               make.left.equalTo(weakSelf.initiateTimeLab.mas_left);
           }];
        // 回复
        self.replyContentLab.text = replyscontentStr;
        self.replyContentLab.textColor = [UIColor colorCommonBlackColor];
        [self.replyContentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.replyTimeLab.mas_bottom).offset(KSIphonScreenH(10));
            make.left.equalTo(weakSelf.replyTimeLab.mas_left);
            make.right.equalTo(weakSelf.initiateContentLab.mas_right);
        }];
        self.replyBgView.backgroundColor = [UIColor colorWithHexString:@"#5c779f"];
    }
}

// 计算高度
+(CGFloat) getWithDetailConntentCellHeight:(NSDictionary *)dict{
    CGFloat height = 0;
    /* ------------ 发起  --------------*/
    height += KSIphonScreenH(30);
    
    height += 20;
    // 上文空间
    height += KSIphonScreenH(10);
    // 发布内容
    NSString *initiateStr = [NSString stringWithFormat:@"%@",dict[@"content"]];
    CGFloat initiateHeight =[YWTTools getLabelHeightWithText:initiateStr width:KScreenW-KSIphonScreenW(110) font:16];
    height += initiateHeight;
    
    /* ------------ 回复  --------------*/
    NSString *replyscontentStr = [NSString stringWithFormat:@"%@",dict[@"replyscontent"]];
    if ([replyscontentStr isEqualToString:@""]) {
        // 下文空隙
        height += KSIphonScreenH(30);
        
        CGFloat replyHeight = [YWTTools getLabelHeightWithText:@"暂未回复" width:KScreenW-KSIphonScreenW(110) font:16];
        height += replyHeight;
        
        height += 20;
        
        return height;
    }
    
    // 有回复内容的
    height += 20;
    
    CGFloat replyHeight = [YWTTools getLabelHeightWithText:replyscontentStr width:KScreenW-KSIphonScreenW(110) font:17];
    height += replyHeight;
           
    height += 30;

    return height;
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
