//
//  AttendanceChenkCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/14.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTAttendanceChenkCell.h"

@interface YWTAttendanceChenkCell ()

@property (nonatomic,strong) UIImageView *chenkImageV;

@end


@implementation YWTAttendanceChenkCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createCheckView];
    }
    return self;
}
-(void) createCheckView{
    __weak typeof(self) weakSelf = self;
    self.layer.borderWidth =1 ;
    self.layer.borderColor = [UIColor colorLineCommonGreyBlackColor].CGColor;
    
    self.chenkImageV = [[UIImageView alloc]init];
    [self addSubview:self.chenkImageV];
    self.chenkImageV.image = [UIImage imageNamed:@"base_attendance_add"];
    self.chenkImageV.contentMode = UIViewContentModeRedraw;
    [self.chenkImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    self.delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.delBtn];
    [self.delBtn setImage:[UIImage imageNamed:@"base_attendance_delete"] forState:UIControlStateNormal];
    [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(weakSelf);
    }];
    [self.delBtn addTarget:self action:@selector(selectDelBtn:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)setPhotoImage:(UIImage *)photoImage{
    _photoImage = photoImage;
    self.chenkImageV.image = photoImage;
}
-(void)setPhotoImageStr:(NSString *)photoImageStr{
    _photoImageStr = photoImageStr;
    // 图片
    [YWTTools sd_setImageView:self.chenkImageV WithURL:photoImageStr andPlaceholder:@"base_attendance_photo"];
    // 隐藏删除按钮
    self.delBtn.hidden = YES;
}
-(void) selectDelBtn:(UIButton *) sender{
    self.selectDelBtn();
}



@end
