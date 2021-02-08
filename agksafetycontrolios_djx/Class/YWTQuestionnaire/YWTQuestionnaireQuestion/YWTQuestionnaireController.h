//
//  YWTQuestionnaireController.h
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/17.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDBaseController.h"

@interface YWTQuestionnaireController : SDBaseController
// 问卷ID
@property (nonatomic,strong) NSString *paperId;
// 任务id
@property (nonatomic,strong) NSString *taskIdStr;
@end


