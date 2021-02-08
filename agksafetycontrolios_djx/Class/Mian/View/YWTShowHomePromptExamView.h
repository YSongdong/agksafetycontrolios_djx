//
//  ShowHomePromptExamView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/30.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTShowHomePromptExamView : UIView

@property (nonatomic,strong)  UILabel *showContentLab;

@property (nonatomic,strong)  UIButton *ignoreBtn;

@property (nonatomic,strong)  UIButton *continueExamBtn;

// 取消视图
@property (nonatomic,copy) void(^cancelProptView)(void);

@property (nonatomic,copy) void(^continueExamBlock)(void);

@end

NS_ASSUME_NONNULL_END
