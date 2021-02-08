//
//  YWTDetailCommentCell.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/11.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTDetailCommentCell.h"

// 头像视图的宽、高
#define kAvatarWidth            32

@interface YWTDetailCommentCell ()
// 头像
@property (nonatomic,strong) UIImageView *avatarImageV;
// 名称
@property (nonatomic,strong) UILabel * nickNameLab;
// 时间
@property (nonatomic,strong) UILabel * timeLab;
// 正文
@property (nonatomic,strong) UILabel *contentLab;
@end


@implementation YWTDetailCommentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCommentCell];
    }
    return self;
}
-(void) createCommentCell{
    WS(weakSelf);
    // 头像视图
    _avatarImageV = [[UIImageView alloc]init];
    [self addSubview:_avatarImageV];
    _avatarImageV.image = [UIImage imageNamed:@"pary_list_uset"];
    [_avatarImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.top.equalTo(weakSelf).offset(KSIphonScreenH(10));
        make.width.height.equalTo(@kAvatarWidth);
    }];
    _avatarImageV.layer.cornerRadius = kAvatarWidth/2;
    _avatarImageV.layer.masksToBounds = YES;
    
    // 名称
    _nickNameLab = [[UILabel alloc]init];
    [self addSubview:_nickNameLab];
    _nickNameLab.textColor = [UIColor colorWithHexString:@"#fa8605"];
    _nickNameLab.font = Font(14);
    _nickNameLab.text =@"";
    [_nickNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(52));
        make.centerY.equalTo(weakSelf.avatarImageV.mas_centerY);
    }];
    
    // 时间
    _timeLab = [[UILabel alloc]init];
    [self addSubview:_timeLab];
    _timeLab.text = @"";
    _timeLab.textColor = [UIColor colorCommonGreyBlackColor];
    _timeLab.font = Font(12);
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
        make.centerY.equalTo(weakSelf.nickNameLab.mas_centerY);
    }];
    
    // 正文
    _contentLab = [[UILabel alloc]init];
    [self addSubview:_contentLab];
    _contentLab.textColor = [UIColor colorCommon65GreyBlackColor];
    _contentLab.font = Font(13);
    _contentLab.numberOfLines = 0;
    [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nickNameLab.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.nickNameLab.mas_left);
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
    }];
    
    UIView *lineView = [[UIView alloc]init];
    [self addSubview:lineView];
    lineView.backgroundColor = [UIColor colorLineE3E3CommonGreyBlackColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
        make.height.equalTo(@1);
        make.bottom.equalTo(weakSelf).offset(-1);
    }];
}

-(void)setModel:(YWTDetailCommentModel *)model{
    _model = model;
    
    // 头像
    [YWTTools sd_setImageView:self.avatarImageV WithURL:model.photo andPlaceholder:@"pary_list_uset"];
    
    // 名称
    _nickNameLab.text =model.realname;
    
    // 时间
    _timeLab.text  = model.createtime;
    
    // 正文
    _contentLab.text = model.content;
}

// 计算高度
+(CGFloat) getWithCommentCellHeight:(YWTDetailCommentModel *)model{
    CGFloat height = KSIphonScreenH(20);
    
    height += 32;
    
    CGFloat conetenHeight =[YWTTools getSpaceLabelHeight:model.content withFont:13 withWidth:KScreenW-KSIphonScreenW(64) withSpace:3];
    height += conetenHeight;
    
    height += 15;
    
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
