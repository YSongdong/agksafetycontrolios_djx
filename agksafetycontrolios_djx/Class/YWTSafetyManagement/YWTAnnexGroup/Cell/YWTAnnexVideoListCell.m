//
//  AnnexVideoListCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/25.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTAnnexVideoListCell.h"

@interface YWTAnnexVideoListCell ()

@property (nonatomic,strong) UIImageView *converImageV;

@property (nonatomic,strong) UILabel *timerLab;

@end

@implementation YWTAnnexVideoListCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createCellView];
    }
    return self;
}

-(void) createCellView{
    __weak typeof(self) weakSelf = self;
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    self.converImageV = [[UIImageView alloc]init];
    [bgView addSubview:self.converImageV ];
    self.converImageV.image = [UIImage imageNamed:@""];
    [self.converImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bgView);
    }];
    
    UIImageView *imageV = [[UIImageView alloc]init];
    [bgView addSubview:imageV];
    imageV.image = [UIImage imageNamed:@""];
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(KSIphonScreenW(5));
        make.bottom.equalTo(bgView.mas_bottom).offset(-KSIphonScreenH(4));
    }];
    
    self.timerLab =[[UILabel alloc]init];
    [bgView addSubview:self.timerLab];
    self.timerLab.text = @"";
    self.timerLab.textColor = [UIColor colorTextWhiteColor];
    self.timerLab.font = Font(12);
    self.timerLab.textAlignment = NSTextAlignmentRight;
    [self.timerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView).offset(-KSIphonScreenW(5));
        make.centerY.equalTo(imageV.mas_centerY);
        make.left.equalTo(bgView).offset(KSIphonScreenW(40));
    }];
}



@end
