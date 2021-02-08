//
//  TBCycleView.h
//  TBCycleProgress
//
//  Created by qianjianeng on 16/2/22.
//  Copyright © 2016年 SF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBCycleView : UIView

/**
 * 开始动画
 * percent CGFloat 百分比(0-100)
 * time CGFloat 动画时间
 */
- (void)setPercet:(CGFloat)percent withTimer:(CGFloat)time ;

- (void)drawProgress:(CGFloat )progress;

@end
