//
//  RecordListTableViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/22.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTRecordListTableViewCell.h"

@interface YWTRecordListTableViewCell ()

// 标题
@property (nonatomic,strong) UILabel *titleLab;
// 时间
@property (nonatomic,strong) UILabel *timeLab;
// 时长
@property (nonatomic,strong) UILabel *durationLab;

@end



@implementation YWTRecordListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       [self createListView];
    }
    return self;
}

-(void) createListView{
    __weak typeof(self) weakSelf = self;
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    [bgView addSubview:lineView];
    lineView.backgroundColor = [UIColor colorLineCommonGreyBlackColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(bgView);
        make.height.equalTo(@1);
    }];
    
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:self.selectBtn];
    [self.selectBtn setImage:[UIImage imageNamed:@"annex_record_nomal"] forState:UIControlStateNormal];
    [self.selectBtn setImage:[UIImage imageNamed:@"annex_record_select"] forState:UIControlStateSelected];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(bgView);
        make.left.equalTo(bgView).offset(KSIphonScreenW(5));
        make.width.equalTo(@(KSIphonScreenW(40)));
    }];
    [self.selectBtn addTarget:self action:@selector(selectCellBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *typeImageV = [[UIImageView alloc]init];
    [bgView addSubview:typeImageV];
    typeImageV.image = [UIImage imageNamed:@"annex_record_type"];
    [typeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.selectBtn.mas_right).offset(KSIphonScreenW(7));
        make.centerY.equalTo(weakSelf.selectBtn.mas_centerY);
    }];
    
//    UIView *contentView = [[UIView alloc]init];
//    [bgView addSubview:contentView];
    
    self.titleLab = [[UILabel alloc]init];
    [typeImageV addSubview:self.titleLab];
    self.titleLab.text = @"";
    self.titleLab.textColor = [UIColor colorCommonBlackColor];
    self.titleLab.font = Font(14);
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(KSIphonScreenW(95));
        make.centerY.equalTo(typeImageV.mas_centerY);
    }];
    
//    self.timeLab = [[UILabel alloc]init];
//    [contentView addSubview:self.timeLab];
//    self.timeLab.text = @"";
//    self.timeLab.textColor = [UIColor colorCommon65GreyBlackColor];
//    self.timeLab.font = Font(12);
//    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.titleLab.mas_bottom).offset(KSIphonScreenH(10));
//        make.left.equalTo(weakSelf.titleLab.mas_left);
//    }];
//
//    self.durationLab = [[UILabel alloc]init];
//    [contentView addSubview:self.durationLab];
//    self.durationLab.text = @"";
//    self.durationLab.textColor = [UIColor colorCommon65GreyBlackColor];
//    self.durationLab.font = Font(12);
//    [self.durationLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf.timeLab.mas_right).offset(KSIphonScreenW(22));
//        make.centerY.equalTo(weakSelf.timeLab.mas_centerY);
//    }];
//
//    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.titleLab.mas_top);
//        make.left.equalTo(bgView).offset(KSIphonScreenW(83));
//        make.right.equalTo(bgView).offset(-KSIphonScreenW(15));
//        make.bottom.equalTo(weakSelf.timeLab.mas_bottom);
//        make.centerY.equalTo(bgView.mas_centerY);
//    }];

}

-(void)setFliePath:(NSString *)fliePath{
    _fliePath = fliePath;
    
    self.titleLab.text = fliePath;
}
-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}
-(void) selectCellBtn:(UIButton *) sender{
    self.selectIndexPath(self.indexPath);
}
-(void)setSelectIndex:(NSIndexPath *)selectIndex{
    _selectIndex = selectIndex;
    if (selectIndex == nil) {
        return;
    }
    if (selectIndex.row == self.indexPath.row) {
        self.selectBtn.selected = YES;
    }else{
        self.selectBtn.selected = NO;
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
