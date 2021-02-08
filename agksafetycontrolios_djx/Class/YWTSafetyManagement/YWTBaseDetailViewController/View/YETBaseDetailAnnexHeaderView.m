//
//  BaseDetailAnnexHeaderView.m
//  PartyBuildingStar
//
//  Created by mac on 2019/5/22.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import "YETBaseDetailAnnexHeaderView.h"

@interface YETBaseDetailAnnexHeaderView ()
// 显示附件lab
@property (nonatomic,strong) UILabel *showAnnexLab;
// 附件说明lab
@property (nonatomic,strong) UILabel *showAnnexMarkLab;
@end

@implementation YETBaseDetailAnnexHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createHeaderView];
    }
    return self;
}
-(void) createHeaderView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorTextWhiteColor];
    
    // 显示附件lab
    self.showAnnexLab = [[UILabel alloc]init];
    [self addSubview:self.showAnnexLab];
    self.showAnnexLab.text = @"附件";
    self.showAnnexLab.textColor = [UIColor colorCommonBlackColor];
    self.showAnnexLab.font = BFont(15);
    [self.showAnnexLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(KSIphonScreenH(20));
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
    }];
    
    // 附件说明lab
    self.showAnnexMarkLab = [[UILabel alloc]init];
    [self addSubview:self.showAnnexMarkLab];
    self.showAnnexMarkLab.text = @"";
    self.showAnnexMarkLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.showAnnexMarkLab.font = Font(12);
    self.showAnnexMarkLab.numberOfLines = 0;
    [self.showAnnexMarkLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.showAnnexLab.mas_bottom).offset(KSIphonScreenH(7));
        make.left.equalTo(weakSelf.showAnnexLab.mas_left);
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
    }];
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    // 判断字典存不存在字段
    if (![[dict allKeys] containsObject:@"infoRemork"]) {
        return;
    }
    NSString *annexMarkStr = [NSString stringWithFormat:@"%@",dict[@"infoRemork"]];
    if (![annexMarkStr isEqualToString:@""]) {
        NSString *markStr = [NSString stringWithFormat:@"(%@)",annexMarkStr];
        self.showAnnexMarkLab.text =markStr;
    }
}

// 计算高度
+(CGFloat) getWithAnnexHeaderHeight:(NSDictionary *) dict{
    CGFloat height = KSIphonScreenH(20);
    
    NSString *showAnnexStr = @"附件";
    CGFloat annexHeight = [YWTTools getLabelHeightWithText:showAnnexStr width:KScreenW-24 font:15];
    height += annexHeight;
    height += KSIphonScreenH(7);
    
    // 判断字典存不存在字段
    if (![[dict allKeys] containsObject:@"infoRemork"]) {
        return height;
    }
    
    NSString *annexMarkStr = [NSString stringWithFormat:@"%@",dict[@"infoRemork"]];
    if (![annexMarkStr isEqualToString:@""]) {
        NSString *markStr = [NSString stringWithFormat:@"(%@)",annexMarkStr];
        CGFloat annexMarkHeight = [YWTTools getSpaceLabelHeight:markStr withFont:12 withWidth:KScreenW-24 withSpace:2];
        height += annexMarkHeight;
        height += KSIphonScreenH(10);
    }
    return height;
}




@end
