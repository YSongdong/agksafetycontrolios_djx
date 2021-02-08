//
//  TaskCenterReultPromptView.h
//  PartyBuildingStar
//
//  Created by mac on 2019/4/16.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTTaskCenterReultPromptView : UIView

@property (nonatomic,strong) NSDictionary *dict;

// 跳转到任务中心
@property (nonatomic,copy) void(^selectTaskCenter)(NSDictionary *taskDict);
// 跳转到指定模块
@property (nonatomic,copy) void(^selectModeName)(NSDictionary *taskDict);

@end

NS_ASSUME_NONNULL_END
