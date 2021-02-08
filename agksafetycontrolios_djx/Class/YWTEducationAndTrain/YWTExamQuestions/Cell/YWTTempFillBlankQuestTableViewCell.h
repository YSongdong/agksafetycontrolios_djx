//
//  TempFillBlankQuestTableViewCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/21.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 答题模式
 */
typedef enum {
    showFillBlankQuestAnswerMode = 0 ,   // 答题模式
    showFillBlankQuestDetailMode ,      // 详情模式
}showExamFillBlankQuestMode;

#import "FSTextView.h"

@interface YWTTempFillBlankQuestTableViewCell : UITableViewCell

@property (nonatomic,strong) FSTextView *fsTextView;

// 类型
@property (nonatomic,assign) showExamFillBlankQuestMode fillBlankQuestMode;

// 用户答案， modeStr 答题模式  1 答题模式 2详情模式
-(void) getWithFillinAnswer:(NSString *)userAnswerStr andMode:(NSString *)modeStr;

// 填写答案
@property (nonatomic,copy) void(^fillinAnswerBlock)(NSString *useAnswer);
// textView 开始编辑和结束编辑的回调   YES  是开始编辑 NO 不是
@property (nonatomic,copy) void(^fsTextViewEditing)(BOOL isBeginEditing);

//计算高度
+(CGFloat)getCellHeightWithStr:(NSString *)answerStr andType:(NSString *)typeStr;

@end

