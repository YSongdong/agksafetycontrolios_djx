//
//  LoginMaskFloorView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/9.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTLoginMaskFloorView.h"

@implementation YWTLoginMaskFloorView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createMaskFloorView];
    }
    return self;
}
-(void) createMaskFloorView{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.05;
}

@end
