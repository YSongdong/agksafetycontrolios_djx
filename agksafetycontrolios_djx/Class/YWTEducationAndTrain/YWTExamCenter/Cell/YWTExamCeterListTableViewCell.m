//
//  ExamCeterListTableViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/22.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTExamCeterListTableViewCell.h"

@interface YWTExamCeterListTableViewCell ()
// 考试状态
@property (nonatomic,strong) UIImageView *examStatuImageV;
// 考试名称
@property (nonatomic,strong) UILabel *examNameLab;
// 考试时段
@property (nonatomic,strong) UILabel *examTimerSlotLab;
// 考场数目
@property (nonatomic,strong) UILabel *examRoomNumberLab;
// 考试说明
@property (nonatomic,strong) UILabel *examMarkLab;
//
@property (nonatomic,strong) UIButton *enterExamBtn;

@property (nonatomic,strong) UIView *bgView;

@end



@implementation YWTExamCeterListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createListView];
    }
    return self;
}
-(void) createListView{
    __weak typeof(self) weakSelf = self;
    
    self.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    self.bgView = [[UIView alloc]init];
    [self addSubview:self.bgView];
    self.bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
        make.bottom.equalTo(weakSelf).offset(-KSIphonScreenH(12));
    }];
    self.bgView.layer.cornerRadius = KSIphonScreenH(8);
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.borderWidth = 1;
    self.bgView.layer.borderColor = [UIColor colorWithHexString:@"#e3e3e3"].CGColor;
    
    self.examStatuImageV = [[UIImageView alloc]init];
    [self.bgView addSubview:self.examStatuImageV];
    self.examStatuImageV.image = [UIImage imageNamed:@"pic_bq02"];
    [self.examStatuImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(weakSelf.bgView);
    }];
    
    self.examNameLab = [[UILabel alloc]init];
    [self.bgView addSubview:self.examNameLab];
    self.examNameLab.textColor = [UIColor colorCommonBlackColor];
    self.examNameLab.font = BFont(17);
    self.examNameLab.textAlignment = NSTextAlignmentLeft;
    self.examNameLab.numberOfLines = 0;
    [self.examNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bgView).offset(KSIphonScreenH(15));
        make.left.equalTo(weakSelf.bgView).offset(KSIphonScreenH(15));
        make.right.equalTo(weakSelf.bgView).offset(-KSIphonScreenW(55));
    }];
    
    // 考试时段
    self.examTimerSlotLab = [[UILabel alloc]init];
    [self.bgView addSubview:self.examTimerSlotLab];
    self.examTimerSlotLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.examTimerSlotLab.font = Font(14);
    [self.examTimerSlotLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.examNameLab.mas_bottom).offset(KSIphonScreenH(20));
        make.left.equalTo(weakSelf.examNameLab.mas_left);
        make.right.equalTo(weakSelf.bgView).offset(-KSIphonScreenW(15));
    }];
    
    // 考场数目
    self.examRoomNumberLab = [[UILabel alloc]init];
    [self.bgView addSubview:self.examRoomNumberLab];
    self.examRoomNumberLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.examRoomNumberLab.font = Font(14);
    [self.examRoomNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.examTimerSlotLab.mas_bottom).offset(KSIphonScreenH(7));
        make.left.equalTo(weakSelf.examTimerSlotLab.mas_left);
        make.right.equalTo(weakSelf.bgView).offset(-KSIphonScreenW(15));
    }];
    
    // 考试说明
    self.examMarkLab = [[UILabel alloc]init];
    [self.bgView addSubview:self.examMarkLab];
    self.examMarkLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.examMarkLab.font = Font(14);
    self.examMarkLab.numberOfLines = 0;
    [self.examMarkLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.examRoomNumberLab.mas_bottom).offset(KSIphonScreenH(7));
        make.left.equalTo(weakSelf.examTimerSlotLab.mas_left);
        make.right.equalTo(weakSelf.bgView).offset(-KSIphonScreenW(15));
    }];
    
    self.enterExamBtn = [[UIButton alloc]init];
    [self.bgView addSubview:self.enterExamBtn];
    [self.enterExamBtn setTitle:@"进入考试" forState:UIControlStateNormal];
    [self.enterExamBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.enterExamBtn.titleLabel.font = Font(13);
    self.enterExamBtn.backgroundColor = [UIColor colorLineCommonBlueColor];
    [self.enterExamBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView).offset(KSIphonScreenW(65));
        make.right.equalTo(weakSelf.bgView).offset(-KSIphonScreenW(65));
        make.bottom.equalTo(weakSelf.bgView).offset(-KSIphonScreenH(15));
        make.height.equalTo(@(KSIphonScreenH(35)));
    }];
    self.enterExamBtn.layer.cornerRadius = KSIphonScreenH(5);
    self.enterExamBtn.layer.masksToBounds = YES;
    self.enterExamBtn.layer.borderWidth =1;
    self.enterExamBtn.layer.borderColor = [UIColor colorLineCommonBlueColor].CGColor;
    self.enterExamBtn.enabled = NO;
    
}
-(void)setModel:(ExamCenterListModel *)model{
    _model = model;
    
    // 试卷名称
    self.examNameLab.text = [NSString stringWithFormat:@"%@",model.title];
    // 考试时段
    self.examTimerSlotLab.text = [NSString stringWithFormat:@"考试时段: %@",model.examTime];
    // 考场数量
    self.examRoomNumberLab.text = [NSString stringWithFormat:@"考场数目: %@",model.examNum];
    // 考试说明
    NSString *deacStr = [NSString stringWithFormat:@"%@",model.descr];
    if ([deacStr isEqualToString:@""]) {
        self.examMarkLab.hidden = YES;
    }else{
        self.examMarkLab.text =[NSString stringWithFormat:@"考试说明: %@",model.descr];
        [YWTTools changeLineSpaceForLabel:self.examMarkLab WithSpace:2 andFont:Font(14)];
    }
    // 1考试进行中 2考试未开始
    NSString *statuStr = [NSString stringWithFormat:@"%@",model.status];
    if ([statuStr isEqualToString:@"1"] || [statuStr isEqualToString:@"3"]) {
        self.examStatuImageV.image = [UIImage imageNamed:@"pic_bq01"];
    }else{
        self.examStatuImageV.image = [UIImage imageNamed:@"pic_bq02"];
    }
    // 1考试进行中 2考试未开始 3 考试次数已用完
    if ([model.status isEqualToString:@"1"]) {
        // 1开始考试 2继续考试 3禁止考试
        if ([model.examStatus  isEqualToString:@"1"]) {
            [self.enterExamBtn setTitle:@"进入考试" forState:UIControlStateNormal];
            [self.enterExamBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
        }else if ([model.examStatus isEqualToString:@"2"]){
            [self.enterExamBtn setTitle:@"继续考试" forState:UIControlStateNormal];
            [self.enterExamBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
        }
    }else if ([model.status isEqualToString:@"2"]){
        // 2考试未开始
        [self.enterExamBtn setTitle:@"进入考试" forState:UIControlStateNormal];
        [self.enterExamBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    }else if ([model.status isEqualToString:@"3"]){
        //  3 考试次数已用完
        [self.enterExamBtn setTitle:@"考试已完成" forState:UIControlStateNormal];
        [self.enterExamBtn setTitleColor:[UIColor colorCommonGreyBlackColor] forState:UIControlStateNormal];
        self.enterExamBtn.backgroundColor = [UIColor colorTextWhiteColor];
        self.enterExamBtn.layer.borderWidth =1;
        self.enterExamBtn.layer.borderColor = [UIColor colorWithHexString:@"#d7d7d7"].CGColor;
    }
}

// 计算高度
+(CGFloat) getWithExamCenterListCellHeight:(ExamCenterListModel*) model{
    CGFloat height = KSIphonScreenH(15);
    
    NSString *titleStr = [NSString stringWithFormat:@"%@",model.title];
    CGFloat titleHeight = [YWTTools getSpaceLabelHeight:titleStr withFont:18 withWidth:KScreenW-KSIphonScreenW(80) withSpace:2];
    height += titleHeight;
    height +=KSIphonScreenH(55);
    
    // 考试说明
    NSString *deacStr = [NSString stringWithFormat:@"%@",model.descr];
    if (![deacStr isEqualToString:@""]) {
        NSString *deacS = [NSString stringWithFormat:@"考试说明:%@",model.descr];
        CGFloat deacHeight = [YWTTools getSpaceLabelHeight:deacS withFont:14 withWidth:KScreenW-KSIphonScreenW(30) withSpace:2];
        height += deacHeight;
        
        height += KSIphonScreenH(33);
        
        height += KSIphonScreenH(35);
        
        height += KSIphonScreenH(15);
        
        return height;
    }
    
    height += KSIphonScreenH(20);
    
    height += KSIphonScreenH(35);

    height += KSIphonScreenH(25);
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
