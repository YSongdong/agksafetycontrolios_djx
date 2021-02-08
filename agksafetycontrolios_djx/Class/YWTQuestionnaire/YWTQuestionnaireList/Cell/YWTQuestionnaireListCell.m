//
//  YWTQuestionnaireListCell.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/17.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTQuestionnaireListCell.h"

@interface YWTQuestionnaireListCell ()
// 名称
@property (nonatomic,strong) UILabel *nameLab;
// 内容
@property (nonatomic,strong) UILabel *contentLab;

@end

@implementation YWTQuestionnaireListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createListCell];
    }
    return self;
}
-(void) createListCell{
    WS(weakSelf);
    self.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];

    self.nameLab = [[UILabel alloc]init];
    [bgView addSubview:self.nameLab];
    self.nameLab.text = @"";
    self.nameLab.textColor = [UIColor colorCommonBlackColor];
    self.nameLab.font = BFont(15);
    self.nameLab.numberOfLines = 0;
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(KSIphonScreenH(17));
        make.left.equalTo(bgView).offset(KSIphonScreenW(12));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(12));
    }];
    [UILabel  changeLineSpaceForLabel:self.nameLab WithSpace:3];
    
    self.contentLab = [[UILabel alloc]init];
    [bgView addSubview:self.contentLab];
    self.contentLab.text  =@"";
    self.contentLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.contentLab.font = Font(12);
    self.contentLab.numberOfLines = 0;
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLab.mas_bottom).offset(KSIphonScreenH(20));
        make.left.right.equalTo(weakSelf.nameLab);
    }];
    [UILabel  changeLineSpaceForLabel:self.contentLab WithSpace:3];
    
    UIButton *beginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:beginBtn];
    [beginBtn setTitle:@"开始调查" forState:UIControlStateNormal];
    [beginBtn setTitleColor:[UIColor colorLineCommonBlueColor] forState:UIControlStateNormal];
    beginBtn.titleLabel.font = BFont(14);
    beginBtn.backgroundColor = [UIColor colorTextWhiteColor];
    beginBtn.enabled = NO;
    [beginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentLab.mas_bottom).offset(KSIphonScreenH(20));
        make.left.right.bottom.equalTo(bgView);
        make.height.equalTo(@(KSIphonScreenH(48)));
    }];
    
    UIView *lineView = [[UIView alloc]init];
    [bgView addSubview:lineView];
    lineView.backgroundColor = [UIColor colorLineE3E3CommonGreyBlackColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(beginBtn.mas_top);
        make.left.equalTo(bgView).offset(KSIphonScreenW(12));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(12));
        make.height.equalTo(@0.5);
        make.centerX.equalTo(beginBtn.mas_centerX);
    }];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.right.bottom.equalTo(weakSelf).offset(-KSIphonScreenW(12));
    }];
    bgView.layer.cornerRadius = 8;
    bgView.layer.masksToBounds = YES;
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    // 标题
    self.nameLab.text =[NSString stringWithFormat:@"%@",dict[@"title"]];
    // 内容
    self.contentLab.text = [NSString stringWithFormat:@"%@",dict[@"content"]];
    
}

// 计算高度
+(CGFloat) getWithListCellHeight:(NSDictionary*)dict{
    CGFloat height = 0;
    height += KSIphonScreenH(17);
    
    // 标题
    CGFloat titleHight = [YWTTools  getSpaceLabelHeight:dict[@"title"] withFont:15 withWidth:KScreenW-12*4 withSpace:3];
    height += titleHight;
    height +=KSIphonScreenH(20);
    
    // 内容
    CGFloat contentHeight = [YWTTools  getSpaceLabelHeight:dict[@"content"] withFont:15 withWidth:KScreenW-12*4 withSpace:3];
    height += contentHeight;
    height +=KSIphonScreenH(20);
    
    height += KSIphonScreenH(48);
    return height;
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
