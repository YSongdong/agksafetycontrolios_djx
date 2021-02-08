//
//  AnnexTypeTableViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/11.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTAnnexTypeTableViewCell.h"

@interface YWTAnnexTypeTableViewCell ()
@property (nonatomic,strong) UIImageView *typeImageV;

@property (nonatomic,strong) UILabel * typeNameLab;

@end

@implementation YWTAnnexTypeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self craeteCellTypeView];
    }
    return self;
}
-(void) craeteCellTypeView{
    __weak typeof(self)  weakSelf = self;
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    self.typeImageV = [[UIImageView alloc]init];
    [bgView addSubview:self.typeImageV];
    self.typeImageV.image = [UIImage imageNamed:@"chenk_annex_photo"];
    [self.typeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(KSIphonScreenW(14));
        make.centerY.equalTo(bgView.mas_centerY);
    }];
    
    self.typeNameLab = [[UILabel alloc]init];
    [bgView addSubview:self.typeNameLab];
    self.typeNameLab.text = @"";
    self.typeNameLab.textColor = [UIColor colorCommonBlackColor];
    self.typeNameLab.font = Font(12);
    [self.typeNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(KSIphonScreenW(35));
        make.centerY.equalTo(bgView.mas_centerY);
        make.right.equalTo(bgView).offset(-KSIphonScreenW(45));
    }];
    
    UIButton *deleteBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:deleteBtn];
    [deleteBtn setImage:[UIImage imageNamed:@"base_annex_delete"] forState:UIControlStateNormal];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView).offset(-KSIphonScreenW(10));
        make.centerY.equalTo(bgView.mas_centerY);
        make.width.equalTo(@30);
        make.height.equalTo(bgView.mas_height);
    }];
    [deleteBtn addTarget:self action:@selector(selectDelBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = [[UIView alloc]init];
    [bgView addSubview:lineView];
    lineView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bgView).offset(-1);
        make.left.equalTo(bgView).offset(KSIphonScreenW(14));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(14));
        make.height.equalTo(@1);
    }];
}
// 删除按钮
-(void) selectDelBtn:(UIButton *) sender{
    self.selectDelBtn();
}
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    if (self.cellType == showAnnexTableCellAddType) {
        // 判断类型
        if ([dict[@"type"] isEqualToString:@"images"]) {
            self.typeNameLab.text = dict[@"typeName"];
            self.typeImageV.image = [UIImage imageNamed:@"chenk_annex_photo"];
        }else if ([dict[@"type"] isEqualToString:@"video"]){
            self.typeNameLab.text = dict[@"typeName"];
            self.typeImageV.image = [UIImage imageNamed:@"base_annex_video"];
        }else if ([dict[@"type"] isEqualToString:@"audio"]){
            self.typeNameLab.text = dict[@"typeName"];
            self.typeImageV.image = [UIImage imageNamed:@"base_annex_music"];
        }
    }else{
        NSString *typeStr = [NSString stringWithFormat:@"%@",dict[@"type"]];
        self.typeNameLab.text = dict[@"name"];
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
}
-(void)setCellType:(showAnnexTableCellType)cellType{
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
