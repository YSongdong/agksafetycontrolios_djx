//
//  ExamPaperListTopBtnView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/15.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTExamPaperListTopBtnView : UIView
// 试卷列表
@property (nonatomic,strong) UIButton *examListBtn;
// 试卷记录
@property (nonatomic,strong) UIButton *examRecordBtn;
// 选择按钮   0  试卷列表 1 练习记录
@property (nonatomic,copy) void(^selectBtnBlock)(NSInteger btnTag);

@end

NS_ASSUME_NONNULL_END
