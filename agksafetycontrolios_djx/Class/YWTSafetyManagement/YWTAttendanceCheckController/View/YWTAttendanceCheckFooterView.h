//
//  AttendanceCheckFooterView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/14.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTAttendanceCheckFooterView : UICollectionReusableView
// 取消
@property (nonatomic,copy) void(^cancelBtn)(void);
// 确认签到
@property (nonatomic,copy) void(^submitCheckBtn)(void);

@end

NS_ASSUME_NONNULL_END
