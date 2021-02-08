//
//  BootLoaderController.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/29.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "YWTBootLoaderController.h"

#import "YWTLoginViewController.h"
#import "LWDPageControl.h"

@interface YWTBootLoaderController ()<UIScrollViewDelegate>{
    // 判断是否是第一次进入应用
    BOOL flag;
}
@property (nonatomic,strong) UIScrollView *myScrollView;
@property (nonatomic,strong) UIButton *nextBtn;
@property (nonatomic,strong) LWDPageControl *pageControl;
@end

@implementation YWTBootLoaderController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createScrollView];
}
-(void) createScrollView{
    __weak typeof(self) weakSelf = self;
    
    self.myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    [self.view addSubview:self.myScrollView];
    self.myScrollView.delegate = self;
    self.myScrollView.contentSize = CGSizeMake(KScreenW*3, KScreenH);
    self.myScrollView.showsVerticalScrollIndicator= NO;
    self.myScrollView.showsHorizontalScrollIndicator = NO;
    self.myScrollView.bounces = NO;
    self.myScrollView.pagingEnabled = YES;
    for (int i = 0; i< 3 ; i++) {
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(i*KScreenW, 0, KScreenW, KScreenH)];
        [self.myScrollView addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"Guidepages_0%d",i+1]];
    }
    _pageControl = [[LWDPageControl alloc] initWithFrame:CGRectMake(0, KScreenH-KSTabbarH-45, KScreenW, 30) indicatorMargin:10.f indicatorWidth:10.f currentIndicatorWidth:20.f indicatorHeight:10];
    _pageControl.numberOfPages = 3;
    [self.view addSubview:_pageControl];

    self.nextBtn = [[UIButton alloc]init];
    [self.view addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@44);
        make.left.equalTo(weakSelf.view).offset(KSIphonScreenW(80));
        make.right.equalTo(weakSelf.view).offset(-KSIphonScreenW(80));
        make.bottom.equalTo(weakSelf.view).offset(-(KSTabbarH+KSIphonScreenH(20)));
    }];
    [self.nextBtn setTitle:@"立即体验" forState:UIControlStateNormal];
    [self.nextBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.nextBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    self.nextBtn.layer.cornerRadius =44/2;
    self.nextBtn.layer.masksToBounds = YES;
    [self.nextBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorWithHexString:@"#ff002c"]] forState:UIControlStateNormal];
    [self.nextBtn setBackgroundImage:[YWTTools imageWithColor:[UIColor colorWithHexString:@"#ff002c" alpha:0.8]] forState:UIControlStateHighlighted];
    [self.nextBtn addTarget:self action:@selector(onNextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.nextBtn.hidden = YES;
}
-(void)onNextBtnClick:(UIButton *) sender
{
    flag = YES;
    NSUserDefaults *useDef = [NSUserDefaults standardUserDefaults];
    // 保存用户数据
    [useDef setBool:flag forKey:@"notFirst"];
    [useDef synchronize];
    // 切换根视图控制器
    SDRootNavigationController *loginVC = [[SDRootNavigationController alloc]initWithRootViewController:[YWTLoginViewController new]];
    AppDelegate *appdel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appdel.window.rootViewController = loginVC;
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
    // 计算当前在第几页
    self.pageControl.currentPage =currentPage;
    if (currentPage == 2) {
        [UIView animateWithDuration:1 animations:^{
            self.nextBtn.hidden = NO;
            self.pageControl.hidden = YES;
        }];
    }else{
        [UIView animateWithDuration:1 animations:^{
            self.nextBtn.hidden = YES;
            self.pageControl.hidden = NO;
        }];
    }
}




@end
