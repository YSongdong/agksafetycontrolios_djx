//
//  ExamScoreUnpubilshBtnCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/23.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTExamScoreUnpubilshBtnCell.h"

@implementation YWTExamScoreUnpubilshBtnCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createExamPaperView];
    }
    return self;
}
-(void)createExamPaperView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorTextWhiteColor];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    UIButton *backHomeBtn = [[UIButton alloc]init];
    [bgView addSubview:backHomeBtn];
    [backHomeBtn setTitle:@"回到首页" forState:UIControlStateNormal];
    backHomeBtn.titleLabel.font = Font(16);
    [backHomeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(KSIphonScreenW(25));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(25));
        make.height.equalTo(@(KSIphonScreenH(44)));
        make.centerX.equalTo(bgView.mas_centerX);
        make.centerY.equalTo(bgView.mas_centerY);
    }];
    backHomeBtn.layer.cornerRadius = KSIphonScreenH(44)/2;
    backHomeBtn.layer.masksToBounds = YES;
    [backHomeBtn addTarget:self action:@selector(selectBackHomeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backHomeBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    [backHomeBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorLineCommonBlueColor]] forState:UIControlStateNormal];
    [backHomeBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorClickCommonBlueColor]] forState:UIControlStateHighlighted];
}
// 点击返回首页
-(void)selectBackHomeBtn:(UIButton *) sender{
    self.backHomeBlock();
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
