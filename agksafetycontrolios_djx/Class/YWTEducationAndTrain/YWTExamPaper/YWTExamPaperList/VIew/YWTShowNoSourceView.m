//
//  ShowNoSourceView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/15.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTShowNoSourceView.h"

@implementation YWTShowNoSourceView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createNoSourceView];
    }
    return self;
}

-(void) createNoSourceView{
    self.backgroundColor =  [UIColor colorWithHexString:@"#f0f0f0"];
    __weak typeof(self) weakSelf = self;
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    
    UIImageView *bgImageV = [[UIImageView alloc]init];
    [bgView addSubview:bgImageV];
    bgImageV.image = [UIImage imageNamed:@"zwkt_pic"];
    [bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_top);
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
    
    self.showMarkLab = [[UILabel alloc]init];
    [bgView addSubview:self.showMarkLab];
    self.showMarkLab.text =@"暂无资源";
    self.showMarkLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.showMarkLab.font = BFont(16);
    [self.showMarkLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgImageV.mas_bottom).offset(KSIphonScreenH(17));
        make.centerX.equalTo(bgImageV.mas_centerX);
    }];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgImageV.mas_top);
        make.left.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.showMarkLab.mas_bottom);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
}



@end
