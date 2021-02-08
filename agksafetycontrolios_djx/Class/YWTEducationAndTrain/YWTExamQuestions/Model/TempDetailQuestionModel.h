//
//  TempDetailQuestionModel.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/24.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class QuestionListModel,SheetModel,OptionListModel,ListModel;

@interface TempDetailQuestionModel : NSObject <YYModel>

//试卷名
@property (nonatomic,copy) NSString *title;
//题目总数
@property (nonatomic,copy) NSString *questionNum;
//正确数
@property (nonatomic,copy) NSString *corrNumber;
//错误数
@property (nonatomic,copy) NSString *errNumber;
//未作答
@property (nonatomic,copy) NSString *notMade;
//未知题型
@property (nonatomic,copy) NSString *unknown;
//进入考试时间
@property (nonatomic,copy) NSString *startTime;
//考试耗时
@property (nonatomic,copy) NSString *timeCons;
//考试成绩
@property (nonatomic,copy) NSString *score;
//1是合格 2是不合格
@property (nonatomic,copy) NSString *isPass;
//考试试题
@property (nonatomic,strong) NSArray *questionList;
//答题卡
@property (nonatomic,strong) NSArray *sheet;

@end


@interface QuestionListModel : NSObject <YYModel>
//题 id
@property (nonatomic,copy) NSString *Id;
//题 标题
@property (nonatomic,copy) NSString *title;
//题
@property (nonatomic,copy) NSString *libaryId;
//题  【题目类型】
@property (nonatomic,copy) NSString *typeId;
//题
@property (nonatomic,copy) NSString *chapterId;
//题 解析】
@property (nonatomic,copy) NSString *analyze;
//题
@property (nonatomic,copy) NSString *selected;
//题  答案】
@property (nonatomic,copy) NSString *answer;
//题  【选项类型】
@property (nonatomic,copy) NSString *layoutType;
//题 数量
@property (nonatomic,copy) NSString *total;
//用户选择答案
@property (nonatomic,copy) NSString *userAnswer;
//题
@property (nonatomic,copy) NSString *minute;
//题
@property (nonatomic,copy) NSString *score;
//题 1默认 2易 3中 4难
@property (nonatomic,copy) NSString *level;
//题   1正常2删除 无用字段
@property (nonatomic,copy) NSString *isDelete;
//题  1启用2禁用 无用字段
@property (nonatomic,copy) NSString *status;
// 试卷名称
@property (nonatomic,copy) NSString *paperTitle;
//题干 图片
@property (nonatomic,copy) NSString *picture;
//题
@property (nonatomic,copy) NSString *createTime;
//题
@property (nonatomic,copy) NSString *updateTime;
//题 【选项ABCD】
@property (nonatomic,strong) NSArray *optionList;



@end

@interface OptionListModel : NSObject
//选项 title
@property (nonatomic,copy) NSString *title;
//选项  图片
@property (nonatomic,copy) NSString *photo;
//选项  文字
@property (nonatomic,copy) NSString *option;

@end

@interface SheetModel : NSObject

@property (nonatomic,copy) NSString *key ;

@property (nonatomic,copy) NSString *spread;

@property (nonatomic,strong) NSArray *list;

@end


//答题卡
@interface ListModel : NSObject  <YYModel>
// id
@property (nonatomic,copy) NSString *Id;
// 作对2 做错3 未知4
@property (nonatomic,copy) NSString *selected;
// key
@property (nonatomic,copy) NSString *qid;

@end



NS_ASSUME_NONNULL_END
