//
//  WKWebViewOrJSText.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/22.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    showLibaryTitleSequentPracType = 0, // 顺序练习
    showLibaryTitleSpecialTrainType ,   // 专项训练
    showLibaryTitleErrorQuestType   ,   // 错题巩固
    showLibaryTitleMineCollecType   ,   // 我的收藏
}showLibaryTitleType;

#import "SDBaseController.h"

@interface WKWebViewOrJSText : SDBaseController
// 类型
@property (nonatomic,assign) showLibaryTitleType titleType;
//题库ID
@property (nonatomic,strong) NSString *libaryIdStr;
//  顺序练习 练习状态
@property (nonatomic,strong) NSString *sequentPracStatus;
//  专项练习   章节id【专项练习使用】
@property (nonatomic,strong) NSString *chapterIdStr;
//  专项练习 试题类型【专项练习使用】 1：单选题 2：多选题 3：判断题 4：问答题 5：填空题 6:主观题
@property (nonatomic,strong) NSString *typeIdStr;
// 任务id  如果等于空字符串 就是没有开启任务
@property (nonatomic,strong) NSString *taskIdStr;
// 人脸规则数组
@property (nonatomic,strong) NSArray *monitorRulesArr;
@end


