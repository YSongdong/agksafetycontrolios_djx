//
//  ListTypeCellHeaderView.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/23.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTListTypeCellHeaderView.h"

#import "STTagsView.h"
#import "STTagFrame.h"

@interface YWTListTypeCellHeaderView () 
// 标题
@property (nonatomic,strong) UILabel *titleLab;
// 标签view
@property (nonatomic,strong) STTagsView *tagView;
// 时间
@property (nonatomic,strong) UILabel *timeLab;
// 说明
@property (nonatomic,strong) UILabel *explanationLab;

@property (nonatomic,strong) UIView *lineView;

@end


@implementation YWTListTypeCellHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createHeaderView];
    }
    return self;
}
-(void) createHeaderView{
    __weak typeof(self) weakSelf = self;
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    // 标题
    self.titleLab = [[UILabel alloc]init];
    [bgView addSubview:self.titleLab];
    self.titleLab.text = @"";
    self.titleLab.textColor = [UIColor colorCommonBlackColor];
    self.titleLab.font = BFont(18);
    self.titleLab.numberOfLines = 0;
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(KSIphonScreenH(17));
        make.left.equalTo(bgView).offset(KSIphonScreenW(15));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(13));
    }];
    
    // 标签
    self.tagView = [STTagsView tagViewWithFrame:CGRectZero tagsArray:@[] textColor:[UIColor colorTextWhiteColor] textFont:Font(12) normalTagBackgroundColor:[UIColor colorTextWhiteColor] tagBorderColor:[UIColor colorTextWhiteColor] contentInsets:UIEdgeInsetsMake(2, 6, 2, 6) labelContentInsets:UIEdgeInsetsMake(2, 6, 2, 6) labelHorizontalSpacing:10 labelVerticalSpacing:10];
    [self addSubview:self.tagView];
    
    [self.tagView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLab.mas_bottom).offset(KSIphonScreenH(9));
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(9));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(15));
    }];
    
    // 时间
    self.timeLab = [[UILabel alloc]init];
    [bgView addSubview:self.timeLab];
    self.timeLab.text = @"时间 ";
    self.timeLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.timeLab.font = Font(13);
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.tagView.mas_bottom).offset(KSIphonScreenH(15));
        make.left.equalTo(weakSelf.titleLab.mas_left);
    }];

    // 说明
    self.explanationLab = [[UILabel alloc]init];
    [bgView addSubview:self.explanationLab];
    self.explanationLab.text = @"说明 ";
    self.explanationLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.explanationLab.font = Font(13);
    self.explanationLab.numberOfLines = 0 ;
    [self.explanationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.timeLab.mas_bottom).offset(KSIphonScreenH(8));
        make.left.equalTo(weakSelf.timeLab.mas_left);
        make.right.equalTo(bgView).offset(-KSIphonScreenW(13));
    }];
    
    self.lineView = [[UIView alloc]init];
    [bgView addSubview:self.lineView];
    self.lineView.backgroundColor = [UIColor colorLineE3E3CommonGreyBlackColor];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.explanationLab.mas_bottom).offset(KSIphonScreenH(14));
        make.left.equalTo(bgView).offset(KSIphonScreenW(15));
        make.right.equalTo(bgView).offset(-KSIphonScreenH(15));
        make.height.equalTo(@1);
    }];
}
-(void)setModel:(BaseShowListModel *)model{
    _model = model;
   
    __weak typeof(self) weakSelf = self;
    // 标题
    self.titleLab.text = [NSString stringWithFormat:@"%@",model.title];
    [YWTTools changeLineSpaceForLabel:self.titleLab WithSpace:3 andFont:BFont(19)];
    
    NSArray *tagArr = model.tag;
    if (tagArr.count == 0) {
        [self.timeLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.titleLab.mas_bottom).offset(KSIphonScreenH(15));
            make.left.equalTo(weakSelf.titleLab.mas_left);
        }];
    }else{
        // 标签的高度
        STTagFrame * tagFrame = [STTagFrame tagFrameWithContentInsets:UIEdgeInsetsMake(2, 6, 2, 6) labelContentInsets:UIEdgeInsetsMake(2, 6, 2, 6) horizontalSpacing:10 verticalSpacing:10 textFont:[UIFont systemFontOfSize:12] tagArray:tagArr];
        tagFrame.width = KScreenW-KSIphonScreenW(54) ;
        tagFrame.tagsArray = tagArr.mutableCopy;
        
        [self.tagView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.titleLab.mas_bottom).offset(KSIphonScreenH(9));
            make.left.equalTo(weakSelf).offset(KSIphonScreenW(9));
            make.right.equalTo(weakSelf).offset(-KSIphonScreenW(15));
            make.height.equalTo(@(tagFrame.height));
        }];
        
        [self.timeLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.tagView.mas_bottom).offset(KSIphonScreenH(15));
            make.left.equalTo(weakSelf.titleLab.mas_left);
        }];
    }
    self.tagView.tagsList = [NSMutableArray arrayWithArray:tagArr];
    
    // 时间
    self.timeLab.text = [NSString stringWithFormat:@"时间 %@",model.time];
    // 说明
    if (![model.content isEqualToString:@""]) {
        self.explanationLab.hidden = NO;
        self.explanationLab.text = [NSString stringWithFormat:@"说明 %@",model.content];
        [YWTTools changeLineSpaceForLabel:self.explanationLab WithSpace:3 andFont:Font(13)];
    }else{
        self.explanationLab.hidden = YES;
        __weak typeof(self) weakSelf = self;
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.timeLab.mas_bottom).offset(KSIphonScreenH(14));
            make.left.equalTo(weakSelf).offset(KSIphonScreenW(15));
            make.right.equalTo(weakSelf).offset(-KSIphonScreenH(15));
            make.height.equalTo(@1);
        }];
    }
}

