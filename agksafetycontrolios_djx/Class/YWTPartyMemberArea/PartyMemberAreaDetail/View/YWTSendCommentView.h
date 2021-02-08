//
//  YWTSendCommentView.h
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/12.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTSendCommentView : UIView
// 确定评论
@property (nonatomic,copy) void(^selectCommit)(NSString *commitText);

@end

NS_ASSUME_NONNULL_END
