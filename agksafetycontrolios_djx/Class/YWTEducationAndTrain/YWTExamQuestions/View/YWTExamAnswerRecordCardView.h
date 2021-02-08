//
//  ExamAnswerRecordCardView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/18.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*
 模式
 */
typedef enum {
    showAnswerCardAnswerMode = 0,   // 答题模式
    showAnswerCardDetailMode,       // 详情模式
}showAnswerCardMode;

@interface YWTExamAnswerRecordCardView : UIView

//  模式
@property (nonatomic,assign) showAnswerCardMode answerCardMode;
// 当前题id
@property (nonatomic,strong) NSString *questId;
// 数据源数组
@property (nonatomic,strong) NSArray *sourceArr;
// 详情数据源数组
@property (nonatomic,strong) NSArray *detaSourceArr;
// 选中题的id
@property (nonatomic,copy) void(^selectQuetionBlock)(NSString *questId);


@end

NS_ASSUME_NONNULL_END
