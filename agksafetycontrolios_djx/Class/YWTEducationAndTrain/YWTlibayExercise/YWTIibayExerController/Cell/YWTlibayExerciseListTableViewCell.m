//
//  libayExerciseListTableViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/26.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTlibayExerciseListTableViewCell.h"

@interface YWTlibayExerciseListTableViewCell ()
// 题库名称
@property (nonatomic,strong) UILabel *libayExerNameLab;
// 题目数量
@property (nonatomic,strong) UILabel *questTotalLab;
// 更新时间
@property (nonatomic,strong) UILabel *updateTimerLab;
// 进度条
@property (nonatomic,strong) UIProgressView *learnProgressView;
// 学习进度
@property (nonatomic,strong) UILabel *learnProgressLab;
// 学习比例
@property (nonatomic,strong) UILabel *learnProportionLab;
// 开始学习
@property (nonatomic,strong)  UIButton *samilLearnBtn;

@end



@implementation YWTlibayExerciseListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createListTableViewCell];
    }
    return self;
}
-(void) createListTableViewCell{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
        make.bottom.equalTo(weakSelf).offset(-KSIphonScreenH(12));
    }];
    bgView.layer.cornerRadius = KSIphonScreenH(15)/2;
    bgView.layer.masksToBounds = YES;
    bgView.layer.borderWidth = 1;
    bgView.layer.borderColor = [UIColor colorWithHexString:@"#e5e5e5"].CGColor;
    
    self.libayExerNameLab = [[UILabel alloc]init];
    [bgView addSubview:self.libayExerNameLab];
    self.libayExerNameLab.textColor = [UIColor colorCommonBlackColor];
    self.libayExerNameLab.font = BFont(17);
    [self.libayExerNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(KSIphonScreenH(15));
        make.left.equalTo(bgView).offset(KSIphonScreenW(15));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(15));
        make.centerX.equalTo(bgView.mas_centerX);
    }];
    
    self.questTotalLab = [[UILabel alloc]init];
    [bgView addSubview:self.questTotalLab];
    self.questTotalLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.questTotalLab.font = Font(13);
    [self.questTotalLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.libayExerNameLab.mas_bottom).offset(KSIphonScreenH(15));
        make.left.equalTo(bgView).offset(KSIphonScreenW(15));
    }];
    
    self.updateTimerLab = [[UILabel alloc]init];
    [bgView addSubview:self.updateTimerLab];
    self.updateTimerLab.textColor  = [UIColor colorCommonGreyBlackColor];
    self.updateTimerLab.font = Font(13);
    self.updateTimerLab.textAlignment =  NSTextAlignmentRight;
    [self.updateTimerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView).offset(-KSIphonScreenW(15));
        make.centerY.equalTo(weakSelf.questTotalLab.mas_centerY);
    }];
    
    // 进度条
    self.learnProgressView = [[UIProgressView alloc]init];
    [bgView addSubview:self.learnProgressView];
    self.learnProgressView.progressTintColor = [UIColor colorConstantCommonBlueColor];
    self.learnProgressView.trackTintColor = [UIColor colorWithHexString:@"#e9e9e9"];
    [self.learnProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.questTotalLab.mas_bottom).offset(KSIphonScreenH(15));
        make.left.equalTo(bgView).offset(KSIphonScreenW(70));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(70));
        make.height.equalTo(@4);
    }];
    self.learnProgressView.layer.cornerRadius = 2;
    self.learnProgressView.layer.masksToBounds = YES;
    
    // 学习进度
    self.learnProgressLab = [[UILabel alloc]init];
    [bgView addSubview:self.learnProgressLab];
    self.learnProgressLab.textColor = [UIColor colorCommonBlackColor];
    self.learnProgressLab.font = Font(12);
    [self.learnProgressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.learnProgressView.mas_left);
        make.top.equalTo(weakSelf.learnProgressView.mas_bottom).offset(KSIphonScreenH(6));
    }];
    
     // 学习比例
    self.learnProportionLab = [[UILabel alloc]init];
    [bgView addSubview:self.learnProportionLab];
    self.learnProportionLab.text = @"0/0";
    self.learnProportionLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.learnProportionLab.font = Font(12);
    [self.learnProportionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.learnProgressView.mas_right);
        make.centerY.equalTo(weakSelf.learnProgressLab.mas_centerY);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    [bgView addSubview:lineView];
    lineView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.learnProgressLab.mas_bottom).offset(KSIphonScreenH(15));
        make.left.right.equalTo(bgView);
        make.height.equalTo(@1);
    }];
   
    UIView *btnView = [[UIView alloc]init];
    [bgView addSubview:btnView];
    btnView.backgroundColor = [UIColor colorTextWhiteColor];
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom);
        make.left.right.bottom.equalTo(bgView);
    }];
    
    for (int i = 0 ; i < 3; i++) {
        UIButton *btn = [[UIButton alloc]init];
        [btnView addSubview:btn];
        [btn setTitle:@"" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorCommonBlackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = Font(12);
        btn.backgroundColor = [UIColor colorTextWhiteColor];
        btn.tag = 100+i;
        CGFloat w = (KScreenW-KSIphonScreenW(30))/3;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(btnView);
            make.height.equalTo(@(KSIphonScreenH(50)));
            make.width.equalTo(@(w));
            make.centerY.equalTo(btnView.mas_centerY);
            make.left.equalTo(bgView).offset(i*w);
        }];
        [btn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i < 2) {
            UIImageView *btnLineImageV = [[UIImageView alloc]init];
            [btnView addSubview:btnLineImageV];
            btnLineImageV.image = [UIImage imageNamed:@"ico_line"];
            [btnLineImageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(btn.mas_right);
                make.centerY.equalTo(btn.mas_centerY);
            }];
        }
    }
    // 找到错题巩固
    UIButton *errorQuestBtn = [self viewWithTag:100];
    
    UIView *errorQuestView = [[UIView alloc]init];
    [btnView addSubview:errorQuestView];
    
    UIImageView *errorImageV = [[UIImageView alloc]init];
    [errorQuestView addSubview:errorImageV];
    errorImageV.image = [UIImage imageNamed:@"ico_ctgg"];
    errorImageV.contentMode = UIViewContentModeScaleAspectFit;
    [errorImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(errorQuestView);
        make.centerY.equalTo(errorQuestView.mas_centerY);
    }];
    
    UILabel *errorLab = [[UILabel alloc]init];
    [errorQuestView addSubview:errorLab];
    errorLab.text =@"错题巩固";
    errorLab.font = Font(12);
    errorLab.textColor = [UIColor colorCommonBlackColor];
    [errorLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(errorImageV.mas_right).offset(KSIphonScreenH(7));
        make.centerY.equalTo(errorQuestView.mas_centerY);
        make.right.equalTo(errorQuestView);
    }];
    [errorQuestView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(errorQuestBtn.mas_centerX);
        make.centerY.equalTo(errorQuestBtn.mas_centerY);
    }];
    
    // 我的收藏
    UIButton *collectBtn = [self viewWithTag:101];
    
    UIView *collectView = [[UIView alloc]init];
    [btnView addSubview:collectView];
    
    UIImageView *collectImageV = [[UIImageView alloc]init];
    [collectView addSubview:collectImageV];
    collectImageV.image = [UIImage imageNamed:@"ico_wdsc"];
    collectImageV.contentMode = UIViewContentModeScaleAspectFit;
    [collectImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(collectView);
        make.centerY.equalTo(collectView.mas_centerY);
    }];
    
    UILabel *collectLab = [[UILabel alloc]init];
    [collectView addSubview:collectLab];
    collectLab.text =@"我的收藏";
    collectLab.font = Font(12);
    collectLab.textColor = [UIColor colorCommonBlackColor];
    [collectLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(collectImageV.mas_right).offset(KSIphonScreenH(7));
        make.centerY.equalTo(collectView.mas_centerY);
        make.right.equalTo(collectView);
    }];
    [collectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(collectBtn.mas_centerX);
        make.centerY.equalTo(collectBtn.mas_centerY);
    }];
    
    // 找到最后一个btn
    UIButton *beginLearnBtn = [self viewWithTag:102];
    beginLearnBtn.userInteractionEnabled = NO;
    
    self.samilLearnBtn = [[UIButton alloc]init];
    [bgView addSubview:self.samilLearnBtn];
    [self.samilLearnBtn setTitle:@"开始学习" forState:UIControlStateNormal];
    self.samilLearnBtn.titleLabel.font = BFont(13);
    self.samilLearnBtn.userInteractionEnabled = YES;
    self.samilLearnBtn.tag = 102;
    [self.samilLearnBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    [self.samilLearnBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorLineCommonBlueColor]] forState:UIControlStateNormal];
    [self.samilLearnBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorClickCommonBlueColor]] forState:UIControlStateHighlighted];
    [self.samilLearnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(KSIphonScreenH(32)));
        make.left.equalTo(beginLearnBtn.mas_left).offset(KSIphonScreenW(26));
        make.right.equalTo(beginLearnBtn.mas_right).offset(-KSIphonScreenW(15));
        make.centerY.equalTo(beginLearnBtn.mas_centerY);
    }];
    self.samilLearnBtn.layer.cornerRadius = KSIphonScreenH(32)/2;
    self.samilLearnBtn.layer.masksToBounds = YES;
    [self.samilLearnBtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}
