//
//  ExamQuestBottomToolView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/17.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTExamQuestBottomToolView : UIView

// 点击上一题
@property (nonatomic,copy) void(^lastQuestBlock)(void);
// 答题卡
@property (nonatomic,copy) void(^answerCardBlock)(void);
// 设置
@property (nonatomic,copy) void(^settingBlcok)(void);
// 下一题
@property (nonatomic,copy) void(^nextQuestBlock)(void);


@end

NS_ASSUME_NONNULL_END
