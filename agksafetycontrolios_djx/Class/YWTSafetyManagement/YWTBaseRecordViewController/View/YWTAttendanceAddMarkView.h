//
//  AttendanceAddMarkView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/14.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    showAttendanceAddMarkType = 0,  // 添加
    showAttendanceLookMarkType,     //  查看
}showAttendanceMarkType;


@interface YWTAttendanceAddMarkView : UIView
// 类型
@property (nonatomic,assign) showAttendanceMarkType markType;
// 数据源
@property (nonatomic,strong) NSMutableArray *dataArr;
// 备注文字
@property (nonatomic,strong) NSString *markConterStr;

// 用户选择图片后调用方法
-(void) addUserSelectPhoto:(UIImage *) selectImage;
// 打开相册
@property (nonatomic,copy) void(^openLibary)(void);
// 查看大图
@property (nonatomic,copy) void(^selectBigPhoto)(NSDictionary *dict);
// 点击关闭
@property (nonatomic,copy) void(^selectCancelBtn)(NSDictionary *markDict);

@end

NS_ASSUME_NONNULL_END
