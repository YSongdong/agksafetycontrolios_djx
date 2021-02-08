//
//  HomeBottomView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/2/21.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTHomeBottomView.h"

@implementation YWTHomeBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}
-(void) createView{
    
    __weak typeof(self) weakSelf = self;
    weakSelf.backgroundColor =  [UIColor colorStyleLeDarkWithConstantColor:[UIColor colorConstantStyleDarkColor]normalCorlor:[UIColor colorTextWhiteColor]];
    
    UILabel *lab = [[UILabel alloc]init];
    [self addSubview:lab];
    lab.text =@"Copyright (c)2018 国网重庆潼南供电 ALLRights Reserved";
    lab.textColor = [UIColor colorWithHexString:@"#aaaaaa"];
    lab.font = Font(12);
    lab.textAlignment = NSTextAlignmentCenter;
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
    if (@available(iOS 13.0, *)) {
           lab.textColor = [UIColor placeholderTextColor];
       }else{
           lab.textColor = [UIColor colorWithHexString:@"#aaaaaa"];
       }
    
}

@end
