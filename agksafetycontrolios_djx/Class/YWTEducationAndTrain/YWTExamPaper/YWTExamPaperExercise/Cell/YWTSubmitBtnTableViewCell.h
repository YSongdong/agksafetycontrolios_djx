//
//  SubmitBtnTableViewCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/16.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTSubmitBtnTableViewCell : UITableViewCell

@property (nonatomic,strong)  UIButton *submitBtn;
// 点击进入考试按钮
@property (nonatomic,copy) void(^selectSubmitBlock)(void);

@end

NS_ASSUME_NONNULL_END
