//
//  TempExamQuestTableViewCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/17.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>


/*
 答案类型
 */
typedef enum {
    showAnswerQuestTextType = 0,         // 只有文字
    showAnswerQuestPhotoType ,           // 只有图片
    showAnswerQuestPhotoAndTextType ,    // 图片加文字
}showAnswerQuestType;
/*
 答题模式
 */
typedef enum {
    showQuestAnswerMode = 0 ,   // 答题模式
    showQuestDetailMode ,      // 详情模式
}showExamQuestMode;

#import "TempDetailQuestionModel.h"


@interface YWTTempExamQuestTableViewCell : UITableViewCell
// 答案类型
@property (nonatomic,assign) showAnswerQuestType anserQuestType;
//  答题模式
@property (nonatomic,assign) showExamQuestMode questMode;

@property (nonatomic,strong) QuestionListModel *questionModel;
// 数据源
@property (nonatomic,strong) OptionListModel *listModel;

//计算高度
+(CGFloat)getLabelHeightWithDict:(OptionListModel *)listModel andQuestType:(showAnswerQuestType)quesType;

@end


