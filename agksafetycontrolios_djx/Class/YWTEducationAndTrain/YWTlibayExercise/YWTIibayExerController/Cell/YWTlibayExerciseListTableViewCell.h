//
//  libayExerciseListTableViewCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/26.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTlibayExerciseListTableViewCell : UITableViewCell

@property (nonatomic,strong) NSDictionary *dict;

// 错题巩固
@property (nonatomic,copy) void(^errorQuestBlock)(void);
// 我的收藏
@property (nonatomic,copy) void(^mineCollecBlock)(void);
// 开始练习
@property (nonatomic,copy) void(^beginLearnBlock)(void);


@end

NS_ASSUME_NONNULL_END
