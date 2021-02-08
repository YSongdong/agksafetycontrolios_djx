//
//  YWTParyMemberAreaAddPhotoCell.m
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/6.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import "YWTParyMemberAreaAddPhotoCell.h"

@interface YWTParyMemberAreaAddPhotoCell ()

@property (nonatomic,strong) UIImageView *photoImageV;

@property (nonatomic,strong) UIButton *delBtn;

@end


@implementation YWTParyMemberAreaAddPhotoCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createAddPhotoCell];
    }
    return self;
}
-(void) createAddPhotoCell{
    WS(weakSelf);
    
    self.photoImageV = [[UIImageView alloc]init];
    [self addSubview:self.photoImageV];
    self.photoImageV.contentMode = UIViewContentModeRedraw;
    self.photoImageV.image = [UIImage imageNamed:@"patry_add_photo_normal"];
    [self.photoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    self.delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.delBtn];
    [self.delBtn setImage:[UIImage imageNamed:@"patry_add_del"] forState:UIControlStateNormal];
    [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.right.equalTo(weakSelf.mas_right);
    }];
    [self.delBtn addTarget:self action:@selector(selectDelAction:) forControlEvents:UIControlEventTouchUpInside];
    self.delBtn.hidden = YES;
}

-(void)setPhotoImage:(UIImage *)photoImage{
    _photoImage = photoImage;
    self.photoImageV.image = photoImage;
}
-(void)setIsShowDel:(BOOL)isShowDel{
    _isShowDel =  isShowDel;
    if (isShowDel) {
        self.delBtn.hidden = NO;
    }else{
        self.delBtn.hidden = YES;
    }
}

-(void) selectDelAction:(UIButton *)sender{
    self.selectDelImage();
}

@end
