//
//  DataBaseManager.m
//  LimitFree
//
//  Created by Chaosky on 16/1/8.
//  Copyright © 2016年 1000phone. All rights reserved.
//

#import "DataBaseManager.h"
#import "FMDB.h"

@implementation DataBaseManager
{
    // 数据库管理对象
    FMDatabase * _fmdb;
}

// 单例方法
+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    static DataBaseManager * dbManager = nil;
    dispatch_once(&onceToken, ^{
        if (!dbManager) {
            dbManager = [[DataBaseManager alloc] initPrivate];
        }
    });
    return dbManager;
    
//    @synchronized(self) {
//        if (!dbManager) {
//            dbManager = [[DataBaseManager alloc] initPrivate];
//        }
//    }
}

// 重写初始化方法
- (instancetype)init
{
    // 1. 抛出异常方式
    @throw [NSException exceptionWithName:@"DataBaseManager init" reason:@"不能调用init方法" userInfo:nil];
    // 2. 断言，判定言论，程序崩溃
//    NSAssert(NO, @"DataBaseManager无法调用该方法");
    return self;
}

// 重新实现初始化方法
- (instancetype)initPrivate
{
    if (self = [super init]) {
        [self createDataBase];
    }
    return self;
}

// 初始化数据库
- (void)createDataBase
{
    // 获取沙盒路径下的documents路径
    NSArray * documentsPath =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * dbPath = [[documentsPath firstObject] stringByAppendingPathComponent:@"t_quest.sqlite"];
    NSLog(@"DBPath = %@", dbPath);
    if (!_fmdb) {
        // 创建数据库管理对象
        _fmdb = [[FMDatabase alloc] initWithPath:dbPath];
    }
    // 打开数据库
    if ([_fmdb open]) {
        // 创建数据库表
        [_fmdb executeUpdate:@"CREATE TABLE IF NOT EXISTS t_quest (questId text PRIMARY KEY , testType,examType,answer,userAnswer);"];
    }
}
#pragma mark - 增删查
//保存所有的试题数据
-(void) saveQusetAlls:(NSArray *)questArr{
    //删除
    [self deleteAll];
   
    for (NSDictionary *dict in questArr) {
        BOOL save = [self insertQuestId:[NSString stringWithFormat:@"%@",dict[@"id"]] andTestType:dict[@"ExamType"] andExamType:dict[@"id"] andAnswer:dict[@"answer"] andUserAnswer:dict[@"userAnswer"]];
        if (save) {
//                NSLog(@"----------添加成功-----");
        }else{
//               NSLog(@"---------添加失败-----");
        }
    }
}
// 判断libaryId对应的数据是否存在
- (BOOL)isExistsQuestId:(NSString *)QuestId{
    BOOL  isQuestID = NO;
    
    [_fmdb open];
     FMResultSet * rs = [_fmdb executeQuery:@"SELECT * FROM t_quest"];
    // 判断结果集是否存在
    while ([rs next]) {
        NSString *questID = [rs stringForColumn:@"questId"];
        if ([questID isEqualToString:QuestId]) {
            isQuestID = YES;
        }
    }
    //关闭数据库
    [_fmdb close];
    return isQuestID;
}
// 添加数据
- (BOOL)insertQuestId:(NSString *)questId andTestType:(NSString *)testType  andExamType:(NSString *)examType andAnswer:(NSString *)answer andUserAnswer:(NSString *)userAnswer{
    // 判断appId在数据库中是否存在
    if (![self isExistsQuestId:questId]) {
        [_fmdb open];
        // 如果不存在
        BOOL success = [_fmdb executeUpdate:@"INSERT INTO t_quest VALUES (?,?,?,?,?)", questId,  testType,examType,answer,userAnswer];
        
        //关闭数据库
        [_fmdb close];
        
        return success;
    }
    return NO;
}

//更新用户选择答案数据
-(void)updateFMDBDataQuestId:(NSString *)questId andUserAnswer:(NSString *)userAnswer;{
    // 打开数据库
    if ([_fmdb open]) {
        
        NSString *advFenLeiStr = [NSString stringWithFormat:@"update t_quest set userAnswer = '%@' WHERE questId = '%@';",userAnswer,questId];
        BOOL result = [_fmdb executeUpdate:advFenLeiStr];
        if (result) {
            NSLog(@"FenLei数据更新成功");
        }else
        {
            NSLog(@"FenLei数据更新失败");
        }
    }
    [_fmdb close];
}
// 根据题id 获取用户选择的答案
-(NSString*) getObtainUserSelectAnswer:(NSString *)questId{
    [_fmdb open];
    NSString *userAnswerStr ;
    NSString *advFenLeiStr = [NSString stringWithFormat:@"SELECT * FROM t_quest WHERE questId = '%@';",questId];
    // 从表Collection中获取所有的数据
    FMResultSet * rs = [_fmdb executeQuery:advFenLeiStr];
    // 遍历结果集
    while ([rs next]) {
        userAnswerStr = [rs stringForColumn:@"userAnswer"];
    }
    [_fmdb close];
    return userAnswerStr;
}

//根据条件查询
-(NSDictionary *) selectWhereQuestId:(NSString *)questId{
    [_fmdb open];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *advFenLeiStr = [NSString stringWithFormat:@"SELECT * FROM t_quest WHERE questId = '%@';",questId];
    // 从表Collection中获取所有的数据
    FMResultSet * rs = [_fmdb executeQuery:advFenLeiStr];
    // 遍历结果集
    while ([rs next]) {
        param[@"testType"] = [rs stringForColumn:@"testType"];
        param[@"examType"] = [rs stringForColumn:@"examType"];
        param[@"answer"] = [rs stringForColumn:@"answer"];
        param[@"userAnswer"] = [rs stringForColumn:@"userAnswer"];
    }
    [_fmdb close];
    return [param copy];
}
// 获取数据库中所有的记录
- (NSArray *)selectAllApps
{
    [_fmdb open];
    // 从表Collection中获取所有的数据
    FMResultSet * rs = [_fmdb executeQuery:@"SELECT * FROM t_quest"];
    // 遍历结果集
    NSMutableArray * apps = [NSMutableArray array];
    while ([rs next]) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"questId"] = [rs stringForColumn:@"questId"];
        param[@"testType"] = [rs stringForColumn:@"testType"];
        param[@"examType"] = [rs stringForColumn:@"examType"];
        param[@"answer"] = [rs stringForColumn:@"answer"];
        param[@"userAnswer"] = [rs stringForColumn:@"userAnswer"];
        [apps addObject:param];
    }
    [_fmdb close];
    return [apps copy];
    
}

// 删除数据库中的数据
-(BOOL) deleteAll
{
    // 获取沙盒路径下的documents路径
    NSArray * documentsPath =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * dbPath = [[documentsPath firstObject] stringByAppendingPathComponent:@"t_quest.sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    [db open];
    
    BOOL success =  [db executeUpdate:@"DELETE FROM t_quest"];
    
    [db close];
    
    return success;
    return YES;
}


@end





