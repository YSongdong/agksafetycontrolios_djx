//
//  YWTCellVideoView.h
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/4.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTCellVideoView : UIView

@property (nonatomic,strong) UIImageView *coverImageV;

// 封面地址
@property (nonatomic,strong) NSString *coverUrlStr;
// 播放视频
@property (nonatomic,copy) void(^selectPlayVideo)(void);

@end

NS_ASSUME_NONNULL_END
