//
//  YWTCellVideoView.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/4.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTCellVideoView.h"

@implementation YWTCellVideoView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =  [super initWithFrame:frame]) {
        [self createVideoView];
    }
    return self;
}
-(void) createVideoView{
    WS(weakSelf);
    _coverImageV = [[UIImageView alloc]init];
    [self addSubview:_coverImageV];
    _coverImageV.image = [UIImage imageNamed:@"patry_list_video_default"];
    _coverImageV.userInteractionEnabled = YES;
    [_coverImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectTap)];
    [_coverImageV addGestureRecognizer:tap];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btn];
    [btn setImage:[UIImage imageNamed:@"base_wjxq_pullUpNews"] forState:UIControlStateNormal];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.coverImageV.mas_centerX);
        make.centerY.equalTo(weakSelf.coverImageV.mas_centerY);
    }];
    [btn addTarget:self action:@selector(selectPlayBtn:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setCoverUrlStr:(NSString *)coverUrlStr{
    _coverUrlStr = coverUrlStr;
    [YWTTools sd_setImageView:self.coverImageV WithURL:coverUrlStr andPlaceholder:@"patry_list_video_default"];
}

-(void) selectTap{
    self.selectPlayVideo();
}
-(void) selectPlayBtn:(UIButton *)sender{
    [self selectTap];
}

@end
