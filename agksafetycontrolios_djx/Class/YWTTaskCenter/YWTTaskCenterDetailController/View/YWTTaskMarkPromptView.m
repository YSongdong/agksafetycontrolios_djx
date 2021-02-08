//
//  TaskMarkPromptView.m
//  PartyBuildingStar
//
//  Created by mac on 2019/4/19.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import "YWTTaskMarkPromptView.h"

@implementation YWTTaskMarkPromptView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createMarkPromptView];
    }
    return self;
}
-(void) createMarkPromptView{
    __weak typeof(self) weakSelf = self;
    
    UIView *bigBgView = [[UIView alloc]init];
    [self addSubview:bigBgView];
    bigBgView.backgroundColor = [UIColor blackColor];
    bigBgView.alpha = 0.35;
    [bigBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    UITapGestureRecognizer *bigBgTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectBigBgTap)];
    [bigBgView addGestureRecognizer:bigBgTap];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor  = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(45));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(45));
        make.height.equalTo(@(KSIphonScreenH(350)));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    bgView.layer.cornerRadius = 8;
    bgView.layer.masksToBounds = YES;
    
    UIView *titleView = [[UIView alloc]init];
    [bgView addSubview:titleView];
    titleView.backgroundColor  = [UIColor colorTextWhiteColor];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(bgView);
        make.height.equalTo(@(KSIphonScreenH(45)));
    }];
    
    UIView *titleContentView = [[UIView alloc]init];
    [titleView addSubview:titleContentView];
    
    UIImageView *titleImageV = [[UIImageView alloc]init];
    [titleContentView addSubview:titleImageV];
    titleImageV.image = [UIImage imageNamed:@"taskCenter_detail_taskMark"];
    [titleImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleContentView);
        make.centerY.equalTo(titleContentView.mas_centerY);
    }];
    
    UILabel *titleLab = [[UILabel alloc]init];
    [titleContentView addSubview:titleLab];
    titleLab.text = @"任务说明";
    titleLab.textColor = [UIColor colorCommonBlackColor];
    titleLab.font = BFont(17);
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleImageV.mas_right).offset(KSIphonScreenW(9));
        make.centerY.equalTo(titleContentView.mas_centerY);
    }];
    
    [titleContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleImageV.mas_left);
        make.top.right.bottom.equalTo(titleLab);
        make.centerX.equalTo(titleView.mas_centerX);
        make.centerY.equalTo(titleView.mas_centerY);
    }];
    
    UIView *titleLineView = [[UIView alloc]init];
    [titleView addSubview:titleLineView];
    titleLineView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    [titleLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(titleView);
        make.height.equalTo(@1);
    }];
    
    // 关闭view
    UIView *cancelView = [[UIView alloc]init];
    [bgView addSubview:cancelView];
    cancelView.backgroundColor = [UIColor colorTextWhiteColor];
    [cancelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(bgView);
        make.height.equalTo(@(KSIphonScreenH(45)));
    }];
    
    UIView *cancelLineView = [[UIView alloc]init];
    [cancelView addSubview:cancelLineView];
    cancelLineView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    [cancelLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(cancelView);
        make.height.equalTo(@1);
    }];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelView addSubview: cancelBtn];
    [cancelBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = BFont(16);
    [cancelBtn addTarget:self action:@selector(selectCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cancelView);
    }];
    
    UIView *contentView = [[UIView alloc]init];
    [bgView addSubview:contentView];
    contentView.backgroundColor = [UIColor colorTextWhiteColor];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView.mas_bottom);
        make.left.right.equalTo(bgView);
        make.bottom.equalTo(cancelView.mas_top);
    }];
    
    self.taskMarkTextView = [[UITextView alloc]init];
    [contentView addSubview:self.taskMarkTextView];
    self.taskMarkTextView.editable = NO;
    self.taskMarkTextView.textColor = [UIColor colorCommonBlackColor];
    self.taskMarkTextView.font = Font(14);
    [self.taskMarkTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(KSIphonScreenH(10));
        make.left.equalTo(contentView).offset(KSIphonScreenW(10));
        make.bottom.equalTo(contentView).offset(-KSIphonScreenH(10));
        make.right.equalTo(contentView).offset(-KSIphonScreenW(10));
    }];

}

-(void) selectBigBgTap{
    [self removeFromSuperview];
}
-(void) selectCancelBtn:(UIButton *) sender{
    [self selectBigBgTap];
}


@end
