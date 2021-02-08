//
//  YWTQuestResultImageCell.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/17.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTQuestResultImageCell.h"

@implementation YWTQuestResultImageCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createImageCell];
    }
    return self;
}
-(void) createImageCell{
    WS(weakSelf);
    UIImageView *bgImageV = [[UIImageView alloc]init];
    [self addSubview:bgImageV];
    bgImageV.image = [UIImage imageNamed:@"suggetion_quest_reaultBg"];
    [bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
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
