//
//  DataBaseManager.h
//  LimitFree
//
//  Created by Chaosky on 16/1/8.
//  Copyright © 2016年 1000phone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBaseManager : NSObject

// 单例方法
+ (instancetype)sharedManager;

//保存所有的试题数据
-(void) saveQusetAlls:(NSArray *)questArr;

// 判断libaryId对应的数据是否存在
- (BOOL)isExistsQuestId:(NSString *)QuestId;

// 添加数据
- (BOOL)insertQuestId:(NSString *)questId andTestType:(NSString *)testType  andExamType:(NSString *)examType andAnswer:(NSString *)answer andUserAnswer:(NSString *)userAnswer;

//更新用户选择答案数据
-(void)updateFMDBDataQuestId:(NSString *)questId andUserAnswer:(NSString *)userAnswer;

// 根据题id 获取用户选择的答案
-(NSString*) getObtainUserSelectAnswer:(NSString *)questId;

//根据条件查询
-(NSDictionary *) selectWhereQuestId:(NSString *)questId;

// 获取数据库中所有的记录
- (NSArray *)selectAllApps;

// 删除数据库中的数据
-(BOOL) deleteAll;



@end
