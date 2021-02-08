//
//  HomeViewModel.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/7.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTHomeViewModel.h"

@implementation YWTHomeViewModel

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super init]) {
        _bgView = [[UIView alloc]initWithFrame:frame];
        _bgView.backgroundColor = [UIColor redColor];
        [_bgView addSubview:_homeCollectView];
    }
    return self;
}




@end
