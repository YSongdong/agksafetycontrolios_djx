//
//  TaskCenterUnStartedCell.h
//  PartyBuildingStar
//
//  Created by mac on 2019/4/17.
//  Copyright © 2019 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TaskCenterListModel.h"

@interface YWTTaskCenterUnStartedCell : UITableViewCell

@property (nonatomic,strong) TaskCenterListModel *model;

// 计算高度
+(CGFloat) getWithCompleteCellHeight:(TaskCenterListModel *) model;

@end


