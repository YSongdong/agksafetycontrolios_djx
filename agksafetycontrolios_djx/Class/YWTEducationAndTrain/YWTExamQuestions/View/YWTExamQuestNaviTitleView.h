//
//  ExamQuestNaviTitleView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/17.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTExamQuestNaviTitleView : UIView
// 开始时间
@property (nonatomic,assign) NSTimeInterval totalInterval;
// 显示定时按钮
@property (nonatomic,strong) UIButton *showTimerBtn;
// 立即交卷
@property (nonatomic,copy) void(^immedSubmitBlock)(void);
// 到时间交卷
@property (nonatomic,copy) void(^timeToBlock)(void);
// 弹3分钟提示框
@property (nonatomic,copy) void(^bulletBoxBlock)(void);
// 销毁定时器
- (void)removeTimer;

@end

NS_ASSUME_NONNULL_END
