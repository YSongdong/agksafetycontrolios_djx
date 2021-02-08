//
//  HomeScrollCollectionViewCell.m
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/10.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import "HomeScrollCollectionViewCell.h"
#import "SDCycleScrollView.h"

@interface HomeScrollCollectionViewCell () <SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet SDCycleScrollView *homeCycleScrollView;

@end

@implementation HomeScrollCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.homeCycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    self.homeCycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.homeCycleScrollView.delegate = self;
    
    if (self.bannerArr.count == 0) {
        NSArray *imageArr = @[@"home_banner"];
        self.homeCycleScrollView.localizationImageNamesGroup = imageArr;
    }else{
        self.homeCycleScrollView.imageURLStringsGroup = self.bannerArr;
    }
}

- (void)setBannerArr:(NSMutableArray *)bannerArr{
    _bannerArr = bannerArr;
    if (self.bannerArr.count == 0) {
        NSArray *imageArr = @[@"home_banner"];
        self.homeCycleScrollView.localizationImageNamesGroup = imageArr;
    }else{
        self.homeCycleScrollView.imageURLStringsGroup = self.bannerArr;
    }
}

@end
