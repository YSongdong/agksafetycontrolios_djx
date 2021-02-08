//
//  CreditChartRankingCell.m
//  PartyBuildingStar
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import "CreditChartRankingCell.h"

@interface CreditChartRankingCell ()

// 排名图片
@property (nonatomic,strong) UIImageView *rankImageV;
// 排名lab
@property (nonatomic,strong) UILabel *rankLab;
// 头像
@property (nonatomic,strong) UIImageView *headImageV;
// 名字
@property (nonatomic,strong) UILabel *nameLab;
// 总分
@property (nonatomic,strong) UILabel *totalScroeLab;

@end


@implementation CreditChartRankingCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createRankView];
    }
    return self;
}
-(void) createRankView{
    __weak typeof(self) weakSelf = self;
    
    UIView *lineView = [[UIView alloc]init];
    [self addSubview:lineView];
    lineView.backgroundColor = [UIColor colorLineE3E3CommonGreyBlackColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(14));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
        make.bottom.equalTo(weakSelf);
        make.height.equalTo(@1);
    }];
    
    // 排名lab
    self.rankLab = [[UILabel alloc]init];
    [self addSubview:self.rankLab];
    self.rankLab.text = @"1";
    self.rankLab.textColor = [UIColor colorWithHexString:@"#999999"];
    self.rankLab.font = Font(15);
    self.rankLab.textAlignment = NSTextAlignmentCenter;
    [self.rankLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.equalTo(@50);
    }];
    
    // 排名图片
    self.rankImageV = [[UIImageView alloc]init];
    [self addSubview:self.rankImageV];
    self.rankImageV.image  = [UIImage imageNamed:@"creditChart_rank_one"];
    [self.rankImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.rankLab.mas_centerX);
        make.centerY.equalTo(weakSelf.rankLab.mas_centerY);
    }];
    // 默认隐藏
    self.rankImageV.hidden = YES;
    
    // 头像
    self.headImageV = [[UIImageView alloc]init];
    [self addSubview:self.headImageV];
    self.headImageV.image = [UIImage imageNamed:@"taskCenter_header_nomal"];
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(KSIphonScreenH(30)));
        make.left.equalTo(weakSelf.rankLab.mas_right).offset(KSIphonScreenW(10));
        make.centerY.equalTo(weakSelf.rankLab.mas_centerY);
    }];
    self.headImageV.layer.cornerRadius = KSIphonScreenH(30)/2;
    self.headImageV.layer.masksToBounds = YES;
  
    // 姓名
    self.nameLab = [[UILabel alloc]init];
    [self addSubview:self.nameLab];
    self.nameLab.text = @"";
    self.nameLab.textColor = [UIColor colorCommonBlackColor];
    self.nameLab.font = BFont(15);
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headImageV.mas_right).offset(KSIphonScreenW(17));
        make.centerY.equalTo(weakSelf.headImageV.mas_centerY);
        make.width.equalTo(@(KSIphonScreenW(130)));
    }];
    
    //
    UILabel *showLab = [[UILabel alloc]init];
    [self addSubview:showLab];
    showLab.text = @"分";
    showLab.textColor = [UIColor colorCommon65GreyBlackColor];
    showLab.font = Font(12);
    [showLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
        make.centerY.equalTo(weakSelf.headImageV.mas_centerY);
    }];
    
    // 总分
    self.totalScroeLab = [[UILabel alloc]init];
    [self addSubview:self.totalScroeLab];
    self.totalScroeLab.text = @"";
    self.totalScroeLab.textColor = [UIColor colorWithHexString:@"#0088ff"];
    self.totalScroeLab.font = BFont(18);
    self.totalScroeLab.textAlignment = NSTextAlignmentRight;
    [self.totalScroeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(showLab.mas_left).offset(-KSIphonScreenW(10));
        make.centerY.equalTo(showLab.mas_centerY);
    }];
    
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    // 名次
    NSString *ranKingStr = [NSString stringWithFormat:@"%@",dict[@"ranKing"]];
    if ([ranKingStr integerValue] > 3) {
        self.rankImageV.hidden = YES;
        self.rankLab.hidden = NO;
    }else{
        if ([ranKingStr integerValue] == 1) {
            self.rankImageV.image = [UIImage imageNamed:@"creditChart_rank_one"];
        }else if ([ranKingStr integerValue] == 2){
            self.rankImageV.image = [UIImage imageNamed:@"creditChart_rank_two"];
        }else{
            self.rankImageV.image = [UIImage imageNamed:@"creditChart_rank_three"];
        }
       self.rankImageV.hidden = NO;
        self.rankLab.hidden = YES;
    }
    self.rankLab.text = ranKingStr;
    
    // 头像
    NSString *iconStr = [NSString stringWithFormat:@"%@",dict[@"photo"]];
    // 字符串和UTF8编码转换
    NSString *urlUTF8Str = [iconStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [YWTTools sd_setImageView:self.headImageV WithURL:urlUTF8Str andPlaceholder:@"taskCenter_header_nomal"];
    
    // 姓名
    self.nameLab.text = [NSString stringWithFormat:@"%@",dict[@"realName"]];
    
    // 学分
    self.totalScroeLab.text = [NSString stringWithFormat:@"%@",dict[@"credit"]];
   
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
