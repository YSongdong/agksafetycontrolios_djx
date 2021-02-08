//
//  DetailQuestInfoTableViewCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/16.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YWTExamExerDetaModel.h"

@interface YWTDetailQuestInfoTableViewCell : UITableViewCell

@property (nonatomic,strong) YWTExamExerDetaModel *detaModel;
// 点击跳转
@property (nonatomic,copy) void(^pushLibayExer)(NSString *titleStr);

//计算高度
+(CGFloat)getLabelHeightWithDict:(YWTExamExerDetaModel*) model;


@end

