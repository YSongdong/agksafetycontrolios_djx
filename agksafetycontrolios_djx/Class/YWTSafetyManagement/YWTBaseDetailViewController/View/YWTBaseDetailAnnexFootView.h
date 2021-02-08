//
//  BaseDetailAnnexFootView.h
//  PartyBuildingStar
//
//  Created by mac on 2019/5/22.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTBaseDetailAnnexFootView : UIView

@property (nonatomic,strong) NSDictionary *dict;
// 点击撤销按钮
@property (nonatomic,copy) void(^selectRevokelsBtn)(void);
// 点击修改按钮
@property (nonatomic,copy) void(^selelctAlterBtn)(void);

@end

NS_ASSUME_NONNULL_END
