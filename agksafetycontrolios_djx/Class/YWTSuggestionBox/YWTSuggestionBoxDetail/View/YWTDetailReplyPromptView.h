//
//  YWTDetailReplyPromptView.h
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/19.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YWTDetailReplyPromptViewDelegate <NSObject>
// 回复信息
-(void) selectReplyWithdrawContent:(NSString *)contentText;

@end


@interface YWTDetailReplyPromptView : UIView <UITextViewDelegate>

@property (nonatomic,weak) id <YWTDetailReplyPromptViewDelegate> delegate;

@property (nonatomic,strong) FSTextView *fsTextView;

@end

NS_ASSUME_NONNULL_END
