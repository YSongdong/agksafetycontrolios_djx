//
//  LibayExerPromptView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/2/14.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTLibayExerPromptView : UIView

@property (nonatomic,strong) UILabel *showContentLab;
// 进入题库
@property (nonatomic,copy) void(^enterExam)(void);
// 再次练习
@property (nonatomic,copy) void(^againExer)(void);
@end

NS_ASSUME_NONNULL_END
