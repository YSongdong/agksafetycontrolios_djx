//
//  CWVoiceView.m
//  QQVoiceDemo
//
//  Created by 陈旺 on 2017/9/2.
//  Copyright © 2017年 陈旺. All rights reserved.
//

#import "YWTCWVoiceView.h"
#import "UIView+CWChat.h"
#import "CWRecordView.h"


@interface YWTCWVoiceView ()

@property (nonatomic,weak) CWRecordView *recordView;        // 录音视图

@end

@implementation YWTCWVoiceView
{
    CGFloat _labelDistance;
    CGPoint _currentContentOffSize;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    __weak typeof(self) weakSelf = self;
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#e2e2e2"];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    UIView *bankView = [[UIView alloc]init];
    [bgView addSubview:bankView];
    bankView.backgroundColor = [UIColor colorTextWhiteColor];
    [bankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(bgView);
        make.height.equalTo(@(KSIphonScreenH(50)));
    }];
    
    UIButton *bankBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bankView addSubview:bankBtn];
    [bankBtn setTitle:@" 返回" forState:UIControlStateNormal];
    [bankBtn setTitleColor:[UIColor colorCommonBlackColor] forState:UIControlStateNormal];
    [bankBtn setImage:[UIImage imageNamed:@"base_record_back"] forState:UIControlStateNormal];
    bankBtn.titleLabel.font = BFont(14);
    [bankBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bankView).offset(KSIphonScreenW(12));
        make.centerY.equalTo(bankView.mas_centerY);
    }];
    [bankBtn addTarget:self action:@selector(selectBankBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *contentView = [[UIView alloc]init];
    [bgView addSubview:contentView];
    contentView.backgroundColor = [UIColor colorTextWhiteColor];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bankView.mas_bottom).offset(1);
        make.left.right.bottom.equalTo(bgView);
    }];
    
    CWRecordView *recordView = [[CWRecordView alloc] init];
    [contentView addSubview:recordView];
    self.recordView = recordView;
    [recordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(contentView);
    }];
    recordView.selectTureBtn = ^(NSDictionary *dict) {
        weakSelf.selectTureBtn(dict);
        [weakSelf removeFromSuperview];
    };
}

-(void)selectBankBtn:(UIButton *) sender{
    // 结束录音
    [self.recordView stopRecordBtn];
    
    [self removeFromSuperview];
}


@end











