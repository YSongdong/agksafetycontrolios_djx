//
//  LivenessViewController.h
//  IDLFaceSDKDemoOC
//
//  Created by 阿凡树 on 2017/5/23.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#import "FaceBaseViewController.h"

@interface LivenessViewController : FaceBaseViewController

- (void)livenesswithList:(NSArray *)livenessArray order:(BOOL)order numberOfLiveness:(NSInteger)numberOfLiveness;

@property (nonatomic,copy) void(^fackBlcok)(UIImage *image);
// 点击关闭视图方法
@property (nonatomic,copy) void(^closeViewControllBlock)(void);
// 如果验证超时方法
@property (nonatomic,copy) void(^CodeTimeoutBlock)(void);

@end
