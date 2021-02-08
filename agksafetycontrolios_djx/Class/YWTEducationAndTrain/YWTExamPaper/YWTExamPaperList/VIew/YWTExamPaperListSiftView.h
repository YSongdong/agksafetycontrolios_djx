//
//  ExamPaperListSiftView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/15.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    showListSiftLabayExerType = 0, // 题库筛选
    showListSiftMockTestType,      // 试卷练习
    showListSiftExposureStationType, // 曝光台
    showListSiftRiskDisplayType,    // 风险展示
    showListSiftMyStudiesType,     // 学习中心
    showListSiftTaskCenterType,    // 任务中心
    showListSiftSafetContolRecordType,    // 安全管理 记录
}showListSiftType;


@protocol ExamPaperListSiftViewDelegate <NSObject>

// 点击确定按钮
-(void) selectSubmitBtnTagIdStr:(NSString *)tagIdStr;


@end

@interface YWTExamPaperListSiftView : UIView

@property (nonatomic,strong) NSDictionary *dict;

@property (nonatomic,weak) id<ExamPaperListSiftViewDelegate> delegate;
// 筛选类型
@property (nonatomic,assign)showListSiftType siftType;

@end

NS_ASSUME_NONNULL_END
