//
//  ExamRoomListCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/28.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "ExamCenterRoomListModel.h"

@interface YWTExamRoomListCell : UITableViewCell

@property (nonatomic,strong) ExamCenterRoomListModel *model;

// 计算高度
+(CGFloat) getWithExamRoomCellHeight:(ExamCenterRoomListModel*) model;

/// 倒计时到0时回调
@property (nonatomic, copy) void(^countDownZero)(ExamCenterRoomListModel *model);
// 跳转到模拟考试
@property (nonatomic,copy) void(^pushExamPaperBlock)(NSString *titleStr);

@end

