//
//  TempExamQuestHeaderView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/18.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 答题类型
 */
typedef enum {
    tempExamQuestHeaderSingleSelectType = 0, // 单选
    tempExamQuestHeaderMultipleSelectType,   // 多选
    tempExamQuestHeaderJudgmentType,         // 判断
    tempExamQuestHeaderFillingType,          // 填空
    tempExamQuestHeaderThemeType,            // 主题
}tempExamQuestHeaderType;

/**
 答题模式
 */
typedef enum {
    tempExamQuestHeaderAnswerMode = 0,  // 答题
    tempExamQuestHeaderDetailMode ,     // 详情
}tempExamQuestHeaderMode;

#import "TempDetailQuestionModel.h"

@interface YWTTempExamQuestHeaderView : UIView
// 答题类型
@property (nonatomic,assign) tempExamQuestHeaderType questHeaderType;
// 答题模式
@property (nonatomic,assign) tempExamQuestHeaderMode questHeaderMode;

@property (nonatomic,strong) QuestionListModel *questModel;

@property (nonatomic,strong) TempDetailQuestionModel *dataHeaderModel;

// 当前是多少题
@property (nonatomic,strong) NSString *nowQuestNumberStr;
//计算高度
+(CGFloat)getLabelHeightWithDict:(QuestionListModel *)questModel andHeaderModo:(tempExamQuestHeaderMode) headerMode;

@end


