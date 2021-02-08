//
//  BaseRecordController.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/11.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDBaseController.h"

typedef enum {
    showBaseRecordSafetyType = 0,  //安全检查
    showBaseRecordMeetingType ,    // 会议
    showBaseRecordViolationType ,  // 违章
    showBaseRecordTechnoloType ,   // 技术
    showBaseRecordCheckType ,      // 考勤签到
}showBaseRecordType;

@interface YWTBaseRecordController : SDBaseController
// 类型
@property (nonatomic,assign) showBaseRecordType recordType;


@end


