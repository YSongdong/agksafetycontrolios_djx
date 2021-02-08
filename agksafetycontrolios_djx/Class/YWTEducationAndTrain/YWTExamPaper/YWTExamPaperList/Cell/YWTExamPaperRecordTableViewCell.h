//
//  ExamPaperRecordTableViewCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/16.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTExamPaperRecordTableViewCell : UITableViewCell

@property (nonatomic,strong) NSDictionary *dict;

// 点击查看更多事件
@property (nonatomic,copy) void(^recordMoreBlock)(void);
// 点击开始考试
@property (nonatomic,copy) void(^beginExamBlock)(void);
// 查看详情
@property (nonatomic,copy) void(^seeDetailBlock)(void);
@end

NS_ASSUME_NONNULL_END
