//
//  TaskCenterListHeaderView.h
//  PartyBuildingStar
//
//  Created by mac on 2019/4/17.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTTaskCenterListHeaderView : UIView

// 更新用户信息
-(void) updateUserDataInfo:(NSDictionary*)dict;

// 我的学分
@property (nonatomic,copy) void(^selectMyStudies)(void);
// 进行中任务
@property (nonatomic,copy) void(^selectTasking)(void);
// 全部任务
@property (nonatomic,copy) void(^selectAllTask)(void);
// 搜索筛选
@property (nonatomic,copy) void(^selectSearch)(NSString *searchStr);

// 更新搜索条件UI
-(void) updateSearchTextStr:(NSString *)searchStr;

@end

NS_ASSUME_NONNULL_END
