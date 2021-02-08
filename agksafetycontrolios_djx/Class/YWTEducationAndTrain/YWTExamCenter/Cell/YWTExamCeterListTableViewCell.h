//
//  ExamCeterListTableViewCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/22.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ExamCenterListModel.h"

@interface YWTExamCeterListTableViewCell : UITableViewCell

@property (nonatomic,strong) ExamCenterListModel *model;

// 计算高度
+(CGFloat) getWithExamCenterListCellHeight:(ExamCenterListModel*) model;

@end


