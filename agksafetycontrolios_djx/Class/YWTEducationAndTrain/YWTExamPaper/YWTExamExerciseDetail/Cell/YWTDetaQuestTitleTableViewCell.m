//
//  DetaQuestTitleTableViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/16.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTDetaQuestTitleTableViewCell.h"

@interface YWTDetaQuestTitleTableViewCell ()
//封面
@property (nonatomic,strong) UIImageView *coverImageV;
// 更新时间
@property (nonatomic,strong) UILabel *updateTimerLab;
// 题 标题
@property (nonatomic,strong) UILabel *questionTitleLab;
// 标签view
@property (nonatomic,strong) UIView *tagView;
// 标签内容view
@property (nonatomic,strong)  UIView *tagContentView;
// 题类型
@property (nonatomic,strong) UILabel *questionTypeLab;
// 更新时间ImageV
@property (nonatomic,strong) UIImageView *updateImageV;
// 标签
@property (nonatomic,strong) UIImageView *typeImageV;
// 题 书签
@property (nonatomic,strong) UILabel *questBookmarkLab;

@property (nonatomic,strong) UIImageView *bookmarkImageV;


@end


@implementation YWTDetaQuestTitleTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createQuestTitleView];
    }
    return self;
}

-(void) createQuestTitleView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    // 题标题view
    UIView *questTitleView = [[UIView alloc]init];
    [self addSubview:questTitleView];
    questTitleView.backgroundColor = [UIColor colorTextWhiteColor];
    [questTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf).offset(-KSIphonScreenH(10));
    }];
    
    self.coverImageV = [[UIImageView alloc]init];
    [questTitleView addSubview:self.coverImageV];
    self.coverImageV.image = [UIImage imageNamed:@"base_detail_nomal"];
    self.coverImageV.contentMode = UIViewContentModeScaleAspectFill;
    self.coverImageV.clipsToBounds = YES;
    self.coverImageV.userInteractionEnabled =  YES;
    [self.coverImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf);
        make.height.equalTo(@(KSNaviTopHeight+KSIphonScreenH(170)));
    }];
    UITapGestureRecognizer *coverImageVTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectCoverImageV)];
    [self.coverImageV addGestureRecognizer:coverImageVTap];
    
    // 顶部阴影
    UIImageView *shodowTopImageV = [[UIImageView alloc]init];
    [questTitleView addSubview:shodowTopImageV];
    shodowTopImageV.image = [UIImage imageNamed:@"shadow_top"];
    [shodowTopImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(questTitleView);
        make.height.equalTo(@(KSNaviTopHeight));
    }];
    
    // 底部阴影
    UIImageView *shodowBottomImageV = [[UIImageView alloc]init];
    [questTitleView addSubview:shodowBottomImageV];
    shodowBottomImageV.image = [UIImage imageNamed:@"shadow_bottom"];
    [shodowBottomImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(questTitleView);
        make.height.equalTo(@(KSIphonScreenH(44)));
        make.bottom.equalTo(weakSelf.coverImageV.mas_bottom);
    }];
    
    // 题 标题
    self.questionTitleLab  = [[UILabel alloc]init];
    [questTitleView addSubview:self.questionTitleLab];
    self.questionTitleLab.textColor = [UIColor colorCommonBlackColor];
    self.questionTitleLab.text = @"建设工程职业健康安全与环境管理标题";
    self.questionTitleLab.font = BFont(18);
    self.questionTitleLab.numberOfLines = 2;
    [self.questionTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.coverImageV.mas_bottom).offset(KSIphonScreenH(15));
        make.left.equalTo(questTitleView).offset(KSIphonScreenW(12));
        make.right.equalTo(questTitleView).offset(-KSIphonScreenW(12));
    }];
    
    // 标签view
    self.tagView  = [[UIView alloc]init];
    [questTitleView addSubview:self.tagView];
    self.tagView.backgroundColor  = [UIColor colorWithHexString:@"#f1f6fe"];
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.questionTitleLab.mas_bottom).offset(KSIphonScreenH(15));
        make.left.equalTo(questTitleView).offset(KSIphonScreenW(12));
        make.right.equalTo(questTitleView).offset(-KSIphonScreenW(12));
        make.bottom.equalTo(questTitleView).offset(-KSIphonScreenH(15));
    }];
    self.tagView.layer.cornerRadius = 8;
    self.tagView.layer.masksToBounds = YES;
  
    // 标签内容view
    self.tagContentView = [[UIView alloc]init];
    [self.tagView addSubview:self.tagContentView];
    
    // 类型
    self.typeImageV = [[UIImageView alloc]init];
    [self.tagContentView addSubview:self.typeImageV];
    self.typeImageV.image = [UIImage imageNamed:@"ico_dljc"];
    self.typeImageV.contentMode =UIViewContentModeScaleAspectFit;
    [self.typeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(weakSelf.tagContentView);
    }];
    
    self.questionTypeLab = [[UILabel alloc]init];
    [self.tagContentView addSubview:self.questionTypeLab];
    self.questionTypeLab.text = @"电力基础";
    self.questionTypeLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.questionTypeLab.font = Font(14);
    [self.questionTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.typeImageV.mas_top);
        make.left.equalTo(weakSelf.typeImageV.mas_right).offset(KSIphonScreenW(5));
        make.centerY.equalTo(weakSelf.typeImageV.mas_centerY);
    }];
    
    // 更新时间
    self.updateImageV = [[UIImageView alloc]init];
    [self.tagContentView addSubview:self.updateImageV];
    self.updateImageV.image = [UIImage imageNamed:@"libay_deta_time"];
    self.updateImageV.contentMode =UIViewContentModeScaleAspectFit;
    [self.updateImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.typeImageV.mas_right).offset(KSIphonScreenW(110));
        make.centerY.equalTo(weakSelf.typeImageV.mas_centerY);
    }];
    
    // 更新时间
    self.updateTimerLab = [[UILabel alloc]init];
    [self.tagContentView addSubview:self.updateTimerLab];
    self.updateTimerLab.text = @"";
    self.updateTimerLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.updateTimerLab.font = Font(15);
    [self.updateTimerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.updateImageV.mas_right).offset(KSIphonScreenW(7));
        make.centerY.equalTo(weakSelf.updateImageV.mas_centerY);
    }];
    
    // 书签
    self.bookmarkImageV = [[UIImageView alloc]init];
    [self.tagContentView addSubview:self.bookmarkImageV];
    self.bookmarkImageV.image = [UIImage imageNamed:@"ico_bq"];
    self.bookmarkImageV.contentMode =UIViewContentModeScaleAspectFit;
    [self.bookmarkImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.typeImageV.mas_left);
        make.top.equalTo(weakSelf.typeImageV.mas_bottom).offset(KSIphonScreenH(17));
    }];
    
    self.questBookmarkLab  = [[UILabel alloc]init];
    [self.tagContentView addSubview:self.questBookmarkLab];
    self.questBookmarkLab.text = @"";
    self.questBookmarkLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.questBookmarkLab.font = Font(14);
    self.questionTypeLab.numberOfLines =0;
    [self.questBookmarkLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.tagView).offset(KSIphonScreenW(35));
        make.centerY.equalTo(weakSelf.bookmarkImageV.mas_centerY);
        make.right.equalTo(weakSelf.tagContentView).offset(-KSIphonScreenW(15));
    }];
    
    [self.tagContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.tagView).offset(KSIphonScreenH(15));
        make.left.equalTo(weakSelf.tagView).offset(KSIphonScreenW(15));
        make.right.equalTo(weakSelf.tagView).offset(-KSIphonScreenW(15));
        make.bottom.equalTo(weakSelf.questBookmarkLab.mas_bottom);
        make.centerX.equalTo(weakSelf.tagView.mas_centerX);
        make.centerY.equalTo(weakSelf.tagView.mas_centerY);
    }];
   
}
-(void)setDetaModel:(YWTExamExerDetaModel *)detaModel{
    _detaModel = detaModel;
    
    if (![detaModel.imgUrl isEqualToString:@""]) {
        // 字符串和UTF8编码转换
        NSString *urlUTF8Str = [detaModel.imgUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        // 图片
        [YWTTools sd_setImageView:self.coverImageV WithURL:urlUTF8Str andPlaceholder:@"Image_loadFailedNomal"];
    }
   
    // 试卷标题
    self.questionTitleLab.text = [NSString stringWithFormat:@"%@",detaModel.title];
    // 更新时间
    self.updateTimerLab.text =[NSString stringWithFormat:@"%@",detaModel.updateTime];
    // 类型
    if ([detaModel.catEgory isKindOfClass:[NSNull class]] || detaModel.catEgory == nil) {
        self.questionTypeLab.text = @"";
    }else{
        self.questionTypeLab.text = [NSString stringWithFormat:@"%@",detaModel.catEgory];
    }
    // 书签
    if ([detaModel.tag isKindOfClass:[NSNull class]] || detaModel.tag == nil) {
        self.questBookmarkLab.text = @"";
    }else{
        self.questBookmarkLab.text = [NSString stringWithFormat:@"%@",detaModel.tag];
    }
    // 判断是显示
     __weak typeof(self) weakSelf = self;
    if ([detaModel.catEgory isEqualToString:@""] && [detaModel.tag isEqualToString:@""]) {
        self.typeImageV.image = [UIImage imageNamed:@"libay_deta_time"];
        self.questionTypeLab.text = [NSString stringWithFormat:@"%@",detaModel.updateTime];
        
        self.updateImageV.hidden = YES;
        self.updateTimerLab.hidden = YES;
        self.bookmarkImageV.hidden = YES;
        self.questBookmarkLab.hidden = YES;
       
        //  修改约束
        [self.tagContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.tagView).offset(KSIphonScreenH(15));
            make.left.equalTo(weakSelf.tagView).offset(KSIphonScreenW(15));
            make.right.equalTo(weakSelf.tagView).offset(-KSIphonScreenW(15));
            make.bottom.equalTo(weakSelf.questionTypeLab.mas_bottom);
            make.centerX.equalTo(weakSelf.tagView.mas_centerX);
            make.centerY.equalTo(weakSelf.tagView.mas_centerY);
        }];
    }else if( [detaModel.catEgory isEqualToString:@""]) {
        // 类型
        self.typeImageV.image = [UIImage imageNamed:@"libay_deta_time"];
        self.questionTypeLab.text  =[NSString stringWithFormat:@"%@",detaModel.updateTime];
        
        self.updateImageV.hidden = YES;
        self.updateTimerLab.hidden = YES;
        
    }else if( [detaModel.tag isEqualToString:@""]) {
        
        self.bookmarkImageV.hidden = YES;
        self.questBookmarkLab.hidden = YES;
        //  修改约束
        [self.tagContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.tagView).offset(KSIphonScreenH(15));
            make.left.equalTo(weakSelf.tagView).offset(KSIphonScreenW(15));
            make.right.equalTo(weakSelf.tagView).offset(-KSIphonScreenW(15));
            make.bottom.equalTo(weakSelf.questionTypeLab.mas_bottom);
            make.centerX.equalTo(weakSelf.tagView.mas_centerX);
            make.centerY.equalTo(weakSelf.tagView.mas_centerY);
        }];
    }
}
// 查看大图
-(void)selectCoverImageV{
    [XWScanImage scanBigImageWithImageView:self.coverImageV];
}
//计算高度
+(CGFloat)getLabelHeightWithDict:(YWTExamExerDetaModel*) model{
    CGFloat height = 0;
    // 图片高度
    height = KSNaviTopHeight+KSIphonScreenH(170);
    height += 15;
    
    // 计算标题高度
    CGFloat titleHeight = [YWTTools getSpaceLabelHeight:model.title withFont:18 withWidth:KScreenW-24 withSpace:2];
    height += titleHeight;
    height += 15;
    // 判断是显示
    if ([model.catEgory isEqualToString:@""] && [model.tag isEqualToString:@""]) {
        height += 70;
        return height;
    }
    // 标签高度
    height += 60;
    // 书签高度
    CGFloat bookTagHeight = [YWTTools getSpaceLabelHeight:model.tag withFont:14 withWidth:KScreenW-24-30 withSpace:2];
    height += bookTagHeight;
    height += 30;
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
