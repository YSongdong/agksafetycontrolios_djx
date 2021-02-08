//
//  QuestChapterCollectionViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/2/14.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTQuestChapterCollectionViewCell.h"

@interface YWTQuestChapterCollectionViewCell ()

@property (nonatomic,strong) UILabel *chapterTitleLab;

@property (nonatomic,strong) UILabel *chapterTotalLab;

@end

@implementation YWTQuestChapterCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createChapterView];
    }
    return self;
}

-(void) createChapterView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorTextWhiteColor];
    
    UIImageView *chapterImageV = [[UIImageView alloc]init];
    [self addSubview:chapterImageV];
    chapterImageV.image = [UIImage imageNamed:@"zxlx_ico07"];
    [chapterImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(26));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];

    self.chapterTitleLab = [[UILabel alloc]init];
    [self addSubview:self.chapterTitleLab];
    self.chapterTitleLab.text = @"";
    self.chapterTitleLab.textColor = [UIColor colorCommonBlackColor];
    self.chapterTitleLab.font = Font(14);
    [self.chapterTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(45));
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(65));
    }];

    self.chapterTotalLab = [[UILabel alloc]init];
    [self addSubview:self.chapterTotalLab];
    self.chapterTotalLab.text = @"";
    self.chapterTotalLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.chapterTotalLab.font = Font(13);
    self.chapterTotalLab.textAlignment = NSTextAlignmentRight;
    [self.chapterTotalLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
    }];
    
    UIView *lineView = [[UIView alloc]init];
    [self addSubview:lineView];
    lineView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(weakSelf);
        make.height.equalTo(@1);
    }];
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    // 章节
    self.chapterTitleLab.text = [NSString stringWithFormat:@"第%ld章 %@",(long)self.indexPath.row+1,dict[@"title"]];
    
    // 数量
    self.chapterTotalLab.text = [NSString stringWithFormat:@"%@",dict[@"nums"]];
}

-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}

@end
