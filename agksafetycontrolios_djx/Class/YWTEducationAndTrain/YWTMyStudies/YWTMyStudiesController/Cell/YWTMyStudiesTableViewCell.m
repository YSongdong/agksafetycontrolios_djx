//
//  MyStudiesTableViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/4/10.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTMyStudiesTableViewCell.h"

@interface YWTMyStudiesTableViewCell ()
// 详情点击按钮
@property (nonatomic,strong) UIButton *detailClickBtn;
// 类型图片
@property (nonatomic,strong) UIImageView *typeImageV;
// 标题
@property (nonatomic,strong) UILabel *titleLab;

// 文件大小
@property (nonatomic,strong) UILabel *annexSizeLab;
// 更新时间
@property (nonatomic,strong) UILabel *updateTimeLab;

// 在线学习按钮
@property (nonatomic,strong) UIButton *learnBtn;

@end


@implementation YWTMyStudiesTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCellView];
    }
    return self;
}
-(void) createCellView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
        make.bottom.equalTo(weakSelf).offset(-KSIphonScreenH(12));
    }];
    bgView.layer.cornerRadius = KSIphonScreenH(7);
    bgView.layer.masksToBounds = YES;
//    bgView.layer.borderWidth = 1;
//    bgView.layer.borderColor =  [UIColor colorLineCommonGreyBlackColor].CGColor;
    
    // 在线学习
    self.learnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:self.learnBtn];
    [self.learnBtn setTitle:@"在线学习" forState:UIControlStateNormal];
    [self.learnBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    self.learnBtn.titleLabel.font = BFont(15);
    self.learnBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [self.learnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(bgView);
        make.height.equalTo(@(KSIphonScreenH(45)));
    }];
    self.learnBtn.enabled = NO;
    
    UIView *lineView = [[UIView alloc]init];
    [bgView addSubview:lineView];
    lineView.backgroundColor = [UIColor colorLineE3E3CommonGreyBlackColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.learnBtn.mas_top);
        make.left.equalTo(bgView).offset(KSIphonScreenW(12));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(12));
        make.height.equalTo(@1);
    }];
    
    // 点击详情按钮
    self.detailClickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:self.detailClickBtn];
    self.detailClickBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [self.detailClickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineView.mas_top);
        make.left.top.right.equalTo(bgView);
    }];
    self.detailClickBtn.enabled = NO;

    UIView *cententView = [[UIView alloc]init];
    [bgView addSubview:cententView];
    
   // 标题
    self.titleLab = [[UILabel alloc]init];
    [cententView addSubview:self.titleLab];
    self.titleLab.text = @"";
    self.titleLab.textColor = [UIColor colorCommonBlackColor];
    self.titleLab.font = BFont(16);
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cententView).offset(KSIphonScreenW(38));
        make.top.equalTo(cententView.mas_top);
        make.right.equalTo(cententView).offset(-KSIphonScreenW(30));
    }];
    
    // 类型
    self.typeImageV = [[UIImageView alloc]init];
    [cententView addSubview:self.typeImageV];
    self.typeImageV.image = [UIImage imageNamed:@"base_deta_wsb"];
    [self.typeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cententView).offset(KSIphonScreenW(13));
        make.centerY.equalTo(weakSelf.titleLab.mas_centerY);
    }];
    
    //
    UIImageView *rightImageV = [[UIImageView alloc]init];
    [cententView addSubview:rightImageV];
    rightImageV.image = [UIImage imageNamed:@"base_dydj_enter"];
    [rightImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(cententView).offset(-KSIphonScreenW(14));
        make.top.equalTo(weakSelf.titleLab.mas_top);
    }];
    
    // 文件大小
    self.annexSizeLab = [[UILabel alloc]init];
    [cententView addSubview:self.annexSizeLab];
    self.annexSizeLab.text = @"";
    self.annexSizeLab.textColor = [UIColor colorWithHexString:@"#999999"];
    self.annexSizeLab.font = Font(13);
    [self.annexSizeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLab.mas_bottom).offset(KSIphonScreenH(13));
        make.left.equalTo(weakSelf.titleLab.mas_left);
    }];
    
    UIView *cententLineView = [[UIView alloc]init];
    [cententView addSubview:cententLineView];
    cententLineView.backgroundColor = [UIColor colorWithHexString:@"#999999"];
    [cententLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.annexSizeLab.mas_right).offset(KSIphonScreenW(17));
        make.centerY.equalTo(weakSelf.annexSizeLab.mas_centerY);
        make.width.equalTo(@1);
        make.height.equalTo(@(KSIphonScreenH(13)));
    }];
    
    self.updateTimeLab = [[UILabel alloc]init];
    [cententView addSubview:self.updateTimeLab];
    self.updateTimeLab.text = @"";
    self.updateTimeLab.textColor = [UIColor colorWithHexString:@"#999999"];
    self.updateTimeLab.font = Font(13);
    [self.updateTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cententLineView.mas_right).offset(KSIphonScreenW(17));
        make.centerY.equalTo(weakSelf.annexSizeLab.mas_centerY);
    }];
    
    [cententView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bgView);
        make.top.equalTo(weakSelf.titleLab.mas_top);
        make.bottom.equalTo(weakSelf.annexSizeLab.mas_bottom);
        make.centerY.equalTo(weakSelf.detailClickBtn.mas_centerY);
        make.centerX.equalTo(weakSelf.detailClickBtn.mas_centerX);
    }];
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    // 标题
    self.titleLab.text = [NSString stringWithFormat:@"%@",dict[@"title"]];
    // 大小
    NSString *sizeStr = [NSString stringWithFormat:@"%@",dict[@"size"]];
    self.annexSizeLab.text =[NSString stringWithFormat:@"大小:%.2fMB",([sizeStr doubleValue]/1024/1024)];
    // 更新时间
    self.updateTimeLab.text =[NSString stringWithFormat:@"更新时间:%@",dict[@"time"]];
    // 类型
    NSString *typeStr = [NSString stringWithFormat:@"%@",dict[@"type"]];
    if ([typeStr isEqualToString:@"images"]) {
        // 图片
        self.typeImageV.image = [UIImage imageNamed:@"base_image_photo"];
        
    }else if ([typeStr isEqualToString:@"video"]){
        // 视频
        self.typeImageV.image = [UIImage imageNamed:@"base_annex_video"];
    }else if ([typeStr isEqualToString:@"audio"]){
        // 音频
        self.typeImageV.image = [UIImage imageNamed:@"base_annex_music"];
    }else if ([typeStr isEqualToString:@"pdf"]){
        // pdf
        self.typeImageV.image = [UIImage imageNamed:@"base_deta_pdf"];
    }else if ([typeStr isEqualToString:@"doc"]){
        // doc
        self.typeImageV.image = [UIImage imageNamed:@"base_deta_word"];
    }else if ([typeStr isEqualToString:@"ppt"]){
        // ppt
        self.typeImageV.image = [UIImage imageNamed:@"base_deta_ppt"];
    }else if ([typeStr isEqualToString:@"xls"]){
        // xls
        self.typeImageV.image = [UIImage imageNamed:@"base_iamge_excle"];
    }else{
        // 其他
        self.typeImageV.image = [UIImage imageNamed:@"base_deta_wsb"];
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
