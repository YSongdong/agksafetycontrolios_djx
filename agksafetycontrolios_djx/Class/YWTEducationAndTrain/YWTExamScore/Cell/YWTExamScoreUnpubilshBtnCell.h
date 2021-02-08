//
//  ExamScoreUnpubilshBtnCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/23.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTExamScoreUnpubilshBtnCell : UITableViewCell
// 点击返回首页
@property (nonatomic,copy) void(^backHomeBlock)(void);


@end

NS_ASSUME_NONNULL_END
