//
//  IibayExerDetaIfonCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/2/14.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTIibayExerDetaIfonCell.h"

@interface YWTIibayExerDetaIfonCell ()
//封面
@property (nonatomic,strong) UIImageView *coverImageV;
// 进度条
@property (nonatomic,strong) UIProgressView *progressView;
// 进度比例
@property (nonatomic,strong) UILabel *scheduleRatioLab;
// 标签view
@property (nonatomic,strong) UIView *tagView;
// 标签内容view
@property (nonatomic,strong)  UIView *tagContentView;
// 类型imageV
@property (nonatomic,strong) UIImageView *typeImageV;
// 题目数量
@property (nonatomic,strong)  UIImageView *questNumberImageV;
// 更新时间ImageV
@property (nonatomic,strong)   UIImageView *timeImageV;
// 书签imageV
@property (nonatomic,strong)  UIImageView *bookmarkImageV;
// 学习进度
@property (nonatomic,strong) UILabel *learnProgressLab;
// 更新时间
@property (nonatomic,strong) UILabel *updateTimeLab;
// 题 标题
@property (nonatomic,strong) UILabel *questionTitleLab;
// 题类型
@property (nonatomic,strong) UILabel *questionTypeLab;
// 题 书签
@property (nonatomic,strong) UILabel *questBookmarkLab;
// 题目数量
@property (nonatomic,strong) UILabel *questNumberLab;

@end


@implementation YWTIibayExerDetaIfonCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createDetaIfonCell];
    }
    return self;
}

