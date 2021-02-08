//
//  CreditChartRankingView.h
//  PartyBuildingStar
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CreditChartRankingView : UIView

//当前用户信息
@property (nonatomic,copy) void(^currentUser)(NSDictionary *userDict);

@end

NS_ASSUME_NONNULL_END
