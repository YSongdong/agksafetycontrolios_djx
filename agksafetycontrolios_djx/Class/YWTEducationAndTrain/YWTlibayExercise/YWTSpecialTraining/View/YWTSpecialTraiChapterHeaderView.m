//
//  SpecialTraiFooterView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/2/14.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTSpecialTraiChapterHeaderView.h"

@implementation YWTSpecialTraiChapterHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self  = [super initWithFrame:frame]) {
        [self createFooterView];
    }
    return self;
}
-(void) createFooterView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5f"];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    UILabel *lab = [[UILabel alloc]init];
    [bgView addSubview:lab];
    lab.text = @"按章节练习";
    lab.textColor = [UIColor colorCommonBlackColor];
    lab.font = BFont(18);
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(KSIphonScreenW(12));
        make.top.equalTo(bgView).offset(KSIphonScreenH(23));
    }];
    
    UIImageView *chapterImageV =[[ UIImageView alloc]init];
    [bgView addSubview:chapterImageV];
    chapterImageV.image = [UIImage imageNamed:@"zxlx_ico06"];
    [chapterImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lab.mas_left);
        make.top.equalTo(lab.mas_bottom).offset(KSIphonScreenH(20));
    }];
    
    UILabel *showTotalQusetNumberLab = [[UILabel alloc]init];
    [bgView addSubview:showTotalQusetNumberLab];
    showTotalQusetNumberLab.text = @"全部题目";
    showTotalQusetNumberLab.textColor = [UIColor colorCommonBlackColor];
    showTotalQusetNumberLab.font = Font(16);
    [showTotalQusetNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(chapterImageV.mas_right).offset(KSIphonScreenW(7));
        make.centerY.equalTo(chapterImageV.mas_centerY);
    }];
    
    self.totalQusetNumberLab = [[UILabel alloc]init];
    [bgView addSubview:self.totalQusetNumberLab];
    self.totalQusetNumberLab.text = @"0";
    self.totalQusetNumberLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.totalQusetNumberLab.font = Font(13);
    [self.totalQusetNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView).offset(-KSIphonScreenW(12));
        make.centerY.equalTo(showTotalQusetNumberLab.mas_centerY);
    }];

    UIView *lineView = [[UIView alloc]init];
    [bgView addSubview:lineView];
    lineView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(bgView);
        make.height.equalTo(@1);
    }];
}

@end