-(void) createDetaIfonCell{
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
    
    UIImageView *shodowTopImageV = [[UIImageView alloc]init];
    [questTitleView addSubview:shodowTopImageV];
    shodowTopImageV.image = [UIImage imageNamed:@"shadow_top"];
    [shodowTopImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(questTitleView);
        make.height.equalTo(@KSNaviTopHeight);
    }];
    
    UIView *coverAlphaView = [[UIView alloc]init];
    [questTitleView addSubview:coverAlphaView];
    [coverAlphaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(questTitleView);
        make.height.equalTo(@(KSIphonScreenH(44)));
        make.bottom.equalTo(weakSelf.coverImageV.mas_bottom);
    }];

    UIImageView *alphaImageV = [[UIImageView alloc]init];
    [coverAlphaView addSubview:alphaImageV];
    alphaImageV.image = [UIImage imageNamed:@"shadow_bottom"];
    [alphaImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(coverAlphaView);
    }];

    // 学习进度
    self.learnProgressLab = [[UILabel alloc]init];
    [coverAlphaView addSubview:self.learnProgressLab];
    self.learnProgressLab.textColor = [UIColor colorTextWhiteColor];
    self.learnProgressLab.font = Font(14);
    [self.learnProgressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(coverAlphaView).offset(KSIphonScreenW(13));
        make.bottom.equalTo(coverAlphaView.mas_bottom).offset(-KSIphonScreenH(8));
    }];

    //进度比例
    self.scheduleRatioLab = [[UILabel alloc]init];
    [coverAlphaView addSubview:self.scheduleRatioLab];
    self.scheduleRatioLab.text = @"0/0";
    self.scheduleRatioLab.textColor = [UIColor colorTextWhiteColor];
    self.scheduleRatioLab.font = Font(14);
    [self.scheduleRatioLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(coverAlphaView).offset(-KSIphonScreenW(12));
        make.centerY.equalTo(weakSelf.learnProgressLab.mas_centerY);
    }];

    // 进度view
    self.progressView = [[UIProgressView alloc]init];
    [coverAlphaView addSubview:self.progressView];
    self.progressView.progressTintColor = [UIColor colorTextCommonOrangeColor];
    self.progressView.progress = 0 ;
    self.progressView.trackTintColor = [UIColor colorTextWhiteColor];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.learnProgressLab.mas_right).offset(KSIphonScreenW(10));
        make.right.equalTo(weakSelf.scheduleRatioLab.mas_left).offset(-KSIphonScreenW(10));
        make.height.equalTo(@4);
        make.centerY.equalTo(weakSelf.learnProgressLab.mas_centerY);
    }];
    self.progressView.layer.cornerRadius = 4/2;
    self.progressView.layer.masksToBounds = YES;

    // 题 标题
    self.questionTitleLab  = [[UILabel alloc]init];
    [questTitleView addSubview:self.questionTitleLab];
    self.questionTitleLab.textColor = [UIColor colorCommonBlackColor];
    self.questionTitleLab.text = @"";
    self.questionTitleLab.font = BFont(16);
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
    
    self.typeImageV = [[UIImageView alloc]init];
    [self.tagContentView addSubview:self.typeImageV];
    self.typeImageV.image = [UIImage imageNamed:@"libayExercis_dljc"];
    self.typeImageV.contentMode = UIViewContentModeScaleAspectFit;
    [self.typeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(weakSelf.tagContentView);
    }];
   
    // 类型
    self.questionTypeLab = [[UILabel alloc]init];
    [self.tagContentView addSubview:self.questionTypeLab];
    self.questionTypeLab.text = @"";
    self.questionTypeLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.questionTypeLab.font = Font(14);
    [self.questionTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.typeImageV.mas_right).offset(KSIphonScreenW(5));
        make.centerY.equalTo(weakSelf.typeImageV.mas_centerY);
        
    }];
  
    // 题目数量
    self.questNumberImageV = [[UIImageView alloc]init];
    [self.tagContentView addSubview:self.questNumberImageV];
    self.questNumberImageV.image = [UIImage imageNamed:@"libayExercis_tl"];
    self.questNumberImageV.contentMode = UIViewContentModeScaleAspectFit;
    [self.questNumberImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.typeImageV.mas_right).offset(KSIphonScreenW(110));
        make.centerY.equalTo(weakSelf.typeImageV.mas_centerY);
    }];
    
    // 题目数量
    self.questNumberLab  = [[UILabel alloc]init];
    [self.tagContentView addSubview:self.questNumberLab];
    self.questNumberLab.text = @"";
    self.questNumberLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.questNumberLab.font = Font(14);
    [self.questNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.questNumberImageV.mas_right).offset(KSIphonScreenW(5));
        make.centerY.equalTo(weakSelf.questNumberImageV.mas_centerY);
    }];
    
    // 更新时间
    self.timeImageV = [[UIImageView alloc]init];
    [self.tagContentView addSubview:self.timeImageV];
    self.timeImageV.image = [UIImage imageNamed:@"libayExercis_sjgx"];
    self.timeImageV.contentMode = UIViewContentModeScaleAspectFit;
    [self.timeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.questNumberImageV.mas_right).offset(KSIphonScreenW(96));
        make.centerY.equalTo(weakSelf.typeImageV.mas_centerY);
    }];
    
    self.updateTimeLab = [[UILabel alloc]init];
    [self.tagContentView addSubview:self.updateTimeLab];
    self.updateTimeLab.text = @"";
    self.updateTimeLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.updateTimeLab.font = Font(14);
    [self.updateTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.timeImageV.mas_right).offset(KSIphonScreenW(5));
        make.centerY.equalTo(weakSelf.timeImageV.mas_centerY);
    }];
  
    // 书签
    self.bookmarkImageV = [[UIImageView alloc]init];
    [self.tagContentView addSubview:self.bookmarkImageV];
    self.bookmarkImageV.image = [UIImage imageNamed:@"libayExercis_bq"];
    self.bookmarkImageV.contentMode = UIViewContentModeScaleAspectFill;
    [self.bookmarkImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.typeImageV.mas_left);
        make.top.equalTo(weakSelf.typeImageV.mas_bottom).offset(KSIphonScreenH(13));
    }];

    // 书签
    self.questBookmarkLab  = [[UILabel alloc]init];
    [self.tagContentView addSubview:self.questBookmarkLab];
    self.questBookmarkLab.text = @"";
    self.questBookmarkLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.questBookmarkLab.font = Font(14);
    [self.questBookmarkLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.tagView).offset(KSIphonScreenW(35));
        make.centerY.equalTo(weakSelf.bookmarkImageV.mas_centerY);
        make.right.equalTo(weakSelf.tagContentView).offset(-KSIphonScreenW(15));
    }];
 
    [self.tagContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.typeImageV.mas_top);
        make.left.equalTo(weakSelf.tagView).offset(KSIphonScreenW(15));
        make.right.equalTo(weakSelf.tagView).offset(-KSIphonScreenW(15));
        make.bottom.equalTo(weakSelf.questBookmarkLab.mas_bottom);
        make.centerX.equalTo(weakSelf.tagView.mas_centerX);
        make.centerY.equalTo(weakSelf.tagView.mas_centerY);
    }];
}
-(void)setModel:(YWTLibayExerDetaModel *)model{
    _model = model;
    
    if (![model.sourceImgUrl isEqualToString:@""]) {
        // 字符串和UTF8编码转换
        NSString *urlUTF8Str = [model.sourceImgUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        // 封面图
        [YWTTools sd_setImageView:self.coverImageV WithURL:urlUTF8Str andPlaceholder:@"Image_loadFailedNomal"];
    }
    // 进度比例
    self.scheduleRatioLab.text = [NSString stringWithFormat:@"%@/%@",model.doNum,model.totalNum];
    // 进度
    self.progressView.progress = [model.percentStr floatValue];
    
    // 学习进度
    self.learnProgressLab.text =[NSString stringWithFormat:@"学习进度 %d%%",(int)([model.percentStr floatValue]*100)];
    
    // q题库名称
    self.questionTitleLab.text = [NSString stringWithFormat:@"%@",model.title];
    //分类
    if ([model.catName isKindOfClass:[NSNull class]] || model.catName == nil) {
        self.questionTypeLab.text = @"";
    }else{
        self.questionTypeLab.text = [NSString stringWithFormat:@"%@",model.catName];
    }
    // 描述
    if ([model.tagTitle isKindOfClass:[NSNull class]] || model.tagTitle == nil) {
        self.questBookmarkLab.text = @"";
    }else{
        self.questBookmarkLab.text = [NSString stringWithFormat:@"%@",model.tagTitle];
    }
    // 题目数量
    self.questNumberLab.text = [NSString stringWithFormat:@"%@题",model.totalNum];
    // 更新时间
    self.updateTimeLab.text = [NSString stringWithFormat:@"%@",model.updateTime];
    //判断 分类和标签都没有
    BOOL  catName = model.catName == nil ? YES : NO;
    BOOL  tagTitle = [model.tagTitle isEqualToString:@""] ? YES : NO;
    __weak typeof(self) weakSelf = self;
    if (catName && tagTitle) {
        // 更改
        // 题目数量
        self.typeImageV.image = [UIImage imageNamed:@"libayExercis_tl"];
        self.questionTypeLab.text = [NSString stringWithFormat:@"%@题",model.totalNum];
        // 更新时间
        self.questNumberImageV.image = [UIImage imageNamed:@"libayExercis_sjgx"];
        self.questNumberLab.text = [NSString stringWithFormat:@"%@",model.updateTime];
        // 隐藏
        self.timeImageV.hidden = YES;
        self.updateTimeLab.hidden = YES;
        
        self.bookmarkImageV.hidden = YES;
        self.questBookmarkLab.hidden  = YES;
    
        //重新创建约束
        [self.tagContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.typeImageV.mas_top);
            make.left.equalTo(weakSelf.tagView).offset(KSIphonScreenW(15));
            make.right.equalTo(weakSelf.tagView).offset(-KSIphonScreenW(15));
            make.bottom.equalTo(weakSelf.questionTypeLab.mas_bottom);
            make.centerX.equalTo(weakSelf.tagView.mas_centerX);
            make.centerY.equalTo(weakSelf.tagView.mas_centerY);
        }];
    }else if (catName){
        // 分类
        self.typeImageV.image = [UIImage imageNamed:@"libayExercis_tl"];
        self.questionTypeLab.text = [NSString stringWithFormat:@"%@题",model.totalNum];
        
        // 更新时间
        self.questNumberImageV.image = [UIImage imageNamed:@"libayExercis_sjgx"];
        self.questNumberLab.text = [NSString stringWithFormat:@"%@",model.updateTime];
        
        self.timeImageV.hidden = YES;
        self.updateTimeLab.hidden = YES;
        
        //重新创建约束
        [self.tagContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.typeImageV.mas_top);
            make.left.equalTo(weakSelf.tagView).offset(KSIphonScreenW(15));
            make.right.equalTo(weakSelf.tagView).offset(-KSIphonScreenW(15));
            make.bottom.equalTo(weakSelf.questBookmarkLab.mas_bottom);
            make.centerX.equalTo(weakSelf.tagView.mas_centerX);
            make.centerY.equalTo(weakSelf.tagView.mas_centerY);
        }];
    }else if (tagTitle){
        // 书签
        self.bookmarkImageV.hidden = YES;
        self.questBookmarkLab.hidden = YES;
        
        //重新创建约束
        [self.tagContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.typeImageV.mas_top);
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

// 计算高度的
+(CGFloat) getDetaInfoHeight:(YWTLibayExerDetaModel *)model{
    CGFloat height = 0;
    height += KSIphonScreenH(220);
    // 标题
    CGFloat titleHeight = [YWTTools getSpaceLabelHeight:model.title withFont:16 withWidth:KScreenW-24 withSpace:2];
    height += titleHeight;
    height += KSIphonScreenH(15);
    // 标签的高度
    height += KSIphonScreenH(60);
    //判断 分类和标签都没有
    BOOL  catName = model.catName == nil ? YES : NO;
    BOOL  tagTitle = [model.tagTitle isEqualToString:@""] ? YES : NO;
    if (catName && tagTitle) {
        height += KSIphonScreenH(30);
        return height;
    }
    // 描述
    CGFloat tagHeight =  [YWTTools getSpaceLabelHeight:model.tagTitle withFont:14 withWidth:KScreenW-24-30 withSpace:2];
    height += tagHeight;
    height += KSIphonScreenH(30);
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
