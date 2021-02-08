//
//  AnnouncementCollectionViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/10.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "AnnouncementCollectionViewCell.h"

#import "SGAdvertScrollView.h"

@interface AnnouncementCollectionViewCell ()<SGAdvertScrollViewDelegate>
//跑马灯
@property (weak, nonatomic) IBOutlet SGAdvertScrollView *advertScrollView;

@end

@implementation AnnouncementCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //跑马灯
    self.advertScrollView.titles = @[@"暂无公告"];
    self.advertScrollView.userInteractionEnabled = NO;
    self.advertScrollView.textAlignment = NSTextAlignmentRight;
    self.advertScrollView.titleFont = [UIFont systemFontOfSize:13];
    self.advertScrollView.delegate = self;
    self.advertScrollView.backgroundColor =  [UIColor colorStyleLeDarkWithConstantColor:[UIColor colorConstantStyleDarkColor]normalCorlor:[UIColor colorTextWhiteColor]];
    if (@available(iOS 13.0, *)) {
        self.advertScrollView.titleColor = [UIColor placeholderTextColor];
    }else{
        self.advertScrollView.titleColor = [UIColor colorCommonGreyBlackColor];
    }
}
-(void)setAnnouArr:(NSMutableArray *)annouArr{
    _annouArr = annouArr;
    if (annouArr.count == 0) {
        self.advertScrollView.titles = @[@"暂无公告"];
    }else{
        self.advertScrollView.titles = annouArr.copy;
    }
}
// delegate 方法
- (void)advertScrollView:(SGAdvertScrollView *)advertScrollView didSelectedItemAtIndex:(NSInteger)index{
    
}
@end
