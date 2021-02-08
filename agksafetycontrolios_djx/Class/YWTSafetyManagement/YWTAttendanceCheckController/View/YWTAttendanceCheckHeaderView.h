//
//  AttendanceCheckHeaderView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/14.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTAttendanceCheckHeaderView : UICollectionReusableView

// 定位地址
@property (nonatomic,strong) NSString *addressStr;
// 人脸验证结果
@property (nonatomic,strong) UILabel *faceVerifRultLab;
// 重新验证
@property (nonatomic,strong) UIButton *againVeriBtn;
// 备注
@property (nonatomic,strong) FSTextView *fsTextView;
// 点击重新验证
@property (nonatomic,copy) void(^selectAgainVerif)(void);

@end

NS_ASSUME_NONNULL_END
