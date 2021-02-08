//
//  AttendanceAddMarkHeaderView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/14.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTAttendanceAddMarkHeaderView : UICollectionReusableView <UITextViewDelegate>

@property (nonatomic,strong) UILabel *markTitleLab;
// 备注
@property (nonatomic,strong) FSTextView *fsTextView;


@end

NS_ASSUME_NONNULL_END
