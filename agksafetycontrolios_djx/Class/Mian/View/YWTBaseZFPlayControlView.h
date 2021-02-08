//
//  BaseZFPlayControlView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/4/12.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTBaseZFPlayControlView : UIView <ZFPlayerMediaControl>
// 封面图
@property (nonatomic,strong) UIImageView *coverImageV;
// 是否显示封面图  YES  显示 NO 不显示
@property (nonatomic,assign) BOOL isShowCoverImageV;
// 判断是视频还是音频   NO  音频 YES 视频 默认NO
@property (nonatomic,assign) BOOL  isVideoType;
// 文件名称
@property (nonatomic,strong) NSString *fileNameStr;
// 当前播放时间进度回调
@property (nonatomic,copy) void(^videoPlayerCurrentTime)(NSDictionary *currentTimeDict);
// 点击返回按钮
@property (nonatomic,copy) void(^selectBackBtn)(void);

@end

NS_ASSUME_NONNULL_END
