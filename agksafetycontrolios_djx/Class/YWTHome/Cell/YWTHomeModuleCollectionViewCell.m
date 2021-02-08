//
//  HomeModuleCollectionViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/4.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTHomeModuleCollectionViewCell.h"

@interface YWTHomeModuleCollectionViewCell ()

@property (nonatomic,strong) UIImageView *moduleImageV;

@property (nonatomic,strong) UIImageView *moduleStatuImageV;

@property (nonatomic,strong) UILabel *moduleNameLab;

@property (nonatomic,strong) UILabel *moduleEnglishLab;

@end

@implementation YWTHomeModuleCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createModuleView];
    }
    return self;
}
-(void) createModuleView{
    __weak typeof(self) weakSelf = self;
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor =   [UIColor colorStyleLeDarkWithConstantColor:[UIColor colorConstantStyleDarkColor]normalCorlor:[UIColor colorTextWhiteColor]];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    UIView *moduleView = [[UIView alloc]init];
    [bgView addSubview:moduleView];
    
    //  模块图片
    self.moduleImageV = [[UIImageView alloc]init];
    [moduleView addSubview:self.moduleImageV];
    self.moduleImageV.image = [UIImage imageNamed:@"home_libayExercise"];
    self.moduleImageV.contentMode = UIViewContentModeScaleAspectFit;
    [self.moduleImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moduleView.mas_top);
        make.centerX.equalTo(moduleView.mas_centerX);
        make.width.equalTo(@(KSIphonScreenW(95)));
        make.height.equalTo(@(KSIphonScreenH(95)));
    }];
    
    // 模块新状态图片
    self.moduleStatuImageV = [[UIImageView alloc]init];
    [moduleView addSubview:self.moduleStatuImageV];
    self.moduleStatuImageV.image = [UIImage imageNamed:@"home_new"];
    [self.moduleStatuImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.moduleImageV).offset(KSIphonScreenH(8.5));
        make.right.equalTo(weakSelf.moduleImageV).offset(-KSIphonScreenW(17));
    }];
    
    self.moduleNameLab = [[UILabel alloc]init];
    [moduleView addSubview:self.moduleNameLab];
    self.moduleNameLab.text = @"教育培训";
    self.moduleNameLab.textColor = [UIColor colorCommonBlackColor];
    self.moduleNameLab.font = Font(16);
    [self.moduleNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.moduleImageV.mas_bottom);
        make.centerX.equalTo(weakSelf.moduleImageV.mas_centerX);
    }];
    
    self.moduleEnglishLab = [[UILabel alloc]init];
    [moduleView addSubview:self.moduleEnglishLab];
    self.moduleEnglishLab.text = @"Topic Exercises";
    self.moduleEnglishLab.textColor = [UIColor colorWithHexString:@"#bbbcc9"];
    self.moduleEnglishLab.font = Font(12);
    [self.moduleEnglishLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.moduleNameLab.mas_bottom).offset(KSIphonScreenH(5));
        make.centerX.equalTo(weakSelf.moduleNameLab.mas_centerX);
    }];
    
    [moduleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.moduleImageV.mas_top);
        make.left.equalTo(weakSelf.moduleImageV.mas_left);
        make.right.equalTo(weakSelf.moduleImageV.mas_right);
        make.bottom.equalTo(weakSelf.moduleEnglishLab.mas_bottom);
        make.centerX.equalTo(bgView.mas_centerX);
        make.centerY.equalTo(bgView.mas_centerY);
    }];
    
    //适配黑暗模式
    if (@available(iOS 13.0, *)) {
        self.moduleNameLab.textColor = [UIColor labelColor];
        self.moduleEnglishLab.textColor = [UIColor placeholderTextColor];
    }else{
        self.moduleNameLab.textColor = [UIColor colorCommonBlackColor];
        self.moduleEnglishLab.textColor = [UIColor colorWithHexString:@"#bbbcc9"];
    }
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
    
    // 模块英文字
    self.moduleEnglishLab.text = dict[@"titleEnglish"];
    
    // 是否显示new 图片
    if ([dict[@"newest"] boolValue]) {
        self.moduleStatuImageV.hidden = NO;
    }else{
        self.moduleStatuImageV.hidden = YES;
    }
}



@end
