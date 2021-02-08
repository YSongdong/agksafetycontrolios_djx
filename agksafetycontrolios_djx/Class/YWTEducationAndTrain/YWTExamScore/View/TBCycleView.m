//
//  TBCycleView.m
//  TBCycleProgress
//
//  Created by qianjianeng on 16/2/22.
//  Copyright © 2016年 SF. All rights reserved.
//

#import "TBCycleView.h"

#define  PROGREESS_WIDTH 80 //圆直径
#define PROGRESS_LINE_WIDTH 7 //弧线的宽度
#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式
@interface TBCycleView ()

@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, strong) CAShapeLayer *progressLayer;

@property (nonatomic, strong) CALayer *gradientLayer;

@end
@implementation TBCycleView

- (void)drawProgress:(CGFloat )progress{
    _progress = progress;
    [_progressLayer removeFromSuperlayer];
    [_gradientLayer removeFromSuperlayer];
    [self setNeedsDisplay];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self drawCycleProgressRect:rect];
}
- (void)drawCycleProgressRect:(CGRect)rect{
    CGPoint center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    //判断是否是isiPhoneX 系列
    BOOL  isiPhoneX = [[YWTTools deviceModelName]containsString:@"X"];
    CGFloat radius = 0;
    if (isiPhoneX) {
        radius = 88;
    }else{
        radius = 70;
    }
    CGFloat startA = - M_PI_2;  //设置进度条起点位置
    CGFloat endA = -M_PI_2 + M_PI * 2 * _progress;  //设置进度条终点位置
    CGFloat endAA = -M_PI_2 + M_PI * 2 * 1;  //设置进度条终点位置
    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];//上面说明过了用来构建圆形
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endAA clockwise:YES];
    //创建轨道
    CAShapeLayer *trackLayer = [CAShapeLayer layer];
    trackLayer.frame = rect;
    trackLayer.fillColor = [UIColor clearColor].CGColor;
    trackLayer.strokeColor = [UIColor colorWithHexString:@"#4fa1fe"].CGColor;
    trackLayer.opacity = 1; //背景颜色的透明度
    trackLayer.lineCap = kCALineCapRound;//指定线的边缘是圆的
    trackLayer.lineWidth = PROGRESS_LINE_WIDTH;//线的宽度
    trackLayer.path = [bezierPath CGPath];
    [self.layer addSublayer:trackLayer];
    
    //获取环形路径（画一个圆形，填充色透明，设置线框宽度为10，这样就获得了一个环形）
    _progressLayer = [CAShapeLayer layer];//创建一个track shape layer
    _progressLayer.frame = self.bounds;
    _progressLayer.fillColor = [[UIColor clearColor] CGColor];  //填充色为无色
    _progressLayer.strokeColor = [[UIColor redColor] CGColor]; //指定path的渲染颜色,这里可以设置任意不透明颜色
    _progressLayer.opacity = 1; //背景颜色的透明度
    _progressLayer.lineCap = kCALineCapRound;//指定线的边缘是圆的
    _progressLayer.lineWidth = PROGRESS_LINE_WIDTH;//线的宽度
    _progressLayer.path =[path1 CGPath]; //把path传递給layer，然后layer会处理相应的渲染，整个逻辑和CoreGraph是一致的。
    //生成渐变色
    _gradientLayer = [CALayer layer];

    //渐变色
    CAGradientLayer *leftLayer = [CAGradientLayer layer];
    leftLayer.frame = CGRectMake(0, 0, self.bounds.size.width , self.bounds.size.height);    // 分段设置渐变色
    leftLayer.locations = @[@0.3, @0.9, @1];
    leftLayer.colors = @[(id)[UIColor colorWithHexString:@"#ffa700"].CGColor, (id)[UIColor colorWithHexString:@"#ffef00"].CGColor,(id)[UIColor colorWithHexString:@"#ffa700"].CGColor];
    [_gradientLayer addSublayer:leftLayer];

    [_gradientLayer setMask:_progressLayer]; //用progressLayer来截取渐变层
    [self.layer addSublayer:_gradientLayer];
}
- (void)setPercet:(CGFloat)percent withTimer:(CGFloat)time {
    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [CATransaction setAnimationDuration:time];
    _progress = percent;
    [CATransaction commit];
}

@end
