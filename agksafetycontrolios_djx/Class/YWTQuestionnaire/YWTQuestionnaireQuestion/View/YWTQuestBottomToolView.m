//
//  YWTQuestBottomToolView.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/17.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTQuestBottomToolView.h"

@implementation YWTQuestBottomToolView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createToolView];
    }
    return self;
}
-(void) createToolView{
    WS(weakSelf);
    
    UIView *lineView = [[UIView alloc]init];
    [self addSubview:lineView];
    lineView.backgroundColor = [UIColor colorHeaderImageVDBDBColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(weakSelf);
        make.height.equalTo(@0.5);
    }];
    
    self.lastQuestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.lastQuestBtn];
    [self.lastQuestBtn setTitle:@" 上一题" forState:UIControlStateNormal];
    [self.lastQuestBtn setTitleColor:[UIColor colorCommonBlackColor] forState:UIControlStateNormal];
    [self.lastQuestBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateHighlighted];
    self.lastQuestBtn.titleLabel.font = Font(12);
    [self.lastQuestBtn setImage:[UIImage imageNamed:@"sjlx_tab_ico_01"] forState:UIControlStateNormal];
    [self.lastQuestBtn setImage:[UIImage imageNamed:@"tab_exam_left_sel_2"] forState:UIControlStateHighlighted];
    [self.lastQuestBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(weakSelf);
    }];
    [self.lastQuestBtn addTarget:self action:@selector(selectLastQuestAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *lineImageV = [[UIImageView alloc]init];
    [self addSubview:lineImageV];
    lineImageV.image = [UIImage imageNamed:@"suggetion_quest_line"];
    lineImageV.contentMode = UIViewContentModeScaleAspectFit;
    [lineImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lastQuestBtn.mas_right);
        make.width.equalTo(@1);
        make.centerY.equalTo(weakSelf.lastQuestBtn.mas_centerY);
    }];
    
    self.nextQuestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.nextQuestBtn];
    [self.nextQuestBtn setTitle:@" 下一题" forState:UIControlStateNormal];
    [self.nextQuestBtn setTitleColor:[UIColor colorCommonBlackColor] forState:UIControlStateNormal];
    [self.nextQuestBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateHighlighted];
    self.nextQuestBtn.titleLabel.font = Font(12);
    [self.nextQuestBtn setImage:[UIImage imageNamed:@"sjlx_tab_ico_04"] forState:UIControlStateNormal];
    [self.nextQuestBtn setImage:[UIImage imageNamed:@"tab_exam_right_sel_2"] forState:UIControlStateHighlighted];
    [self.nextQuestBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineImageV.mas_right);
        make.right.equalTo(weakSelf);
        make.width.height.equalTo(weakSelf.lastQuestBtn);
        make.centerY.equalTo(weakSelf.lastQuestBtn.mas_centerY);
    }];
    [self.nextQuestBtn LZSetbuttonType:LZCategoryTypeLeft];
    [self.nextQuestBtn addTarget:self action:@selector(selectNextQuestAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void) selectLastQuestAction:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(selectBottomLastQuest)]) {
        [self.delegate selectBottomLastQuest];
    }
}
-(void) selectNextQuestAction:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(selectBottomNextQuest)]) {
        [self.delegate selectBottomNextQuest];
    }
}

@end
