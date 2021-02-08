//
//  YWTUserInfoDetailCell.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/18.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTUserInfoDetailCell.h"

@interface YWTUserInfoDetailCell ()
// 发布人头像
@property (nonatomic,strong) UIImageView *releaseHeaderImageV;
// 发布人名称
@property (nonatomic,strong) UILabel *relesaNameLab;
// 发布人单位
@property (nonatomic,strong) UILabel *relesaUnitLab;
// 发布人背景view
@property (nonatomic,strong) UIView *relesaeBgView;
// 发布人背景view
@property (nonatomic,strong) UIView *relesaeNameBgView;

// 接收人头像
@property (nonatomic,strong) UIImageView *receiveHeaderImageV;
// 接收人名称
@property (nonatomic,strong) UILabel *receiveNameLab;
// 接收人单位
@property (nonatomic,strong) UILabel *receiveUnitLab;
//
@property (nonatomic,strong) UIView *receiveBgView;

// 接收人背景view
@property (nonatomic,strong) UIView *receiveNameBgView;

@end


@implementation YWTUserInfoDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createDetailCell];
    }
    return self;
}
-(void) createDetailCell{
    WS(weakSelf);
    self.backgroundColor = [UIColor colorViewBackGrounpWhiteColor];
    
    UIImageView *bgImageV = [[UIImageView alloc]init];
    [self addSubview:bgImageV];
    bgImageV.image = [UIImage imageNamed:@"suggestion_detail_bg"];
    [bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(KSIphonScreenH(40));
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(38));
        make.bottom.equalTo(weakSelf).offset(-KSIphonScreenH(40));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(38));
    }];
    
    // 发布
    self.relesaeBgView = [[UIView alloc]init];
    [self addSubview:self.relesaeBgView];
    [self.relesaeBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(KSIphonScreenH(50));
        make.left.equalTo(weakSelf).offset(KSIphonScreenW(40));
        make.right.equalTo(weakSelf).offset(-KSIphonScreenW(40));
    }];
    
    // 接收
    self.receiveBgView = [[UIView alloc]init];
    [self addSubview:self.receiveBgView];
    [self.receiveBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.relesaeBgView.mas_bottom);
        make.bottom.equalTo(weakSelf).offset(-KSIphonScreenH(50));
        make.width.height.equalTo(weakSelf.relesaeBgView);
        make.centerX.equalTo(weakSelf.relesaeBgView.mas_centerX);
    }];
    
    UIImageView *verticalImageV = [[UIImageView alloc]init];
    [self addSubview: verticalImageV];
    verticalImageV.image = [UIImage imageNamed:@"suggestion_detail_image"];
    verticalImageV.contentMode = UIViewContentModeScaleAspectFit;
    [verticalImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImageV.mas_left).offset(KSIphonScreenW(23));
        make.centerY.equalTo(bgImageV.mas_centerY);
    }];
    
    UIImageView *fgxImageV = [[UIImageView alloc]init];
    [self addSubview:fgxImageV];
    fgxImageV.image = [UIImage imageNamed:@"suggetion_detail_fgx"];
    [fgxImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgImageV.mas_right);
        make.centerY.equalTo(bgImageV.mas_centerY);
    }];

    //发布人 头像
    self.releaseHeaderImageV = [[UIImageView alloc]init];
    [self.relesaeBgView addSubview:self.releaseHeaderImageV];
    self.releaseHeaderImageV.image = [UIImage imageNamed:@"suggetion_detail_nm"];
    [self.releaseHeaderImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.relesaeBgView).offset(KSIphonScreenW(50));
        make.centerY.equalTo(weakSelf.relesaeBgView.mas_centerY);
        make.width.height.equalTo(@55);
    }];
    self.releaseHeaderImageV.layer.cornerRadius = 55/2;
    self.releaseHeaderImageV.layer.masksToBounds = YES;
    
    
    self.relesaeNameBgView = [[UIView alloc]init];
    [self.relesaeBgView addSubview:self.relesaeNameBgView];
    
    //发布人 名称
    self.relesaNameLab = [[UILabel alloc]init];
    [self.relesaeNameBgView addSubview:self.relesaNameLab];
    self.relesaNameLab.text  =@"";
    self.relesaNameLab.textColor = [UIColor colorCommonBlackColor];
    self.relesaNameLab.font = BFont(16);
    self.relesaNameLab.numberOfLines = 0;
    [self.relesaNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(weakSelf.relesaeNameBgView);
        make.right.equalTo(weakSelf.relesaeNameBgView.mas_right).offset(-KSIphonScreenW(5));
    }];
    
    //发布人 单位
    self.relesaUnitLab = [[UILabel alloc]init];
    [self.relesaeNameBgView addSubview:self.relesaUnitLab];
    self.relesaUnitLab.text  =@"";
    self.relesaUnitLab.textColor = [UIColor colorWithHexString:@"#999999"];
    self.relesaUnitLab.font = Font(12);
    self.relesaUnitLab.numberOfLines = 0;
    [self.relesaUnitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.relesaNameLab.mas_bottom).offset(KSIphonScreenH(8));
        make.left.equalTo(weakSelf.relesaNameLab.mas_left);
        make.right.equalTo(weakSelf.relesaeNameBgView.mas_right).offset(-KSIphonScreenW(5));
    }];
    
    [self.relesaeNameBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.releaseHeaderImageV.mas_right).offset(KSIphonScreenW(15));
        make.top.equalTo(weakSelf.relesaNameLab.mas_top);
        make.bottom.equalTo(weakSelf.relesaUnitLab.mas_bottom);
        make.right.equalTo(weakSelf.relesaeBgView);
        make.centerY.equalTo(weakSelf.releaseHeaderImageV.mas_centerY);
    }];

    //接收 头像
    self.receiveHeaderImageV= [[UIImageView alloc]init];
    [self.receiveBgView addSubview:self.receiveHeaderImageV];
    self.receiveHeaderImageV.image = [UIImage imageNamed:@"suggetion_detail_nm"];
    [self.receiveHeaderImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.receiveBgView).offset(KSIphonScreenW(50));
        make.centerY.equalTo(weakSelf.receiveBgView.mas_centerY);
        make.width.height.equalTo(@55);
    }];
    self.receiveHeaderImageV.layer.cornerRadius = 55/2;
    self.receiveHeaderImageV.layer.masksToBounds = YES;


    self.receiveNameBgView = [[UIView alloc]init];
    [self.receiveBgView addSubview:self.receiveNameBgView];

    //接收人 名称
    self.receiveNameLab = [[UILabel alloc]init];
    [self.receiveNameBgView addSubview:self.receiveNameLab];
    self.receiveNameLab.text  =@"";
    self.receiveNameLab.textColor = [UIColor colorCommonBlackColor];
    self.receiveNameLab.font = BFont(16);
    self.receiveNameLab.numberOfLines = 0;
    [self.receiveNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(weakSelf.receiveNameBgView);
        make.right.equalTo(weakSelf.receiveNameBgView.mas_right).offset(-KSIphonScreenW(5));
    }];

    //接收人 单位
    self.receiveUnitLab = [[UILabel alloc]init];
    [self.receiveNameBgView addSubview:self.receiveUnitLab];
    self.receiveUnitLab.text  =@"";
    self.receiveUnitLab.textColor = [UIColor colorWithHexString:@"#999999"];
    self.receiveUnitLab.font = Font(12);
    self.receiveUnitLab.numberOfLines = 0;
    [self.receiveUnitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.receiveNameLab.mas_bottom).offset(KSIphonScreenH(8));
        make.left.equalTo(weakSelf.receiveNameLab.mas_left);
        make.right.equalTo(weakSelf.receiveNameBgView.mas_right).offset(-KSIphonScreenW(5));
    }];

    [self.receiveNameBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.relesaeNameBgView.mas_left);
        make.top.equalTo(weakSelf.receiveNameLab.mas_top);
        make.bottom.equalTo(weakSelf.receiveUnitLab.mas_bottom);
        make.right.equalTo(weakSelf.relesaeNameBgView.mas_right);
        make.centerY.equalTo(weakSelf.receiveHeaderImageV.mas_centerY);
    }];
 
    UIImageView *qztImageV = [[UIImageView alloc]init];
    [self addSubview:qztImageV];
    qztImageV.image = [UIImage imageNamed:@"suggetion_detail_dqzt"];
    [qztImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf);
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    WS(weakSelf);
    //1实名 2匿名
    NSString *typesStr = [NSString stringWithFormat:@"%@",dict[@"types"]];
    
    // 接收已经目标标识 1是个人2是单位
    NSString *aimsTypeStr = [NSString stringWithFormat:@"%@",dict[@"aimsType"]];
