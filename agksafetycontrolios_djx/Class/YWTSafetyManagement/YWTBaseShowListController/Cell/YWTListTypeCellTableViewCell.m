//
//  ListTypeCellTableViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/23.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTListTypeCellTableViewCell.h"

@interface YWTListTypeCellTableViewCell ()
// 类型
@property (nonatomic,strong) UIImageView *typeImageV;
//类型名称
@property (nonatomic,strong) UILabel *typeNameLab;
// 说明
@property (nonatomic,strong) UILabel *explanationLab;

@end


@implementation YWTListTypeCellTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCellView];
    }
    return self;
}
-(void) createCellView{
    __weak typeof(self) weakSelf = self;
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    // 类型
    self.typeImageV = [[UIImageView alloc]init];
    [bgView addSubview:self.typeImageV];
    self.typeImageV.image = [UIImage imageNamed:@"base_iamge_excle"];
    self.typeImageV.contentMode =  UIViewContentModeScaleAspectFit;
    [self.typeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(KSIphonScreenH(17));
        make.left.equalTo(bgView).offset(KSIphonScreenW(15));
    }];
    
    //类型名称
    self.typeNameLab =  [[UILabel alloc]init];
    [bgView addSubview:self.typeNameLab];
    self.typeNameLab.text = @"";
    self.typeNameLab.textColor = [UIColor colorCommonBlackColor];
    self.typeNameLab.font = BFont(16);
    [self.typeNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(KSIphonScreenW(35));
        make.centerY.equalTo(weakSelf.typeImageV.mas_centerY);
        make.right.equalTo(bgView).offset(-KSIphonScreenW(30));
    }];
    
    UIImageView *rightImageV = [[UIImageView alloc]init];
    [bgView addSubview:rightImageV];
    rightImageV.image = [UIImage imageNamed:@"base_dydj_enter"];
    [rightImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView).offset(-KSIphonScreenW(14));
        make.centerY.equalTo(weakSelf.typeImageV.mas_centerY);
    }];
    
    // 说明
    self.explanationLab = [[UILabel alloc]init];
    [bgView addSubview:self.explanationLab];
    self.explanationLab.text = @"";
    self.explanationLab.textColor = [UIColor colorWithHexString:@"#999999"];
    self.explanationLab.font = Font(12);
    [self.explanationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.typeNameLab.mas_bottom).offset(KSIphonScreenH(12));
        make.left.equalTo(weakSelf.typeNameLab.mas_left);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    [bgView addSubview:lineView];
    lineView.backgroundColor = [UIColor colorLineE3E3CommonGreyBlackColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bgView);
        make.right.equalTo(bgView).offset(-KSIphonScreenW(15));
        make.left.equalTo(weakSelf.typeNameLab.mas_left);
        make.height.equalTo(@1);
    }]; 
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
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

    //类型名称
    self.typeNameLab.text = [NSString stringWithFormat:@"%@",dict[@"name"]];
    
    // 说明
    NSString *sizeStr = [NSString stringWithFormat:@"%@",dict[@"size"]];
    self.explanationLab.text =[NSString stringWithFormat:@"大小: %.2fMB",([sizeStr doubleValue]/1024/1024)];
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