// 计算高度
+(CGFloat) getTypeCellHeader:(BaseShowListModel *)model{
    CGFloat heiht = KSIphonScreenH(17);
    // 标题
    NSString *titleStr = [NSString stringWithFormat:@"%@",model.title];
    CGFloat titleHight = [YWTTools getSpaceLabelHeight:titleStr withFont:18 withWidth:KScreenW-KSIphonScreenW(40) withSpace:3];
    heiht += titleHight;
    
    NSArray *tagArr = model.tag;
    if (tagArr.count == 0) {
        // 时间段
        heiht += KSIphonScreenH(35);
        // 说明
        NSString *markStr = [NSString stringWithFormat:@"%@",model.content];
        if (![markStr isEqualToString:@""]) {
            CGFloat  markHight = [YWTTools getSpaceLabelHeight:markStr withFont:13 withWidth:KScreenW-KSIphonScreenW(54) withSpace:3];
            heiht += markHight;
        }
        heiht += KSIphonScreenH(22);
        return heiht;
    }
    
    STTagFrame * tagFrame = [STTagFrame tagFrameWithContentInsets:UIEdgeInsetsMake(2, 6, 2, 6) labelContentInsets:UIEdgeInsetsMake(2, 6, 2, 6) horizontalSpacing:10 verticalSpacing:10 textFont:[UIFont systemFontOfSize:12] tagArray:tagArr];
    tagFrame.width = KScreenW-KSIphonScreenW(45) ;
    tagFrame.tagsArray = tagArr.mutableCopy;
    heiht += tagFrame.height;

    heiht += KSIphonScreenH(35);
    // 说明
    NSString *markStr = [NSString stringWithFormat:@"%@",model.content];
    if (![model.content isEqualToString:@""]) {
        
        CGFloat  markHight = [YWTTools getSpaceLabelHeight:markStr withFont:13 withWidth:KScreenW-KSIphonScreenW(54) withSpace:3];
        heiht += markHight;
        
    }
    heiht += KSIphonScreenH(30);
    
    return heiht;
}



@end
