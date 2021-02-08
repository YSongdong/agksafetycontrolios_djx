//
//  ExamPaperDetailController.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/2/13.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDBaseController.h"

@interface YWTExamPaperDetailController : SDBaseController
// 考试记录id
@property (nonatomic,strong) NSString *examRecordIdStr;
// 跳转到指定题
@property (nonatomic,strong) NSString *speciJumpQuestNumberStr;

@end


