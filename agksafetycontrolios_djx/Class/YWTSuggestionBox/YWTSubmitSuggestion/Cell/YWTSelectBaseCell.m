//
//  YWTSelectBaseCell.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/16.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTSelectBaseCell.h"

@interface YWTSelectBaseCell ()

@property (nonatomic,strong) UIView *topLineView;

@end

@implementation YWTSelectBaseCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSelectCell];
    }
    return self;
}
-(void) createSelectCell{
    WS(weakSelf);
    self.backgroundColor = [UIColor colorTextWhiteColor];
    
    self.topLineView = [[UIView alloc]init];
    [self addSubview:self.topLineView];
    self.topLineView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf);
        make.top.equalTo(weakSelf.mas_top);
        make.height.equalTo(@0.5);
    }];
    
    UIImageView *rightImageV = [[UIImageView alloc]init];
    [self addSubview:rightImageV];
    rightImageV.image = [UIImage imageNamed:@"examPaper_right"];
    rightImageV.contentMode = UIViewContentModeScaleAspectFit;
    [rightImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.equalTo(@20);
    }];
    
    self.placeholderLab = [[UILabel alloc]init];
    [self addSubview:self.placeholderLab];
    self.placeholderLab.text = @"向单位提意见";
    self.placeholderLab.textColor = [UIColor colorCommonAAAAGreyBlackColor];
    self.placeholderLab.font = Font(13);
    [self.placeholderLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
    self.baseLab = [[UILabel alloc]init];
    [self addSubview:self.baseLab];
    self.baseLab.text = @"";
    self.baseLab.textColor = [UIColor colorCommonBlackColor];
    self.baseLab.font = Font(13);
    [self.baseLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(rightImageV.mas_left).offset(-KSIphonScreenW(5));
    }];
    
    UIView *lineView =[[UIView alloc]init];
    [self addSubview:lineView];
    lineView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.baseLab.mas_left);
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.height.equalTo(@0.5);
    }];
}
-(void)setCellType:(SelectBaseCellType)cellType{
    _cellType = cellType;
    if (cellType == SelectBaseCellSelectType) {
         self.placeholderLab.text = @"向单位提意见";
         self.topLineView.hidden = NO;
    }else{
        self.placeholderLab.text = @"请选择意见接受单位";
        self.topLineView.hidden = YES;
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
