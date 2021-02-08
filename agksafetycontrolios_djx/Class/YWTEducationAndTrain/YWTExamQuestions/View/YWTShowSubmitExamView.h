//
//  ShowSubmitExamView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/21.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTShowSubmitExamView : UIView

@property (nonatomic,strong) UILabel *contentLab;

// 确认交卷按钮
@property (nonatomic,copy) void(^submitExamBlock)(void);

@end

NS_ASSUME_NONNULL_END
