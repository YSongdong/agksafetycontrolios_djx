//
//  YWTSubmitSendMethodCell.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/16.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTSubmitSendMethodCell.h"

@implementation YWTSubmitSendMethodCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createOpinionCell];
    }
    return self;
}
-(void) createOpinionCell{
    WS(weakSelf);
     self.backgroundColor = [UIColor colorTextWhiteColor];
    
    self.sendMethodBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.sendMethodBtn];
    [self.sendMethodBtn setTitle:@" 匿名" forState:UIControlStateNormal];
    [self.sendMethodBtn setTitleColor:[UIColor colorCommonBlackColor] forState:UIControlStateNormal];
    self.sendMethodBtn.titleLabel.font = Font(14);
    [self.sendMethodBtn setImage:[UIImage imageNamed:@"suggetion_submitBtn_normal"] forState:UIControlStateNormal];
    [self.sendMethodBtn setImage:[UIImage imageNamed:@"suggetion_submitBtn_select"] forState:UIControlStateSelected];
    [self.sendMethodBtn addTarget:self action:@selector(selectMethodBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.sendMethodBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
    UILabel *placeLab = [[UILabel alloc]init];
    [self addSubview:placeLab];
    placeLab.text  =@"你写的意见将以匿名形式发送";
    placeLab.textColor = [UIColor colorCommonAAAAGreyBlackColor];
    placeLab.font = Font(14);
    [placeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
    UIView *lineView =[[UIView alloc]init];
    [self addSubview:lineView];
    lineView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.height.equalTo(@0.5);
    }];
    
}

-(void) selectMethodBtn:(UIButton*)sender{
    sender.selected = !sender.selected;
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
