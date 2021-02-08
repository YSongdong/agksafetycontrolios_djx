//
//  ExamCenterListHeaderView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/22.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTExamCenterListHeaderView.h"

@implementation YWTExamCenterListHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createListHeaderView];
    }
    return self;
}
-(void) createListHeaderView{
    __weak typeof(self) weakSelf  = self;
    
    self.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(KSIphonScreenH(12));
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.bottom.equalTo(weakSelf).offset(-KSIphonScreenH(12));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
    }];
    bgView.layer.cornerRadius = KSIphonScreenH(7);
    bgView.layer.masksToBounds = YES;
    bgView.layer.borderWidth = 1;
    bgView.layer.borderColor =  [UIColor colorLineCommonGreyBlackColor].CGColor;
    
    UIButton *showTitleBtn = [[UIButton alloc]init];
    [bgView addSubview:showTitleBtn];
    [showTitleBtn setTitle:@" 考前须知" forState:UIControlStateNormal];
    showTitleBtn.titleLabel.font = BFont(16);
    [showTitleBtn setTitleColor:[UIColor colorConstantCommonBlueColor] forState:UIControlStateNormal];
    [showTitleBtn setImage:[UIImage imageNamed:@"ico_01"] forState:UIControlStateNormal];
    [showTitleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(KSIphonScreenH(12));
        make.centerX.equalTo(bgView);
    }];
    
    
    UIView *contentView = [[UIView alloc]init];
    [bgView addSubview:contentView];
   
    UILabel *showContentLab = [[UILabel alloc]init];
    [contentView addSubview:showContentLab];
    NSString *str = @"1、请保证手机电量充足，网络畅通 \n2、请携带本人身份证件 \n3、考试过程中随机身份认证，请于考前上传留底照片。";
    NSString *msg;
    msg = [NSString stringWithFormat:@"%@",
           [str stringByReplacingOccurrencesOfString:@"\\n" withString:@" \r\n" ]];
    showContentLab.text =msg;
    showContentLab.textColor = [UIColor colorCommon65GreyBlackColor];
    showContentLab.font = BFont(15);
    showContentLab.numberOfLines = 0;
    [showContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView);
        make.left.right.equalTo(contentView);
        make.bottom.equalTo(contentView);
    }];
    [YWTTools changeLineSpaceForLabel:showContentLab WithSpace:3 andFont:Font(13)];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(showTitleBtn.mas_bottom).offset(KSIphonScreenH(12));
        make.centerX.equalTo(bgView.mas_centerX);
    }];
    
    
}





@end
