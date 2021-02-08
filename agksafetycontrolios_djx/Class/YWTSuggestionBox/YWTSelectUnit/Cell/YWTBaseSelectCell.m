//
//  YWTBaseSelectCell.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/16.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTBaseSelectCell.h"

@interface YWTBaseSelectCell ()
//选中按钮
@property (nonatomic,strong) UIButton *selectBtn;

@property (nonatomic,strong) UIImageView *typeImageV;

@property (nonatomic,strong) UIImageView *rightImageV;

@property (nonatomic,strong) UIView *contentBgView;

@property (nonatomic,strong) UILabel *nameLab;

@property (nonatomic,strong) UILabel *departLab;

@end

@implementation YWTBaseSelectCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createBaseCell];
    }
    return self;
}
-(void) createBaseCell{
    WS(weakSelf);
    
    self.rightImageV = [[UIImageView alloc]init];
    [self addSubview:self.rightImageV];
    self.rightImageV.image = [UIImage imageNamed:@"examPaper_right"];
    self.rightImageV.contentMode = UIViewContentModeScaleAspectFit;
    [self.rightImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.equalTo(@20);
    }];
    
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.selectBtn];
    [self.selectBtn setImage:[UIImage imageNamed:@"suggetion_submitBtn_normal"] forState:UIControlStateNormal];
    [self.selectBtn setImage:[UIImage imageNamed:@"suggetion_submitBtn_select"] forState:UIControlStateSelected];
    [self.selectBtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.equalTo(@45);
    }];
    
    self.typeImageV = [[UIImageView alloc]init];
    [self addSubview:self.typeImageV];
    self.typeImageV.image = [UIImage imageNamed:@"suggetion_select_unit"];
    self.typeImageV.contentMode = UIViewContentModeScaleAspectFit;
    [self.typeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.selectBtn.mas_right);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.equalTo(@18);
    }];
    
    self.contentBgView = [[UIView alloc]init];
    [self addSubview:self.contentBgView];

    self.nameLab = [[UILabel alloc]init];
    [self.contentBgView addSubview:self.nameLab];
    self.nameLab.text =@"";
    self.nameLab.textColor = [UIColor colorCommonBlackColor];
    self.nameLab.font = BFont(15);
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(weakSelf.contentBgView);
        make.right.equalTo(weakSelf.rightImageV.mas_left).offset(KSIphonScreenW(8));
    }];

    self.departLab = [[UILabel alloc]init];
    [self.contentBgView addSubview:self.departLab];
    self.departLab.text =@"";
    self.departLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.departLab.font = Font(12);
    [self.departLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nameLab.mas_left);
        make.top.equalTo(weakSelf.nameLab.mas_bottom);
        make.right.equalTo(weakSelf.rightImageV.mas_left).offset(KSIphonScreenW(8));
    }];

    [self.contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLab.mas_top);
        make.right.equalTo(weakSelf.rightImageV.mas_left).offset(-KSIphonScreenW(5));
        make.left.equalTo(weakSelf.typeImageV.mas_right).offset(KSIphonScreenW(10));
        make.bottom.equalTo(weakSelf.nameLab.mas_bottom);
        make.centerY.equalTo(weakSelf.selectBtn.mas_centerY);
    }];
}
// 选中
-(void) selectBtnAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(selectBaseBtnIndexPath:isSelect:)]) {
        [self.delegate selectBaseBtnIndexPath:self.indexPath isSelect:sender.selected];
    }
}
-(void)setSelectCellType:(SelectType)selectCellType{
    _selectCellType = selectCellType;
     WS(weakSelf);
    if (selectCellType == SelectUnitType ) {
        [self.typeImageV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.selectBtn.mas_right);
            make.centerY.equalTo(weakSelf.mas_centerY);
            make.width.equalTo(@18);
        }];
        
        [self.contentBgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.nameLab.mas_top);
            make.right.equalTo(weakSelf.rightImageV.mas_left).offset(-KSIphonScreenW(5));
            make.left.equalTo(weakSelf.typeImageV.mas_right).offset(KSIphonScreenW(10));
            make.bottom.equalTo(weakSelf.nameLab.mas_bottom);
            make.centerY.equalTo(weakSelf.selectBtn.mas_centerY);
        }];
    }else{
        [self.typeImageV mas_remakeConstraints:^(MASConstraintMaker *make) {
               make.left.equalTo(weakSelf.selectBtn.mas_right);
               make.centerY.equalTo(weakSelf.mas_centerY);
               make.width.equalTo(@40);
        }];
        [self.contentBgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.nameLab.mas_top);
            make.right.equalTo(weakSelf.rightImageV.mas_left).offset(-KSIphonScreenW(5));
            make.left.equalTo(weakSelf.typeImageV.mas_right).offset(KSIphonScreenW(10));
            make.bottom.equalTo(weakSelf.departLab.mas_bottom);
            make.centerY.equalTo(weakSelf.selectBtn.mas_centerY);
        }];
    }
}
-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}
-(void)setModel:(YWTSelectUnitModel *)model{
    _model = model;
    if (self.selectCellType == SelectUnitType ) {
           // 单位
           self.typeImageV.image = [UIImage imageNamed:@"suggetion_select_unit"];
           self.nameLab.text = model.unitName;
    }else{
           // 人员
           [YWTTools sd_setImageView:self.typeImageV WithURL:model.photo andPlaceholder:@"pary_list_uset"];
           self.nameLab.text = model.realname;
           self.departLab.text =model.company;
    }
    self.selectBtn.selected = model.isSelect;
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
