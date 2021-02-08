//
//  QuestTypeCollectionViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/2/14.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTQuestTypeCollectionViewCell.h"

@interface YWTQuestTypeCollectionViewCell ()

@property (nonatomic,strong) UIImageView *typeImageV;

@property (nonatomic,strong) UILabel *typeLab;

@property (nonatomic,strong) UILabel *questNumberLab;

@property (nonatomic,strong) UIView *lineView;

@end

@implementation YWTQuestTypeCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createTypeView];
    }
    return self;
}
-(void) createTypeView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorTextWhiteColor];
    
    self.typeImageV = [[UIImageView alloc]init];
    [self addSubview:self.typeImageV];
    self.typeImageV.image = [UIImage imageNamed:@"zxlx_ico01"];
    [self.typeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(18));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
    self.typeLab = [[UILabel alloc]init];
    [self addSubview:self.typeLab];
    self.typeLab.text = @"单选题";
    self.typeLab.textColor = [UIColor colorCommonBlackColor];
    self.typeLab.font = Font(15);
    [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.typeImageV.mas_right).offset(KSIphonScreenW(10));
        make.centerY.equalTo(weakSelf.typeImageV.mas_centerY);
    }];
    
    self.questNumberLab = [[UILabel alloc]init];
    [self addSubview:self.questNumberLab];
    self.questNumberLab.text = @"0";
    self.questNumberLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.questNumberLab.font = Font(13);
    [self.questNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.typeLab.mas_right).offset(KSIphonScreenW(22));
        make.centerY.equalTo(weakSelf.typeLab.mas_centerY);
    }];
    
    self.lineView = [[UIView alloc]init];
    [self addSubview:self.lineView];
    self.lineView.backgroundColor = [UIColor colorWithHexString:@"#f3f3f3"];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.equalTo(@1);
        make.height.equalTo(@(KSIphonScreenH(26)));
    }];
    
    UIView *bottomLineView = [[UIView alloc]init];
    [self addSubview:bottomLineView];
    bottomLineView.backgroundColor = [UIColor colorWithHexString:@"#f3f3f3"];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf);
        make.height.equalTo(@1);
    }];
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    self.typeLab.text = dict[@"type"];
    
    self.questNumberLab.text = [NSString stringWithFormat:@"%@",dict[@"number"]];
    
    self.typeImageV.image = [UIImage imageNamed:dict[@"image"]];
    
}

-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}

@end
