//
//  BaseDetaUserInfoCell.m
//  PartyBuildingStar
//
//  Created by mac on 2019/5/21.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import "YWTBaseDetaUserInfoCell.h"

@interface YWTBaseDetaUserInfoCell ()
// 撤销图片
@property (nonatomic,strong) UIImageView *cancelImageV;
// 显示检查标题
@property (nonatomic,strong) UILabel *showChenkTitleLab;
// 检查标题
@property (nonatomic,strong) UILabel *chenkTitleLab;
// 显示检查人名称
@property (nonatomic,strong) UILabel *showChenkPersonLab;
// 检查人名称
@property (nonatomic,strong) UILabel *chenkPersonLab;
// 显示检查时间
@property (nonatomic,strong) UILabel *showChenkTimeLab;
// 检查时间
@property (nonatomic,strong) UILabel *chenkTimeLab;
// 显示检查单位
@property (nonatomic,strong) UILabel *showChenkUnitLab;
// 检查单位
@property (nonatomic,strong) UILabel *chenkUnitLab;
// 显示检查地点
@property (nonatomic,strong) UILabel *showChenkAddressLab;
// 检查地点
@property (nonatomic,strong) UILabel *chenkAddressLab;
// 显示工作票编号
@property (nonatomic,strong) UILabel *showWorkNumberLab;
// 工作票编号
@property (nonatomic,strong) UILabel *workNumberLab;
// 显示检查内容
@property (nonatomic,strong) UILabel *showChenkContentLab;
// 检查内容
@property (nonatomic,strong) UILabel *chenkContentLab;

@end

