//
//  ShowMessageSiftView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/4.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTShowMessageSiftView : UIView

// 筛选
@property (nonatomic,strong) NSString *tagIdStr;

//类型
@property (nonatomic,copy) void(^selectType)(NSString *typeStr);

@end

NS_ASSUME_NONNULL_END
