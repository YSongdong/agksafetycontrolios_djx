//
//  AttendanceChenkCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/14.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTAttendanceChenkCell : UICollectionViewCell
// 删除按钮
@property (nonatomic,strong) UIButton *delBtn;

@property (nonatomic,strong) UIImage *photoImage;
// 图片网络地址
@property (nonatomic,strong) NSString *photoImageStr;

// 点击删除
@property (nonatomic,copy) void(^selectDelBtn)(void);

@end

NS_ASSUME_NONNULL_END
