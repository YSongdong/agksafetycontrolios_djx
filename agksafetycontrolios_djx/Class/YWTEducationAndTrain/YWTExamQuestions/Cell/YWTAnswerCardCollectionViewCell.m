//
//  AnswerCardCollectionViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/18.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTAnswerCardCollectionViewCell.h"

@interface YWTAnswerCardCollectionViewCell ()
@property (nonatomic,strong) UIView *bgView;

@property (nonatomic,strong) UILabel *showNumberLab;
@end

@implementation YWTAnswerCardCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createCardView];
    }
    return self;
}
-(void) createCardView{
    __weak typeof(self) weakSelf = self;
    
    self.bgView = [[UIView alloc]init];
    self.bgView.backgroundColor = [UIColor colorCommonGreyColor];
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    self.bgView.layer.cornerRadius = CGRectGetHeight(self.frame)/2;
    self.bgView.layer.masksToBounds = YES;
    
    self.showNumberLab = [[UILabel alloc]init];
    [self.bgView addSubview:self.showNumberLab];
    self.showNumberLab.textColor = [UIColor colorCommonBlackColor];
    self.showNumberLab.font = Font(14);
    [self.showNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.bgView.mas_centerY);
        make.centerX.equalTo(weakSelf.bgView.mas_centerX);
    }];
}

-(void)setModel:(QuestionListModel *)model{
    _model = model;

    self.showNumberLab.text =[NSString stringWithFormat:@"%@",self.questNumber];
    
    //判断用户有没有选择答案
    NSString *userAnswerStr = [[DataBaseManager sharedManager]getObtainUserSelectAnswer:model.Id];
    if ([userAnswerStr isEqualToString:@""]) {
        //判断是否是当前题
        if ([model.Id isEqualToString:self.questId]) {
            self.bgView.backgroundColor = [UIColor colorWithHexString:@"#dbdbdb"];
            self.bgView.layer.borderWidth = 1;
            self.bgView.layer.borderColor = [UIColor colorWithHexString:@"#c0c0c0"].CGColor;
            self.showNumberLab.textColor = [UIColor colorCommonBlackColor];
        }else{
            self.bgView.backgroundColor = [UIColor colorCommonGreyColor];
            self.bgView.layer.borderWidth = 0;
            self.bgView.layer.borderColor = [UIColor colorCommonGreyColor].CGColor;
            self.showNumberLab.textColor = [UIColor colorCommonBlackColor];
        }
    }else{
        //判断是否是当前题
        if ([model.Id isEqualToString:self.questId]) {
            self.bgView.backgroundColor = [UIColor colorWithHexString:@"#3390e2"];
            self.bgView.layer.borderWidth = 1;
            self.bgView.layer.borderColor = [UIColor colorWithHexString:@"#146ab4"].CGColor;
            self.showNumberLab.textColor = [UIColor colorTextWhiteColor];
        }else{
            self.bgView.backgroundColor = [UIColor colorWithHexString:@"#55b0ff"];
            self.bgView.layer.borderWidth = 0;
            self.bgView.layer.borderColor = [UIColor colorWithHexString:@"#3390e2"].CGColor;
            self.showNumberLab.textColor = [UIColor colorTextWhiteColor];
        }
    } 
}
-(void)setListModel:(ListModel *)listModel{
    _listModel = listModel;
    
    self.showNumberLab.text =[NSString stringWithFormat:@"%@",self.questNumber];
    self.showNumberLab.textColor = [UIColor colorTextWhiteColor];
    
    // 判断  作对2 做错3 未知4
    if ([listModel.selected isEqualToString:@"2"]) {
        //判断是否是当前题
        if ([listModel.qid isEqualToString:self.questId]) {
            self.bgView.backgroundColor = [UIColor colorWithHexString:@"#7ad8a5"];
            self.bgView.layer.borderWidth = 1;
            self.bgView.layer.borderColor = [UIColor colorWithHexString:@"#4f916d"].CGColor;
            self.showNumberLab.textColor = [UIColor colorTextWhiteColor];
        }else{
            self.bgView.backgroundColor = [UIColor colorWithHexString:@"#7ad8a5"];
            self.bgView.layer.borderWidth = 0;
            self.bgView.layer.borderColor = [UIColor colorWithHexString:@"#7ad8a5"].CGColor;
            self.showNumberLab.textColor = [UIColor colorTextWhiteColor];
        }
    }else if ([listModel.selected isEqualToString:@"3"]){
        //判断是否是当前题
        if ([listModel.qid isEqualToString:self.questId]) {
            self.bgView.backgroundColor = [UIColor colorWithHexString:@"#e9a4a4"];
            self.bgView.layer.borderWidth = 1;
            self.bgView.layer.borderColor = [UIColor colorWithHexString:@"#a17070"].CGColor;
            self.showNumberLab.textColor = [UIColor colorTextWhiteColor];
        }else{
            self.bgView.backgroundColor = [UIColor colorWithHexString:@"#e9a4a4"];
            self.bgView.layer.borderWidth = 0;
            self.bgView.layer.borderColor = [UIColor colorWithHexString:@"#e9a4a4"].CGColor;
            self.showNumberLab.textColor = [UIColor colorTextWhiteColor];
        }
    }else if ([listModel.selected isEqualToString:@"4"]){
        //判断是否是当前题
        if ([listModel.qid isEqualToString:self.questId]) {
            self.bgView.backgroundColor = [UIColor colorWithHexString:@"#f6bb6d"];
            self.bgView.layer.borderWidth = 1;
            self.bgView.layer.borderColor = [UIColor colorWithHexString:@"#b47e36"].CGColor;
            self.showNumberLab.textColor = [UIColor colorTextWhiteColor];
        }else{
            self.bgView.backgroundColor = [UIColor colorWithHexString:@"#f6bb6d"];
            self.bgView.layer.borderWidth = 0;
            self.bgView.layer.borderColor = [UIColor colorWithHexString:@"#f6bb6d"].CGColor;
            self.showNumberLab.textColor = [UIColor colorTextWhiteColor];
        }
    }
}
-(void)setQuestId:(NSString *)questId{
    _questId = questId;
}
-(void)setQuestNumber:(NSString *)questNumber{
    _questNumber = questNumber;
}

@end
