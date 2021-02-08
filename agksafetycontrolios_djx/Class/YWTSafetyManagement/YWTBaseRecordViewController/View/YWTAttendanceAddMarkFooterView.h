//
//  AttendanceAddMarkFooterView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/14.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTAttendanceAddMarkFooterView : UICollectionReusableView

@property (nonatomic,strong)UIButton *submitBtn;

//
@property (nonatomic,copy) void(^selectSubmitBnt)(void);

@end

NS_ASSUME_NONNULL_END