@implementation YWTBaseDetaUserInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUserInfoCell];
    }
    return self;
}
-(void) createUserInfoCell{
     __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorTextWhiteColor];
    
    // 检查标题
    self.showChenkTitleLab = [[UILabel alloc]init];
    [self addSubview:self.showChenkTitleLab];
    self.showChenkTitleLab.text = @"检查标题";
    self.showChenkTitleLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.showChenkTitleLab.font = Font(14);
    [self.showChenkTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(KSIphonScreenH(20));
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(12));
    }];
    
    self.chenkTitleLab = [[UILabel alloc]init];
    [self addSubview:self.chenkTitleLab];
    self.chenkTitleLab.text = @"";
    self.chenkTitleLab.textColor = [UIColor colorCommonBlackColor];
    self.chenkTitleLab.font = Font(14);
    self.chenkTitleLab.numberOfLines = 0;
    [self.chenkTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.showChenkTitleLab.mas_top);
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(98));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
    }];
    
    // 检查人
    self.chenkPersonLab = [[UILabel alloc]init];
    [self addSubview:self.chenkPersonLab];
    self.chenkPersonLab.text = @"";
    self.chenkPersonLab.textColor = [UIColor colorCommonBlackColor];
    self.chenkPersonLab.font = Font(14);
    self.chenkPersonLab.numberOfLines = 0;
    [self.chenkPersonLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.chenkTitleLab);
        make.top.equalTo(weakSelf.chenkTitleLab.mas_bottom).offset(KSIphonScreenH(15));
    }];
    
    self.showChenkPersonLab = [[UILabel alloc]init];
    [self addSubview:self.showChenkPersonLab];
    self.showChenkPersonLab.text = @"检查人";
    self.showChenkPersonLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.showChenkPersonLab.font = Font(14);
    [self.showChenkPersonLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.chenkPersonLab.mas_top);
        make.left.equalTo(weakSelf.showChenkTitleLab.mas_left);
    }];
    
    // 检查时间
    self.chenkTimeLab = [[UILabel alloc]init];
    [self addSubview:self.chenkTimeLab];
    self.chenkTimeLab.text = @"";
    self.chenkTimeLab.textColor = [UIColor colorCommonBlackColor];
    self.chenkTimeLab.font = Font(14);
    self.chenkTimeLab.numberOfLines  = 0;
    [self.chenkTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.chenkTitleLab.mas_left);
        make.top.equalTo(weakSelf.chenkPersonLab.mas_bottom).offset(KSIphonScreenH(15));
        make.right.equalTo(weakSelf.chenkTitleLab.mas_right);
    }];
    
    self.showChenkTimeLab = [[UILabel alloc]init];
    [self addSubview:self.showChenkTimeLab];
    self.showChenkTimeLab.text = @"检查时间";
    self.showChenkTimeLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.showChenkTimeLab.font = Font(14);
    [self.showChenkTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.chenkTimeLab.mas_top);
        make.left.equalTo(weakSelf.showChenkPersonLab.mas_left);
    }];
    
    self.chenkUnitLab = [[UILabel alloc]init];
    [self addSubview:self.chenkUnitLab];
    self.chenkUnitLab.text = @"";
    self.chenkUnitLab.textColor = [UIColor colorCommonBlackColor];
    self.chenkUnitLab.font = Font(14);
    self.chenkUnitLab.numberOfLines  = 0;
    [self.chenkUnitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.chenkTimeLab.mas_left);
        make.top.equalTo(weakSelf.chenkTimeLab.mas_bottom).offset(KSIphonScreenH(15));
        make.right.equalTo(weakSelf.chenkTitleLab.mas_right);
    }];
    
    // 检查单位
    self.showChenkUnitLab = [[UILabel alloc]init];
    [self addSubview:self.showChenkUnitLab];
    self.showChenkUnitLab.text = @"被检单位";
    self.showChenkUnitLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.showChenkUnitLab.font = Font(14);
    [self.showChenkUnitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.chenkUnitLab.mas_top);
        make.left.equalTo(weakSelf.showChenkTimeLab.mas_left);
    }];
    
    self.chenkAddressLab = [[UILabel alloc]init];
    [self addSubview:self.chenkAddressLab];
    self.chenkAddressLab.text = @"";
    self.chenkAddressLab.textColor = [UIColor colorCommonBlackColor];
    self.chenkAddressLab.font = Font(14);
    self.chenkAddressLab.numberOfLines  = 0;
    [self.chenkAddressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.chenkUnitLab.mas_left);
        make.top.equalTo(weakSelf.chenkUnitLab.mas_bottom).offset(KSIphonScreenH(15));
        make.right.equalTo(weakSelf.chenkTitleLab.mas_right);
    }];
    
    // 检查地点
    self.showChenkAddressLab = [[UILabel alloc]init];
    [self addSubview:self.showChenkAddressLab];
    self.showChenkAddressLab.text = @"被检地点";
    self.showChenkAddressLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.showChenkAddressLab.font = Font(14);
    [self.showChenkAddressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.chenkAddressLab.mas_top);
        make.left.equalTo(weakSelf.showChenkUnitLab.mas_left);
    }];
    
    // 工作票编号
    self.workNumberLab = [[UILabel alloc]init];
    [self addSubview:self.workNumberLab];
    self.workNumberLab.text = @"";
    self.workNumberLab.textColor = [UIColor colorCommonBlackColor];
    self.workNumberLab.font = Font(14);
    self.workNumberLab.numberOfLines = 0;
    [self.workNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.chenkAddressLab.mas_left);
        make.top.equalTo(weakSelf.chenkAddressLab.mas_bottom).offset(KSIphonScreenH(15));
        make.right.equalTo(weakSelf.chenkTitleLab.mas_right);
    }];
    
    self.showWorkNumberLab = [[UILabel alloc]init];
    [self addSubview:self.showWorkNumberLab];
    self.showWorkNumberLab.text = @"工作票编号";
    self.showWorkNumberLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.showWorkNumberLab.font = Font(14);
    [self.showWorkNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.showChenkPersonLab.mas_left);
        make.top.equalTo(weakSelf.workNumberLab.mas_top);
    }];
    
    // 检查内容
    self.chenkContentLab = [[UILabel alloc]init];
    [self addSubview:self.chenkContentLab];
    self.chenkContentLab.text = @"";
    self.chenkContentLab.textColor = [UIColor colorCommonBlackColor];
    self.chenkContentLab.font = Font(14);
    self.chenkContentLab.numberOfLines = 0;
    [self.chenkContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.workNumberLab.mas_left);
        make.top.equalTo(weakSelf.workNumberLab.mas_bottom).offset(KSIphonScreenH(15));
        make.right.equalTo(weakSelf.chenkTitleLab.mas_right);
    }];
    
    self.showChenkContentLab = [[UILabel alloc]init];
    [self addSubview:self.showChenkContentLab];
    self.showChenkContentLab.text = @"检查内容";
    self.showChenkContentLab.textColor = [UIColor colorCommonGreyBlackColor];
    self.showChenkContentLab.font = Font(14);
    [self.showChenkContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.showChenkPersonLab.mas_left);
        make.top.equalTo(weakSelf.chenkContentLab.mas_top);
    }];
    
    // 撤销图片
    self.cancelImageV = [[UIImageView alloc]init];
    [self addSubview:self.cancelImageV];
    self.cancelImageV.image = [UIImage imageNamed:@"base_annex_cancel"];
    [self.cancelImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(KSIphonScreenH(8));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
    }];
    self.cancelImageV.hidden = YES;
}
-(void)setCellType:(showBaseUserInfoCellType)cellType{
    _cellType = cellType;
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    // 撤销图片
    NSString *revokeIsStr = [NSString stringWithFormat:@"%@",dict[@"revokeIs"]];
    if ([revokeIsStr isEqualToString:@"1"]) {
        self.cancelImageV.hidden = YES;
    }else{
        self.cancelImageV.hidden = NO;
    }
    if (self.cellType == showBaseUserInfoSafetyType) {
             //安全检查
        // 检查人
        self.chenkPersonLab.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"realName"]]];
        // 检查时间
        self.chenkTimeLab.text =[YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"checkTime"]]];
        // 被检单位
        self.chenkUnitLab.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"beingCheckUnitName"]]];
        // 地点
        self.chenkAddressLab.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"securityCheckAddress"]]];
        // 工作票
        self.workNumberLab.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"workTicketNumber"]]];
        //  标题
        self.chenkTitleLab.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"securityCheckTitle"]]];
        // 内容
        self.chenkContentLab.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"securityCheckContent"]]];
    }else if (self.cellType == showBaseUserInfoMeetingType) {
                   //班会记录
        //  标题
        self.showChenkTitleLab.text = @"会议标题";
        self.chenkTitleLab.text  = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"classRecordTitle"]]];
        // 工作负责人
        self.showChenkPersonLab.text =  @"工作负责人";
        self.chenkPersonLab.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"realName"]]];
        // 工作班组
        self.showChenkTimeLab.text  = @"工作班组";
        self.chenkTimeLab.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"unitName"]]];
        // 工作地点
        self.showChenkUnitLab.text =  @"工作地点";
        self.chenkUnitLab.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"classRecordAddress"]]];
        // 工作票编号
        self.showChenkAddressLab.text = @"工作票编号";
        self.chenkAddressLab.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"workTicketNumber"]]];
        
        // 会议内容
        NSString *numberStr = [NSString stringWithFormat:@"%@",dict[@"classRecordContent"]];
        if (![numberStr isEqualToString:@""]) {
            self.showWorkNumberLab.text = @"会议内容";
            self.workNumberLab.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"classRecordContent"]]];
        }else{
            // 隐藏工作票编号
            self.showWorkNumberLab.hidden = YES;
            self.workNumberLab.hidden = YES;
            
            // 更新会议内容约束
            __weak typeof(self) weakSelf = self;
            [self.chenkContentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.chenkAddressLab.mas_left);
                make.top.equalTo(weakSelf.chenkAddressLab.mas_bottom).offset(KSIphonScreenH(15));
                make.right.equalTo(weakSelf).offset(-KSIphonScreenW(12));
            }];
        }
        // 隐藏
        self.showChenkContentLab.hidden = YES;
        self.chenkContentLab.hidden = YES;
   }else if (self.cellType == showBaseUserInfoViolationType) {
                    // 违章处理
       // 违章事由
       self.showChenkTitleLab.text = @"违章事由";
       self.chenkTitleLab.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"violationHanTitle"]]];
       // 查处人员
       self.showChenkPersonLab.text = @"查处人员";
       self.chenkPersonLab.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"realName"]]];
       // 违章人姓名
       self.showChenkTimeLab.text  = @"违章人姓名";
       self.chenkTimeLab.text =[YWTTools getWithNSStringGoHtmlString: [NSString stringWithFormat:@"%@",dict[@"violationUserInfo"]]];
       // 违章人单位
       self.showChenkUnitLab.text = @"违章人单位";
       self.chenkUnitLab.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"violationUnitName"]]];
       // 违章等级
       self.showChenkAddressLab.text = @"违章等级";
       self.chenkAddressLab.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"levels"]]];
       // 处理情况
       self.showWorkNumberLab.text = @"处理情况";
       self.workNumberLab.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"violationHanContent"]]];
       
       // 内容
       self.showChenkContentLab.hidden = YES;
       self.chenkContentLab.hidden = YES;
   }else if (self.cellType == showBaseUserInfoTechnoloType) {
                     // 技术交底
       // 交底标题
       self.showChenkTitleLab.text = @"交底标题";
       self.chenkTitleLab.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"technicalDisclosureTitle"]]];
       // 交底人员
       self.showChenkPersonLab.text = @"交底人员";
       self.chenkPersonLab.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"realName"]]];
       // 工作地点
       self.showChenkTimeLab.text  = @"工作地点";
       self.chenkTimeLab.text =[YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"technicalDisclosureAddress"]]];
       // 工作票编号
       self.showChenkUnitLab.text = @"工作票编号";
       self.chenkUnitLab.text = [YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"workTicketNumber"]]];
       // 交底内容
       self.showChenkAddressLab.text = @"交底内容";
       self.chenkAddressLab.text =[YWTTools getWithNSStringGoHtmlString:[NSString stringWithFormat:@"%@",dict[@"technicalDisclosureContent"]]];
       // 处理情况
       self.showWorkNumberLab.hidden = YES;
       self.workNumberLab.hidden = YES;
       // 内容
       self.showChenkContentLab.hidden = YES;
       self.chenkContentLab.hidden = YES;
   }
}

