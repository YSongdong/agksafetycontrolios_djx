//
//  BaseDetailAnnexCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/12.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTBaseDetailAnnexCell.h"
#import "YWTShowNoSourceView.h"

@interface YWTBaseDetailAnnexCell ()
// 空白页
@property (nonatomic,strong) YWTShowNoSourceView *showNoSoucreView;
// 类型
@property (nonatomic,strong) UIImageView *typeImageV;
// 类型名称
@property (nonatomic,strong) UILabel *typeNameLab;

@property (nonatomic,strong) UIButton *toolBtn;
@property (nonatomic,strong) UILabel *toolLab;
@property (nonatomic,strong) UIImageView *toolImageV;

@end

@implementation YWTBaseDetailAnnexCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
      [self createAnnexView];
    }
    return self;
}
-(void) createAnnexView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorTextWhiteColor];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(KSIphonScreenH(5));
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
        make.bottom.equalTo(weakSelf).offset(-KSIphonScreenH(5));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
    }];
    bgView.layer.cornerRadius = 5;
    bgView.layer.masksToBounds = YES;
    bgView.layer.borderWidth = 1;
    bgView.layer.borderColor = [UIColor colorWithHexString:@"#e5e5e5"].CGColor;
    
    self.typeImageV = [[UIImageView alloc]init];
    [bgView addSubview:self.typeImageV];
    self.typeImageV.image = [UIImage imageNamed:@"chenk_annex_photo"];
    [self.typeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(KSIphonScreenW(12));
        make.centerY.equalTo(bgView.mas_centerY);
    }];
    
    self.toolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:self.toolBtn];
    self.toolBtn.titleLabel.font = Font(12);
    [self.toolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView).offset(-KSIphonScreenW(10));
        make.centerY.equalTo(bgView.mas_centerY);
        make.width.equalTo(@(KSIphonScreenW(45)));
        make.height.equalTo(bgView);
    }];
    self.toolBtn.enabled = NO;
    
    self.toolLab = [[UILabel alloc]init];
    [bgView addSubview:self.toolLab];
    self.toolLab.text = @"查看 >>";
    self.toolLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.toolLab.font = Font(12);
    [self.toolLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.toolBtn.mas_centerX);
        make.centerY.equalTo(weakSelf.toolBtn.mas_centerY);
    }];
    
    self.toolImageV = [[UIImageView alloc]init];
    [bgView addSubview:self.toolImageV];
    self.toolImageV.image = [UIImage imageNamed:@"base_deta_yybf"];
    [self.toolImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.toolBtn.mas_centerX);
        make.centerY.equalTo(weakSelf.toolBtn.mas_centerY);
    }];
    // 默认隐藏
    self.toolImageV.hidden = YES;
    
    self.typeNameLab = [[UILabel alloc]init];
    [bgView addSubview:self.typeNameLab];
    self.typeNameLab.text = @"技术交底文件";
    self.typeNameLab.textColor = [UIColor colorCommonBlackColor];
    self.typeNameLab.font = Font(12);
    [self.typeNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(KSIphonScreenW(40));
        make.centerY.equalTo(bgView.mas_centerY);
        make.right.equalTo(weakSelf.toolBtn.mas_left).offset(-KSIphonScreenW(10));
    }];
    
    // 空白页
    self.showNoSoucreView = [[YWTShowNoSourceView alloc]init];
    [self addSubview:self.showNoSoucreView];
    self.showNoSoucreView.backgroundColor = [UIColor colorTextWhiteColor];
    self.showNoSoucreView.showMarkLab.text = @"暂无附件";
    [self.showNoSoucreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    // 默认隐藏
    self.showNoSoucreView.hidden = YES;
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    // 显示
    self.toolLab.hidden =  NO;
    // 隐藏
    self.toolImageV.hidden = YES;
    NSString *typeStr = [NSString stringWithFormat:@"%@",dict[@"type"]];
    if ([typeStr isEqualToString:@"images"]) {
        // 图片
        self.typeImageV.image = [UIImage imageNamed:@"base_image_photo"];
    }else if ([typeStr isEqualToString:@"video"]){
        // 视频
        self.typeImageV.image = [UIImage imageNamed:@"base_annex_video"];
    }else if ([typeStr isEqualToString:@"audio"]){
        // 音频
        self.typeImageV.image = [UIImage imageNamed:@"base_annex_music"];
        // 显示
        self.toolImageV.hidden = NO;
        // 隐藏
        self.toolLab.hidden =  YES;

    }else if ([typeStr isEqualToString:@"pdf"]){
        // pdf
        self.typeImageV.image = [UIImage imageNamed:@"base_deta_pdf"];
    }else if ([typeStr isEqualToString:@"doc"]){
        // doc
        self.typeImageV.image = [UIImage imageNamed:@"base_deta_word"];
    }else if ([typeStr isEqualToString:@"ppt"]){
        // ppt
        self.typeImageV.image = [UIImage imageNamed:@"base_deta_ppt"];
    }else if ([typeStr isEqualToString:@"xls"]){
        // xls
        self.typeImageV.image = [UIImage imageNamed:@"base_iamge_excle"];
    }else{
        // 其他
        self.typeImageV.image = [UIImage imageNamed:@"base_deta_wsb"];
    }
    
    // 名称
    self.typeNameLab.text = [NSString stringWithFormat:@"%@",dict[@"name"]];
}
-(void)setIsShowSpace:(BOOL)isShowSpace{
    _isShowSpace = isShowSpace;
    // 是否显示空白页  YES 是 NO 不是 默认NO
    if (isShowSpace) {
        self.showNoSoucreView.hidden = NO;
    }else{
        self.showNoSoucreView.hidden = YES;
    }
}

@end
