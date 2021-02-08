//
//  ExamScoreBaseTableViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/22.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTExamScoreBaseTableViewCell.h"

@interface YWTExamScoreBaseTableViewCell ()

@property (nonatomic,strong) UIImageView *typeImageV;

// title
@property (nonatomic,strong) UILabel *typeTitleLab;
// 显示
@property (nonatomic,strong) UILabel *showContentLab;

@property (nonatomic,strong) UIImageView *rightImageV;

@end


@implementation YWTExamScoreBaseTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createBaseView];
    }
    return self;
}
-(void) createBaseView{
    __weak typeof(self) weakSelf = self;
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    self.typeImageV = [[UIImageView alloc]init];
    [bgView addSubview:self.typeImageV];
    self.typeImageV.image = [UIImage imageNamed:@"kscj_ico_dxt_01"];
    [self.typeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(KSIphonScreenW(15));
        make.height.width.equalTo(@35);
        make.centerY.equalTo(bgView.mas_centerY);
    }];
    
    self.rightImageV = [[UIImageView alloc]init];
    [bgView addSubview:self.rightImageV];
    self.rightImageV.image = [UIImage imageNamed:@"grzx_btn_enter"];
    [self.rightImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView).offset(-KSIphonScreenW(15));
        make.centerY.equalTo(bgView.mas_centerY);
    }];
    
    UIView *contentView = [[UIView alloc]init];
    [bgView addSubview:contentView];
    
    self.typeTitleLab = [[UILabel alloc]init];
    [contentView addSubview:self.typeTitleLab];
    self.typeTitleLab.textColor = [UIColor colorCommonBlackColor];
    self.typeTitleLab.font = Font(17);
    [self.typeTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(contentView);
    }];
    
    self.showContentLab = [[UILabel alloc]init];
    [contentView addSubview:self.showContentLab];
    self.showContentLab.textColor = [UIColor colorCommonAAAAGreyBlackColor];
    self.showContentLab.font = Font(15);
    [self.showContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.typeTitleLab.mas_bottom).offset(KSIphonScreenH(7));
        make.left.equalTo(weakSelf.typeTitleLab.mas_left);
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.typeTitleLab.mas_top);
        make.bottom.equalTo(weakSelf.showContentLab.mas_bottom);
        make.left.equalTo(weakSelf.typeImageV.mas_right).offset(KSIphonScreenW(10));
        make.right.equalTo(weakSelf.rightImageV.mas_left).offset(-KSIphonScreenW(10));
        make.centerY.equalTo(bgView.mas_centerY);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    [bgView addSubview:lineView];
    lineView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(KSIphonScreenW(15));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(15));
        make.bottom.equalTo(bgView);
        make.height.equalTo(@1);
    }];
}
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    // 题型 1单选 2多选 3判断 4。
    NSString *keyStr = [NSString stringWithFormat:@"%@",dict[@"key"]];
    if ([keyStr isEqualToString:@"1"]) {
        self.typeTitleLab.text = @"单选题";
        self.typeImageV.image = [UIImage imageNamed:@"kscj_ico_dxt_01"];
    }else if ([keyStr isEqualToString:@"2"]){
        self.typeTitleLab.text = @"多选题";
        self.typeImageV.image = [UIImage imageNamed:@"kscj_ico_dxt_02"];
    }else if ([keyStr isEqualToString:@"3"]){
        self.typeTitleLab.text = @"判断题";
        self.typeImageV.image = [UIImage imageNamed:@"kscj_ico_pdt_03"];
    }else if ([keyStr isEqualToString:@"5"]){
        self.typeTitleLab.text = @"填空题";
        self.typeImageV.image = [UIImage imageNamed:@"kscj_ico_tkt_04"];
    }else if ([keyStr isEqualToString:@"6"]){
        self.typeTitleLab.text = @"主观题";
        self.typeImageV.image = [UIImage imageNamed:@"kscj_ico_zgt_05"];
    }else if ([keyStr isEqualToString:@"4"]){
        self.typeTitleLab.text = @"主观题";
        self.typeImageV.image = [UIImage imageNamed:@"kscj_ico_tkt_04"];
    }
    NSDictionary *listDict = dict[@"list"];
    self.showContentLab.text =[NSString stringWithFormat:@"共%@题，做对%@题，得分%@分",listDict[@"total"],listDict[@"passQuestions"],listDict[@"score"]];
}
-(void)setCellType:(showExamScoreCellType)cellType{
    _cellType = cellType;
    if (cellType == showExamScoreCellExamPaperType) {
        self.rightImageV.hidden = YES;
    }else{
        self.rightImageV.hidden = NO;
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
