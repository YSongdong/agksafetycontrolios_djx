//
//  ExamQuestSettingView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/18.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTExamQuestSettingView : UIView

//记录当前tag
@property (nonatomic,assign) NSInteger pageTag;
// 刷新视图
@property (nonatomic,copy) void(^refreshViewBlock)(void);

@end

NS_ASSUME_NONNULL_END
