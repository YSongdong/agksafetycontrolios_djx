//
//  ExamCenterRecordUnpublishCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/2/27.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTExamCenterRecordUnpublishCell.h"

@interface YWTExamCenterRecordUnpublishCell ()
// 成绩状态
@property (nonatomic,strong) UIImageView *scroeImageV;
// 考场名称
@property (nonatomic,strong) UILabel *examRoomNameLab;
// 考试名称
@property (nonatomic,strong) UILabel *examNameLab;
// 试卷名称
@property (nonatomic,strong) UILabel *examPaperNameLab;

@end


@implementation YWTExamCenterRecordUnpublishCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createExamCenterRecordView];
    }
    return self;
}
-(void) createExamCenterRecordView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
        make.height.equalTo(weakSelf).offset(-KSIphonScreenH(12));
    }];
    bgView.layer.cornerRadius = KSIphonScreenH(7);
    bgView.layer.masksToBounds = YES;
    bgView.layer.borderWidth =1;
    bgView.layer.borderColor = [UIColor colorWithHexString:@"#e3e3e3"].CGColor;
    
    self.scroeImageV = [[UIImageView alloc]init];
    [bgView addSubview:self.scroeImageV];
    self.scroeImageV.image = [UIImage imageNamed:@"pic_wgb"];
    [self.scroeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(bgView);
    }];
    
    self.examRoomNameLab = [[UILabel alloc]init];
    [bgView addSubview:self.examRoomNameLab];
    self.examRoomNameLab.textColor = [UIColor colorCommonBlackColor];
    self.examRoomNameLab.font = BFont(17);
    self.examRoomNameLab.numberOfLines = 0;
    [self.examRoomNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(KSIphonScreenH(15));
        make.left.equalTo(bgView).offset(KSIphonScreenW(15));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(55));
    }];
    
    self.examNameLab = [[UILabel alloc]init];
    [bgView addSubview:self.examNameLab];
    self.examNameLab.textColor = [UIColor colorConstantCommonBlueColor];
    self.examNameLab.font = Font(14);
    self.examNameLab.numberOfLines = 0;
    [self.examNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.examRoomNameLab.mas_bottom).offset(KSIphonScreenH(20));
        make.left.equalTo(weakSelf.examRoomNameLab.mas_left);
        make.right.equalTo(bgView).offset(-KSIphonScreenW(15));
    }];
    
    // 试卷名称
    self.examPaperNameLab = [[UILabel alloc]init];
    [bgView addSubview:self.examPaperNameLab];
    self.examPaperNameLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.examPaperNameLab.font = Font(14);
    self.examPaperNameLab.numberOfLines = 2;
    [self.examPaperNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.examNameLab.mas_bottom).offset(KSIphonScreenH(6));
        make.left.equalTo(weakSelf.examNameLab.mas_left);
        make.right.equalTo(bgView).offset(-KSIphonScreenW(15));
    }];
    
    UIView *samilView = [[UIView alloc]init];
    [bgView addSubview:samilView];
    
    UIImageView *samilImageV = [[UIImageView alloc]init];
    [samilView addSubview:samilImageV];
    samilImageV.image = [UIImage imageNamed:@"ico_ts"];
    samilImageV.contentMode = UIViewContentModeScaleAspectFit;
    [samilImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(samilView);
        make.centerY.equalTo(samilView);
    }];
    
    UILabel *samilLab = [[UILabel alloc]init];
    [samilView addSubview:samilLab];
    samilLab.text =@"考试已完成，成绩暂未公布!";
    samilLab.textColor = [UIColor colorWithHexString:@"#ffb046"];
    samilLab.font = Font(17);
    [samilLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(samilImageV.mas_right).offset(KSIphonScreenW(4));
        make.centerY.equalTo(samilImageV.mas_centerY);
    }];
    
    [samilView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(samilImageV.mas_left);
        make.top.equalTo(weakSelf.examPaperNameLab.mas_bottom).offset(KSIphonScreenH(15));
        make.right.equalTo(samilLab.mas_right);
        make.bottom.equalTo(samilLab.mas_bottom);
        make.centerX.equalTo(bgView.mas_centerX);
    }];
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    // 试卷名称
    self.examRoomNameLab.text = dict[@"examRoomTitle"];
    // 所属考试
    self.examNameLab.text = [NSString stringWithFormat:@"所属考试：%@",dict[@"examTitle"]];
    // 试卷名称
    self.examPaperNameLab.text =  dict[@"paperTitle"];
    
}
// 计算高度
+(CGFloat) getWithRecordCellHeight:(NSDictionary *)dict{
    CGFloat height = KSIphonScreenH(120);
    
    NSString *titleStr = [NSString stringWithFormat:@"%@",dict[@"examRoomTitle"]];
    CGFloat titleHeight = [YWTTools getSpaceLabelHeight:titleStr withFont:17 withWidth:KScreenW-KSIphonScreenW(70) withSpace:2];
    height += titleHeight;
    
    NSString *examTitleStr = [NSString stringWithFormat:@"所属考试：%@",dict[@"examTitle"]];
    CGFloat examTitleHeight = [YWTTools getSpaceLabelHeight:examTitleStr withFont:14 withWidth:KScreenW-KSIphonScreenW(30) withSpace:2];
    height += examTitleHeight;
    
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
