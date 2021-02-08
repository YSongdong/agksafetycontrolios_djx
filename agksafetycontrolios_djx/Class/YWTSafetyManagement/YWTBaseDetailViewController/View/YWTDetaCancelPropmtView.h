//
//  DetaCancelPropmtVie.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/19.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTDetaCancelPropmtView : UIView

@property (nonatomic,strong) UIButton *tureCancelBtn;
// 确定撤销
@property (nonatomic,copy) void(^selectTureCancel)(void);

@end

NS_ASSUME_NONNULL_END
