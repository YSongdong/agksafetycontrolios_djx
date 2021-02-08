//
//  SafetyChenkUserInfoCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/11.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTSafetyChenkUserInfoCell.h"

@interface YWTSafetyChenkUserInfoCell ()
// 显示检查人
@property (nonatomic,strong) UILabel *showChenkNameLab;

@property (nonatomic,strong) UILabel *chenkNameLab;
//
@property (nonatomic,strong) UILabel *showChenkTimerLab;

@property (nonatomic,strong) UILabel *chenkTimerLab;

@end



@implementation YWTSafetyChenkUserInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUserInfoView];
    }
    return self;
}

-(void) createUserInfoView{
    __weak typeof(self) weakSelf = self;
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    UIView *infoView = [[UIView alloc]init];
    [bgView addSubview:infoView];
    infoView.backgroundColor = [UIColor colorTextWhiteColor];
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(KSIphonScreenH(12));
        make.left.equalTo(bgView).offset(KSIphonScreenW(12));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(12));
        make.bottom.equalTo(bgView);
    }];
    infoView.layer.cornerRadius = 8;
    infoView.layer.masksToBounds = YES;
    infoView.layer.borderWidth = 1;
    infoView.layer.borderColor = [UIColor colorWithHexString:@"#e5e5e5"].CGColor;
    
    
    UIView *contentView = [[UIView alloc]init];
    [infoView addSubview:contentView];
    
    self.showChenkNameLab = [[UILabel alloc]init];
    [contentView addSubview:self.showChenkNameLab];
    self.showChenkNameLab.text = @"检查人:";
    self.showChenkNameLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.showChenkNameLab.font = Font(14);
    [self.showChenkNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(contentView);
    }];
    
    self.chenkNameLab = [[UILabel alloc]init];
    [contentView addSubview:self.chenkNameLab];
    self.chenkNameLab.text = @"";
    self.chenkNameLab.textColor = [UIColor colorCommonBlackColor];
    self.chenkNameLab.font = Font(14);
    [self.chenkNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.showChenkNameLab.mas_right).offset(KSIphonScreenW(5));
        make.centerY.equalTo(weakSelf.showChenkNameLab.mas_centerY);
    }];
    
    self.showChenkTimerLab = [[UILabel alloc]init];
    [contentView addSubview:self.showChenkTimerLab];
    self.showChenkTimerLab.text = @"检查时间:";
    self.showChenkTimerLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.showChenkTimerLab.font = Font(14);
    [self.showChenkTimerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.showChenkNameLab.mas_bottom).offset(KSIphonScreenH(10));
        make.left.equalTo(weakSelf.showChenkNameLab.mas_left);
    }];
    
    self.chenkTimerLab = [[UILabel alloc]init];
    [contentView addSubview:self.chenkTimerLab];
    self.chenkTimerLab.text = @"";
    self.chenkTimerLab.textColor = [UIColor colorCommonBlackColor];
    self.chenkTimerLab.font = Font(14);
    [self.chenkTimerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.showChenkTimerLab.mas_right).offset(KSIphonScreenW(5));
        make.centerY.equalTo(weakSelf.showChenkTimerLab.mas_centerY);
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.showChenkNameLab.mas_top);
        make.left.equalTo(infoView).offset(KSIphonScreenW(15));
        make.bottom.equalTo(weakSelf.showChenkTimerLab.mas_bottom);
        make.right.equalTo(infoView).offset(-KSIphonScreenW(15));
        make.centerX.equalTo(infoView.mas_centerX);
        make.centerY.equalTo(infoView.mas_centerY);
    }];
}
-(void)setCellType:(showBaseCellType)cellType{
    _cellType = cellType;
    if (cellType == showBaseCellSafetyType) {
        self.showChenkNameLab.text = @"检查人:";
        self.showChenkTimerLab.text = @"检查时间:";
    }else{
        self.showChenkNameLab.text = @"工作(值班)负责人:";
        self.showChenkTimerLab.text = @"工作班组:";
    }
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    if (self.cellType == showBaseCellSafetyType) {
        // 检查人
        self.chenkNameLab.text =[YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"realName"]]];
        
        // 检查时间
        self.chenkTimerLab.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"time"]]];
    }else{
        // 工作负责人
        self.chenkNameLab.text =[YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"realName"]]];
        
        // 工作班组
        self.chenkTimerLab.text =[YWTTools getWithNSStringGoHtmlString: [NSString stringWithFormat:@"%@",dict[@"unitName"]]];
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
