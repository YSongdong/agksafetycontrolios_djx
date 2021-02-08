//
//  YWTDetailReplyBtnView.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/10/17.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTDetailReplyBtnView.h"

@implementation YWTDetailReplyBtnView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createReplyBtnView];
    }
    return self;
}
-(void) createReplyBtnView{
    WS(weakSelf);
    self.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    self.replyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.replyBtn];
    [self.replyBtn setTitle:@"撤回" forState:UIControlStateNormal];
    [self.replyBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.replyBtn.titleLabel.font = Font(16);
    [self.replyBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorLineCommonBlueColor]] forState:UIControlStateNormal];
    [self.replyBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorClickCommonBlueColor]] forState:UIControlStateNormal];
    [self.replyBtn addTarget:self action:@selector(selectReplyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.replyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(30));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(30));
        make.height.equalTo(@44);
    }];
    self.replyBtn.layer.cornerRadius = 44/2;
    self.replyBtn.layer.masksToBounds = YES;
}

-(void) selectReplyBtnAction:(UIButton *)sender{
    NSString *initiateStr = [NSString stringWithFormat:@"%@",self.dict[@"initiate"]];
    NSString *withdrawStr = [NSString stringWithFormat:@"%@",self.dict[@"withdraw"]];
    if ([initiateStr isEqualToString:@"1"]) {
       if ([withdrawStr isEqualToString:@"1"]) {
           // 可以撤回
           self.selectReplyAction(NO);
       }
    }else{
        // 回复
        self.selectReplyAction(YES);
    }
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    // 状态
    NSString *statusStr = [NSString stringWithFormat:@"%@",dict[@"status"]];
    if ([statusStr isEqualToString:@"3"]) {
        self.replyBtn.enabled = NO;
        // 不可以撤回
        [self.replyBtn setTitle:@"撤回" forState:UIControlStateNormal];
        [self.replyBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorWithHexString:@"#999999"]] forState:UIControlStateNormal];
        return;
    }
    
    // 意见发起人
    NSString *initiateStr = [NSString stringWithFormat:@"%@",dict[@"initiate"]];
    NSString *withdrawStr = [NSString stringWithFormat:@"%@",dict[@"withdraw"]];
    if ([initiateStr isEqualToString:@"1"]) {
        if ([withdrawStr isEqualToString:@"1"]) {
            // 可以撤回
            [self.replyBtn setTitle:@"撤回" forState:UIControlStateNormal];
        }else{
            self.replyBtn.enabled = NO;
            // 不可以撤回
            [self.replyBtn setTitle:@"撤回" forState:UIControlStateNormal];
            [self.replyBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorWithHexString:@"#999999"]] forState:UIControlStateNormal];
        }
    }else{
        [self.replyBtn setTitle:@"回复" forState:UIControlStateNormal];
    }
}


@end
