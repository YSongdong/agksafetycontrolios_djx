//
//  SubmitBtnTableViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/16.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTSubmitBtnTableViewCell.h"

@implementation YWTSubmitBtnTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createInfoView];
    }
    return self;
}
-(void)createInfoView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    self.submitBtn = [[UIButton alloc]init];
    [self addSubview:self.submitBtn];
    [self.submitBtn setTitle:@"开始练习" forState:UIControlStateNormal];
    self.submitBtn.titleLabel.font = Font(15);
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(25));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(25));
        make.height.equalTo(@(KSIphonScreenH(44)));
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
    self.submitBtn.layer.cornerRadius = KSIphonScreenH(44)/2;
    self.submitBtn.layer.masksToBounds = YES;
    [self.submitBtn addTarget:self action:@selector(selectSubmitBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.submitBtn setTitleColor:[UIColor  colorTextWhiteColor] forState:UIControlStateNormal];
    [self.submitBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorLineCommonBlueColor]] forState:UIControlStateNormal];
    [self.submitBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorClickCommonBlueColor]] forState:UIControlStateHighlighted];
}
// 点击进入考试按钮
-(void)selectSubmitBtn:(UIButton *) sender{
    self.selectSubmitBlock();
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
