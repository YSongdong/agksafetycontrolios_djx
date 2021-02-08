//
//  YWTBoxRecordTopView.h
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/17.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTBoxRecordTopView : UIView

@property (nonatomic,strong) UIButton *mineReleaseBtn;

@property (nonatomic,strong) UIButton *mineReceiveBtn;

// 选择按钮   0 我发布的 1 我的接收的
@property (nonatomic,copy) void(^selectBtnBlock)(NSInteger btnTag);

@end

NS_ASSUME_NONNULL_END
