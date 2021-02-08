//
//  YWTOperateMenuView.h
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/4.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTOperateMenuView : UIView

// 浏览数
@property (nonatomic,strong) UIButton *viewingCountBtn;
// 评论数
@property (nonatomic,strong) UIButton *commentCountBtn;
// 点赞数
@property (nonatomic,strong) UIButton *likeCountBtn;

// 评论
@property (nonatomic,copy) void(^selectCommentBtn)(void);
// 点赞
@property (nonatomic,copy) void(^selectLikeBtn)(void);


@end

NS_ASSUME_NONNULL_END
