//
//  InfoAttandanceCheckView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/14.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTInfoAttandanceCheckView : UIView

// 定位地址
@property (nonatomic,strong) NSString *addressStr;
// 人脸验证状态
@property (nonatomic,strong) NSString *faceVerifStr;
// 相册里选择的图片
@property (nonatomic,strong) UIImage *libaryImage;
// 打开相册
@property (nonatomic,copy) void(^openLibary)(void);
// 点击重新验证
@property (nonatomic,copy) void(^selectAgainVierf)(void);
// 点击确认签到
@property (nonatomic,copy) void(^selectTureAttendance)(NSDictionary *dict);
// 查看大图
@property (nonatomic,copy) void(^selectBigPhoto)(NSDictionary *dict);

@end

NS_ASSUME_NONNULL_END
