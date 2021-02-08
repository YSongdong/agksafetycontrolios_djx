//
//  YWTBoxRecordCell.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/18.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTBoxRecordCell.h"

@interface YWTBoxRecordCell ()

@property (nonatomic,strong) UIImageView *headerImageV;

@property (nonatomic,strong) UILabel *nameLab;

@property (nonatomic,strong) UILabel *timeLab;

@property (nonatomic,strong) UILabel *contentLab;
// 红点
@property (nonatomic,strong) UIView *redDotView;

@end

@implementation YWTBoxRecordCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createRecordView];
    }
    return self;
}
-(void) createRecordView{
    WS(weakSelf);
    self.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf).offset(-KSIphonScreenH(10));
    }];
    
    self.headerImageV = [[UIImageView alloc]init];
    [bgView addSubview:self.headerImageV];
    self.headerImageV.image = [UIImage imageNamed:@"suggetion_record_normal"];
    [self.headerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(KSIphonScreenH(15));
        make.left.equalTo(bgView).offset(KSIphonScreenW(12));
        make.width.height.equalTo(@44);
    }];
    self.headerImageV.layer.cornerRadius = 44/2;
    self.headerImageV.layer.masksToBounds = YES;
    
    self.redDotView = [[UIView alloc]init];
    [bgView addSubview:self.redDotView];
    self.redDotView.backgroundColor = [UIColor colorCommonRedColor];
    [self.redDotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(weakSelf.headerImageV);
        make.width.height.equalTo(@10);
    }];
    self.redDotView.layer.cornerRadius = 10/2;
    self.redDotView.layer.masksToBounds = YES;
    self.redDotView.hidden = YES;
    
    self.timeLab = [[UILabel alloc]init];
    [bgView addSubview:self.timeLab];
    self.timeLab.text = @"";
    self.timeLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.timeLab.font = Font(12);
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(KSIphonScreenH(18));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(12));
        make.width.equalTo(@100);
    }];
    
    self.nameLab = [[UILabel alloc]init];
    [bgView addSubview:self.nameLab];
    self.nameLab.text = @"";
    self.nameLab.textColor  =[UIColor colorCommonBlackColor];
    self.nameLab.font = BFont(16);
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headerImageV.mas_right).offset(KSIphonScreenW(6));
        make.right.equalTo(weakSelf.timeLab.mas_left).offset(-KSIphonScreenW(5));
        make.centerY.equalTo(weakSelf.timeLab.mas_centerY);
    }];
    
    self.contentLab = [[UILabel alloc]init];
    [bgView addSubview:self.contentLab];
    self.contentLab.text = @"";
    self.contentLab.textColor  =[UIColor colorCommon65GreyBlackColor];
    self.contentLab.font = BFont(12);
    self.contentLab.numberOfLines  = 0 ;
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLab.mas_bottom).offset(KSIphonScreenH(10));
        make.left.equalTo(weakSelf.nameLab.mas_left);
        make.right.equalTo(weakSelf.timeLab.mas_right);
    }];
}
-(void)setCellType:(SuggestionRecordBoxCellType)cellType{
    _cellType = cellType;
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    // 1发给个人2发给单位
    NSString *aimstypeStr = [NSString stringWithFormat:@"%@",dict[@"aimstype"]];
    // 1实名 2匿名
    NSString *typesStr = [NSString stringWithFormat:@"%@",dict[@"types"]];
    // 时间
    NSString *starttimeStr = [NSString stringWithFormat:@"%@",dict[@"starttime"]];
    self.timeLab.text = starttimeStr;

    // 1实名 2匿名
    if ([typesStr isEqualToString:@"2"]) {
        self.headerImageV.image = [UIImage imageNamed:@"suggetion_detail_nm"];
        self.nameLab.text = @"匿名";
        self.contentLab.text = [NSString stringWithFormat:@"%@",dict[@"content"]];
    }else{
        // 时间
        self.timeLab.text = starttimeStr;
        // 名称
        self.nameLab.text = [NSString stringWithFormat:@"%@",dict[@"title"]];
        // 意见
        self.contentLab.text = [NSString stringWithFormat:@"%@",dict[@"content"]];
        if ([aimstypeStr isEqualToString:@"1"]) {
            // 个人
            NSString *photoStr = [NSString stringWithFormat:@"%@",dict[@"photo"]];
            [YWTTools sd_setImageView:self.headerImageV WithURL:photoStr andPlaceholder:@"suggetion_record_normal"];
        }else{
            // 单位
            self.headerImageV.image = [UIImage imageNamed:@"suggetion_detail_unit"];
        }
    }
    if (self.cellType == SuggestionBoxReplyBoxCellType) {
        // 回复意见
        NSString *replyStr = [NSString stringWithFormat:@"%@",dict[@"reply"]];
        if ([replyStr isEqualToString:@"2"]) {
            self.redDotView.hidden = NO;
        }else{
            self.redDotView.hidden = YES;
        }
    }else{
        // 1已读 2未读
        NSString *aReadStr = [NSString stringWithFormat:@"%@",dict[@"aRead"]];
        if ([aReadStr isEqualToString:@"1"]) {
           self.redDotView.hidden = YES;
        }else{
           self.redDotView.hidden = NO;
        }
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