// 计算高度
+(CGFloat) getWithBaseDetaUserInfoHeightCell:(NSDictionary*)dict andCellType:(showBaseUserInfoCellType)cellType{

    CGFloat height = KSIphonScreenH(20);
    if (cellType == showBaseUserInfoSafetyType) {
        // 标题
        NSString *titleStr = [NSString stringWithFormat:@"%@",dict[@"securityCheckTitle"]];
        CGFloat titleHieght = [YWTTools getSpaceLabelHeight:titleStr withFont:13 withWidth:KScreenW-KSIphonScreenW(110) withSpace:2];
        height += titleHieght;
        height += KSIphonScreenH(15);
        
        // 检查人
        NSString  *realNameStr = [NSString stringWithFormat:@"%@",dict[@"realName"]];
        CGFloat realNameHieght = [YWTTools getSpaceLabelHeight:realNameStr withFont:13 withWidth:KScreenW-KSIphonScreenW(110) withSpace:2];
        height += realNameHieght;
        height += KSIphonScreenH(15);
        
        // 检查时间
        NSString *checkTimeStr = [NSString stringWithFormat:@"%@",dict[@"checkTime"]];
        CGFloat checkTimeHieght = [YWTTools getSpaceLabelHeight:checkTimeStr withFont:13 withWidth:KScreenW-KSIphonScreenW(110) withSpace:2];
        height += checkTimeHieght;
        height += KSIphonScreenH(15);
        
        // 检查单位
        NSString *beingCheckUnitNameStr = [NSString stringWithFormat:@"%@",dict[@"beingCheckUnitName"]];
        CGFloat beingCheckUnitNameHieght = [YWTTools getSpaceLabelHeight:beingCheckUnitNameStr withFont:13 withWidth:KScreenW-KSIphonScreenW(110) withSpace:2];
        height += beingCheckUnitNameHieght;
        height += KSIphonScreenH(15);
        
        // 检查地点
        NSString *securityCheckAddressStr = [NSString stringWithFormat:@"%@",dict[@"securityCheckAddress"]];
        CGFloat securityCheckAddressHieght = [YWTTools getSpaceLabelHeight:securityCheckAddressStr withFont:13 withWidth:KScreenW-KSIphonScreenW(110) withSpace:2];
        height += securityCheckAddressHieght;
        height += KSIphonScreenH(15);
        
        // 工作票号
        NSString *workTicketNumberStr = [NSString stringWithFormat:@"%@",dict[@"workTicketNumber"]];
        CGFloat workTicketNumberHieght = [YWTTools getSpaceLabelHeight:workTicketNumberStr withFont:13 withWidth:KScreenW-KSIphonScreenW(110) withSpace:2];
        height += workTicketNumberHieght;
        height += KSIphonScreenH(15);
        
        // 检查内容
        NSString *sClassRecordContentStr = [NSString stringWithFormat:@"%@",dict[@"securityCheckContent"]];
        CGFloat sClassRecordContentHieght = [YWTTools getSpaceLabelHeight:sClassRecordContentStr withFont:13 withWidth:KScreenW-KSIphonScreenW(110) withSpace:2];
        height += sClassRecordContentHieght;
        height += KSIphonScreenH(20);
    }else if (cellType == showBaseUserInfoMeetingType) {
                   // 班会记录
        // 标题
        NSString *titleStr = [NSString stringWithFormat:@"%@",dict[@"classRecordTitle"]];
        CGFloat titleHieght = [YWTTools getSpaceLabelHeight:titleStr withFont:13 withWidth:KScreenW-KSIphonScreenW(110) withSpace:2];
        height += titleHieght;
        height += KSIphonScreenH(15);
        
        // 工作负责人
        NSString  *realNameStr = [NSString stringWithFormat:@"%@",dict[@"realName"]];
        CGFloat realNameHieght = [YWTTools getSpaceLabelHeight:realNameStr withFont:13 withWidth:KScreenW-KSIphonScreenW(110) withSpace:2];
        height += realNameHieght;
        height += KSIphonScreenH(15);
        
        // 工作班组
        NSString *addTimeStr = [NSString stringWithFormat:@"%@",dict[@"unitName"]];
        CGFloat addTimeHieght = [YWTTools getSpaceLabelHeight:addTimeStr withFont:13 withWidth:KScreenW-KSIphonScreenW(110) withSpace:2];
        height += addTimeHieght;
        height += KSIphonScreenH(15);
        
        // 检查地点
        NSString *unitNameStr = [NSString stringWithFormat:@"%@",dict[@"classRecordAddress"]];
        CGFloat unitNameHieght = [YWTTools getSpaceLabelHeight:unitNameStr withFont:13 withWidth:KScreenW-KSIphonScreenW(110) withSpace:2];
        height += unitNameHieght;
        height += KSIphonScreenH(15);
        
        // 工作票号
        NSString *securityCheckAddressStr = [NSString stringWithFormat:@"%@",dict[@"workTicketNumber"]];
        CGFloat securityCheckAddressHieght = [YWTTools getSpaceLabelHeight:securityCheckAddressStr withFont:13 withWidth:KScreenW-KSIphonScreenW(110) withSpace:2];
        height += securityCheckAddressHieght;
        height += KSIphonScreenH(15);
        
        // 会议内容
        NSString *sClassRecordContentStr = [NSString stringWithFormat:@"%@",dict[@"classRecordContent"]];
        if (![sClassRecordContentStr isEqualToString:@""]) {
            CGFloat sClassRecordContentHieght = [YWTTools getSpaceLabelHeight:sClassRecordContentStr withFont:13 withWidth:KScreenW-KSIphonScreenW(110) withSpace:2];
            height += sClassRecordContentHieght;
            height += KSIphonScreenH(20);
        }
       
    }else if (cellType == showBaseUserInfoViolationType) {
             // 违章处理
        // 标题
        NSString *titleStr = [NSString stringWithFormat:@"%@",dict[@"violationHanTitle"]];
        CGFloat titleHieght = [YWTTools getSpaceLabelHeight:titleStr withFont:13 withWidth:KScreenW-KSIphonScreenW(110) withSpace:2];
        height += titleHieght;
        height += KSIphonScreenH(15);
        
        // 查处人员
        NSString  *realNameStr = [NSString stringWithFormat:@"%@",dict[@"realName"]];
        CGFloat realNameHieght = [YWTTools getSpaceLabelHeight:realNameStr withFont:13 withWidth:KScreenW-KSIphonScreenW(110) withSpace:2];
        height += realNameHieght;
        height += KSIphonScreenH(15);
        
        // 违章人员信息
        NSString *addTimeStr = [NSString stringWithFormat:@"%@",dict[@"violationUserInfo"]];
        CGFloat addTimeHieght = [YWTTools getSpaceLabelHeight:addTimeStr withFont:13 withWidth:KScreenW-KSIphonScreenW(110) withSpace:2];
        height += addTimeHieght;
        height += KSIphonScreenH(15);
        
        // 违章人员单位
        NSString *unitNameStr = [NSString stringWithFormat:@"%@",dict[@"violationUnitName"]];
        CGFloat unitNameHieght = [YWTTools getSpaceLabelHeight:unitNameStr withFont:13 withWidth:KScreenW-KSIphonScreenW(110) withSpace:2];
        height += unitNameHieght;
        height += KSIphonScreenH(15);
        
        // 违章等级
        NSString *levelsStr = [NSString stringWithFormat:@"%@",dict[@"levels"]];
        CGFloat levelsHieght = [YWTTools getSpaceLabelHeight:levelsStr withFont:13 withWidth:KScreenW-KSIphonScreenW(110) withSpace:2];
        height += levelsHieght;
        height += KSIphonScreenH(15);
        
        // 处理q情况
        NSString *violationHanContentStr = [NSString stringWithFormat:@"%@",dict[@"violationHanContent"]];
        CGFloat violationHanContentHieght = [YWTTools getSpaceLabelHeight:violationHanContentStr withFont:13 withWidth:KScreenW-KSIphonScreenW(110) withSpace:2];
        height += violationHanContentHieght;
        height += KSIphonScreenH(20);
    }else if (cellType == showBaseUserInfoTechnoloType) {
           // 技术
        // 标题
        NSString *titleStr = [NSString stringWithFormat:@"%@",dict[@"technicalDisclosureTitle"]];
        CGFloat titleHieght = [YWTTools getSpaceLabelHeight:titleStr withFont:13 withWidth:KScreenW-KSIphonScreenW(110) withSpace:2];
        height += titleHieght;
        height += KSIphonScreenH(15);
        
        // 交底人员
        NSString  *realNameStr = [NSString stringWithFormat:@"%@",dict[@"realName"]];
        CGFloat realNameHieght = [YWTTools getSpaceLabelHeight:realNameStr withFont:13 withWidth:KScreenW-KSIphonScreenW(110) withSpace:2];
        height += realNameHieght;
        height += KSIphonScreenH(15);
        
        // 工作地点
        NSString *technicalDisclosureAddressStr = [NSString stringWithFormat:@"%@",dict[@"technicalDisclosureAddress"]];
        CGFloat technicalDisclosureAddressHieght = [YWTTools getSpaceLabelHeight:technicalDisclosureAddressStr withFont:13 withWidth:KScreenW-KSIphonScreenW(110) withSpace:2];
        height += technicalDisclosureAddressHieght;
        height += KSIphonScreenH(15);
        
        // 工作票编号
        NSString *workTicketNumberStr = [NSString stringWithFormat:@"%@",dict[@"workTicketNumber"]];
        CGFloat workTicketNumberHieght = [YWTTools getSpaceLabelHeight:workTicketNumberStr withFont:13 withWidth:KScreenW-KSIphonScreenW(110) withSpace:2];
        height += workTicketNumberHieght;
        height += KSIphonScreenH(15);
        
        // 交底内容
        NSString *contentStr = [NSString stringWithFormat:@"%@",dict[@"technicalDisclosureContent"]];
        CGFloat contentHieght = [YWTTools getSpaceLabelHeight:contentStr withFont:13 withWidth:KScreenW-KSIphonScreenW(110) withSpace:2];
        height += contentHieght;
        height += KSIphonScreenH(15);
    }
    return height ;
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
