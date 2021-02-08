//
//  BaseDetailController.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/12.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDBaseController.h"

typedef enum {
    showBaseDetailSafetyType = 0,  //安全检查
    showBaseDetailMeetingType ,    // 会议
    showBaseDetailViolationType ,  // 违章
    showBaseDetailTechnoloType ,   // 技术
}showBaseDetailType;

typedef enum {
    showBaseToolNormalType = 0,    // 正常
    showBaseToolUNormalType,       // 隐藏
}showBaseToolType;

@interface YWTBaseDetailController : SDBaseController

@property (nonatomic,assign) showBaseToolType toolType;
// 类型
@property (nonatomic,assign) showBaseDetailType detailType;
// id
@property (nonatomic,strong) NSString *idStr;

@end


