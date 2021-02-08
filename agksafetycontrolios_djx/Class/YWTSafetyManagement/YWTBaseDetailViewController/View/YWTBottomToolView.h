//
//  BottomToolView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/12.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTBottomToolView : UIView
// 撤销
@property (nonatomic,copy) void(^selectCancelBtn)(void);
// 修改
@property (nonatomic,copy) void(^selectAlterBtn)(void);

@end

NS_ASSUME_NONNULL_END
