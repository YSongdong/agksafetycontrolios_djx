//
//  ExamScoreViewController.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/21.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    showExamScoreExerType = 0,   //练习
    showExamScoreExamPaperType ,  // 考试
}showExamScoreType;

#import "SDBaseController.h"

@interface YWTExamScoreViewController : SDBaseController
// 类型
@property (nonatomic,assign) showExamScoreType scoreType;
// 交卷后返回的id
@property (nonatomic,strong) NSString *idStr;
// 考场id
@property (nonatomic,strong) NSString *examRoomIdStr;
//任务id
@property (nonatomic,strong) NSString *taskIdStr;
@end


