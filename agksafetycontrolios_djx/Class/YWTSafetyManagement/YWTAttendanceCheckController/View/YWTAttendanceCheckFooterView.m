//
//  AttendanceCheckFooterView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/14.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTAttendanceCheckFooterView.h"

@implementation YWTAttendanceCheckFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createFooterView];
    }
    return self;
}
-(void) createFooterView{
    __weak typeof(self) weakSelf  = self;
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    [bgView addSubview:lineView];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#e9e9e9"];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(bgView);
        make.height.equalTo(@1);
    }];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:cancelBtn];
    [cancelBtn setTitle:@"不签到" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorCommonAAAAGreyBlackColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = Font(16);
    cancelBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom);
        make.left.bottom.equalTo(bgView);
    }];
    [cancelBtn addTarget:self action:@selector(selectCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *subimtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:subimtBtn];
    [subimtBtn setTitle:@"确认签到" forState:UIControlStateNormal];
    [subimtBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    subimtBtn.titleLabel.font = Font(16);
    subimtBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [subimtBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cancelBtn.mas_right).offset(1);
        make.right.equalTo(bgView);
        make.width.height.equalTo(cancelBtn);
        make.centerY.equalTo(cancelBtn.mas_centerY);
    }];
    [subimtBtn addTarget:self action:@selector(selectSubimtBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *btnLineView = [[UIView alloc]init];
    [bgView addSubview:btnLineView];
    btnLineView.backgroundColor = [UIColor colorLineCommonE9E9E9GreyBlackColor];
    [btnLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cancelBtn.mas_right).offset(1);
        make.width.equalTo(@1);
        make.height.equalTo(bgView.mas_height);
        make.centerY.equalTo(cancelBtn.mas_centerY);
    }];
}

-(void)selectCancelBtn:(UIButton *) sneder{
    self.cancelBtn();
}
-(void) selectSubimtBtn:(UIButton *) sneder{
    self.submitCheckBtn();
}

@end
