//
//  YWTDetailReplyPromptView.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/19.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTDetailReplyPromptView.h"

@implementation YWTDetailReplyPromptView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createReplyView];
    }
    return self;
}
-(void) createReplyView{
    WS(weakSelf);
    
    UIView *bigBgView = [[UIView alloc]init];
    [self addSubview:bigBgView];
    bigBgView.backgroundColor = [UIColor blackColor];
    bigBgView.alpha = 0.35;
    [bigBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectTap)];
    [bigBgView addGestureRecognizer:Tap];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    
    UIView *titleView = [[UIView alloc]init];
    [bgView addSubview:titleView];
    titleView.backgroundColor = [UIColor colorTextWhiteColor];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(bgView);
        make.height.equalTo(@(KSIphonScreenH(43)));
    }];
    
    UILabel *showTitleLab = [[UILabel alloc]init];
    [titleView addSubview:showTitleLab];
    showTitleLab.text =@"弹窗";
    showTitleLab.font = Font(19);
    showTitleLab.textColor = [UIColor colorCommonBlackColor];
    [showTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(titleView.mas_centerX);
        make.centerY.equalTo(titleView.mas_centerY);
    }];
    
    UIView *contentView = [[UIView alloc]init];
    [bgView addSubview:contentView];
    contentView.backgroundColor = [UIColor colorTextWhiteColor];
    
    self.fsTextView = [[FSTextView alloc]init];
    [contentView addSubview:self.fsTextView];
    self.fsTextView.placeholder = @"请输入回复";
    self.fsTextView.returnKeyType = UIReturnKeyDone;
    self.fsTextView.delegate = self;
    [self.fsTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(KSIphonScreenH(10));
        make.left.equalTo(contentView).offset(KSIphonScreenW(15));
        make.right.equalTo(contentView).offset(-KSIphonScreenW(15));
        make.bottom.equalTo(contentView).offset(-KSIphonScreenH(10));
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView.mas_bottom).offset(1);
        make.left.right.equalTo(titleView);
        make.height.equalTo(@130);
    }];
    
    UIButton *cancelBtn = [[UIButton alloc]init];
    [bgView addSubview:cancelBtn];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorCommonGreyBlackColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = Font(14);
    cancelBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_bottom).offset(1);
        make.left.equalTo(bgView);
        make.height.equalTo(@(KSIphonScreenH(45)));
    }];
    [cancelBtn addTarget:self action:@selector(selectCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *tureBtn = [[UIButton alloc]init];
    [bgView addSubview:tureBtn];
    [tureBtn setTitle:@"确认回复" forState:UIControlStateNormal];
    [tureBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    tureBtn.titleLabel.font = Font(14);
    tureBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [tureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cancelBtn.mas_right).offset(1);
        make.right.equalTo(bgView);
        make.width.height.equalTo(cancelBtn);
        make.centerY.equalTo(cancelBtn.mas_centerY);
    }];
    [tureBtn addTarget:self action:@selector(selectTureBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView.mas_top);
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(65));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(65));
        make.bottom.equalTo(tureBtn.mas_bottom);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    bgView.layer.cornerRadius = KSIphonScreenH(14)/2;
    bgView.layer.masksToBounds = YES;
}

-(void)selectTap{
    [self removeFromSuperview];
}
-(void)selectCancelBtn:(UIButton *)sender{
    [self selectTap];
}
-(void)selectTureBtn:(UIButton *)sender{
    [self.fsTextView becomeFirstResponder];
    if ([self.delegate respondsToSelector:@selector(selectReplyWithdrawContent:)]) {
        [self.delegate selectReplyWithdrawContent:self.fsTextView.text];
    }
}
#pragma mark --- UITextViewDelegate -----
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
        [self endEditing:YES];
        return NO;
    }
    return YES;
}


@end
