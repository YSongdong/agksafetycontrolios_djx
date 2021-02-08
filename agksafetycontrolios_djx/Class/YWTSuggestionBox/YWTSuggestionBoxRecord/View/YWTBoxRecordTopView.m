//
//  YWTBoxRecordTopView.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/17.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTBoxRecordTopView.h"

@implementation YWTBoxRecordTopView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createTopBtnView];
    }
    return self ;
}

-(void) createTopBtnView{
    __weak typeof(self) weakSelf = self;
    self.layer.cornerRadius = KSIphonScreenH(10)/2;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1;
    self.layer.borderColor  = [UIColor colorTextWhiteColor].CGColor;
    
    self.mineReleaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.mineReleaseBtn];
    [self.mineReleaseBtn setTitle:@"我发布的" forState:UIControlStateNormal];
    [self.mineReleaseBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    self.mineReleaseBtn.titleLabel.font = Font(14);
    self.mineReleaseBtn.tag = 100;
    self.mineReleaseBtn.backgroundColor  = [UIColor colorTextWhiteColor];
    [self.mineReleaseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    [self.mineReleaseBtn addTarget:self action:@selector(selectListBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.mineReceiveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.mineReceiveBtn];
    [self.mineReceiveBtn setTitle:@"我接收的" forState:UIControlStateNormal];
    [self.mineReceiveBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.mineReceiveBtn.titleLabel.font = Font(14);
    self.mineReceiveBtn.tag = 101;
    self.mineReceiveBtn.backgroundColor  = [UIColor clearColor];
    [self.mineReceiveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mineReleaseBtn.mas_right);
        make.right.equalTo(weakSelf);
        make.width.height.equalTo(weakSelf.mineReleaseBtn);
        make.centerY.equalTo(weakSelf.mineReleaseBtn.mas_centerY);
    }];
    [self.mineReceiveBtn addTarget:self action:@selector(selectRecordBtn:) forControlEvents:UIControlEventTouchUpInside];
}
// 选择试卷列表
-(void)selectListBtn:(UIButton *) sender{
    [self.mineReceiveBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.mineReceiveBtn.backgroundColor  = [UIColor clearColor];
    
    [sender setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    sender.backgroundColor  = [UIColor colorTextWhiteColor];
    
    // 回调方法
    self.selectBtnBlock(sender.tag-100);
}
// 选择试卷记录
-(void)selectRecordBtn:(UIButton*) sender{
    [self.mineReleaseBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.mineReleaseBtn.backgroundColor  = [UIColor clearColor];
    
    [sender setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    sender.backgroundColor  = [UIColor colorTextWhiteColor];
    
    // 回调方法
    self.selectBtnBlock(sender.tag-100);
}


@end
