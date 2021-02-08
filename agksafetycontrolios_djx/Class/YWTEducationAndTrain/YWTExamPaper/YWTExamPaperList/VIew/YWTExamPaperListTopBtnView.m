//
//  ExamPaperListTopBtnView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/15.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTExamPaperListTopBtnView.h"

@interface YWTExamPaperListTopBtnView ()

@end

@implementation YWTExamPaperListTopBtnView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createTopBtnView];
    }
    return self;
}
-(void) createTopBtnView{
    __weak typeof(self) weakSelf = self;
    self.layer.cornerRadius = KSIphonScreenH(10)/2;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1;
    self.layer.borderColor  = [UIColor colorTextWhiteColor].CGColor;
    
    self.examListBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.examListBtn];
    [self.examListBtn setTitle:@"模拟测验" forState:UIControlStateNormal];
    [self.examListBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    self.examListBtn.titleLabel.font = Font(14);
    self.examListBtn.tag = 100;
    self.examListBtn.backgroundColor  = [UIColor colorTextWhiteColor];
    [self.examListBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    [self.examListBtn addTarget:self action:@selector(selectListBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.examRecordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.examRecordBtn];
    [self.examRecordBtn setTitle:@"测验记录" forState:UIControlStateNormal];
    [self.examRecordBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.examRecordBtn.titleLabel.font = Font(14);
    self.examRecordBtn.tag = 101;
    self.examRecordBtn.backgroundColor  = [UIColor clearColor];
    [self.examRecordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.examListBtn.mas_right);
        make.right.equalTo(weakSelf);
        make.width.height.equalTo(weakSelf.examListBtn);
        make.centerY.equalTo(weakSelf.examListBtn.mas_centerY);
    }];
     [self.examRecordBtn addTarget:self action:@selector(selectRecordBtn:) forControlEvents:UIControlEventTouchUpInside];
}
// 选择试卷列表
-(void)selectListBtn:(UIButton *) sender{
    [self.examRecordBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.examRecordBtn.backgroundColor  = [UIColor clearColor];
    
    [sender setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    sender.backgroundColor  = [UIColor colorTextWhiteColor];
    
    // 回调方法
    self.selectBtnBlock(sender.tag-100);
}
// 选择试卷记录
-(void)selectRecordBtn:(UIButton*) sender{
    [self.examListBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.examListBtn.backgroundColor  = [UIColor clearColor];
    
    [sender setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    sender.backgroundColor  = [UIColor colorTextWhiteColor];
    
    // 回调方法
    self.selectBtnBlock(sender.tag-100);
}

@end
