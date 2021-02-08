//
//  BaseHorizontalCollectionCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/5.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTBaseHorizontalCollectionCell.h"

@interface YWTBaseHorizontalCollectionCell ()
@property (nonatomic,strong) UIView *baseContentView;
// 模块图片
@property (nonatomic,strong) UIImageView *moduleImageV;
// 模块状态图片
@property (nonatomic,strong) UIImageView *moduleStatuImageV;
// 模块名称
@property (nonatomic,strong) UILabel *moduleNameLab;
// 模块副标题
@property (nonatomic,strong) UILabel *moduleSubmitLab;
@end

@implementation YWTBaseHorizontalCollectionCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createHorizontalView];
    }
    return self;
}
-(void) createHorizontalView{
    __weak typeof(self) weakSelf = self;
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    bgView.layer.shadowColor = [UIColor colorWithHexString:@"#000000"].CGColor;
    bgView.layer.shadowOffset = CGSizeMake(0, 0);
    bgView.layer.shadowOpacity = 0.1;
    bgView.layer.cornerRadius = 7;
    
    // 模块状态图片
    self.moduleStatuImageV = [[UIImageView alloc]init];
    [bgView addSubview:self.moduleStatuImageV];
    self.moduleStatuImageV.image = [UIImage imageNamed:@"ico_jypx_new"];
    [self.moduleStatuImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(bgView);
    }];
    
    self.moduleImageV = [[UIImageView alloc]init];
    [bgView addSubview:self.moduleImageV];
    self.moduleImageV.image = [UIImage imageNamed:@"ico_aqgl_05"];
    [self.moduleImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(KSIphonScreenW(12));
        make.centerY.equalTo(bgView.mas_centerY);
        make.width.height.equalTo(@62);
    }];
    
    UIImageView *rightImageV = [[UIImageView alloc]init];
    [bgView addSubview:rightImageV];
    rightImageV.image = [UIImage imageNamed:@"ico_jt"];
    [rightImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView).offset(-KSIphonScreenW(12));
        make.centerY.equalTo(bgView.mas_centerY);
    }];
    
    self.baseContentView = [[UIView alloc]init];
    [bgView addSubview:self.baseContentView];
    
    // 模块名称
    self.moduleNameLab = [[UILabel alloc]init];
    [self.baseContentView addSubview:self.moduleNameLab];
    self.moduleNameLab.text = @"考勤签到";
    self.moduleNameLab.textColor = [UIColor colorCommonBlackColor];
    self.moduleNameLab.font = BFont(18);
    [self.moduleNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(weakSelf.baseContentView);
    }];
    
    // 模块副标题
    self.moduleSubmitLab = [[UILabel alloc]init];
    [self.baseContentView addSubview:self.moduleSubmitLab];
    self.moduleSubmitLab.text = @"该签就签，不然如何证明你来过？";
    self.moduleSubmitLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.moduleSubmitLab.font = Font(13);
    [self.moduleSubmitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.moduleNameLab.mas_left);
        make.top.equalTo(weakSelf.moduleNameLab.mas_bottom).offset(KSIphonScreenH(6));
    }];
    
    [self.baseContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(KSIphonScreenW(85));
        make.top.equalTo(weakSelf.moduleNameLab.mas_top);
        make.bottom.equalTo(weakSelf.moduleSubmitLab.mas_bottom);
        make.right.equalTo(bgView).offset(-KSIphonScreenW(25));
        make.centerY.equalTo(weakSelf.moduleImageV.mas_centerY);
    }];

}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    // 图片
    NSString *imageUrl = dict[@"image"];
    if ([imageUrl containsString:@"http://"]) {
        [YWTTools sd_setImageView:self.moduleImageV WithURL:imageUrl andPlaceholder:@"home_libayExercise"];
    }else{
        self.moduleImageV.image = [UIImage imageNamed:imageUrl];
    }
    //模块名字
    self.moduleNameLab.text = dict[@"title"];
    
    __weak typeof(self) weakSelf = self;
    // 模块英文字
    NSString *titleEnglishStr = [NSString stringWithFormat:@"%@",dict[@"titleEnglish"]];
    if ([titleEnglishStr isEqualToString:@""]) {
        self.moduleSubmitLab.hidden = YES;
        // 更新约束
        [self.self.baseContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset(KSIphonScreenW(85));
            make.top.equalTo(weakSelf.moduleNameLab.mas_top);
            make.bottom.equalTo(weakSelf.moduleNameLab.mas_bottom);
            make.right.equalTo(weakSelf).offset(-KSIphonScreenW(25));
            make.centerY.equalTo(weakSelf.moduleImageV.mas_centerY);
        }];
    }else{
        self.moduleSubmitLab.hidden = NO;
        self.moduleSubmitLab.text = titleEnglishStr;
        // 更新约束
        [self.self.baseContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset(KSIphonScreenW(85));
            make.top.equalTo(weakSelf.moduleNameLab.mas_top);
            make.bottom.equalTo(weakSelf.moduleSubmitLab.mas_bottom);
            make.right.equalTo(weakSelf).offset(-KSIphonScreenW(25));
            make.centerY.equalTo(weakSelf.moduleImageV.mas_centerY);
        }];
    }
    
    // 是否显示new 图片
    if ([dict[@"newest"] boolValue]) {
        self.moduleStatuImageV.hidden = NO;
    }else{
        self.moduleStatuImageV.hidden = YES;
    }
}




@end
