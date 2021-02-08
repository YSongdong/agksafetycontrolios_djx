//
//  CWAudioPlayView.h
//  QQVoiceDemo
//
//  Created by 陈旺 on 2017/10/4.
//  Copyright © 2017年 陈旺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CWAudioPlayView : UIView

@property (nonatomic,assign) CGFloat progressValue;

// 是否列表播放
@property (nonatomic,assign) BOOL isListPlay;
// 列表播放路径
@property (nonatomic,strong) NSString *listFliePath;
// 选中回调
@property (nonatomic,copy) void(^selectTureBtn)(NSDictionary *audioDict);

@end
