//
//  BaseVodPlayView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/27.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTBaseVodPlayView : UIView
// 播放地址
@property (nonatomic,strong) NSString *filePath;
// 播放器
@property (nonatomic,strong) AVPlayer * player;

@end

NS_ASSUME_NONNULL_END