// 按钮点击方法
-(void) selectBtnAction:(UIButton *) sender{
    switch (sender.tag - 100) {
        case 0:
        {
            self.errorQuestBlock();
            break;
        }
        case 1:
        {
            self.mineCollecBlock();
            break;
        }
        case 2:
        {
           self.beginLearnBlock();
            break;
        }
        default:
            break;
    }

}
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    // 题库标题
    self.libayExerNameLab.text = [NSString stringWithFormat:@"%@",dict[@"title"]];
    // 题库数量
    self.questTotalLab.text =[NSString stringWithFormat:@"题目数量：%@题",dict[@"totalNum"]];
    // 更新时间
    self.updateTimerLab.text = [NSString stringWithFormat:@"更新时间：%@",dict[@"updateTime"]];
    // 进度条
    self.learnProgressView.progress = [dict[@"percent"] floatValue];
    // 学习进度
    self.learnProgressLab.text =[NSString stringWithFormat:@"学习进度 %d%%",(int)([dict[@"percent"] floatValue]*100)];
    // 学习比例
    NSString *doNumStr = [NSString stringWithFormat:@"%@",dict[@"doNum"]];
    if ([doNumStr integerValue] == 0) {
        self.learnProportionLab.text = [NSString stringWithFormat:@"%@/%@",dict[@"doNum"],dict[@"totalNum"]];
    }else{
        NSString *learStr = [NSString stringWithFormat:@"%@/%@",doNumStr,dict[@"totalNum"]];
        self.learnProportionLab.attributedText = [YWTTools getAttrbuteTextStr:learStr andAlterColorStr:doNumStr andColor:[UIColor colorConstantCommonBlueColor] andFont:Font(12)];
    }
    
    NSString *statusStr = [NSString stringWithFormat:@"%@",dict[@"status"]];
    // 1为继续练习 2为开始练习 3为再次练习
    if ([statusStr isEqualToString:@"1"]) {
        [self.samilLearnBtn setTitle:@"继续学习" forState:UIControlStateNormal];
        [self.samilLearnBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
        [self.samilLearnBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorContinueBtnIsSelectColor:NO]] forState:UIControlStateNormal];
        [self.samilLearnBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorContinueBtnIsSelectColor:YES]] forState:UIControlStateSelected];
    }else if([statusStr isEqualToString:@"2"]){
        [self.samilLearnBtn setTitle:@"开始学习" forState:UIControlStateNormal];
        [self.samilLearnBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
        [self.samilLearnBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorLineCommonBlueColor]] forState:UIControlStateNormal];
    }else if([statusStr isEqualToString:@"3"]){
        [self.samilLearnBtn setTitle:@"再次学习" forState:UIControlStateNormal];
        [self.samilLearnBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
        [self.samilLearnBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorWithHexString:@"#f49894"]] forState:UIControlStateNormal];
        [self.samilLearnBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorWithHexString:@"#f49894"alpha:0.8]] forState:UIControlStateSelected];
    }
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
