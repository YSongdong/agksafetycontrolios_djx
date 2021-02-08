//
//  HomeViewModel.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/7.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface YWTHomeViewModel : NSObject
/**< 用来与controller里面的View匹配*/
@property (nonatomic,strong) UIView *bgView;
//控件
@property (nonatomic,strong) UICollectionView *homeCollectView;

- (instancetype)initWithFrame:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
