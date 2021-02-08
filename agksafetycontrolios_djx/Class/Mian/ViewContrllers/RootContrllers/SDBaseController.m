//
//  SDBaseController.m
//  AttendanceManager
//
//  Created by tiao on 2018/7/10.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDBaseController.h"



@interface SDBaseController ()
<
UIGestureRecognizerDelegate
>

@end

@implementation SDBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupNavBar];
}
- (void)setupNavBar
{
    [self.view addSubview:self.customNavBar];

    // 设置自定义导航栏背景图片
    self.customNavBar.barBackgroundColor = [UIColor colorLineCommonBlueColor];
   
    // 设置自定义导航栏标题颜色
    self.customNavBar.titleLabelColor = [UIColor whiteColor];
    //隐藏导航栏线条
    [self.customNavBar  wr_setBottomLineHidden:YES];

}
- (WRCustomNavigationBar *)customNavBar
{
    if (_customNavBar == nil) {
        _customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    }
    return _customNavBar;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (self.childViewControllers.count == 1) {
        return NO;
    }else{
        return YES;
    }
}
- (void)customNaviItemTitle:(NSString *)title titleColor:(UIColor *)color
{
    // 定制UINavigationItem的titleView
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor =color;
    // 设置文字
    titleLabel.text = title;
    
    // 设置导航项的标题视图
    self.navigationItem.titleView = titleLabel;
}

- (void)customTabBarButtonimage:(NSString *)imageName target:(id)target action:(SEL)selector isLeft:(BOOL)isLeft
{
    UIImage *image=[UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    UIImageView *imageView =[[UIImageView alloc]initWithImage:image];
    //    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setImage:image forState:UIControlStateNormal];
    // [button setBackgroundImage:imageView.image forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchDown];
    button.frame = CGRectMake(0, 0, 20, 40);
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    
    // 判断是否为左侧按钮
    UIBarButtonItem * buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    if (isLeft) {
        self.navigationItem.leftBarButtonItem = buttonItem;
    }
    else {
        self.navigationItem.rightBarButtonItem = buttonItem;
    }
}






@end
