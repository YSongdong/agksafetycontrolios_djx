//
//  PhotoMarkTableViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/10.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "PhotoMarkTableViewCell.h"

@interface PhotoMarkTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *photoMarkLab;

@end


@implementation PhotoMarkTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor colorViewBackF9F9GrounpWhiteColor];
    
    NSString *str = @"1、请按示例图片要求上传您的留底照片 \n2、该照片将应用于系统考试、考勤签到等重要场景进行身份验证，不可随意修改 \n3、请确保照片清晰有效，谨慎上传";
    NSString *msg;
    msg = [NSString stringWithFormat:@"%@",
                          [str stringByReplacingOccurrencesOfString:@"\\n" withString:@" \r\n" ]];
    self.photoMarkLab.text = msg;
    self.photoMarkLab.textColor = [UIColor colorCommonGreyBlackColor];
    //添加间距
    [UILabel changeLineSpaceForLabel:self.photoMarkLab WithSpace:5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