#pragma mark -----  匿名 --------------
    if ([typesStr isEqualToString:@"2"]) {
        /*---------发布人-------------*/
        self.releaseHeaderImageV.image = [UIImage imageNamed:@"suggetion_detail_nm"];
        // 名称
        self.relesaNameLab.text = @"匿名";
        // 更新UI
        [self.relesaeNameBgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.releaseHeaderImageV.mas_right).offset(KSIphonScreenW(15));
            make.top.equalTo(weakSelf.relesaNameLab.mas_top);
            make.bottom.equalTo(weakSelf.relesaNameLab.mas_bottom);
            make.right.equalTo(weakSelf.relesaeBgView);
            make.centerY.equalTo(weakSelf.releaseHeaderImageV.mas_centerY);
        }];
        
        /*--------- 接收人-------------*/
        if ([aimsTypeStr isEqualToString:@"2"]) {
            /*-----------------单位 --------------------*/
            /*--------- 接收人-------------*/
            self.receiveHeaderImageV.image = [UIImage imageNamed:@"suggetion_detail_unit"];
            // 单位名
            self.receiveNameLab.text = [NSString stringWithFormat:@"%@",dict[@"aimsTitle"]];
            // 隐藏
            self.receiveUnitLab.hidden =YES;
            // 更新
            [self.receiveNameBgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.relesaeNameBgView.mas_left);
                make.top.equalTo(weakSelf.receiveNameLab.mas_top);
                make.bottom.equalTo(weakSelf.receiveNameLab.mas_bottom);
                make.right.equalTo(weakSelf.relesaeNameBgView.mas_right);
                make.centerY.equalTo(weakSelf.receiveHeaderImageV.mas_centerY);
            }];
        }else{
            /*-----------------人员 --------------------*/
            /*--------- 接收人-------------*/
            NSString *aimsphotoStr = [NSString stringWithFormat:@"%@",dict[@"aimsphoto"]];
            [YWTTools sd_setImageView:self.receiveHeaderImageV WithURL:aimsphotoStr andPlaceholder:@"suggetion_record_normal"];
            // 单位名
            self.receiveNameLab.text = [NSString stringWithFormat:@"%@",dict[@"aimsTitle"]];
            // 目标头像单位
            // 隐藏
            self.receiveUnitLab.hidden = NO;
            self.receiveUnitLab.text  = [NSString stringWithFormat:@"%@",dict[@"aimscompany"]];
        }
    }else{
#pragma mark -----   实名 --------------
        /*---------发布人-------------*/
       NSString *photoStr = [NSString stringWithFormat:@"%@",dict[@"photo"]];
       [YWTTools sd_setImageView:self.releaseHeaderImageV WithURL:photoStr andPlaceholder:@"suggetion_record_normal"];
       // 单位名
       self.relesaNameLab.text = [NSString stringWithFormat:@"%@",dict[@"realName"]];
       // 目标头像单位
       // 显示
       self.relesaUnitLab.hidden = NO;
       self.relesaUnitLab.text  = [NSString stringWithFormat:@"%@",dict[@"company"]];
     /*--------- 接收人-------------*/
        if ([aimsTypeStr isEqualToString:@"2"]) {
            /*-----------------单位 --------------------*/
            self.receiveHeaderImageV.image = [UIImage imageNamed:@"suggetion_detail_unit"];
            // 单位名
            self.receiveNameLab.text = [NSString stringWithFormat:@"%@",dict[@"aimsTitle"]];
            // 隐藏
            self.receiveUnitLab.hidden =YES;
            // 更新
            [self.receiveNameBgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.relesaeNameBgView.mas_left);
                make.top.equalTo(weakSelf.receiveNameLab.mas_top);
                make.bottom.equalTo(weakSelf.receiveNameLab.mas_bottom);
                make.right.equalTo(weakSelf.relesaeNameBgView.mas_right);
                make.centerY.equalTo(weakSelf.receiveHeaderImageV.mas_centerY);
            }];
        }else{
            /*-----------------人员 --------------------*/
            NSString *aimsphotoStr = [NSString stringWithFormat:@"%@",dict[@"aimsphoto"]];
            [YWTTools sd_setImageView:self.receiveHeaderImageV WithURL:aimsphotoStr andPlaceholder:@"suggetion_record_normal"];
            // 单位名
            self.receiveNameLab.text = [NSString stringWithFormat:@"%@",dict[@"aimsTitle"]];
            // 目标头像单位
            // 隐藏
            self.receiveUnitLab.hidden = NO;
            self.receiveUnitLab.text  = [NSString stringWithFormat:@"%@",dict[@"aimscompany"]];
        }
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
