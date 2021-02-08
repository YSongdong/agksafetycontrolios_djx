//
//  ExamPaperExerciseController.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/16.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    showTableViewExamPaperType = 0, // 试卷练习
    showTableViewExamCenterType,    // 正式考试
}showTableViewExamType;

#import "SDBaseController.h"

@interface YWTExamPaperExerciseController : SDBaseController
// 类型
@property (nonatomic,assign) showTableViewExamType examType;
// 试卷id
@property (nonatomic,strong) NSString *paperIdStr;
// 考试ID
@property (nonatomic,strong) NSString *examIdStr;
// 考场ID
@property (nonatomic,strong) NSString *examRoomIdStr;
// 场次ID
@property (nonatomic,strong) NSString *examBatchIdStr;
// 任务id
@property (nonatomic,strong) NSString *taskIdStr;
@end


