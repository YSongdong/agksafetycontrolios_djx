//
//  TaskCenterListModel.h
//  PartyBuildingStar
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TaskCenterListModel : NSObject <YYModel>
// 任务组id
@property (nonatomic,copy) NSString *taskvarid;
// 任务标题
@property (nonatomic,copy) NSString *title;
// 1普通任务2必做任务3每日任务4每日必做任务
@property (nonatomic,copy) NSString *feature;
// 任务开始剩余秒数
@property (nonatomic,copy) NSString *remTime;
// 1进行中2已完成3未完成4暂时完成5作废6未开始【4基本不会返回】
@property (nonatomic,copy) NSString *status;
// 标签组
@property (nonatomic,strong) NSArray *tag;
// 1是可以做 2是不可做任务
@property (nonatomic,copy) NSString *canDo;
// 任务时段
@property (nonatomic,copy) NSString *period;
// 结束时间【不用管】
@property (nonatomic,copy) NSString *endTime;
// 子任务完成进度
@property (nonatomic,copy) NSString *carryOut;
// 任务说明
@property (nonatomic,copy) NSString *descr;
// 1有前置任务 2无前置任务
@property (nonatomic,copy) NSString *relatedtask;
// 前置任务说明
@property (nonatomic,copy) NSString *relatedtaskName;
// 前置任务id
@property (nonatomic,copy) NSString *relatedtaskid;
// 前置任务子id【如果是指定到子任务得这个就不为0】
@property (nonatomic,copy) NSString *relatedtaskidchild;

// 表示时间已经到了
@property (nonatomic, assign) BOOL timeOut;
// 倒计时源
@property (nonatomic, copy) NSString *countDownSource;

@end

NS_ASSUME_NONNULL_END
