//
//  YWTBoxRecordController.h
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/17.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDBaseController.h"

typedef enum {
    YWTSuggestionBoxListBoxType = 0,  // 发起意见
    YWTSuggestionBoxReplyBoxType ,    // 回复意见
}YWTSuggestionBoxType;

@interface YWTBoxRecordController : SDBaseController
// 类型
@property (nonatomic,assign) YWTSuggestionBoxType boxType;

@end


