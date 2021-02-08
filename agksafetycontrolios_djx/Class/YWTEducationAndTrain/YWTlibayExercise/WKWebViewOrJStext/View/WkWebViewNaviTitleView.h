//
//  WkWebViewNaviTitleView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/2/26.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WkWebViewNaviTitleView : UIView

// 选择按钮  1:答题模式 2：背题模式
@property (nonatomic,copy) void(^selectBtnBlock)(NSInteger btnTag);

-(void) alterSelectBtnMode:(NSString *)btnTag;

@end

NS_ASSUME_NONNULL_END
