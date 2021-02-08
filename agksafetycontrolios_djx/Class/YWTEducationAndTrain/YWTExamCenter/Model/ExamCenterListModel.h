//
//  ExamCenterListModel.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/28.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <Foundation/Foundation.h>



NS_ASSUME_NONNULL_BEGIN

@interface ExamCenterListModel : NSObject <YYModel>
@property (nonatomic,copy) NSString *examId;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *descr;
@property (nonatomic,copy) NSString *examTime;
@property (nonatomic,copy) NSString *examNum;
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *remainingTime;
@property (nonatomic,copy) NSString *examStatus;
/// 表示时间已经到了
@property (nonatomic, assign) BOOL timeOut;
/// 倒计时源
@property (nonatomic, copy) NSString *countDownSource;
@end





NS_ASSUME_NONNULL_END
