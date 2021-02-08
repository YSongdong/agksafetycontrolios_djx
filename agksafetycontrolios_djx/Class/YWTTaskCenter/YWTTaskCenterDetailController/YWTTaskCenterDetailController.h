//
//  TaskCenterDetailController.h
//  PartyBuildingStar
//
//  Created by mac on 2019/4/19.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDBaseController.h"

typedef enum {
    showTaskCenterDetailTaskingStatu = 0,   // 任务进行中
    showTaskCenterDetailTaskUndoneStatu,    // 任务未完成
    showTaskCenterDetailTaskUnbeginStatu,    // 任务未开始
    showTaskCenterDetailTaskCompleteStatu,   // 任务已完成
    showTaskCenterDetailTaskOutDateStatu,    // 任务已作废
}showTaskCenterDetailTaskStatu;

@interface YWTTaskCenterDetailController : SDBaseController
// 类型
@property (nonatomic,assign) showTaskCenterDetailTaskStatu taskStatu;
// 任务组id
@property (nonatomic,strong) NSString *taskvarIdStr;

@end


