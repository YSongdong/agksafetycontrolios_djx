//
//  MsgCenterTableViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/4.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTMsgCenterTableViewCell.h"

@interface YWTMsgCenterTableViewCell ()
// 通知时间
@property (nonatomic,strong) UILabel *noticeTimeLab;
// 类型图片
@property (nonatomic,strong) UIImageView *typeImageV;
// 通知类型
@property (nonatomic,strong) UILabel *noticeTypeLab;
// 通知标题
@property (nonatomic,strong) UILabel *noticeTitleLab;
// 通知内容
@property (nonatomic,strong) UILabel *noticeCententLab;

@end


@implementation YWTMsgCenterTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createMessageCellView];
    }
    return self;
}
-(void) createMessageCellView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];

    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
   
    UIView *timeView = [[UIView alloc]init];
    [bgView addSubview:timeView];
    timeView.backgroundColor  = [UIColor colorWithHexString:@"#d8d8d8"];
   
    // 通知时间
    self.noticeTimeLab = [[UILabel alloc]init];
    [timeView addSubview:self.noticeTimeLab];
    self.noticeTimeLab.text = @"2018.06.12 17:50:50";
    self.noticeTimeLab.textColor = [UIColor colorTextWhiteColor];
    self.noticeTimeLab.font = Font(14);
    [self.noticeTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeView).offset(KSIphonScreenH(2));
        make.left.equalTo(timeView).offset(KSIphonScreenW(2));
        make.bottom.equalTo(timeView).offset(-KSIphonScreenH(2));
        make.right.equalTo(timeView).offset(-KSIphonScreenW(2));
    }];
    
    [timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(KSIphonScreenH(12));
        make.centerX.equalTo(bgView.mas_centerX);
        make.height.equalTo(@20);
    }];
    timeView.layer.cornerRadius = 3;
    timeView.layer.masksToBounds = YES;
    
    // 通知类型图片
    self.typeImageV =[[ UIImageView alloc]init];
    [bgView addSubview:self.typeImageV];
    self.typeImageV.image = [UIImage imageNamed:@"msg_photoChenk"];
    self.typeImageV.contentMode = UIViewContentModeScaleAspectFit;
    [self.typeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeView.mas_bottom).offset(KSIphonScreenH(15));
        make.left.equalTo(bgView).offset(KSIphonScreenW(12));
        make.height.width.equalTo(@40);
    }];

    //通知类型
    self.noticeTypeLab = [[UILabel alloc]init];
    [bgView addSubview:self.noticeTypeLab];
    self.noticeTypeLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.noticeTypeLab.font = Font(14);
    [self.noticeTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeView.mas_bottom).offset(KSIphonScreenH(15));
        make.left.equalTo(weakSelf.typeImageV.mas_right).offset(KSIphonScreenH(8));
        make.height.equalTo(@20);
    }];
    
    UIView *contentView = [[UIView alloc]init];
    [bgView addSubview:contentView];
    contentView.backgroundColor = [UIColor colorTextWhiteColor];
    
    // 通知标题
    self.noticeTitleLab = [[UILabel alloc]init];
    [contentView addSubview:self.noticeTitleLab];
    self.noticeTitleLab.textColor  =[UIColor colorLineCommonBlueColor];
    self.noticeTitleLab.font = Font(1);
    self.noticeTitleLab.numberOfLines = 0;
    [self.noticeTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(KSIphonScreenH(10));
        make.left.equalTo(contentView).offset(KSIphonScreenW(10));
        make.right.equalTo(contentView).offset(-KSIphonScreenW(10));
    }];
    
    // 通知内容
    self.noticeCententLab = [[UILabel alloc]init];
    [contentView addSubview:self.noticeCententLab];
    self.noticeCententLab.textColor = [UIColor colorCommonBlackColor];
    self.noticeCententLab.font = Font(15);
    self.noticeCententLab.numberOfLines  = 0;
    [self.noticeCententLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.noticeTitleLab.mas_bottom).offset(KSIphonScreenH(10));
        make.left.equalTo(contentView).offset(KSIphonScreenW(10));
        make.right.equalTo(contentView).offset(-KSIphonScreenW(10));
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.noticeTypeLab.mas_bottom).offset(KSIphonScreenH(5));
        make.left.equalTo(weakSelf.noticeTypeLab.mas_left);
        make.right.equalTo(bgView).offset(-KSIphonScreenW(27));
        make.bottom.equalTo(weakSelf.noticeCententLab.mas_bottom).offset(KSIphonScreenH(15));
    }];
    contentView.layer.cornerRadius = 5;
    contentView.layer.masksToBounds = YES;
    contentView.layer.borderWidth =1;
    contentView.layer.borderColor = [UIColor colorWithHexString:@"#e7e7e7"].CGColor;
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    // 消息类型
    NSString *typesOfStr = [NSString stringWithFormat:@"%@",dict[@"typesOf"]];
    //  1系统消息 2考试通知3任务通知
    if ([typesOfStr isEqualToString:@"2"]){
        // 考试通知
        self.typeImageV.image = [UIImage imageNamed:@"msg_examScore"];
    }else if ([typesOfStr isEqualToString:@"3"]){
        // 任务通知
        self.typeImageV.image = [UIImage imageNamed:@"msg_taskNotifi"];
    }else{
        // 系统消息
        self.typeImageV.image = [UIImage imageNamed:@"msg_photoChenk"];
    }
    
    // 更新时间
    self.noticeTimeLab.text =[YWTTools timestampSwitchTime:[dict[@"createTime"]integerValue] andFormatter:@"YYYY-MM-dd hh:mm:ss"];
    
    //通知类型
    self.noticeTypeLab.text = [NSString stringWithFormat:@"%@",dict[@"tagTitle"]];
    
    // 通知标题
    NSAttributedString *titleAttrStr = [[NSAttributedString alloc]initWithData:[dict[@"title"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    self.noticeTitleLab.attributedText =titleAttrStr;
    self.noticeTitleLab.font = Font(18);
    
    // 通知内容
    NSString *contentsStr = [NSString stringWithFormat:@"%@",dict[@"contents"]];
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSFontAttributeName:[UIFont systemFontOfSize:13]};
    NSData *data = [contentsStr dataUsingEncoding:NSUnicodeStringEncoding];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.lineSpacing = 2;
    [attrStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attrStr.length)];
    self.noticeCententLab.attributedText = attrStr;
    self.noticeCententLab.font = Font(14);
    self.noticeCententLab.textColor = [UIColor colorCommonBlackColor];
}
//计算cell 高度
+(CGFloat) getWithCellHeight:(NSDictionary *)dict{
    CGFloat height = 0;
    height += 80;
    
    // 通知标题
    CGFloat titleHeight =[YWTTools getLabelHeightWithText:dict[@"title"] width:KScreenW-KSIphonScreenW(150) font:14];
    height += titleHeight;
    height += 15;
    
    // 通知内容
    UILabel *lab = [[UILabel alloc]init];
    NSString *contentsStr = [NSString stringWithFormat:@"%@",dict[@"contents"]];
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSFontAttributeName:[UIFont systemFontOfSize:13]};
    NSData *data = [contentsStr dataUsingEncoding:NSUnicodeStringEncoding];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.lineSpacing = 2;
    [attrStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attrStr.length)];
    lab.attributedText = attrStr;
    // 通知内容高度
    CGFloat contentHeight =  [lab.attributedText boundingRectWithSize:CGSizeMake(KScreenW-KSIphonScreenW(160), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    height += contentHeight;
    
    height += 50;
    
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
