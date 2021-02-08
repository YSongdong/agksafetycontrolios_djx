//
//  ListTypeCellHeaderView.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/23.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseShowListModel.h"

@interface YWTListTypeCellHeaderView : UIView

@property (nonatomic,strong) BaseShowListModel *model;

// 计算高度
+(CGFloat) getTypeCellHeader:(BaseShowListModel *) model;


@end

