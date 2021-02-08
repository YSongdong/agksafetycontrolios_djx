//
//  ExamPaperListTableViewCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/15.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTExamPaperListTableViewCell : UITableViewCell

@property (nonatomic,strong) NSDictionary *dict;

// 点击练习按钮
@property (nonatomic,copy) void(^selectExerBlock)(void);

@end

NS_ASSUME_NONNULL_END
