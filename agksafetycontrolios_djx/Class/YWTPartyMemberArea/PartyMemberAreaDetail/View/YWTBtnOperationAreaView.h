//
//  YWTBtnOperationAreaView.h
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/11.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YWTConstant.h"
NS_ASSUME_NONNULL_BEGIN

@protocol YWTBtnOperationAreaViewDeleagate <NSObject>

-(void) selectOPerateMenuOperateType:(YWTOperateType)operateType;

@end

@interface YWTBtnOperationAreaView : UIView

@property (nonatomic,weak) id <YWTBtnOperationAreaViewDeleagate> delegate;
// 评论
@property (nonatomic,strong) UIButton *commentBtn;
// 点赞
@property (nonatomic,strong) UIButton *likeBtn;

@end

NS_ASSUME_NONNULL_END
