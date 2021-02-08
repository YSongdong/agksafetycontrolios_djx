//
//  CreditChartListHeaderView.m
//  PartyBuildingStar
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import "CreditChartListHeaderView.h"

@interface CreditChartListHeaderView ()
// 头像
@property (nonatomic,strong) UIImageView *headImageV;
// 排名
@property (nonatomic,strong) UILabel *showRankingLab;
// 总分
@property (nonatomic,strong) UILabel *showTotalScoreLab;

@end



@implementation CreditChartListHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createHeaderView];
    }
    return self;
}
-(void) createHeaderView{
    __weak typeof(self) weakSelf = self;
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [bgView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    UIImageView *bgImageV = [[UIImageView alloc]init];
    [bgView addSubview:bgImageV];
    bgImageV.image  = [UIImage imageNamed:@"creditChart_list_bg"];
    [bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    // 头像view
    UIView *headView = [[UIView alloc]init];
    [bgView addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(KSIphonScreenH(12));
        make.centerX.equalTo(bgView.mas_centerX);
        make.width.height.equalTo(@(KSIphonScreenW(62)));
    }];
    headView.layer.cornerRadius = KSIphonScreenW(62)/2;
    headView.layer.masksToBounds = YES;
    headView.layer.borderWidth = 1;
    headView.layer.borderColor  = [UIColor colorTextWhiteColor].CGColor;
    
    // 头部图片
    self.headImageV = [[UIImageView alloc]init];
    [headView addSubview:self.headImageV];
    self.headImageV.image = [UIImage imageNamed:@"taskCenter_header_nomal"];
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(KSIphonScreenW(56)));
        make.centerX.equalTo(headView.mas_centerX);
        make.centerY.equalTo(headView.mas_centerY);
    }];
    self.headImageV.layer.cornerRadius = KSIphonScreenW(56)/2;
    self.headImageV.layer.masksToBounds = YES;
    
    // 竖线 view
    UIView *landSpaceView = [[UIView alloc]init];
    [bgView addSubview:landSpaceView];
    landSpaceView.backgroundColor = [UIColor colorTextWhiteColor];
    [landSpaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView.mas_bottom).offset(KSIphonScreenH(10));
        make.width.equalTo(@1);
        make.height.equalTo(@(KSIphonScreenH(20)));
        make.centerX.equalTo(headView.mas_centerX);
    }];
    
    // 排名
    self.showRankingLab = [[UILabel alloc]init];
    [bgView addSubview:self.showRankingLab];
    self.showRankingLab.text = @"第0名";
    self.showRankingLab.textColor = [UIColor colorTextWhiteColor];
    self.showRankingLab.font = Font(16);
    [self.showRankingLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(landSpaceView.mas_left).offset(-KSIphonScreenW(31));
        make.centerY.equalTo(landSpaceView.mas_centerY);
    }];
    
    // 总分
    self.showTotalScoreLab = [[UILabel alloc]init];
    [bgView addSubview:self.showTotalScoreLab];
    self.showTotalScoreLab.text = @"0分";
    self.showTotalScoreLab.textColor = [UIColor colorTextWhiteColor];
    self.showTotalScoreLab.font = Font(16);
    [self.showTotalScoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(landSpaceView.mas_right).offset(KSIphonScreenW(31));
        make.centerY.equalTo(landSpaceView.mas_centerY);
    }];
    
}

//更新用户信息
-(void) updateUserInfoDict:(NSDictionary*)dict{
    // 头像
    NSString *iconStr = [NSString stringWithFormat:@"%@",dict[@"photo"]];
    // 字符串和UTF8编码转换
    NSString *urlUTF8Str = [iconStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [YWTTools sd_setImageView:self.headImageV WithURL:urlUTF8Str andPlaceholder:@"taskCenter_header_nomal"];
    
    // 名次
    self.showRankingLab.text =[NSString stringWithFormat:@"第%@名",dict[@"ranKing"]];
    
    // 总分
    self.showTotalScoreLab.text = [NSString stringWithFormat:@"%@分",dict[@"credit"]];
}





@end
