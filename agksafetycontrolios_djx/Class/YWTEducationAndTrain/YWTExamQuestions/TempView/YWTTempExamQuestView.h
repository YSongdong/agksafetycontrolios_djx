//
//  TempExamQuestView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/17.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 答题模式
 */
typedef enum {
    tempExamQuestAnswerMode = 0,  // 答题
    tempExamQuestDetailMode ,     // 详情
}tempExamQuestMode;

/**
 答题类型
 */
typedef enum {
    tempExamQuestSingleSelectType = 0, // 单选
    tempExamQuestMultipleSelectType,   // 多选
    tempExamQuestJudgmentType,         // 判断
    tempExamQuestQuestAndAnswerType,   // 问答
    tempExamQuestFillingType,          // 填空
    tempExamQuestThemeType,            // 主题
}tempExamQuestType;
/*
 答题样式
 */
typedef enum {
    showTempAnswerQuestTextStyle = 0,         // 只有文字
    showTempAnswerQuestPhotoStyle ,           // 只有图片
    showTempAnswerQuestPhotoAndTextStyle ,    // 图片加文字
}showAnswerQuestStyle;

#import "TempDetailQuestionModel.h"

@interface YWTTempExamQuestView : UIView
// 答题模式
@property (nonatomic,assign) tempExamQuestMode questMode;
// 答题类型
@property (nonatomic,assign) tempExamQuestType questType;
//  答题样式
@property (nonatomic,assign) showAnswerQuestStyle questStyle;

@property (nonatomic,strong) QuestionListModel *tempQuestModel;

@property (nonatomic,strong) TempDetailQuestionModel *tempDataModel;

// 当前是多少题
@property (nonatomic,strong) NSString *nowQuestNumberStr;
// 刷新界面
-(void) refreshUI;

@end
