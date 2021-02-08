//
//  BottomToolView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/12.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTBottomToolView.h"

@implementation YWTBottomToolView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createToolView];
    }
    return self;
}
-(void) createToolView{
    __weak typeof(self) weakSelf = self;
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:cancelBtn];
    [cancelBtn setTitle:@"撤销" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = Font(15);
    cancelBtn.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(1);
        make.left.bottom.equalTo(bgView);
    }];
    [cancelBtn addTarget:self action:@selector(selectCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *alterBtn =[ UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:alterBtn];
    [alterBtn setTitle:@"修改" forState:UIControlStateNormal];
    [alterBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    alterBtn.titleLabel.font = Font(15);
    alterBtn.backgroundColor = [UIColor colorLineCommonBlueColor];
    [alterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cancelBtn.mas_right);
        make.width.height.equalTo(cancelBtn);
        make.right.equalTo(bgView);
        make.centerY.equalTo(cancelBtn.mas_centerY);
    }];
    [alterBtn addTarget:self action:@selector(selectAlterBtn:) forControlEvents:UIControlEventTouchUpInside];
}
// 撤销
-(void) selectCancelBtn:(UIButton *)sender{
    self.selectCancelBtn();
}
// 修改
-(void) selectAlterBtn:(UIButton *) sender{
    self.selectAlterBtn();
}

@end
