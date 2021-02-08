//
//  ExamCenterRoomListModel.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/28.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExamCenterRoomListModel : NSObject
@property (nonatomic,copy) NSString *examId;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *examRoomId;
@property (nonatomic,copy) NSString *paperId;
@property (nonatomic,copy) NSString *paperTitle;
@property (nonatomic,copy) NSString *exercise;
@property (nonatomic,copy) NSString *examTime;
@property (nonatomic,copy) NSString *questionNum;
@property (nonatomic,copy) NSString *examTotalTime;
@property (nonatomic,copy) NSString *totalScore;
@property (nonatomic,copy) NSString *passScore;
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *remainingTime;
@property (nonatomic,copy) NSString *examBatchId;
@property (nonatomic,copy) NSString *examStatus;
/// 表示时间已经到了
@property (nonatomic, assign) BOOL timeOut;
/// 倒计时源
@property (nonatomic, copy) NSString *countDownSource;
@end

NS_ASSUME_NONNULL_END
