//
//  AttendanceAddMarkFooterView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/14.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTAttendanceAddMarkFooterView.h"

@implementation YWTAttendanceAddMarkFooterView
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
    
    self.submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:self.submitBtn];
    [self.submitBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    [self.submitBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    self.submitBtn.titleLabel.font = BFont(16);
    self.submitBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom);
        make.left.bottom.right.equalTo(bgView);
    }];
    [self.submitBtn addTarget:self action:@selector(selectSubmitBtn:) forControlEvents:UIControlEventTouchUpInside];
}
// 提交
-(void) selectSubmitBtn:(UIButton *) sender{
    self.selectSubmitBnt();
}


@end
