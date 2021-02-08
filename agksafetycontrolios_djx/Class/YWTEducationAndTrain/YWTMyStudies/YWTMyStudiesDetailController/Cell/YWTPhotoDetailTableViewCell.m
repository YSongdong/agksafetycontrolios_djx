//
//  PhotoDetailTableViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/4/10.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTPhotoDetailTableViewCell.h"

@interface YWTPhotoDetailTableViewCell ()
//封面
@property (nonatomic,strong) UIImageView *coverImageV;
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



@implementation YWTPhotoDetailTableViewCell

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
    [self.coverImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf);
        make.height.equalTo(@(KSNaviTopHeight+KSIphonScreenH(170)));
    }];
    
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
    
    //  标题
    self.questionTitleLab  = [[UILabel alloc]init];
    [questTitleView addSubview:self.questionTitleLab];
    self.questionTitleLab.textColor = [UIColor colorCommonBlackColor];
    self.questionTitleLab.text = @"";
    self.questionTitleLab.font = BFont(15);
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
    self.typeImageV.image = [UIImage imageNamed:@"ico_dljc"];
    self.typeImageV.contentMode = UIViewContentModeScaleAspectFit;
    [self.typeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(weakSelf.tagContentView);
    }];
    
    // 类型
    self.questionTypeLab = [[UILabel alloc]init];
    [self.tagContentView addSubview:self.questionTypeLab];
    self.questionTypeLab.text = @"";
    self.questionTypeLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.questionTypeLab.font = Font(13);
    [self.questionTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.typeImageV.mas_right).offset(KSIphonScreenW(5));
        make.centerY.equalTo(weakSelf.typeImageV.mas_centerY);
        
    }];
    
    // 题目数量
    self.questNumberImageV = [[UIImageView alloc]init];
    [self.tagContentView addSubview:self.questNumberImageV];
    self.questNumberImageV.image = [UIImage imageNamed:@"task_detailType"];
    self.questNumberImageV.contentMode = UIViewContentModeScaleAspectFit;
    [self.questNumberImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.typeImageV.mas_right).offset(KSIphonScreenW(105));
        make.centerY.equalTo(weakSelf.typeImageV.mas_centerY);
    }];
    
    // 文件大小
    self.questNumberLab  = [[UILabel alloc]init];
    [self.tagContentView addSubview:self.questNumberLab];
    self.questNumberLab.text = @"";
    self.questNumberLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.questNumberLab.font = Font(13);
    [self.questNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.questNumberImageV.mas_right).offset(KSIphonScreenW(5));
        make.centerY.equalTo(weakSelf.questNumberImageV.mas_centerY);
    }];
    
    // 更新时间
    self.timeImageV = [[UIImageView alloc]init];
    [self.tagContentView addSubview:self.timeImageV];
    self.timeImageV.image = [UIImage imageNamed:@"libay_deta_time"];
    [self.timeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.questNumberImageV.mas_right).offset(KSIphonScreenW(105));
        make.centerY.equalTo(weakSelf.typeImageV.mas_centerY);
    }];
    
    self.updateTimeLab = [[UILabel alloc]init];
    [self.tagContentView addSubview:self.updateTimeLab];
    self.updateTimeLab.text = @"";
    self.updateTimeLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.updateTimeLab.font = Font(13);
    [self.updateTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.timeImageV.mas_right).offset(KSIphonScreenW(5));
        make.centerY.equalTo(weakSelf.timeImageV.mas_centerY);
    }];
    
    // 书签
    self.bookmarkImageV = [[UIImageView alloc]init];
    [self.tagContentView addSubview:self.bookmarkImageV];
    self.bookmarkImageV.image = [UIImage imageNamed:@"ico_bq"];
    self.bookmarkImageV.contentMode = UIViewContentModeScaleAspectFit;
    [self.bookmarkImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.typeImageV.mas_left);
        make.top.equalTo(weakSelf.typeImageV.mas_bottom).offset(KSIphonScreenH(17));
    }];
    
    // 书签
    self.questBookmarkLab  = [[UILabel alloc]init];
    [self.tagContentView addSubview:self.questBookmarkLab];
    self.questBookmarkLab.text = @"";
    self.questBookmarkLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.questBookmarkLab.font = Font(13);
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

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    if (![dict[@"sourceImgUrl"] isEqualToString:@""]) {
        // 字符串和UTF8编码转换
        NSString *urlUTF8Str = [dict[@"sourceImgUrl"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        // 封面图
        [YWTTools sd_setImageView:self.coverImageV WithURL:urlUTF8Str andPlaceholder:@"Image_loadFailedNomal"];
    }

     //  标题
    self.questionTitleLab.text = [NSString stringWithFormat:@"%@",dict[@"name"]];
    // 类型
    self.questionTypeLab.text =  [NSString stringWithFormat:@"%@",dict[@"catId"]];
    // 大小
    NSString *sizeStr = [NSString stringWithFormat:@"%@",dict[@"size"]];
    self.questNumberLab.text = [NSString stringWithFormat:@"%@,%.2fMB",dict[@"type"],([sizeStr doubleValue]/1024/1024)];
    // 更新时间
    self.updateTimeLab.text = [NSString stringWithFormat:@"%@",dict[@"createTime"]];
    // 书签
    self.questBookmarkLab.text = [NSString stringWithFormat:@"%@",dict[@"tagTitle"]];
    //判断 分类和标签都没有
    NSString *typeStr = [NSString stringWithFormat:@"%@",dict[@"type"]];
    BOOL  catName = [typeStr isEqualToString:@""] ? YES : NO;
    NSString *tagTitleStr = [NSString stringWithFormat:@"%@",dict[@"tagTitle"]];
    BOOL  tagTitle = [tagTitleStr isEqualToString:@""] ? YES : NO;
    if (catName && tagTitle) {
        // 更改
        // 题目数量
        self.typeImageV.image = [UIImage imageNamed:@"task_detailType"];
        self.questionTypeLab.text = [NSString stringWithFormat:@"%@",dict[@"size"]];
        // 更新时间
        self.questNumberImageV.image = [UIImage imageNamed:@"libay_deta_time"];
        self.questNumberLab.text = [NSString stringWithFormat:@"%@",dict[@"createTime"]];
        
        // 隐藏
        self.timeImageV.hidden = YES;
        self.updateTimeLab.hidden = YES;
        
        self.bookmarkImageV.hidden = YES;
        self.questBookmarkLab.hidden  = YES;
        
        __weak typeof(self) weakSelf = self;
        //重新创建约束
        [self.tagContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.tagView).offset(KSIphonScreenH(15));
            make.left.equalTo(weakSelf.tagView).offset(KSIphonScreenW(15));
            make.right.equalTo(weakSelf.tagView).offset(-KSIphonScreenW(15));
            make.bottom.equalTo(weakSelf.questionTypeLab.mas_bottom);
            make.centerX.equalTo(weakSelf.tagView.mas_centerX);
            make.centerY.equalTo(weakSelf.tagView.mas_centerY);
        }];
    }else if (tagTitle){
        // 书签
        self.bookmarkImageV.hidden = YES;
        // 书签
        self.questBookmarkLab.hidden = YES;
        
        __weak typeof(self) weakSelf = self;
        //重新创建约束
        [self.tagContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.tagView).offset(KSIphonScreenH(15));
            make.left.equalTo(weakSelf.tagView).offset(KSIphonScreenW(15));
            make.right.equalTo(weakSelf.tagView).offset(-KSIphonScreenW(15));
            make.bottom.equalTo(weakSelf.questNumberLab.mas_bottom);
            make.centerX.equalTo(weakSelf.tagView.mas_centerX);
            make.centerY.equalTo(weakSelf.tagView.mas_centerY);
        }];
    }
}
+(CGFloat) getWithHeightCell:(NSDictionary *)dict{
    CGFloat height = 0;
    height += KSIphonScreenH(235);
    // 标题
    NSString *titleStr = [NSString stringWithFormat:@"%@",dict[@"fileName"]];
    CGFloat titleHeight = [YWTTools getSpaceLabelHeight:titleStr withFont:19 withWidth:KScreenW-24 withSpace:2];
    height += titleHeight;
    height += KSIphonScreenH(15);
    // 标签的高度
    height += KSIphonScreenH(60);
    //判断 分类和标签都没有
    NSString *typeStr = [NSString stringWithFormat:@"%@",dict[@"catId"]];
    BOOL  catName = [typeStr isEqualToString:@""] ? YES : NO;
    NSString *tagTitleStr = [NSString stringWithFormat:@"%@",dict[@"tagTitle"]];
    BOOL  tagTitle = [tagTitleStr isEqualToString:@""] ? YES : NO;
    if (catName && tagTitle) {
        height += KSIphonScreenH(15);
        return height;
    }else if(tagTitle){
        height += KSIphonScreenH(15);
        return height;
    }
    // 书签
    CGFloat tagHeight =  [YWTTools getSpaceLabelHeight:tagTitleStr withFont:13 withWidth:KScreenW-24-30 withSpace:2];
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
