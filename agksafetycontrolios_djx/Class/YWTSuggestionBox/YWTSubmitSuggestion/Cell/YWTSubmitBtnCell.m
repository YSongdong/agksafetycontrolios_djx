//
//  YWTSubmitBtnCell.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/16.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTSubmitBtnCell.h"

@implementation YWTSubmitBtnCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createOpinionCell];
    }
    return self;
}
-(void) createOpinionCell{
    WS(weakSelf);
    
    self.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:submitBtn];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    submitBtn.titleLabel.font = Font(14);
    [submitBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorLineCommonBlueColor]] forState:UIControlStateNormal];
    [submitBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorClickCommonBlueColor]] forState:UIControlStateHighlighted];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(25));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(25));
        make.height.equalTo(@(KSIphonScreenH(44)));
        make.bottom.equalTo(weakSelf);
    }];
    submitBtn.layer.cornerRadius = KSIphonScreenH(44)/2;
    submitBtn.layer.masksToBounds = YES;
    [submitBtn addTarget:self action:@selector(selectSubmitBtn:) forControlEvents:UIControlEventTouchUpInside];
}

-(void) selectSubmitBtn:(UIButton *) sender{
    if ([self.delegate respondsToSelector:@selector(selectSubmitCellBtn)]) {
        [self.delegate selectSubmitCellBtn];
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
