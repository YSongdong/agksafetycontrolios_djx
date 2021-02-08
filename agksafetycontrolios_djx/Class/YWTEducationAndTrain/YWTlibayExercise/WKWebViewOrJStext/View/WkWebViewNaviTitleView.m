//
//  WkWebViewNaviTitleView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/2/26.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "WkWebViewNaviTitleView.h"

@interface WkWebViewNaviTitleView ()
// 答题模式
@property (nonatomic,strong) UIButton *answerModelBtn;
// 背题模式
@property (nonatomic,strong) UIButton *backProblemModelBtn;
@end

@implementation WkWebViewNaviTitleView

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
    
    self.answerModelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.answerModelBtn];
    [self.answerModelBtn setTitle:@"答题模式" forState:UIControlStateNormal];
    [self.answerModelBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    self.answerModelBtn.titleLabel.font = Font(14);
    self.answerModelBtn.tag = 101;
    self.answerModelBtn.backgroundColor  = [UIColor colorTextWhiteColor];
    [self.answerModelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    [self.answerModelBtn addTarget:self action:@selector(selectListBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.backProblemModelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.backProblemModelBtn];
    [self.backProblemModelBtn setTitle:@"背题模式" forState:UIControlStateNormal];
    [self.backProblemModelBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.backProblemModelBtn.titleLabel.font = Font(14);
    self.backProblemModelBtn.tag = 102;
    self.backProblemModelBtn.backgroundColor  = [UIColor clearColor];
    [self.backProblemModelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.answerModelBtn.mas_right);
        make.right.equalTo(weakSelf);
        make.width.height.equalTo(weakSelf.answerModelBtn);
        make.centerY.equalTo(weakSelf.answerModelBtn.mas_centerY);
    }];
    [self.backProblemModelBtn addTarget:self action:@selector(selectRecordBtn:) forControlEvents:UIControlEventTouchUpInside];
}
// 选择试卷列表
-(void)selectListBtn:(UIButton *) sender{
    [self.backProblemModelBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.backProblemModelBtn.backgroundColor  = [UIColor clearColor];
    
    [sender setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    sender.backgroundColor  = [UIColor colorTextWhiteColor];
    
    // 回调方法
    self.selectBtnBlock(sender.tag-100);
}
// 选择试卷记录
-(void)selectRecordBtn:(UIButton*) sender{
    [self.answerModelBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.answerModelBtn.backgroundColor  = [UIColor clearColor];
    
    [sender setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    sender.backgroundColor  = [UIColor colorTextWhiteColor];
    
    // 回调方法
    self.selectBtnBlock(sender.tag-100);
}
-(void) alterSelectBtnMode:(NSString *)btnTag{
    switch ([btnTag integerValue]) {
        case 1:{
            [self.backProblemModelBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
            self.backProblemModelBtn.backgroundColor  = [UIColor clearColor];
            [self.answerModelBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
            self.answerModelBtn.backgroundColor  = [UIColor colorTextWhiteColor];
            break;
        }
        case 2:{
            [self.answerModelBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
            self.answerModelBtn.backgroundColor  = [UIColor clearColor];
            [self.backProblemModelBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
            self.backProblemModelBtn.backgroundColor  = [UIColor colorTextWhiteColor];
            break;
        }
        default:
            break;
    }
}

@end
