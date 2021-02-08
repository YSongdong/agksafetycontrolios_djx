//
//  DetailBottomToolView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/4/10.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTDetailBottomToolView.h"

@implementation YWTDetailBottomToolView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createToolView];
    }
    return self;
}
-(void) createToolView{
    __weak typeof(self) weakSelf = self;
    
    self.beginLearnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.beginLearnBtn];
    [self.beginLearnBtn setTitle:@"开始学习" forState:UIControlStateNormal];
    [self.beginLearnBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.beginLearnBtn.titleLabel.font = Font(15);
    [self.beginLearnBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorLineCommonBlueColor]] forState:UIControlStateNormal];
    [self.beginLearnBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorClickCommonBlueColor]] forState:UIControlStateHighlighted];
    [self.beginLearnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    [self.beginLearnBtn addTarget:self action:@selector(selectLearnBtn:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void) selectLearnBtn:(UIButton *) sender{
    self.selectLearnBtn();
}





@end
