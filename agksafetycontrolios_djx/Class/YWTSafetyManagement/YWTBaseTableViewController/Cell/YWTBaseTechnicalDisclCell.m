//
//  BaeTechnicalDisclCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/11.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTBaseTechnicalDisclCell.h"

@interface YWTBaseTechnicalDisclCell ()

@property (nonatomic,strong) UILabel *showTypeNameLab;

@property (nonatomic,strong) UILabel *typeNameLab;

@end


@implementation YWTBaseTechnicalDisclCell
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
    
    self.showTypeNameLab = [[UILabel alloc]init];
    [infoView addSubview:self.showTypeNameLab];
    self.showTypeNameLab.text = @"交底人员:";
    self.showTypeNameLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.showTypeNameLab.font = Font(14);
    [self.showTypeNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infoView).offset(KSIphonScreenW(15));
        make.centerY.equalTo(infoView.mas_centerY);
    }];
    
    self.typeNameLab = [[UILabel alloc]init];
    [infoView addSubview:self.typeNameLab];
    self.typeNameLab.text = @"";
    self.typeNameLab.textColor = [UIColor colorCommonBlackColor];
    self.typeNameLab.font = Font(14);
    [self.typeNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.showTypeNameLab.mas_right).offset(KSIphonScreenW(5));
        make.centerY.equalTo(infoView.mas_centerY);
    }];
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    if (self.baseType == showBaseTechnicalType ) {
        self.typeNameLab.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"realName"]]];
    }else{
        self.typeNameLab.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"realName"]]];
    }
}


-(void)setBaseType:(showBaseType)baseType{
    _baseType = baseType;
    if (baseType == showBaseTechnicalType) {
        self.showTypeNameLab.text = @"交底人员:";
    }else{
        self.showTypeNameLab.text = @"查处人员:";
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
