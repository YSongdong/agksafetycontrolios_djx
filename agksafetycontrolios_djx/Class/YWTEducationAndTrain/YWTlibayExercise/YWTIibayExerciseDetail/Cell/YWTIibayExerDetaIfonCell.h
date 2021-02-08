//
//  IibayExerDetaIfonCell.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/2/14.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YWTLibayExerDetaModel.h"

@interface YWTIibayExerDetaIfonCell : UITableViewCell

@property (nonatomic,strong) YWTLibayExerDetaModel *model;

// 计算高度的
+(CGFloat) getDetaInfoHeight:(YWTLibayExerDetaModel *)model;

@end


