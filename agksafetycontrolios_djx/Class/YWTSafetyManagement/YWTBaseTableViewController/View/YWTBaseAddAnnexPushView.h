//
//  BaseAddAnnexPushView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/11.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTBaseAddAnnexPushView : UIView
// 取消视图
@property (nonatomic,copy) void(^removeView)(void);
// 打开视频
@property (nonatomic,copy) void(^switchVideo)(void);
// 打开相机
@property (nonatomic,copy) void(^switchCemera)(void);
// 打开相册
@property (nonatomic,copy) void(^switchPhotoLibary)(void);
// 打开录音
@property (nonatomic,copy) void(^switchRecording)(void);
// 打开音频列表
@property (nonatomic,copy) void(^switchAudioList)(void);
// 打开录视频
@property (nonatomic,copy) void(^switchRecordVideo)(void);
@end

NS_ASSUME_NONNULL_END
