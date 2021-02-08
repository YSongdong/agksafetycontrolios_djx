//
//  ExamExerDetailController.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/15.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDBaseController.h"

@interface YWTExamExerDetailController : SDBaseController
// 考试ID
@property (nonatomic,strong) NSString *examIdStr;
//考场ID
@property (nonatomic,strong) NSString *examRoomIdStr;
// 试卷ID
@property (nonatomic,strong) NSString *paperIdStr;
// 任务id
@property (nonatomic,strong) NSString *taskIdStr;
// 监控规则数组
@property (nonatomic,strong) NSArray *monitorRulesArr;
// 状态 1继续考试 2开始考试
@property (nonatomic,strong) NSString *statuStr;

@end


