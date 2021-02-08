//
//  LibayExerBottomToolView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/2/14.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTLibayExerBottomToolView.h"

@implementation YWTLibayExerBottomToolView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createBottomToolView];
    }
    return self;
}
-(void) createBottomToolView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    for (int i = 0 ; i < 3; i++) {
        UIButton *btn = [[UIButton alloc]init];
        [self addSubview:btn];
        [btn setTitle:@"" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorCommonBlackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = Font(12);
        btn.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
        btn.tag = 100+i;
        CGFloat w = KScreenW/3;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset(i*w);
            make.height.equalTo(weakSelf.mas_height);
            make.width.equalTo(@(w));
            make.centerY.equalTo(weakSelf.mas_centerY);
        }];
        [btn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i < 2) {
            UIImageView *btnLineImageV = [[UIImageView alloc]init];
            [weakSelf addSubview:btnLineImageV];
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
    [self addSubview:errorQuestView];
    
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
    [self addSubview:collectView];
    
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
    [self addSubview:self.samilLearnBtn];
    [self.samilLearnBtn setTitle:@"开始学习" forState:UIControlStateNormal];
    [self.samilLearnBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.samilLearnBtn.titleLabel.font = BFont(13);
    self.samilLearnBtn.userInteractionEnabled = YES;
    self.samilLearnBtn.tag = 102;
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


@end
