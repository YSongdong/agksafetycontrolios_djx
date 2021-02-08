//
//  BaseVerticalCollectionCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/5.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTBaseVerticalCollectionCell.h"

@interface YWTBaseVerticalCollectionCell ()

@property (nonatomic,strong) UIView *baseContentView;
// 图片
@property (nonatomic,strong) UIImageView *verticalImageV;
// 模块状态图片
@property (nonatomic,strong) UIImageView *moduleStatuImageV;
// 模块名称
@property (nonatomic,strong) UILabel *moduleNameLab;
// 模块线条
@property (nonatomic,strong) UIView *moduleLineView;
// 模块副标题
@property (nonatomic,strong) UILabel *moduleSubmitLab;

@end

@implementation YWTBaseVerticalCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createVerticalView];
    }
    return self;
}
-(void) createVerticalView{
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
    
    self.baseContentView = [[UIView alloc]init];
    [bgView addSubview:self.baseContentView];
    
    // 图片
    self.verticalImageV = [[UIImageView alloc]init];
    [self.baseContentView addSubview:self.verticalImageV];
    self.verticalImageV.image = [UIImage imageNamed:@"ico_aqgl_01"];
    [self.verticalImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.baseContentView);
        make.centerX.equalTo(weakSelf.baseContentView.mas_centerX);
        make.width.height.equalTo(@68);
    }];
    
    // 模块名称
    self.moduleNameLab = [[UILabel alloc]init];
    [self.baseContentView addSubview:self.moduleNameLab];
    self.moduleNameLab.text =@"安全检查";
    self.moduleNameLab.textColor = [UIColor colorCommonBlackColor];
    self.moduleNameLab.font = BFont(18);
    self.moduleNameLab.textAlignment = NSTextAlignmentCenter;
    [self.moduleNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.verticalImageV.mas_bottom).offset(KSIphonScreenH(17));
        make.centerX.equalTo(weakSelf.baseContentView.mas_centerX);
    }];
    
    // 模块线条
    self.moduleLineView = [[UIView alloc]init];
    [self.baseContentView addSubview:self.moduleLineView];
    self.moduleLineView.backgroundColor = [UIColor colorLineCommonBlueColor];
    [self.moduleLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.moduleNameLab.mas_bottom).offset(KSIphonScreenH(12));
        make.centerX.equalTo(weakSelf.moduleNameLab.mas_centerX);
        make.height.equalTo(@3);
        make.width.equalTo(@(KSIphonScreenW(30)));
    }];
    self.moduleLineView.layer.cornerRadius = 3/2;
    self.moduleLineView.layer.masksToBounds = YES;
    
    // 模块副标题
    self.moduleSubmitLab = [[UILabel alloc]init];
    [self.baseContentView addSubview:self.moduleSubmitLab];
    self.moduleSubmitLab.text = @"生命安全，切莫大意";
    self.moduleSubmitLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.moduleSubmitLab.font = Font(13);
    [self.moduleSubmitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.moduleLineView.mas_bottom).offset(KSIphonScreenH(12));
        make.centerX.equalTo(weakSelf.moduleLineView.mas_centerX);
    }];
    
    [self.baseContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.verticalImageV.mas_top);
        make.left.equalTo(bgView).offset(KSIphonScreenW(12));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(12));
        make.bottom.equalTo(weakSelf.moduleSubmitLab.mas_bottom);
        make.centerX.equalTo(bgView.mas_centerX);
        make.centerY.equalTo(bgView.mas_centerY);
    }];
}
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    // 图片
    NSString *imageUrl = dict[@"image"];
    if ([imageUrl containsString:@"http://"]) {
        [YWTTools sd_setImageView:self.verticalImageV WithURL:imageUrl andPlaceholder:@"ico_aqgl_01"];
    }else{
        self.verticalImageV.image = [UIImage imageNamed:imageUrl];
    }
    //模块名字
    self.moduleNameLab.text = dict[@"title"];
    
    __weak typeof(self) weakSelf = self;
    // 模块英文字
    NSString *titleEnglishStr = [NSString stringWithFormat:@"%@",dict[@"titleEnglish"]];
    if ([titleEnglishStr isEqualToString:@""]) {
        self.moduleLineView.hidden = YES;
        self.moduleSubmitLab.hidden = YES;
        // 更新约束
        [self.baseContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.verticalImageV.mas_top);
            make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
            make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
            make.bottom.equalTo(weakSelf.moduleNameLab.mas_bottom);
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.centerY.equalTo(weakSelf.mas_centerY);
        }];
    }else{
        self.moduleLineView.hidden = NO;
        self.moduleSubmitLab.hidden = NO;
        self.moduleSubmitLab.text = titleEnglishStr;
        // 更新约束
        [self.baseContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.verticalImageV.mas_top);
            make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
            make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
            make.bottom.equalTo(weakSelf.moduleSubmitLab.mas_bottom);
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.centerY.equalTo(weakSelf.mas_centerY);
        }];
    }
    //模块线条颜色
    NSString *moduleNameStr = [NSString stringWithFormat:@"%@",dict[@"actionName"]];
    if ([moduleNameStr isEqualToString:@"examCenter"] || [moduleNameStr isEqualToString:@"securityCheck"]) {
        // 我的考试
        self.moduleLineView.backgroundColor = [UIColor colorWithHexString:@"#00d483"];
    }else if ([moduleNameStr isEqualToString:@"classRecord"] || [moduleNameStr isEqualToString:@"myStudies"]){
        // 班会记录
        self.moduleLineView.backgroundColor = [UIColor colorWithHexString:@"#5acbeb"];
    }else if ([moduleNameStr isEqualToString:@"technicalDisclosure"] || [moduleNameStr isEqualToString:@"libayExercise"]){
        // 技术交底
        self.moduleLineView.backgroundColor = [UIColor colorWithHexString:@"#4285f5"];
    }else if ([moduleNameStr isEqualToString:@"violationHan"] || [moduleNameStr isEqualToString:@"examPaper"]){
        // 违章处理
        self.moduleLineView.backgroundColor = [UIColor colorWithHexString:@"#ff8f03"];
    }

    // 是否显示new 图片
    if ([dict[@"newest"] boolValue]) {
        self.moduleStatuImageV.hidden = NO;
    }else{
        self.moduleStatuImageV.hidden = YES;
    }
}

@end
