//
//  ExamScoreUnpublishTableViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/23.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTExamScoreUnpublishTableViewCell.h"



@implementation YWTExamScoreUnpublishTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createExamPaperView];
    }
    return self;
}
-(void) createExamPaperView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorTextWhiteColor];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    UIImageView *topImageV = [[UIImageView alloc]init];
    [bgView addSubview:topImageV];
    topImageV.image = [UIImage imageChangeName:@"kszx_bg"];
    [topImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bgView);
    }];
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
