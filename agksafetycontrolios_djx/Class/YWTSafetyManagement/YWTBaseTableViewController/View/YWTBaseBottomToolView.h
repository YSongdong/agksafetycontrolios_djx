//
//  BaseBottomToolView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/19.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTBaseBottomToolView : UIView
@property (nonatomic,strong) UIView *bgView;
// 按钮
@property (nonatomic,strong) UIButton *submitBtn;
// 存入草稿
@property (nonatomic,strong) UIButton *saveDraftBtn;
// 点击提交
@property (nonatomic,copy) void(^selectSubmitBtn)(void);
// 存入草稿
@property (nonatomic,copy) void(^selectSaveDraftBtn)(void);
// 更新提交按钮
-(void) updateSubmitBtnUI;

@end

NS_ASSUME_NONNULL_END
