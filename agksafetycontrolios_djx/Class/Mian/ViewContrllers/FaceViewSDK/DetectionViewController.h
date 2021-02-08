//
//  DetectionViewController.h
//  IDLFaceSDKDemoOC
//
//  Created by 阿凡树 on 2017/5/23.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#import "FaceBaseViewController.h"

typedef enum {
    showCodeTimeOutStartStatu = 0,   //开始前
    showCodeTimeOutUnStartStatu,     // 其他情况下
}showCodeTimeOutStatu;

@interface DetectionViewController : FaceBaseViewController
// 类型
@property (nonatomic,assign) showCodeTimeOutStatu outStatu;

@property (nonatomic,copy) void(^fackBlcok)(UIImage *image);
// 点击关闭视图方法
@property (nonatomic,copy) void(^closeViewControllBlock)(void);
// 如果验证超时方法
@property (nonatomic,copy) void(^CodeTimeoutBlock)(void);


@end
