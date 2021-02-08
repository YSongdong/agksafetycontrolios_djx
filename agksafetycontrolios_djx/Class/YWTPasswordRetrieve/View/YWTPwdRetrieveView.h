//
//  PwdRetrieveView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/9.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTPwdRetrieveView : UIView
// 跳转
@property (nonatomic,copy) void(^backBlock)(void);

@end

NS_ASSUME_NONNULL_END
