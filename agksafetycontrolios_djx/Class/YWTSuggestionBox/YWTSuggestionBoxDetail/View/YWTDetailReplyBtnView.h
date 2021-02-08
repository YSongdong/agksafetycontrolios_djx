//
//  YWTDetailReplyBtnView.h
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/10/17.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTDetailReplyBtnView : UIView

@property (nonatomic,strong) UIButton *replyBtn;

// 是不是回复  YES  是 NO 撤回
@property (nonatomic,copy) void(^selectReplyAction)(BOOL isReply);

@property (nonatomic,strong) NSDictionary *dict;

@end

NS_ASSUME_NONNULL_END
