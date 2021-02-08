//
//  SpeciaTraiTypeHeaderView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/2/14.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTSpeciaTraiTypeHeaderView.h"

@implementation YWTSpeciaTraiTypeHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createTypeView];
    }
    return self;
}
-(void) createTypeView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5f"];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    UILabel *contentLab = [[UILabel alloc]init];
    [bgView addSubview:contentLab];
    contentLab.text = @"按题目类型练习";
    contentLab.textColor = [UIColor colorCommonBlackColor];
    contentLab.font = BFont(18);
    [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(KSIphonScreenW(12));
        make.centerY.equalTo(bgView.mas_centerY);
    }];

    UIView *lineView = [[UIView alloc]init];
    [bgView addSubview:lineView];
    lineView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(bgView);
        make.height.equalTo(@1);
    }];
}



@end
