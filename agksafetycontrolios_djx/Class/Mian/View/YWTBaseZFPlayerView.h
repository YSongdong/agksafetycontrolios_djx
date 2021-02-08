//
//  BaseZFPlayerView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/4/11.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YWTBaseZFPlayerView : UIView

@property (nonatomic,strong) NSString *coverStr;
// 文件名称
@property (nonatomic,strong) NSString *fileNameStr;
// 播放地址
@property (nonatomic,strong) NSString *playerUrl;
// 播放器 view
@property (nonatomic,strong) ZFPlayerController *player;
// 是否显示默认封面图
@property (nonatomic,assign) BOOL isShowCoverImageV;
// 判断是视频还是音频   NO  音频 YES 视频 默认NO
@property (nonatomic,assign) BOOL  isVideoType;

// 当前播放时间进度回调
@property (nonatomic,copy) void(^videoPlayerCurrentTime)(NSDictionary *currentTimeDict);

// 当封面上点击播放
@property (nonatomic,copy) void(^selecCoverPlayBtn)(void);
// 点击返回按钮
@property (nonatomic,copy) void(^selectBackBtn)(void);

@end


