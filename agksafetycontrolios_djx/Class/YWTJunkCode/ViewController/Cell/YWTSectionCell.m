//
//  YWTSectionCell.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/2.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTSectionCell.h"

@implementation YWTSectionCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSectionView ];
    }
    return self;
}
-(void) createSectionView{
    self.nameLab = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, 100, 30)];
    [self addSubview:self.nameLab];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0,  CGRectGetMaxY(self.frame)-2, KScreenW, 1) ];
    lineView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    [self addSubview:lineView];
}

-(void)setNameStr:(NSString *)nameStr{
    _nameStr = nameStr;
    self.nameLab.text = nameStr;
}

-(void)setFrame:(CGRect)frame{
    CGFloat margin = 16;
    frame.origin.x = margin;
    frame.size.width = KScreenW - margin*2;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
