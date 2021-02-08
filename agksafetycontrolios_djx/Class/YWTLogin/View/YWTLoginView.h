//
//  LoginView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/8.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTLoginView : UIView

// 点击密码找回
@property (nonatomic,copy) void(^pwdRetieveBlock)(void);
// 登录成功
@property (nonatomic,copy) void(^successBlock)(void);


@end

NS_ASSUME_NONNULL_END
