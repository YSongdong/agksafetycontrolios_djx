//
//  ExamQuestionController.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/17.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 答题模式
 */
typedef enum {
    controllerExamQuestAnswerMode = 0,  // 答题
}controllerExamQuestMode;

/**
 考试类型
 */
typedef enum {
    controllerMockExamType = 0,    // 模拟考试
    controllerOfficialExamType ,   // 正式考试
}controllerExamType;


#import "SDBaseController.h"

@interface YWTExamQuestionController : SDBaseController
//答题 类型
@property (nonatomic,assign) controllerExamQuestMode controllerQuestMode;
//考试 类型
@property (nonatomic,assign) controllerExamType controllerExamType;
// 任务id
@property (nonatomic,strong) NSString *taskidStr;
//考试ID
@property (nonatomic,strong) NSString *examIdStr;
//考场ID
@property (nonatomic,strong) NSString *examRoomIdStr;
//场次ID
@property (nonatomic,strong) NSString *examBatchIdStr;
//  监控规则数组
@property (nonatomic,strong) NSArray *monitorRulesArr;
// 考试说明
@property (nonatomic,strong) NSString *descriptionStr;

@end


