//
//  TaskCenterDetailHeaderView.h
//  PartyBuildingStar
//
//  Created by mac on 2019/4/19.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YWTTaskCenterDetailHeaderView : UIView

// 定时器
@property (nonatomic,strong) NSTimer *timer;

@property (nonatomic,strong) NSDictionary *dict;
// 点击更多按钮
@property (nonatomic,copy) void(^selectMarkMany)(void);
// 点前置任务
@property (nonatomic,copy) void(^selectPariTap)(void);
// 计算高度
+(CGFloat) getWithTaskDetailHeaderHeight:(NSDictionary *) dict;

@end


