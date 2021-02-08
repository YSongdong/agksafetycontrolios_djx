//
//  SettingModuleView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/9.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTSettingModuleView : UIView

// 标题 文字
@property (nonatomic,strong) NSString *titleStr;

// 副标题 文字
@property (nonatomic,strong) NSString *subTitleStr;

// 点击事件
@property (nonatomic,copy) void(^selectViewBlock)(void);


@end

NS_ASSUME_NONNULL_END
