//
//  HeaderPhotoTableViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/10.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTHeaderPhotoTableViewCell.h"

@interface YWTHeaderPhotoTableViewCell ()
//图片状态显示文字lab
@property (nonatomic,strong) UILabel *showPhotoStatuLab;
// 留底图片
@property (nonatomic,strong) UIImageView *headerImageV;
// 失败原因lab
@property (nonatomic,strong) UILabel *photoErrorMaskLab;
// 审核状态 imageV
@property (nonatomic,strong) UIImageView *checkStatuImageV;


@end



@implementation YWTHeaderPhotoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createHeaderPhotoView];
    }
    return self;
}
-(void) createHeaderPhotoView{
    __weak typeof(self) weakSelf = self;
    
    self.backgroundColor = [UIColor colorViewBackF9F9GrounpWhiteColor];
   
    UIImageView *naviImageV = [[UIImageView alloc]init];
    [self addSubview:naviImageV];
    naviImageV.image = [UIImage imageChangeName:@"nav_bg"];
    [naviImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.height.equalTo(@(KSNaviTopHeight+KSIphonScreenH(56)));
    }];
    
    // 大背景view
    UIView *photoBgView = [[UIView alloc]init];
    photoBgView.backgroundColor = [UIColor colorTextWhiteColor];
    photoBgView.layer.cornerRadius = 6;
    photoBgView.layer.shadowColor = [UIColor colorCommonGreyBlackColor].CGColor;
    photoBgView.layer.shadowOffset = CGSizeMake(3, 3);
    photoBgView.layer.shadowOpacity = 0.35;
    photoBgView.layer.shadowRadius = 5;
    [self addSubview:photoBgView];
    
    //图片状态显示文字lab
    self.showPhotoStatuLab = [[UILabel alloc]init];
    [photoBgView addSubview:self.showPhotoStatuLab];
    self.showPhotoStatuLab.text = @"用户留底照片采集";
    self.showPhotoStatuLab.textColor = [UIColor colorCommonBlackColor];
    self.showPhotoStatuLab.font = Font(16);
    self.showPhotoStatuLab.textAlignment  = NSTextAlignmentCenter;
    [self.showPhotoStatuLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(photoBgView).offset(KSIphonScreenH(18));
        make.left.equalTo(photoBgView).offset(KSIphonScreenW(10));
        make.right.equalTo(photoBgView).offset(-KSIphonScreenW(10));
    }];
    
    // 留底照片
    self.headerImageV = [[UIImageView alloc]init];
    [photoBgView addSubview:self.headerImageV];
    self.headerImageV.contentMode = UIViewContentModeScaleAspectFill;
    [self.headerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.showPhotoStatuLab.mas_bottom).offset(KSIphonScreenH(27));
        make.centerX.equalTo(photoBgView.mas_centerX);
        make.width.height.equalTo(@177);
    }];
    self.headerImageV.layer.cornerRadius =177/2;
    self.headerImageV.layer.masksToBounds = YES;
    self.headerImageV.layer.borderWidth = 1;
    self.headerImageV.layer.borderColor = [UIColor colorHeaderImageVDBDBColor].CGColor;
    self.headerImageV.image = [UIImage imageNamed:@"scyd_pic_2"];
    
    // 审核状态 imageV
    self.checkStatuImageV = [[UIImageView alloc]init];
    [photoBgView addSubview:self.checkStatuImageV];
    self.checkStatuImageV.image = [UIImage imageNamed:@"grzx_ico_shz"];
    [self.checkStatuImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headerImageV.mas_top).offset(KSIphonScreenH(4));
        make.right.equalTo(weakSelf.headerImageV.mas_right).offset(-KSIphonScreenW(2));
    }];
    self.checkStatuImageV.hidden = YES;
    
    UIImageView *bottmImageV = [[UIImageView alloc]init];
    [photoBgView addSubview:bottmImageV];
    bottmImageV.image = [UIImage imageChangeName:@"scyd_pic_line"];
    [bottmImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.headerImageV.mas_bottom);
        make.centerX.equalTo(weakSelf.headerImageV.mas_centerX);
    }];
    
    // 照片失败说明
    self.photoErrorMaskLab = [[UILabel alloc]init];
    [photoBgView addSubview:self.photoErrorMaskLab];
    self.photoErrorMaskLab.text = @"失败原因";
    self.photoErrorMaskLab.textColor = [UIColor colorCommonRedColor];
    self.photoErrorMaskLab.font = Font(11);
    self.photoErrorMaskLab.numberOfLines = 2;
    [self.photoErrorMaskLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottmImageV.mas_bottom).offset(KSIphonScreenH(5));
        make.left.equalTo(photoBgView).offset(KSIphonScreenW(10));
        make.right.equalTo(photoBgView).offset(-KSIphonScreenW(10));
        make.centerX.equalTo(photoBgView.mas_centerX);
    }];
    self.photoErrorMaskLab.hidden = YES;
    
    // 约束
    [photoBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(KSIphonScreenH(18)+KSNaviTopHeight);
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(25));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(25));
        make.bottom.equalTo(weakSelf.photoErrorMaskLab.mas_bottom).offset(KSIphonScreenH(10));
    }];
    
}
-(void)setCellPhotoStatu:(showCellPhotoStatu)cellPhotoStatu{
    _cellPhotoStatu = cellPhotoStatu;
    if (cellPhotoStatu == cellPhotoStatuNotUploaded || cellPhotoStatu == cellPhotoStatuCollectionPhoto) {
        self.showPhotoStatuLab.text =@"用户留底照片采集";
        self.showPhotoStatuLab.textColor = [UIColor colorCommonBlackColor];
        self.photoErrorMaskLab.hidden = YES;
        //隐藏审核状态
        self.checkStatuImageV.hidden = YES;
    }else if (cellPhotoStatu == cellPhotoStatuChecking){
        // 审核中
        NSString *textStr = @"留底照片已提交，等待管理员审核";
        self.showPhotoStatuLab.attributedText = [self getAttributTextStr:textStr andTextColor:[UIColor colorTextCommonOrangeColor] andAddImageStr:@"ico_dsh"];
        self.photoErrorMaskLab.hidden = YES;
        //显示审核状态
        self.checkStatuImageV.hidden = NO;
        self.checkStatuImageV.image = [UIImage imageNamed:@"photo_pic"];
    }else if (cellPhotoStatu == cellPhotoStatuCheckSucces){
        // 审核成功
        NSString *textStr = @"用户留底照片认证已通过";
        self.showPhotoStatuLab.attributedText = [self getAttributTextStr:textStr andTextColor:[UIColor colorTextCommonBlueColor] andAddImageStr:@"zpcj_ico_ytg"];
        self.photoErrorMaskLab.hidden = YES;
        //显示审核状态
        self.checkStatuImageV.hidden = NO;
        self.checkStatuImageV.image = [UIImage imageNamed:@"zpcj_pic_ytg"];
    }else if (cellPhotoStatu == cellPhotoStatuCheckError){
        // 审核失败
        NSString *textStr = @"用户留底照片认证未通过";
        self.showPhotoStatuLab.attributedText = [self getAttributTextStr:textStr andTextColor:[UIColor colorCommonRedColor] andAddImageStr:@"zpcj_ico_wtg"];
        self.photoErrorMaskLab.hidden = YES;
        //显示审核状态
        self.checkStatuImageV.hidden = NO;
        self.checkStatuImageV.image = [UIImage imageNamed:@"zpcj_pic_wtg"];
    }
}
// 通过文字添加图片 富文本
-(NSMutableAttributedString *) getAttributTextStr:(NSString *)textStr  andTextColor:(UIColor*)textColor  andAddImageStr:(NSString *)attachStr{
    //设置富文本
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:textStr];
    NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:16],NSFontAttributeName, textColor,NSForegroundColorAttributeName,nil];
    [attributeStr addAttributes:attributeDict range:NSMakeRange(0, attributeStr.length)];
    
    //添加图片
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:attachStr];
    attach.bounds = CGRectMake(-5, -5, 21, 22);
    NSAttributedString *attributeStr2 = [NSAttributedString attributedStringWithAttachment:attach];
    [attributeStr insertAttributedString:attributeStr2 atIndex:0];
    return attributeStr;
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    if ([dict[@"checkPhoto"] isKindOfClass:[UIImage class]]) {
        self.headerImageV.image = dict[@"checkPhoto"];
    }else if ([dict[@"checkPhoto"] isKindOfClass:[NSString class]]){
        [YWTTools sd_setImageView:self.headerImageV WithURL:dict[@"checkPhoto"] andPlaceholder:@"scyd_pic_2"];
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
