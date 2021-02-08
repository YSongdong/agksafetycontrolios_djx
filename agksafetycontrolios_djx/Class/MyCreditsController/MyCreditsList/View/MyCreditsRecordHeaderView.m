//
//  MyCreditsRecordHeaderView.m
//  PartyBuildingStar
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import "MyCreditsRecordHeaderView.h"

@implementation MyCreditsRecordHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createHeaderView];
    }
    return self;
}
-(void) createHeaderView{
    __weak typeof(self) weakSelf = self;
    
    UIView *lineView = [[UIView alloc]init];
    [self addSubview:lineView];
    lineView.backgroundColor = [UIColor colorLineE3E3CommonGreyBlackColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(15));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(15));
    }];
    
    UILabel *showLab = [[UILabel alloc]init];
    [self addSubview:showLab];
    showLab.text = @"学习记录";
    showLab.textColor = [UIColor colorCommonBlackColor];
    showLab.font = BFont(13);
    [showLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(19));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
    // 竖线 view
    UIView *landSpaceView = [[UIView alloc]init];
    [self addSubview:landSpaceView];
    landSpaceView.backgroundColor = [UIColor colorConstantCommonBlueColor];
    [landSpaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(showLab.mas_left).offset(-KSIphonScreenW(5));
        make.width.equalTo(@2);
        make.height.equalTo(@(KSIphonScreenH(13)));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
}




@end
