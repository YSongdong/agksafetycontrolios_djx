//
//  BaseRecordTableViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/11.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTBaseRecordTableViewCell.h"

@interface YWTBaseRecordTableViewCell ()
// 类型图片
@property (nonatomic,strong) UIImageView *typeImageV;
// 状态图片
@property (nonatomic,strong) UIImageView *typeStatuImageV;
// 时间
@property (nonatomic,strong) UILabel *updateTimerLab;
// 标题
@property (nonatomic,strong) UILabel *recordTitleLab;
// 副标题
@property (nonatomic,strong) UILabel *submitTitleLab;

@property (nonatomic,strong) UIView *textContentView;

@end


@implementation YWTBaseRecordTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createBaseRecordView];
    }
    return self;
}
-(void) createBaseRecordView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf).offset(-KSIphonScreenH(12));
    }];
    
    self.typeImageV = [[UIImageView alloc]init];
    [bgView addSubview:self.typeImageV];
    self.typeImageV.image = [UIImage imageNamed:@"base_list_aqjc"];
    [self.typeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(KSIphonScreenW(12));
        make.centerY.equalTo(bgView.mas_centerY);
    }];
    
    self.textContentView = [[UIView alloc]init];
    [bgView addSubview:self.textContentView];
    
    self.updateTimerLab = [[UILabel alloc]init];
    [self.textContentView addSubview:self.updateTimerLab];
    self.updateTimerLab.text = @"";
    self.updateTimerLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.updateTimerLab.font = Font(12);
    [self.updateTimerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.textContentView);
        make.right.equalTo(weakSelf.textContentView);
        make.width.equalTo(@(KSIphonScreenW(110)));
    }];
    
    self.recordTitleLab = [[UILabel alloc]init];
    [self.textContentView addSubview:self.recordTitleLab];
    self.recordTitleLab.text = @"";
    self.recordTitleLab.textColor = [UIColor colorCommonBlackColor];
    self.recordTitleLab.font = Font(17);
    [self.recordTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.updateTimerLab.mas_centerY);
        make.left.equalTo(weakSelf.textContentView);
        make.right.equalTo(weakSelf.updateTimerLab.mas_left).offset(-KSIphonScreenW(5));
    }];
    
    self.submitTitleLab = [[UILabel alloc]init];
    [self.textContentView addSubview:self.submitTitleLab];
    self.submitTitleLab.text = @"";
    self.submitTitleLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.submitTitleLab.font = Font(13);
    [self.submitTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.recordTitleLab.mas_bottom).offset(KSIphonScreenH(10));
        make.left.equalTo(weakSelf.recordTitleLab.mas_left);
        make.right.equalTo(weakSelf.textContentView);
    }];
    
    [self.textContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(KSIphonScreenW(65));
        make.top.equalTo(weakSelf.recordTitleLab.mas_top);
        make.bottom.equalTo(weakSelf.submitTitleLab.mas_bottom);
        make.right.equalTo(bgView).offset(-KSIphonScreenW(12));
        make.centerY.equalTo(weakSelf.typeImageV.mas_centerY);
    }];

    self.typeStatuImageV = [[UIImageView alloc]init];
    [bgView addSubview:self.typeStatuImageV];
    self.typeStatuImageV.image = [UIImage imageNamed:@"base_list_ycx"];
    self.typeStatuImageV.contentMode = UIViewContentModeScaleAspectFit;
    [self.typeStatuImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView);
        make.right.equalTo(bgView);
    }];
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
   // 时间
   self.updateTimerLab.text = [NSString stringWithFormat:@"%@",dict[@"time"]];
   
    // 标题
    self.recordTitleLab.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"title"]]];
    
    // 1正常 2撤销 3编辑中
    NSString *revokeIsStr = [NSString stringWithFormat:@"%@",dict[@"revokeIs"]];
    if ([revokeIsStr isEqualToString:@"1"]) {
        self.typeStatuImageV.hidden = YES;
    }else if ([revokeIsStr isEqualToString:@"2"]) {
        // 2撤销
        self.typeStatuImageV.image = [UIImage imageNamed:@"base_list_ycx"];
        self.typeStatuImageV.hidden = NO;
    }else  if ([revokeIsStr isEqualToString:@"3"]){
         // 3编辑中
        self.typeStatuImageV.image = [UIImage imageNamed:@"base_list_editing"];
        self.typeStatuImageV.hidden = NO;
    }
    
    if (self.cellType == showBaseRecordCellSafetyType ) {
        //  安全检查
        self.typeImageV.image = [UIImage imageNamed:@"base_list_aqjc"];
        // 内容
        self.submitTitleLab.text =[YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"检查内容:%@",dict[@"content"]]];
    }else if (self.cellType == showBaseRecordCellMeetingType){
        // 会议
        self.typeImageV.image = [UIImage imageNamed:@"base_list_bhjl"];
        // 内容
        NSString *contentStr = [NSString stringWithFormat:@"%@",dict[@"content"]];
        if (![contentStr isEqualToString:@""]) {
           self.submitTitleLab.text =[YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"备注:%@",dict[@"content"]]];
        }else{
           self.submitTitleLab.hidden = YES;
            __weak typeof(self) weakSelf = self;
            [self.textContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf).offset(KSIphonScreenW(65));
                make.top.equalTo(weakSelf.recordTitleLab.mas_top);
                make.bottom.equalTo(weakSelf.recordTitleLab.mas_bottom);
                make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
                make.centerY.equalTo(weakSelf.typeImageV.mas_centerY);
            }];
        }
    }else if (self.cellType == showBaseRecordCellViolationType){
        // 违章
        self.typeImageV.image = [UIImage imageNamed:@"base_list_wzcl"];
        // 内容
        self.submitTitleLab.text =[YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"处理情况:%@",dict[@"content"]]];
    }else if (self.cellType == showBaseRecordCellTechnoloType){
        // 技术
        self.typeImageV.image = [UIImage imageNamed:@"base_list_jsjd"];
        // 内容
        self.submitTitleLab.text =[YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"交底内容:%@",dict[@"content"]]];
    }
}

-(void)setCellType:(showBaseRecordCellType)cellType{
    _cellType = cellType;
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
