//
//  LibayExerStartLearnPromptView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/2/26.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTLibayExerStartLearnPromptView : UIView

// 顺序练习
@property (nonatomic,copy) void(^selectSequenPrac)(void);
// 专项练习
@property (nonatomic,copy) void(^selectSpecialPrac)(void);

@end

NS_ASSUME_NONNULL_END
