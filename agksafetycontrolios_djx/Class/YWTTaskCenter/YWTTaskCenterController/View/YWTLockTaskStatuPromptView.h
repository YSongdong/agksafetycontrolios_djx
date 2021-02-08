//
//  LockTaskStatuPromptView.h
//  PartyBuildingStar
//
//  Created by mac on 2019/4/19.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTLockTaskStatuPromptView : UIView

// 任务名称
@property (nonatomic,strong) UILabel *taskNameLab;
// 任务要求
@property (nonatomic,strong) UILabel *taskRequirLab;

// 点击本任务查看详情
@property (nonatomic,copy) void(^selectLookDetail)(void);
// 点前置任务详情
@property (nonatomic,copy) void(^selectTaskRequir)(void);

@end

NS_ASSUME_NONNULL_END
