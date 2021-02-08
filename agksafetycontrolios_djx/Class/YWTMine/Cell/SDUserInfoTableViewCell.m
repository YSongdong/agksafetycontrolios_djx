//
//  SDUserInfoTableViewCell.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/27.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDUserInfoTableViewCell.h"

@interface SDUserInfoTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *tittleLab;
//副标题
@property (weak, nonatomic) IBOutlet UILabel *subheadLab;
//右边Image'
@property (weak, nonatomic) IBOutlet UIImageView *reihtImageV;

@property (weak, nonatomic) IBOutlet UIImageView *tableViewReihtImageV;
//表示性别

@property (weak, nonatomic) IBOutlet UIImageView *sixImageV;
//留底照片状态
@property (weak, nonatomic) IBOutlet UIImageView *photoStatuImageV;
@end


@implementation SDUserInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.reihtImageV.layer.cornerRadius = CGRectGetWidth(self.reihtImageV.frame)/2;
    self.reihtImageV.layer.masksToBounds = YES;
    self.reihtImageV.layer.borderWidth = 1;
    self.reihtImageV.layer.borderColor = [UIColor colorHeaderImageVDBDBColor].CGColor;
}

-(void)setDict:(NSDictionary *)dict{
    _dict =  dict;

    self.tittleLab.text = dict[@"name"];

    if (self.indexPath.section == 0) {
        [YWTTools sd_setImageView:self.reihtImageV WithURL:dict[@"desc"] andPlaceholder:@"cbl_pic_user"];
    }
    self.subheadLab.text =[NSString stringWithFormat:@"%@",dict[@"desc"]];
    
    if (self.indexPath.section == 0) {
        NSString *photoStatu = [NSString stringWithFormat:@"%@",dict[@"photoStatus"]];
        if ([photoStatu isEqualToString:@"4"]) {
            //4审核中
            self.photoStatuImageV.image = [UIImage imageNamed:@"grzx_ico_shz"];
        }else if ([photoStatu isEqualToString:@"3"]){
            //3认证不通过
             self.photoStatuImageV.image = [UIImage imageNamed:@"grzx_ico_wtg"];
        }else if ([photoStatu isEqualToString:@"1"]){
            //1认证
            self.photoStatuImageV.image = [UIImage imageNamed:@"grzx_ico_ytg"];
        }else if ([photoStatu isEqualToString:@"2"]){
            //2未认证
            self.photoStatuImageV.image = [UIImage imageNamed:@"grzx_pic_wcj"];
        }
    }
    
    if (self.indexPath.section == 1 && self.indexPath.row == 0) {
        NSString *photoStatu = [NSString stringWithFormat:@"%@",dict[@"photoStatus"]];
        if ([photoStatu isEqualToString:@"0"]) {
            //未知
            self.sixImageV.hidden = YES;
            self.sixImageV.image = [UIImage imageNamed:@"grzx_ico_wz"];
        }else  if ([photoStatu isEqualToString:@"2"]) {
             self.sixImageV.hidden = NO;
            //女
            self.sixImageV.image = [UIImage imageNamed:@"grzx_pic_ns"];
        }else  if ([photoStatu isEqualToString:@"1"]) {
             self.sixImageV.hidden = NO;
            //男
            self.sixImageV.image = [UIImage imageNamed:@"grzx_pic_nh"];
        }
    }
    
    NSString *vMobileStr = [NSString stringWithFormat:@"%@",dict[@"photoStatus"]];
    if (self.indexPath.section ==1 && self.indexPath.row == 5) {
        if ([vMobileStr isEqualToString:@"2"]) {
            //未绑定
            self.subheadLab.textColor =[UIColor colorCommon65GreyBlackColor];
//            self.subheadLab.text = @"未绑定";
        }else{
            self.subheadLab.textColor =[UIColor colorCommon65GreyBlackColor];
        }
    }
    
}

-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    //头像
    if (indexPath.section == 0 && indexPath.row == 0) {
        self.reihtImageV.hidden =  NO;
        self.subheadLab.hidden = YES;
        self.sixImageV.hidden = YES;
        self.photoStatuImageV.hidden = NO;
    }else{
        self.reihtImageV.hidden =  YES;
        self.sixImageV.hidden = YES;
        self.photoStatuImageV.hidden = YES;
    }
    
    if (indexPath.section == 1) {
        self.reihtImageV.hidden =  YES;
        self.photoStatuImageV.hidden = YES;
        if (indexPath.row == 0) {
            self.sixImageV.hidden = NO;
        }else{
             self.sixImageV.hidden = YES;
        }
        if (indexPath.row == 5 || indexPath.row ==6) {
            self.tableViewReihtImageV.hidden = NO;
        }else{
            self.tableViewReihtImageV.hidden = YES;
        }
    }
}
-(void)alterVipNameStr:(NSString *)nameStr{
    self.subheadLab.text = nameStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


@end
