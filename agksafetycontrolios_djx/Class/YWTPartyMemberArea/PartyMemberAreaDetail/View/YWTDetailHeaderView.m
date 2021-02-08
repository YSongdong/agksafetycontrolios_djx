//
//  YWTDetailHeaderView.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/11.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTDetailHeaderView.h"

@implementation YWTDetailHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createHeaderView];
    }
    return self;
}
-(void) createHeaderView{
    WS(weakSelf);
    weakSelf.backgroundColor = [UIColor colorTextWhiteColor];
    
    self.allCommitLab = [[UILabel alloc]init];
    [self addSubview:self.allCommitLab];
    self.allCommitLab.textColor = [UIColor colorCommonBlackColor];
    self.allCommitLab.font = BFont(14);
    self.allCommitLab.text = @"全部评论 (0)";
    [self.allCommitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    [self addSubview:lineView];
    lineView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
        make.bottom.equalTo(weakSelf).offset(-1);
        make.height.equalTo(@1);
    }];
}


@end
