//
//  YWTQuestResultContentCell.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/17.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTQuestResultContentCell.h"

@interface YWTQuestResultContentCell ()

@property (nonatomic,strong) UILabel *examRoomLab;

@property (nonatomic,strong) UILabel *examTimerLab;

@end


@implementation YWTQuestResultContentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createExamPaperView];
    }
    return self;
}
-(void)createExamPaperView{
    WS(weakSelf);
    self.backgroundColor = [UIColor colorTextWhiteColor];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    
    self.examRoomLab = [[UILabel alloc]init];
    [bgView addSubview:self.examRoomLab];
    self.examRoomLab.textColor = [UIColor colorCommonBlackColor];
    self.examRoomLab.font = BFont(18);
    self.examRoomLab.textAlignment = NSTextAlignmentCenter;
    self.examRoomLab.numberOfLines = 0;
    [self.examRoomLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView);
        make.left.equalTo(bgView).offset(KSIphonScreenW(12));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(12));
        make.centerX.equalTo(bgView.mas_centerX);
    }];
    
    self.examTimerLab = [[UILabel alloc]init];
    [bgView addSubview:self.examTimerLab];
    self.examTimerLab.textColor = [UIColor colorCommonBlackColor];
    self.examTimerLab.font = Font(13);
    self.examTimerLab.textAlignment = NSTextAlignmentCenter;
    [self.examTimerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.examRoomLab.mas_bottom).offset(KSIphonScreenH(23));
        make.centerX.equalTo(weakSelf.examRoomLab.mas_centerX);
    }];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.examRoomLab.mas_top);
        make.left.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.examRoomLab.mas_bottom);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
}

// 更新UI
-(void)updateResultCellData:(NSDictionary *)dict{
    
    self.examRoomLab.text = [NSString stringWithFormat:@"%@",dict[@"papertitle"]];
    // 时间
    self.examTimerLab.attributedText = [self getMMSSFromSS:[NSString stringWithFormat:@"%@",dict[@"examUserTotalTime"]]];;
}

//传入 秒  得到 xx:xx:xx
-(NSMutableAttributedString *)getMMSSFromSS:(NSString *)totalTime{
    NSInteger seconds = [totalTime integerValue];
    
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSMutableAttributedString *attriStr ;
    if ([str_hour isEqualToString:@"00"]) {
        NSString * format_time =[NSString stringWithFormat:@"本次调查用时%@",[NSString stringWithFormat:@" %@ 分 %@ 秒",str_minute,str_second]];
        attriStr = [self getAttrbuteContentStr:format_time andAlterHourStr:@"" andMinuteStr:str_minute andSecondStr:str_second];
        
    }else{
         NSString * format_time =[NSString stringWithFormat:@"本次调查用时%@",[NSString stringWithFormat:@" %@ 时 %@ 分 %@ 秒",str_hour,str_minute,str_second]];
        attriStr = [self getAttrbuteContentStr:format_time andAlterHourStr:str_hour andMinuteStr:str_minute andSecondStr:str_second];
    }
    return attriStr;
}

// UILabel 富文本
/*
 nameStr : 传入的文字
 colorStr   : 要想修改的文字
 */
-(NSMutableAttributedString *) getAttrbuteContentStr:(NSString *)contentStr andAlterHourStr:(NSString *)hourStr andMinuteStr:(NSString *)minuterStr andSecondStr:(NSString *)secondStr{
    NSMutableAttributedString  *attributStr = [[NSMutableAttributedString alloc]initWithString:contentStr];
    if ([hourStr isEqualToString:@""]) {
        NSRange range = NSMakeRange(7, minuterStr.length);
        if (range.location != NSNotFound) {
            // 设置颜色
            [attributStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorConstantCommonBlueColor] range:range];
            // 设置字体
            [attributStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:range];
        }
        NSRange secondRange = NSMakeRange(7+3+minuterStr.length, secondStr.length);
        if (secondRange.location != NSNotFound) {
            // 设置颜色
            [attributStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorConstantCommonBlueColor] range:secondRange];
            // 设置字体
            [attributStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:secondRange];
        }
        return attributStr;
    }else{
        NSRange range = NSMakeRange(7, hourStr.length);
        if (range.location != NSNotFound) {
            // 设置颜色
            [attributStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorConstantCommonBlueColor] range:range];
            // 设置字体
            [attributStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:range];
        }
        NSRange minuterRange = NSMakeRange(7+3+hourStr.length, minuterStr.length);
        if (minuterRange.location != NSNotFound) {
            // 设置颜色
            [attributStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorConstantCommonBlueColor] range:minuterRange];
            // 设置字体
            [attributStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:minuterRange];
        }
        NSRange secondRange = NSMakeRange(7+3+hourStr.length+3+minuterRange.length, secondStr.length);
        if (secondRange.location != NSNotFound) {
            // 设置颜色
            [attributStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorConstantCommonBlueColor] range:secondRange];
            // 设置字体
            [attributStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:secondRange];
        }
        return attributStr;
    }
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
