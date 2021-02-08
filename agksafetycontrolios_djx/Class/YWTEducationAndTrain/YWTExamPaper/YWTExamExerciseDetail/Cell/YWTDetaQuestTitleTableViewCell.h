//
//  DetaQuestTitleTableViewCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/1/16.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>



#import "YWTExamExerDetaModel.h"

@interface YWTDetaQuestTitleTableViewCell : UITableViewCell

@property (nonatomic,strong) YWTExamExerDetaModel *detaModel;

//计算高度
+(CGFloat)getLabelHeightWithDict:(YWTExamExerDetaModel*) model;

@end


