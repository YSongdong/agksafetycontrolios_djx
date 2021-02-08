//
//  PlatformAnnoTableViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/1.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTPlatformAnnoTableViewCell.h"

@interface YWTPlatformAnnoTableViewCell ()

@property (nonatomic,strong) UILabel *contentLab;

@property (nonatomic,strong) UILabel *timerLab;

@end

@implementation YWTPlatformAnnoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createPlatformView];
    }
    return self;
}
-(void) createPlatformView{
    __weak typeof(self) weakSelf = self;
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorTextWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];

    // 内容
    self.contentLab = [[UILabel alloc]init];
    [bgView addSubview:self.contentLab];
    self.contentLab.text =@"";
    self.contentLab.textColor = [UIColor colorCommon65GreyBlackColor];
    self.contentLab.font = Font(14);
    self.contentLab.numberOfLines = 0;
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(KSIphonScreenW(12));
        make.right.equalTo(bgView).offset(-KSIphonScreenW(12));
        make.top.equalTo(bgView).offset(KSIphonScreenH(17));
    }];
    
    // 时间
    self.timerLab = [[UILabel alloc]init];
    [bgView addSubview:self.timerLab];
    self.timerLab.text = @"";
    self.timerLab.textColor = [UIColor colorCommonAAAAGreyBlackColor];
    self.timerLab.font = Font(14);
    [self.timerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentLab.mas_bottom).offset(KSIphonScreenH(10));
        make.left.equalTo(bgView).offset(KSIphonScreenW(12));
        make.height.equalTo(@22);
        make.bottom.equalTo(bgView).offset(-KSIphonScreenH(17));
    }];
    
    UIView *lineView = [[UIView alloc]init];
    [bgView addSubview:lineView];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(bgView);
        make.height.equalTo(@1);
    }];
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    //时间
    self.timerLab.text = dict[@"createTime"];
    
    //内容
    NSString *typeStr;
    NSString *typesStr = [NSString stringWithFormat:@"%@",dict[@"types"]];
    if ([typesStr isEqualToString:@"2"]){
        typeStr = @"【考试公告】";
    }else if ([typesStr isEqualToString:@"2"]){
        typeStr = @"【管理公告】";
    }else{
        typeStr = @"【系统公告】";
    }
    NSString *contentStr = [NSString stringWithFormat:@"%@: %@",typeStr,dict[@"contents"]];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString: contentStr];
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = [UIImage imageNamed:@"ico_ad"]; //设置图片源
    textAttachment.bounds = CGRectMake(0, -8, 27, 27);                 //设置图片位置和大小
    NSAttributedString *attrStr = [NSAttributedString attributedStringWithAttachment: textAttachment];
    [attributedStr insertAttributedString: attrStr atIndex: 0]; //NSTextAttachment占用一个字符长度，插入后原字符串长度增加1
    
    //设置字体
    [attributedStr addAttribute:NSFontAttributeName value:
     BFont(14) range:NSMakeRange(0, 7)];
//    //设置字体颜色
//    [attributedStr addAttribute:NSForegroundColorAttributeName value:
//    [UIColor colorCommonBlackColor] range:NSMakeRange(0, 7)];
    
    //设置行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [contentStr length])];
    
    self.contentLab.attributedText = attributedStr;
    self.contentLab.textColor = [UIColor colorCommonBlackColor];
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
