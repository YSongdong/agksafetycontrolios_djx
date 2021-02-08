//
//  BaseHeaderSearchView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/15.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTBaseHeaderSearchView : UIView

@property (nonatomic,strong) UIView *bgView ;

@property (nonatomic,strong) UIImageView *searchImageV;

@property (nonatomic,strong) UITextField *searchTextField;
// 搜索
@property (nonatomic,copy) void(^searchBlock)(NSString *search);

@property (nonatomic,assign) BOOL isExamCenterRcord;

@end

NS_ASSUME_NONNULL_END
