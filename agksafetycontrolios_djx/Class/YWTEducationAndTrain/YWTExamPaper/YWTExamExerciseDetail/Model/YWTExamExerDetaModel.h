//
//  ExamExerDetaModel.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/2/21.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class libaryListModel;

@interface YWTExamExerDetaModel : NSObject <YYModel>
//试卷图片
@property (nonatomic,copy) NSString *imgUrl;
//更新试卷
@property (nonatomic,copy) NSString *updateTime;
//试卷标题
@property (nonatomic,copy) NSString *title;
//试卷类型
@property (nonatomic,copy) NSString *catEgory;
//试卷所具有的标签
@property (nonatomic,copy) NSString *tag;
//所包含题库列表
@property (nonatomic,strong) NSArray *libaryList;
//总题数
@property (nonatomic,copy) NSString *questionNum;
//考试时间
@property (nonatomic,copy) NSString *examTotalTime;
//总分
@property (nonatomic,copy) NSString *totalScore;
//合格分数
@property (nonatomic,copy) NSString *passScore;
//题库描述链接
@property (nonatomic,copy) NSString *desc;

@end

@interface libaryListModel : NSObject <YYModel>
//题库id
@property (nonatomic,copy) NSString *Id;
//题库标题
@property (nonatomic,copy) NSString *title;
//1是可以跳转 2是不能跳转
@property (nonatomic,copy) NSString *jump;

@end



NS_ASSUME_NONNULL_END
